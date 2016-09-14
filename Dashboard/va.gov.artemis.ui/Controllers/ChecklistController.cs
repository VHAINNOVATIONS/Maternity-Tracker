using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.UI.Data.Models.Patient;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class ChecklistController : DashboardController
    {
        private const int ItemsPerPage = 10; 

        [HttpGet]
        public ActionResult Index(string page)
        {
            // TODO: What kind of sorting/paging to allow
            // TODO: Can pass duedays to vista and always sort on that?
            // TODO: Will need better sort to handle paging in vista or can handle paging/sorting in repository (less efficient)

            ChecklistIndex model = new ChecklistIndex();

            int pageVal = this.GetPage(page);

            //ChecklistItemsResult result = this.DashboardRepository.Checklist.GetItems("", pageVal, ItemsPerPage);
            ChecklistItemsResult result = this.DashboardRepository.Checklist.GetItems("", 1, 1000); 

            if (!result.Success)
                this.Error(result.Message);
            else
            {                
                model.Items = result.Items;

                model.Items.Sort(delegate(ChecklistItem x, ChecklistItem y)
                {
                    int returnVal = 0; 

                    returnVal = x.DueDays.CompareTo(y.DueDays);

                    if (returnVal == 0)
                        returnVal = x.ItemType.ToString().CompareTo(y.ItemType.ToString()); 

                    if (returnVal == 0) 
                        returnVal = x.Category.CompareTo(y.Category); 

                    if (returnVal == 0) 
                        returnVal = x.Description.CompareTo(y.Description); 

                    return returnVal; 
                });

                //model.Paging.SetPagingData(ItemsPerPage, pageVal, result.TotalResults);
                model.Paging.SetPagingData(1000, pageVal, result.TotalResults);
                model.Paging.BaseUrl = Url.Action("Index", new { @page = "" }); 
            }

            return View(model); 
        }

        [HttpPost]
        public ActionResult PostIndex(ChecklistIndex model)
        {
            ActionResult result;

            if (model.PostOperation == ChecklistIndexOperation.Delete)
            {
                //ClearAllItems();

                result = DeleteItem(model);
            }
            else if (model.PostOperation == ChecklistIndexOperation.LoadDefaults)
                result = LoadDefaults(model);
            else
            {
                this.Attention("Unknown operation");
                result = RedirectToAction("Index", new { page = "1" });
            }

            return result; 
        }

        [HttpGet]
        public ActionResult AddEdit(string ien)
        {
            ChecklistItemAddEdit model = new ChecklistItemAddEdit();

            if (!string.IsNullOrWhiteSpace(ien))
            {
                ChecklistItemsResult result = this.DashboardRepository.Checklist.GetItems(ien, 1, 1000);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                        {
                            model.Item = result.Items[0];

                            //if (model.Item.ItemType == DsioChecklistItemType.EducationItem)
                            //    model.EducationItemLink = model.Item.Link; 

                            model.GetDueVals();
                        }
            }

            model.EducationItemSelection = this.DashboardRepository.Education.GetItemSelection();

            return View(model); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEdit(ChecklistItemAddEdit model)
        {
            ActionResult returnResult;

            bool success = false;

            //if (model.Item.ItemType == DsioChecklistItemType.EducationItem)
            //    model.Item.Link = model.EducationItemLink;

            if (model.Item.IsValid())
            {
                model.SetDueVals();
 
                IenResult result = this.DashboardRepository.Checklist.SaveItem(model.Item);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    success = true;
            }
            else
                this.Error(model.Item.ValidationMessage);

            if (success)
            {
                if (string.IsNullOrWhiteSpace(model.Item.Ien))
                    this.Information("Checklist item created successfully");
                else
                    this.Information("Checklist item updated successfully");

                returnResult = RedirectToAction("Index");
            }
            else
            {
                model.EducationItemSelection = this.DashboardRepository.Education.GetItemSelection();
                returnResult = View(model);
            }
                
            return returnResult; 
        }

        [HttpGet]
        public ActionResult PregnancyIndex(string dfn, string pregIen, string page)
        {
            PregnancyChecklistIndex model = new PregnancyChecklistIndex();

            model.Patient = this.CurrentPatient;

            // TODO: In future add ability to view checklist for a specific pregnancy passed in as parameter 
            //       Add a pregnancy selection and display
            //PregnancyDetails preg = PregnancyUtilities.GetWorkingPregnancy(this.DashboardRepository, dfn, pregIen); 

            PregnancyDetails preg = PregnancyUtilities.GetWorkingPregnancy(this.DashboardRepository, dfn, ""); 

            if (preg == null)
                model.NoPregnancies = true; 
            else
            {
                if ((preg.EDD == DateTime.MinValue) && (preg.EndDate == DateTime.MinValue))
                    model.NoPregnancyDate = true; 

                model.Pregnancy = preg;

                //PregnancyChecklistItemsResult result = this.DashboardRepository.Checklist.GetPregnancyItems(dfn, preg.Ien, "");

                //if (!result.Success)
                //    this.Error(result.Message);
                //else
                //{
                //    model.Items = new PregnancyChecklistItemList();
                //    model.Items.AddRange(result.Items);

                //    model.Items.AddPregnancyDates(preg.EDD, preg.EndDate);

                //    model.Items.Sort(delegate(PregnancyChecklistItem x, PregnancyChecklistItem y)
                //    {
                //        return x.DueDate.CompareTo(y.DueDate);
                //    });
                //}

                PregnancyChecklistItemsResult result = ChecklistUtility.GetSortedPregnancyChecklist(this.DashboardRepository, dfn, preg, DsioChecklistCompletionStatus.Unknown);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    model.Items.AddRange(result.Items); 
            }

            // TODO: Paging...

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PregnancyIndexPost(PregnancyChecklistIndex model)
        {
            ActionResult returnResult; 

            switch (model.PostOperation)
            {
                case PregnancyChecklistOperation.Complete:
                    returnResult = PostComplete(model);
                    break;
                case PregnancyChecklistOperation.InProgress:
                    returnResult = PostInProgress(model); 
                    break; 
                case PregnancyChecklistOperation.Cancel:
                    returnResult = PostCancel(model); 
                    break; 
                case PregnancyChecklistOperation.AddDefault:
                    returnResult = PostAddDefault(model); 
                    break;
                case PregnancyChecklistOperation.Delete:
                    returnResult = PostDeletePregItem(model); 
                    break;
                default:
                    returnResult = RedirectToAction("PregnancyIndex", new {dfn = model.Patient.Dfn, pregIen = model.Pregnancy.Ien, page = model.Paging.CurrentPage });
                    break;
            }

            return returnResult; 
        }

        private ActionResult PostInProgress(PregnancyChecklistIndex model)
        {
            PregnancyChecklistItemResult opResult = this.DashboardRepository.Checklist.GetPregnancyItem(model.Patient.Dfn, model.SelectedItemIen);
            
            if (!opResult.Success)
                this.Error(opResult.Message);
            else
            {
                PregnancyChecklistItem item = opResult.Item;

                BrokerOperationResult updateResult = this.DashboardRepository.Checklist.SetPregnancyItemInProgress(item);

                if (!updateResult.Success)
                    this.Error(updateResult.Message); 
            }

            return RedirectToAction("PregnancyIndex", new { dfn = model.Patient.Dfn, pregIen = model.Pregnancy.Ien, page = model.Paging.CurrentPage });
        }

        private ActionResult PostCancel(PregnancyChecklistIndex model)
        {
            PregnancyChecklistItemResult opResult = this.DashboardRepository.Checklist.GetPregnancyItem(model.Patient.Dfn, model.SelectedItemIen);

            if (!opResult.Success)
                this.Error(opResult.Message);
            else
            {
                PregnancyChecklistItem item = opResult.Item;

                BrokerOperationResult updateResult = this.DashboardRepository.Checklist.CancelPregnancyItem(item);

                if (!updateResult.Success)
                    this.Error(updateResult.Message);
                else
                {
                    // *** Update the next checklist date ***
                    BrokerOperationResult result = ChecklistUtility.UpdateNextDates(this.DashboardRepository, item.PatientDfn, item.PregnancyIen);

                    if (!result.Success)
                        this.Error("Error updating next dates: " + result.Message); 

                }
            }

            return RedirectToAction("PregnancyIndex", new { dfn = model.Patient.Dfn, pregIen = model.Pregnancy.Ien, page = model.Paging.CurrentPage });
        }

        private ActionResult PostComplete(PregnancyChecklistIndex model)
        {
            // *** Update completion status for a pregnancy checklist item ***

            // *** Create default return action ***
            ActionResult returnResult = RedirectToAction("PregnancyIndex", new { dfn = model.Patient.Dfn, pregIen = model.Pregnancy.Ien, page = model.Paging.CurrentPage });

            // *** Get the item ***
            PregnancyChecklistItemResult getResult = this.DashboardRepository.Checklist.GetPregnancyItem(model.Patient.Dfn, model.SelectedItemIen);

            if (!getResult.Success)
                this.Error(getResult.Message);
            else
            {
                // *** Should only be one ***
                PregnancyChecklistItem item = getResult.Item;

                BrokerOperationResult opResult;

                if (item.ItemType == DsioChecklistItemType.MccCall)
                    if (string.IsNullOrWhiteSpace(item.CompletionLink))
                        returnResult = RedirectToAction("Create", "PatientContact", new { @dfn = model.Patient.Dfn, @callType = item.Link, @checkIen = item.Ien });
                    else
                        returnResult = RedirectToAction("Edit", "PatientContact", new { @dfn = model.Patient.Dfn, @noteIen = item.CompletionLink, @checkIen = item.Ien });
                else
                {
                    opResult = CompleteItem(item);

                    if (opResult.Success)
                        this.Information(opResult.Message);
                    else
                        this.Error(opResult.Message);

                }
            }

            return returnResult; 
        }

        private BrokerOperationResult CompleteItem(PregnancyChecklistItem item)
        {
            BrokerOperationResult result = new BrokerOperationResult(); 

            switch (item.ItemType)
            {
                // *** For education items, create the education item, and complete the checklist item ***
                case DsioChecklistItemType.EducationItem:

                    result = ChecklistUtility.CompleteEducationItem(
                        this.DashboardRepository,
                        item.PatientDfn,
                        item.EducationItemIen,
                        item.Ien);

                    break;

                // *** For all other items, complete the checklist item ***
                default:

                    result = this.DashboardRepository.Checklist.CompletePregnancyItem(item); 

                    break;
            }

            // *** Update the next checklist date ***
            if (result.Success) 
                result = ChecklistUtility.UpdateNextDates(this.DashboardRepository, item.PatientDfn, item.PregnancyIen); 

            return result; 
        }

        [HttpGet]
        public ActionResult PregnancyAddEdit(string dfn, string pregIen, string itemIen)
        {
            PregnancyChecklistAddEdit model = new PregnancyChecklistAddEdit();

            model.Patient = this.CurrentPatient;

            if (!string.IsNullOrWhiteSpace(itemIen))
            {
                PregnancyChecklistItemsResult result = this.DashboardRepository.Checklist.GetPregnancyItems(dfn, "", itemIen);

                if (!result.Success)
                    this.Error(result.Message);
                else
                {
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                        {
                            model.Item = result.Items[0];

                            model.GetDueVals();

                            //if (model.Item.ItemType == DsioChecklistItemType.EducationItem)
                            //    model.EducationItemLink = model.Item.Link; 
                        }
                }
            }
            else
            {
                model.Item.PatientDfn = dfn;
                model.Item.PregnancyIen = pregIen;
                model.Item.CompletionStatus = DsioChecklistCompletionStatus.NotComplete;
            }

            model.EducationItemSelection = this.DashboardRepository.Education.GetItemSelection();

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PregnancyAddEdit(PregnancyChecklistAddEdit model)
        {
            ActionResult result;

            bool ok = false;

            //if (model.Item.ItemType == DsioChecklistItemType.EducationItem)
            //    model.Item.Link = model.EducationItemLink; 

            if (model.Item.IsValid())
            {
                model.SetDueVals();

                IenResult saveResult = this.DashboardRepository.Checklist.SavePregnancyItem(model.Item);

                if (!saveResult.Success)
                    this.Error(saveResult.Message);
                else
                {
                    if (string.IsNullOrWhiteSpace(model.Item.Ien))
                        this.Information("Checklist item created successfully");
                    else
                        this.Information("Checklist item updated successfully");

                    // *** Update the next checklist date ***
                    BrokerOperationResult updResult = ChecklistUtility.UpdateNextDates(this.DashboardRepository, model.Patient.Dfn, model.Item.PregnancyIen);

                    if (!updResult.Success)
                        this.Error("Error updating next dates: " + updResult.Message); 

                    ok = true;
                }
            }
            else 
                this.Error(model.Item.ValidationMessage); 

            if (ok)
                result = RedirectToAction("PregnancyIndex", new { dfn = model.Patient.Dfn, pregIen = model.Item.PregnancyIen });
            else
            {
                this.CurrentPatientDfn = model.Patient.Dfn;
                model.Patient = this.CurrentPatient;

                model.EducationItemSelection = this.DashboardRepository.Education.GetItemSelection();

                result = View(model);
            }

            return result;
        }

        private ActionResult PostAddDefault(PregnancyChecklistIndex model)
        {
            BrokerOperationResult result = this.DashboardRepository.Checklist.AddDefaultPregnancyItems(model.Patient.Dfn, model.Pregnancy.Ien);

            if (!result.Success)
                this.Error(result.Message);
            else
            {
                // *** Update the next checklist date ***
                BrokerOperationResult updResult = ChecklistUtility.UpdateNextDates(this.DashboardRepository, model.Patient.Dfn, model.Pregnancy.Ien);

                if (!updResult.Success)
                    this.Error("Error updating next dates: " + updResult.Message);
                 
                this.Information("The default items have been added to the patient's checklist");
            }

            return RedirectToAction("PregnancyIndex", new { dfn = model.Patient.Dfn, pregIen = model.Pregnancy.Ien, page = model.Paging.CurrentPage });
        }

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        private ActionResult DeleteItem(ChecklistIndex model)
        {
            if (string.IsNullOrWhiteSpace(model.SelectedItemIen))
                this.Error("Please select an item to delete");
            else
            {
                BrokerOperationResult result = this.DashboardRepository.Checklist.DeleteItem(model.SelectedItemIen);

                if (!result.Success)
                    this.Error(result.Message);
                else
                    this.Information("The item has been deleted"); 
            }

            return RedirectToAction("Index");
        }
                
        private ActionResult PostDeletePregItem(PregnancyChecklistIndex model)
        {
            if (string.IsNullOrWhiteSpace(model.SelectedItemIen))
                this.Error("Please select an item to delete");
            else
            {
                BrokerOperationResult result = this.DashboardRepository.Checklist.DeletePregnancyItem(model.Patient.Dfn, model.SelectedItemIen);

                if (!result.Success)
                    this.Error(result.Message);
                else
                {
                    this.Information("The item has been deleted");

                    // *** Update the next checklist date ***
                    BrokerOperationResult updResult = ChecklistUtility.UpdateNextDates(this.DashboardRepository, model.Patient.Dfn, model.Pregnancy.Ien);

                    if (!updResult.Success)
                        this.Error("Error updating next dates: " + updResult.Message); 
                }
            }

            return RedirectToAction("PregnancyIndex", new {dfn= model.Patient.Dfn, pregIen = model.Pregnancy.Ien });
        }

        private ActionResult LoadDefaults(ChecklistIndex model)
        {
            BrokerOperationResult result = this.DashboardRepository.Checklist.LoadDefaultChecklist();

            if (!result.Success)
                this.Error(result.Message);
            else
                this.Information("Default Checklist Items Added Successfully"); 

            return RedirectToAction("Index", new { page = "1" });
        }

        //private PregnancyDetails GetChecklistPregnancy(string dfn, string pregIen)
        //{
        //    PregnancyDetails returnVal = null; 
            
        //    // *** First try the pregnancy ien passed in ***
        //    if (!string.IsNullOrWhiteSpace(pregIen))
        //    {
        //        PregnancyListResult pregResult = this.DashboardRepository.Pregnancy.GetPregnancies(dfn, pregIen);

        //        if (pregResult.Success)
        //            if (pregResult.Pregnancies != null)
        //                if (pregResult.Pregnancies.Count > 0)
        //                    returnVal = pregResult.Pregnancies[0];
        //    }

        //    // *** Then try to get the current/most-recent ***
        //    if (returnVal == null) 
        //    {
        //        PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(dfn); 

        //        if (pregResult.Success) 
        //            returnVal = pregResult.Pregnancy; 
        //    }               

        //    return returnVal; 
        //}

        private ActionResult ClearAllItems()
        {
            ChecklistItemsResult getResult = this.DashboardRepository.Checklist.GetItems("", 1, 1000);

            if (getResult.Success)
            {
                BrokerOperationResult delResult = null;

                foreach (ChecklistItem item in getResult.Items)
                {
                    delResult = this.DashboardRepository.Checklist.DeleteItem(item.Ien);

                    if (!delResult.Success)
                    {
                        this.Error(delResult.Message);
                        break;
                    }
                }

                if (delResult != null)
                    if (delResult.Success)
                        this.Information("Deleted all");
            }

            return RedirectToAction("Index", new { page = "1" });
        }

    }
}
