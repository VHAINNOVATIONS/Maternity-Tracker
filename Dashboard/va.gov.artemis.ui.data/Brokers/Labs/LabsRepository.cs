// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Vpr;
using VA.Gov.Artemis.Commands.Vpr.Data;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Labs;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Labs
{
    public class LabsRepository: RepositoryBase, ILabsRepository
    {
        // *** The file name containing a CSV list of prenatal lab loinc codes ***
        private string prenatalLabLoincFileName { get; set; }

        // *** List of codes to compare with ***
        private List<string> PrenatalLoincCodes { get; set; }

        public LabsRepository(IRpcBroker newBroker, string labFileName) : base(newBroker)
        {
            this.prenatalLabLoincFileName = labFileName; 
        }
        
        /// <summary>
        /// Gets a list of lab results by patient
        /// </summary>
        /// <param name="dfn">Patient's unique DFN</param>
        /// <param name="labType">Type of lab to return (Any or Prenatal Only)</param>
        /// <param name="fromDate">Labs must be after or equal to this date if not min date</param>
        /// <param name="toDate">Labs must be before or equal to this date if not min date</param>
        /// <param name="page">Page of data to retrieve</param>
        /// <param name="itemsPerPage">Number of items on each page</param>
        /// <returns></returns>
        public LabItemsResult GetList(string dfn, LabResultType labType, bool filterByDate, DateTime fromDate, DateTime toDate, int page, int itemsPerPage)
        {
            LabItemsResult result = new LabItemsResult();

            // *** Using DSIO VPR to get a list of all labs ***
            DsioVprGetPatientDataCommand command = new DsioVprGetPatientDataCommand(this.broker);

            // *** Add the arguments ***
            command.AddCommandArguments(dfn, Commands.Vpr.VprDataType.Labs);

            // *** Execute the command ***
            RpcResponse response = command.Execute();

            // *** Add response to return ***
            result.Success = response.Status == RpcResponseStatus.Success;
            result.Message = response.InformationalMessage; 

            // *** Check results ***
            if (result.Success) 
                if (command.PatientResult != null) 
                    if (command.PatientResult.Labs != null)
                        if (command.PatientResult.Labs.Count > 0)
                        {
                            // *** If we have labs to work with ***

                            // *** Set up paging ***
                            int curItem = 0;
                            int first = (page - 1) * itemsPerPage + 1;
                            int last = first + itemsPerPage - 1;
 
                            // *** Go throug all ***
                            foreach (Lab lab in command.PatientResult.Labs)
                            {
                                // *** If matches prenatal filter ***
                                if ((labType == LabResultType.Any) || (this.IsPrenatal(lab)))
                                {
                                    // *** If matches date criteria ***
                                    if (this.LabMatchesDateCriteria(filterByDate, fromDate, toDate, lab))
                                    {
                                        // *** Count the total items that match criteria ***
                                        curItem += 1;

                                        // *** If belongs in current page ***
                                        if ((curItem >= first) && (curItem <= last))
                                        {
                                            // *** Get a lab item based on data ***
                                            LabItem item = GetLabItem(lab);

                                            // *** Create the list if necessary ***
                                            if (result.Labs == null)
                                                result.Labs = new List<LabItem>();

                                            // *** Add to list ***
                                            result.Labs.Add(item);
                                        }
                                    }
                                }
                            }

                            // *** Set total results which match filters ***
                            result.TotalResults = curItem; 
                        }
            return result; 
        }

        private bool LabMatchesDateCriteria(bool filterByDate, DateTime fromDate, DateTime toDate, Lab lab)
        {
            // *** Checks lab against date criteria ***
            //bool returnVal = true;

            //if (lab.Collected != null)
            //{
            //    DateTime dt = Util.GetDateTime(lab.Collected.Value);

            //    if (dt != DateTime.MinValue)
            //    {
            //        if ((dt.Date < fromDate.Date) && (fromDate != DateTime.MinValue))
            //            returnVal = false;

            //        if ((dt.Date > toDate.Date) && (toDate != DateTime.MinValue))
            //            returnVal = false; 
            //    }
            //}

            bool returnVal = false;

            if (!filterByDate)
                returnVal = true; 
            else 
                if (lab.Collected != null)
                {
                    DateTime dt = Util.GetDateTime(lab.Collected.Value);

                    if (dt != DateTime.MinValue)
                        if (fromDate != DateTime.MinValue)
                            if (dt.Date > fromDate.Date) 
                                if (toDate != DateTime.MinValue) 
                                {
                                    if (dt.Date < toDate.Date)
                                        returnVal = true; 
                                }
                                else 
                                    returnVal = true;                                     
                }

            return returnVal; 
        }

        private LabItem GetLabItem(Lab lab)
        {
            // *** Creates a UI LabItem from Lab ***
            LabItem item = new LabItem();

            // *** Id ***
            item.Id = (lab.Id == null) ? "" : lab.Id.Value;

            // *** Specimen ***
            item.Specimen = (lab.Specimen == null) ? "" : lab.Specimen.Name;

            // *** Collected ***
            if (lab.Collected != null)
            {
                DateTime dt = Util.GetDateTime(lab.Collected.Value);

                if (dt != DateTime.MinValue)
                    item.CollectionDateTime = dt.ToString(VistaDates.UserDateTimeFormat);
            }

            // *** Name of Test ***
            item.Test = (lab.Test == null) ? "" : lab.Test.Value;

            // TODO: What is status...? lab.Status.Value

            // *** Status ***
            item.ResultStatus = (lab.Result == null) ? "" : lab.Result.Value;

            // *** Flag ***
            item.Flag = (lab.Interpretation == null) ? "" : lab.Interpretation.Value;

            // *** Units ***
            item.Units = (lab.Units == null) ? "" : lab.Units.Value;

            // *** Ref Range ***
            if ((lab.Low != null) && (lab.High != null))
                item.RefRange = string.Format("{0} - {1}", lab.Low.Value, lab.High.Value);

            // *** Loinc ***
            item.Loinc = (lab.Loinc == null) ? "" : lab.Loinc.Value;

            return item; 
        }

        private bool IsPrenatal(Lab lab)
        {
            // *** Checks if a lab is prenatal ***

            bool returnVal = false; 

            // *** Loads the codes from the csv file, if not already loaded ***
            this.LoadLoincCodes();

            // *** If there's a loinc to test, check if it's in the list ***
            if (lab.Loinc != null)
                returnVal = this.PrenatalLoincCodes.Contains(lab.Loinc.Value); 
            
            return returnVal; 
        }

        private void LoadLoincCodes()
        {
            // *** Load the codes if not done already ***

            string errorMessage = string.Format("Loinc Codes File Not Found: '{0}'", this.prenatalLabLoincFileName); 

            // *** Make sure we have not already populated the codes ***
            if (this.PrenatalLoincCodes == null)
            {
                // *** If no file name, can't load, need to throw exception and get resolved ***
                if (string.IsNullOrWhiteSpace(this.prenatalLabLoincFileName))
                    throw new FileNotFoundException(errorMessage);
                else
                {
                    // *** Check if the file exists ***
                    if (File.Exists(this.prenatalLabLoincFileName))
                    {
                        // *** Read the lines ***
                        string[] lines = System.IO.File.ReadAllLines(this.prenatalLabLoincFileName);

                        // *** Create the list ***
                        this.PrenatalLoincCodes = new List<string>();

                        // *** Go through all the linse ***
                        foreach (string line in lines)
                        {
                            // *** Piece 2 contains the Loinc ***
                            string piece2 = Util.Piece(line, ",", 2);

                            // *** Add to list **
                            this.PrenatalLoincCodes.Add(piece2);
                        }
                    }
                    else
                        throw new FileNotFoundException(errorMessage);
                }
            }
        }

    }
}
