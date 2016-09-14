using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Education;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class EducationController : DashboardController
    {
        private const int EducationItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string page, string sort)
        {
            EducationItemList model = new EducationItemList(); 

            int pageVal = this.GetPage(page);

            EducationItemSort sortVal = EducationItemSort.Type;

            Enum.TryParse<EducationItemSort>(sort, out sortVal);

            model.Sort = sortVal; 

            EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, pageVal, EducationItemsPerPage, sortVal);

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                if (result.EducationItems.Count == 0)
                {
                    result = this.DashboardRepository.Education.LoadDefaults();

                    if (result.Success)
                        result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, pageVal, EducationItemsPerPage, sortVal);

                }

                model.EducationItems = result.EducationItems;

                model.Paging.SetPagingData(EducationItemsPerPage, pageVal, result.TotalResults);

                model.Paging.BaseUrl = Url.Action("Index", new { page = "", sort = (int)sortVal });
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult AddEdit(string ien)
        {
            EducationItemAddEditModel model = new EducationItemAddEditModel();

            if (!string.IsNullOrWhiteSpace(ien))
            {
                EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems(ien, "", EducationItemType.Unknown, 0, 0, EducationItemSort.Type);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    if (result.EducationItems != null) 
                        if (result.EducationItems.Count > 0)
                            model.Item = result.EducationItems[0];
            }

            model.ItemTypeSelection = GetItemTypeSelection();

            // *** Load category selection box ***
            model.CategorySelection = GetCategorySelection(); 

            //model.CodeSelection = GetCodeSelection(); 

            return View(model);
        }
               
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEdit(EducationItemAddEditModel model)
        {
            ActionResult returnResult; 

            BrokerOperationResult result = this.DashboardRepository.Education.SaveEducationItem(model.Item);

            if (!result.Success)
            {
                this.Error(result.Message);

                model.ItemTypeSelection = GetItemTypeSelection();

                // *** Load category selection box ***
                model.CategorySelection = GetCategorySelection();

                // *** Clear previously selected ***
                model.SelectedCategory = ""; 

                returnResult = View(model);
            }
            else 
                returnResult = RedirectToAction("Index", new { page = "1" });

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(EducationItemList model)
        {
            //DeleteAll();

            if (!string.IsNullOrWhiteSpace(model.SelectedItemIen))
            {
                BrokerOperationResult result = this.DashboardRepository.Education.DeleteEducationItem(model.SelectedItemIen);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    this.Information("Education Item Deleted Successfully");
            }

            return RedirectToAction("Index"); 
        }

        private void DeleteAll()
        {
            EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, -1, -1, EducationItemSort.Category);

            if (result.Success)
            {
                BrokerOperationResult delResult = null; 

                foreach (EducationItem item in result.EducationItems)
                {
                    delResult = this.DashboardRepository.Education.DeleteEducationItem(item.Ien);

                    if (!delResult.Success)
                        break; 
                }

                if (delResult != null)
                {
                    if (!delResult.Success)
                        this.Error(delResult.Message);
                }
                else
                    this.Information("All items deleted"); 
            }
        }

        [HttpGet]
        public ActionResult PatientIndex(string dfn, string page)
        {
            // TODO: Make education items pregnancy specific?
            // TODO: Allow passed in pregnancy 

            PatientEducationIndex model = new PatientEducationIndex();

            model.Patient = this.CurrentPatient;

            //PregnancyUtilities util = new PregnancyUtilities(this.DashboardRepository);

            PregnancyDetails preg = PregnancyUtilities.GetWorkingPregnancy(this.DashboardRepository, dfn, "");

            if (preg != null)
                if ((preg.EDD != DateTime.MinValue) || (preg.EndDate != DateTime.MinValue))
                    GetMergedList(model, preg);
                else
                    GetPatientEducationItemList(model);
            else
                GetPatientEducationItemList(model); 

            return View(model);
        }

        private void GetMergedList(PatientEducationIndex model, PregnancyDetails preg)
        {
            PregnancyChecklistItemsResult result = this.DashboardRepository.Checklist.GetPregnancyItems(model.Patient.Dfn, preg.Ien, "");

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                // *** Create view items ***

                if (result.Items != null)
                    foreach (PregnancyChecklistItem item in result.Items)
                        if (item.ItemType == DsioChecklistItemType.EducationItem)
                        {
                            PatientEducationChecklistItem newItem = new PatientEducationChecklistItem();
                            newItem.PregnancyChecklistItem = item;
                            model.ItemList.Add(newItem);
                        }

                // *** Get patient education items ***

                PatientEducationItemsResult edResult = this.DashboardRepository.Education.GetPatientItems(
                    model.Patient.Dfn, 
                    "", 
                    DateTime.MinValue,
                    DateTime.MinValue, 
                    EducationItemType.Unknown, 
                    1, 
                    1000
                    );

                if (!edResult.Success)
                    this.Error(edResult.Message);
                else
                {
                    Dictionary<string, PatientEducationItem> patEdItems = new Dictionary<string, PatientEducationItem>();

                    // *** Place patient education items in dictionary for lookup ***

                    if (edResult.Items != null)
                        foreach (PatientEducationItem patEdItem in edResult.Items)
                            patEdItems.Add(patEdItem.Ien, patEdItem);

                    // *** Go through checklist to find links to patient education ***

                    foreach (PatientEducationChecklistItem finalItem in model.ItemList)
                        if (finalItem.PregnancyChecklistItem != null)
                            if (finalItem.PregnancyChecklistItem.CompletionStatus == DsioChecklistCompletionStatus.Complete)
                                if (!string.IsNullOrWhiteSpace(finalItem.PregnancyChecklistItem.CompletionLink))
                                    if (patEdItems.ContainsKey(finalItem.PregnancyChecklistItem.CompletionLink))
                                    {
                                        // *** If found add to final ***
                                        finalItem.PatientEducationItem = patEdItems[finalItem.PregnancyChecklistItem.CompletionLink];

                                        // *** Remove since already added ***
                                        patEdItems.Remove(finalItem.PregnancyChecklistItem.CompletionLink);
                                    }

                    // *** Now that we've added all items that are linked, add remainder ***
                    foreach (PatientEducationItem patEdItem in patEdItems.Values)
                    {
                        PatientEducationChecklistItem newItem = new PatientEducationChecklistItem();
                        newItem.PatientEducationItem = patEdItem;
                        model.ItemList.Add(newItem);
                    }

                    // *** Finally get education items linked by a checklist but incomplete ***
                    foreach (PatientEducationChecklistItem finalItem in model.ItemList)
                        if (finalItem.PregnancyChecklistItem != null)
                            if (finalItem.PregnancyChecklistItem.CompletionStatus != DsioChecklistCompletionStatus.Complete)
                                if (!string.IsNullOrWhiteSpace(finalItem.Link))
                                {
                                    EducationItemsResult edItemsResult = this.DashboardRepository.Education.GetEducationItems(finalItem.Link, "", EducationItemType.Unknown, 0, 0, EducationItemSort.Type);

                                    if (edItemsResult.Success)
                                        if (edItemsResult.EducationItems != null)
                                            if (edItemsResult.EducationItems.Count > 0)
                                                finalItem.EducationItem = edItemsResult.EducationItems[0];
                                }

                }

                model.ItemList.AddPregnancyDates(preg.EDD, preg.EndDate);

                model.ItemList.Sort(delegate(PatientEducationChecklistItem x, PatientEducationChecklistItem y)
                {
                    return x.CompareDate.CompareTo(y.CompareDate);
                });
            }
        }

        private void GetPatientEducationItemList(PatientEducationIndex model)
        {
            // *** Get patient education items ***

            PatientEducationItemsResult edResult = this.DashboardRepository.Education.GetPatientItems(
                model.Patient.Dfn, 
                "", 
                DateTime.MinValue,
                DateTime.MinValue, 
                EducationItemType.Unknown, 
                1, 
                1000
                );

            if (!edResult.Success)
                this.Error(edResult.Message);
            else
            {
                if (edResult.Items != null) 
                    foreach (PatientEducationItem patEdItem in edResult.Items)
                    {
                        PatientEducationChecklistItem newItem = new PatientEducationChecklistItem();
                        newItem.PatientEducationItem = patEdItem;
                        model.ItemList.Add(newItem);
                    }

                model.ItemList.Sort(delegate(PatientEducationChecklistItem x, PatientEducationChecklistItem y)
                {
                    return x.CompareDate.CompareTo(y.CompareDate);
                });
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Complete(PatientEducationIndex model)
        {

            //PatientEducationItem patItem = new PatientEducationItem()
            //{
            //    PatientDfn = model.Patient.Dfn,
            //    EducationItemIen = model.SelectedEducationIen,
            //    CompletedOn = DateTime.Now
            //};

            //IenResult saveResult = this.DashboardRepository.Education.SavePatientItem(patItem);

            //if (!saveResult.Success)
            //    this.Error(saveResult.Message);
            //else
            //{
            //    PregnancyChecklistItemsResult result = this.DashboardRepository.Checklist.GetPregnancyItems(model.Patient.Dfn, "", model.SelectedChecklistIen);

            //    if (!result.Success)
            //        this.Error(result.Message);
            //    else
            //    {
            //        if (result.Items != null)
            //            if (result.Items.Count > 0)
            //            {
            //                PregnancyChecklistItem checkItem = result.Items[0];

            //                checkItem.CompletionStatus = DsioChecklistCompletionStatus.Complete;
            //                checkItem.CompletionLink = saveResult.Ien;

            //                IenResult ienResult = this.DashboardRepository.Checklist.SavePregnancyItem(checkItem);

            //                if (!saveResult.Success)
            //                    this.Error(saveResult.Message);

            //                this.Information("Education item completed");
            //            }
            //    }
            //}

            BrokerOperationResult result = ChecklistUtility.CompleteEducationItem(
                this.DashboardRepository, 
                model.Patient.Dfn, 
                model.SelectedEducationIen, 
                model.SelectedChecklistIen);

            if (result.Success)
                this.Information(result.Message);
            else
                this.Error(result.Message); 

            return RedirectToAction("PatientIndex", new { dfn = model.Patient.Dfn });
        }

        [HttpGet]
        public ActionResult PatientAddEdit(string dfn, string ien)
        {
            PatientEducationAddEdit model = new PatientEducationAddEdit();

            model.Patient = this.CurrentPatient;

            if (!string.IsNullOrWhiteSpace(ien))
            {
                PatientEducationItemsResult result = this.DashboardRepository.Education.GetPatientItems(
                    dfn, 
                    ien, 
                    DateTime.MinValue, 
                    DateTime.MinValue, 
                    EducationItemType.Unknown, 
                    0, 
                    0);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                            model.Item = result.Items[0];
            }
            else
            {
                model.Item.PatientDfn = dfn;                
            }

            model.ItemTypeSelection = GetItemTypeSelection();
            
            return View(model);
        }

        //private Dictionary<string, string> GetExistingItemSelection()
        //{
        //    Dictionary<string, string> returnVal = new Dictionary<string, string>();

        //    EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, 1, 1000);

        //    returnVal = new Dictionary<string, string>();
        //    returnVal.Add("", "Other"); 

        //    if (result.Success)
        //        if (result.EducationItems != null)
        //            if (result.EducationItems.Count > 0)
        //                foreach (EducationItem item in result.EducationItems)
        //                    returnVal.Add(item.Ien, item.Description); 

        //    return returnVal; 
        //}

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PatientAddEdit(PatientEducationAddEdit model)
        {
            ActionResult returnResult;

            model.Item.CompletedOn = DateTime.Now; 

            BrokerOperationResult result = this.DashboardRepository.Education.SavePatientItem(model.Item);

            if (!result.Success)
            {
                this.Error(result.Message);

                this.CurrentPatientDfn = model.Patient.Dfn; 
                model.Patient = this.CurrentPatient;

                model.ItemTypeSelection = GetItemTypeSelection();
                
                returnResult = View(model);
            }
            else
                returnResult = RedirectToAction("PatientIndex", new { page = "1" });

            return returnResult;  
        }

        [HttpGet]
        public ActionResult PatientDetail(string dfn, string ien)
        {
            ActionResult returnResult; 

            PatientEducationItemDetail model = new PatientEducationItemDetail();

            model.Patient = this.CurrentPatient;

            if (!string.IsNullOrWhiteSpace(ien))
            {
                PatientEducationItemsResult result = this.DashboardRepository.Education.GetPatientItems(dfn, ien, DateTime.MinValue, DateTime.MinValue, EducationItemType.Unknown, 0, 0);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                            model.Item = result.Items[0];

                returnResult = View(model); 
            }
            else
            {
                returnResult = RedirectToAction("PatientIndex", new { dfn = dfn }); 
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult PatientSelect(string dfn)
        {
            PatientEducationSelect model = new PatientEducationSelect();

            model.Patient = this.CurrentPatient;

            EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, 0, 0, EducationItemSort.Type);

            if (!result.Success)
                this.Error(result.Message);
            else if (result.EducationItems != null)
                if (result.EducationItems.Count > 0)
                {
                    result.EducationItems.Sort(delegate(EducationItem x, EducationItem y)
                    {
                        int returnVal = 0; 

                        if (x.Category == y.Category) 
                            returnVal = x.Description.CompareTo(y.Description);
                        else 
                            returnVal = x.Category.CompareTo(y.Category); 

                        return returnVal;
                    });
                    string currentCategory = ""; 
                    foreach (EducationItem item in result.EducationItems)
                    {
                        if (item.Category != currentCategory)
                        {
                            PatientEducationSelectItemRow catRow = new PatientEducationSelectItemRow(){CategoryRow = true, Category = item.Category}; 
                            model.AddRow(catRow); 
                            currentCategory = item.Category; 
                        }

                        PatientEducationSelectItemRow itemRow = new PatientEducationSelectItemRow()
                        {
                            Ien = item.Ien,
                            ItemType = item.ItemType,
                            ItemTypeDescription = item.ItemTypeDescription,
                            Description = item.Description, 
                            Category = item.Category
                        };

                        model.AddRow(itemRow); 
                    }
                }

            return View(model); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PatientSelect(PatientEducationSelect model)
        {
            ActionResult returnResult; 

            List<string> ienList = model.GetSelectedIenList(); 

            bool ok = false; 

            if (ienList != null)
                foreach (string ien in ienList)
                {
                    PatientEducationItem patItem = new PatientEducationItem();

                    patItem.EducationItemIen = ien;
                    patItem.PatientDfn = model.Patient.Dfn;
                    patItem.CompletedOn = DateTime.Now;

                    IenResult ienResult = this.DashboardRepository.Education.SavePatientItem(patItem);

                    if (!ienResult.Success)
                    {
                        this.Error(ienResult.Message);
                        ok = false; 
                        break;
                    }
                    else 
                        ok = true; 
                }

            if (ok)
            {
                this.Information("Education Items Added Successfully");
                returnResult = RedirectToAction("PatientIndex", new { dfn = model.Patient.Dfn });
            }
            else
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;
                returnResult = View(model); 
            }

            return returnResult;  
        }

        //private Dictionary<string, string> GetCodeSelection()
        //{
        //    Dictionary<string, string> returnVal = new Dictionary<string, string>();

        //    returnVal.Add("None", "");

        //    CdaValueSetResult result = this.DashboardRepository.CdaDocuments.GetValueSet(ValueSetType.AntepartumEducation);

        //    if (result.ValueSet != null)
        //        if (result.ValueSet.Items != null)
        //            foreach (ValueSetItem item in result.ValueSet.Items)
        //            {
        //                string[] prefixes = new string[] { "", "L", "S", "O" };
        //                string prefix = prefixes[(int)item.CodeSystem];

        //                string[] systemNames = new string[] { "", "LOINC", "SNOMED-CT", "OTHER" };
        //                string systemName = systemNames[(int)item.CodeSystem];

        //                string value = string.Format("{0}:{1}", prefix, item.Code);
        //                string key = string.Format("{0} [{1} - {2}]", item.ItemName, systemName, item.Code);

        //                returnVal.Add(key, value);
        //            }

        //    return returnVal;
        //}

        private Dictionary<EducationItemType, string> GetItemTypeSelection()
        {
            Dictionary<EducationItemType, string> returnVal = new Dictionary<EducationItemType, string>();

            returnVal.Add(EducationItemType.DiscussionTopic, "Discussion Topic");
            returnVal.Add(EducationItemType.LinkToMaterial, "Link to Material");
            returnVal.Add(EducationItemType.PrintedMaterial, "Printed Material");
            returnVal.Add(EducationItemType.Enrollment, "Enrollment");
            returnVal.Add(EducationItemType.Other, "Other");

            return returnVal;
        }

        private List<string> GetCategorySelection()
        {
            // *** Get category selection list ***

            List<string> returnList = new List<string>();

            // *** Get all ed items ***
            EducationItemsResult result = this.DashboardRepository.Education.GetEducationItems("", "", EducationItemType.Unknown, -1, -1, EducationItemSort.Category);

            // *** Add initially shown item ***
            returnList.Add("(Select)");

            // *** Check if successful ***
            if (!result.Success)
                this.Error(result.Message);
            else // *** Add items ***
                if (result.EducationItems != null)
                    foreach (var item in result.EducationItems)
                        if (!string.IsNullOrWhiteSpace(item.Category))
                            if (!returnList.Contains(item.Category))
                                returnList.Add(item.Category);

            // *** Use this to enter new ***
            returnList.Add("(Enter New)"); 

            return returnList; 
        }

    }
}
