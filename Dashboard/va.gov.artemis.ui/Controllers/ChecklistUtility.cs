// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.Commands.Dsio.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Checklist;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Checklist;
using VA.Gov.Artemis.UI.Data.Models.Education;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;

namespace VA.Gov.Artemis.UI.Controllers
{
    public static class ChecklistUtility
    {
        public static BrokerOperationResult CompleteEducationItem(IDashboardRepository repo, string patientDfn, string educationItemIen, string checklistItemIen)
        {
            BrokerOperationResult returnResult = new BrokerOperationResult(); 

            // *** Two-step process: 
            // ***      (1) Create completed patient education item 
            // ***      (2) Complete the checklist item 

            PatientEducationItem patItem = new PatientEducationItem()
            {
                PatientDfn = patientDfn,
                EducationItemIen = educationItemIen,
                CompletedOn = DateTime.Now
            };

            IenResult saveResult = repo.Education.SavePatientItem(patItem);

            returnResult.SetResult(saveResult.Success, saveResult.Message);

            if (saveResult.Success)
            {
                PregnancyChecklistItemsResult result = repo.Checklist.GetPregnancyItems(patientDfn, "", checklistItemIen);

                returnResult.SetResult(result.Success, result.Message); 

                if (result.Success)
                {
                    if (result.Items != null)
                        if (result.Items.Count > 0)
                        {
                            PregnancyChecklistItem checkItem = result.Items[0];

                            checkItem.CompletionStatus = DsioChecklistCompletionStatus.Complete;
                            checkItem.CompletionLink = saveResult.Ien;

                            IenResult ienResult = repo.Checklist.SavePregnancyItem(checkItem);

                            returnResult.SetResult(ienResult.Success, ienResult.Message);

                            if (returnResult.Success)
                            {
                                returnResult = UpdateNextDates(repo, patientDfn, checkItem.PregnancyIen);

                                if (returnResult.Success)
                                    returnResult.Message = "Education item completed";                                
                            }
                        }
                }
            }

            return returnResult; 
        }

        public static BrokerOperationResult UpdateNextDates(IDashboardRepository repo, string patientDfn, string pregnancyIen)
        {
            BrokerOperationResult result = new BrokerOperationResult();

            // *** First get the pregnancy ***
            PregnancyListResult pregResult = repo.Pregnancy.GetPregnancies(patientDfn, pregnancyIen); 

            result.SetResult(pregResult.Success, pregResult.Message);

            if (pregResult.Success)
            {
                if (pregResult.Pregnancies != null)
                    if (pregResult.Pregnancies.Count > 0)
                    {

                        // *** Get the checklist items ***

                        PregnancyChecklistItemsResult getResult = GetSortedPregnancyChecklist(repo, patientDfn, pregResult.Pregnancies[0], DsioChecklistCompletionStatus.NotComplete);

                        result.SetResult(getResult.Success, getResult.Message);

                        if (result.Success)
                        {
                            if (getResult.Items != null)
                            {
                                if (getResult.Items.Count > 0)
                                {
                                    // *** Find the next due ***
                                    DateTime nextChecklistDue = getResult.Items[0].DueDate;

                                    // *** Save next checklist observation ***
                                    result = repo.Observations.UpdateNextChecklistDue(patientDfn, nextChecklistDue);

                                    if (result.Success)
                                    {
                                        // *** Find next contact due ***
                                        DateTime nextContactDue = DateTime.MinValue;

                                        foreach (PregnancyChecklistItem item in getResult.Items)
                                            if (item.ItemType == DsioChecklistItemType.MccCall)
                                            {
                                                nextContactDue = item.DueDate;
                                                break;
                                            }

                                        result = repo.Observations.UpdateNextContactDue(patientDfn, nextContactDue);
                                    }
                                }
                            }
                        }
                    }
            }
            return result; 
        }

        public static PregnancyChecklistItemsResult GetSortedPregnancyChecklist(IDashboardRepository repo, string patientDfn, PregnancyDetails pregnancy, DsioChecklistCompletionStatus status)
        {
            PregnancyChecklistItemsResult result = new PregnancyChecklistItemsResult(); 

            PregnancyChecklistItemsResult chkResult = repo.Checklist.GetPregnancyItems(patientDfn, pregnancy.Ien, "", status);

            result.SetResult(chkResult.Success, chkResult.Message);

            if (result.Success)
            {
                PregnancyChecklistItemList tempList = new PregnancyChecklistItemList();
                
                tempList.AddRange(chkResult.Items);

                tempList.AddPregnancyDates(pregnancy.EDD, pregnancy.EndDate);

                tempList.Sort(delegate(PregnancyChecklistItem x, PregnancyChecklistItem y)
                {
                    return x.DueDate.CompareTo(y.DueDate);
                });

                result.Items = tempList; 
            }

            return result; 
        }

    }
}