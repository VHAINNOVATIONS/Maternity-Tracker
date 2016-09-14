using System;
using System.Globalization;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.ValueSets;
using VA.Gov.Artemis.Commands.Dsio.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Brokers.Cda
{
    public class CdaRepository: RepositoryBase, ICdaRepository
    {
        public CdaRepository(IRpcBroker tempBroker): base(tempBroker)
        { }
        
        public IenResult SaveDocument(CdaDocumentData documentData)
        {
            // *** Save a document to vista ***

            IenResult result = new IenResult();

            // *** Strings for direction to be stored in VistA ***
            string[] ExchangeDirectionDescription = {"IN", "OUT"}; 
 
            if (this.broker != null)
            {
                // *** Create the command ***
                DsioSaveIheDocCommand command = new DsioSaveIheDocCommand(broker);

                // *** Add the arguments ***
                command.AddCommandArguments(
                    documentData.Ien, 
                    documentData.Id, 
                    documentData.PatientDfn,
                    ExchangeDirectionDescription[(int)documentData.ExchangeDirection],
                    documentData.CreationDateTime.ToString(VistaDates.VistADateFormatFour),
                    documentData.ImportDateTime.ToString(VistaDates.VistADateFormatFour),
                    CdaUtility.DocumentTypeAbbreviation[(int)documentData.DocumentType],
                    documentData.Title,
                    documentData.Sender,
                    documentData.IntendedRecipient,
                    documentData.DocumentContent);

                // *** Execute and get response ***
                RpcResponse response = command.Execute();

                // *** Add command response to result ***
                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                if (result.Success)
                    result.Ien = response.Data; 

            }

            return result; 
        }

        public CdaDocumentListResult GetExchangeHistory(string patientDfn, int page, int itemsPerPage)
        {
            // *** Get list of exchanged documents for a patient ***
            // *** Supports paging ***

            CdaDocumentListResult result = new CdaDocumentListResult();

            // *** Check broker ***
            if (this.broker != null)
            {
                // *** Create the command ***
                //DsioIhePatientListCommand command = new DsioIhePatientListCommand(this.broker);
                DsioGetIheDocsCommand command = new DsioGetIheDocsCommand(this.broker); 

                // *** Add the arguments, patient, paging ***
                command.AddCommandArguments(patientDfn,"", page, itemsPerPage);

                // *** Execute the command ***
                RpcResponse response = command.Execute();

                // *** Add results to return ***
                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                // *** If successful, continue ***
                if (result.Success)
                {
                    // *** Add total results to return ***
                    result.TotalResults = command.TotalResults;

                    if (result.TotalResults > 0)
                    {
                        // *** Check if we have something and loop ***
                        if (command.DocumentList != null)
                            if (command.DocumentList.Count > 0)
                                foreach (DsioCdaDocument dsioDoc in command.DocumentList)
                                {
                                    // *** Create strongly typed object from string-based Dsio object ***
                                    CdaDocumentData docData = GetDocumentData(dsioDoc);

                                    // *** If we have something to work with... ***
                                    if (docData != null)
                                    {
                                        // *** Add patient dfn ***
                                        docData.PatientDfn = patientDfn;

                                        // *** Add to return list ***
                                        result.DocumentList.Add(docData);
                                    }
                                }
                    }
                }
            }

            return result; 
        }

        public CdaDocumentResult GetDocumentData(string id)
        {
            // *** Get data for a single document (Header and Content) ***

            CdaDocumentResult result = new CdaDocumentResult();

            // *** Check broker ***
            if (this.broker != null)
            {
                // *** Create the command ***
                //DsioIheGetDocCommand command = new DsioIheGetDocCommand(this.broker);
                DsioGetIheContentCommand contentCommand = new DsioGetIheContentCommand(this.broker); 

                contentCommand.AddCommandArguments(id); 

                // *** Execute ***
                RpcResponse response = contentCommand.Execute();

                // *** Record success/message ***
                result.Success = (response.Status == RpcResponseStatus.Success);
                result.Message = response.InformationalMessage;

                // *** If successful continue ***
                if (result.Success)
                {
                    if (contentCommand.Document != null)
                    {
                        // *** Hold the content ***
                        string tempContent = contentCommand.Document.Content;

                        DsioGetIheDocsCommand docCommand = new DsioGetIheDocsCommand(this.broker);

                        docCommand.AddCommandArguments("", id, -1, -1);

                        // *** Execute the command ***
                        response = docCommand.Execute();

                        // *** Add results to return ***
                        result.Success = (response.Status == RpcResponseStatus.Success);
                        result.Message = response.InformationalMessage;

                        // *** If successful continue ***
                        if (result.Success)
                        {
                            if (docCommand.DocumentList != null)
                            {
                                if (docCommand.DocumentList.Count == 1)
                                {
                                    // *** Get the document (header) data ***
                                    result.DocumentData = GetDocumentData(docCommand.DocumentList[0]);

                                    // *** Add the content from previous call ***
                                    result.DocumentData.DocumentContent = tempContent;

                                    // *** Repopulate ien ***
                                    result.DocumentData.Ien = id;
                                }
                            }
                        }

                    }
                }
            }

            return result; 
        }

        private CdaDocumentData GetDocumentData(DsioCdaDocument dsioDoc)
        {
            // *** Gets strongly typed Cda data from Dsio data ***
            CdaDocumentData returnDocument = new CdaDocumentData();

            // *** Convert Create Date to DateTime ***
            //CultureInfo enUS = new CultureInfo("en-US");
            //DateTime tempDateTime;
            //if (DateTime.TryParseExact(dsioDoc.CreatedOn, RepositoryDates.VistADateFormatOne, enUS, DateTimeStyles.None, out tempDateTime))
            //    returnDocument.CreationDateTime = tempDateTime;
            returnDocument.CreationDateTime = VistaDates.ParseDateString(dsioDoc.CreatedOn, VistaDates.VistADateFormatFour); 

            // *** Convert Import/Export to DateTime ***
            //if (DateTime.TryParseExact(dsioDoc.ImportExportDate, RepositoryDates.VistADateFormatOne, enUS, DateTimeStyles.None, out tempDateTime))
            //    returnDocument.ImportDateTime = tempDateTime;
            returnDocument.ImportDateTime = VistaDates.ParseDateString(dsioDoc.ImportExportDate, VistaDates.VistADateFormatFour); 

            // *** Get index of value which will match enum ***
            int idx = Array.IndexOf(CdaUtility.DocumentTypeAbbreviation, dsioDoc.DocumentType);

            // *** Convert to enum ***
            if (idx > -1)
                returnDocument.DocumentType = (IheDocumentType)idx;

            // *** Determine if in/out ***
            returnDocument.ExchangeDirection = (dsioDoc.Direction == "IN") ? ExchangeDirection.Inbound : ExchangeDirection.Outbound;

            // *** Populate id's as is ***
            returnDocument.Id = dsioDoc.Id;
            returnDocument.Ien = dsioDoc.Ien;

            // *** Populate as is ***
            returnDocument.IntendedRecipient = dsioDoc.IntendedRecipient;
            returnDocument.Sender = dsioDoc.Sender;
            returnDocument.Title = dsioDoc.Title;

            return returnDocument; 
        }

        public CdaValueSetResult GetValueSet(ValueSetType valueSetType)
        {
            CdaValueSetResult result = new CdaValueSetResult();

            // TODO: Get these value sets from xml or vista...

            switch (valueSetType)
            {
                case ValueSetType.AntepartumEducation:
                    result.ValueSet = new AntepartumEducationValueSet();
                    result.Success = true; 
                    break;
                case ValueSetType.HistoryOfInfection:
                    result.ValueSet = new HistoryOfInfectionValueSet();
                    result.Success = true; 
                    break; 
                case ValueSetType.HistoryOfPastIllness:
                    result.ValueSet = new HistoryOfPastIllnessValueSet();
                    result.Success = true; 
                    break; 
                case ValueSetType.AntepartumFamilyHistory:
                    result.ValueSet = new AntepartumFamilyHistoryValueSet();
                    result.Success = true;
                    break; 
                case ValueSetType.MenstrualHistory:
                    result.ValueSet = new MenstrualHistoryValueSet();
                    result.Success = true;
                    break; 
            }

            return result; 
        }
    }
}
