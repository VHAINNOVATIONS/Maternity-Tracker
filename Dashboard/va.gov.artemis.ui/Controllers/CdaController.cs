// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Web.Mvc;
using System.Linq;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.IHE;
using VA.Gov.Artemis.CDA.Observations;
using VA.Gov.Artemis.CDA.RecordTarget;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Cda;
using VA.Gov.Artemis.UI.Data.Brokers.Common;
using VA.Gov.Artemis.UI.Data.Brokers.Notes;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;
using VA.Gov.Artemis.UI.Data.Cda;
using VA.Gov.Artemis.UI.Data.Models;
using VA.Gov.Artemis.UI.Data.Models.Cda;
using VA.Gov.Artemis.UI.Data.Models.Common;
using VA.Gov.Artemis.UI.Data.Models.Notes;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.UI.Data.Models.PatientSearch;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.UI.Filters;
using VA.Gov.Artemis.Vista.Utility;
using VA.Gov.Artemis.CDA.Raw;
using VA.Gov.Artemis.CDA.IHE.Documents;
using VA.Gov.Artemis.UI.Data.Brokers.Radiology;
using VA.Gov.Artemis.UI.Data.Brokers.Pregnancy;
using VA.Gov.Artemis.UI.Data.Models.Edd;
using VA.Gov.Artemis.UI.Data.Models.Education;

namespace VA.Gov.Artemis.UI.Controllers
{
    [DisableLocalCache]
    [VerifySession]
    [Authorize]
    public class CdaController : DashboardController
    {
        private const string styleSheetFileName = "CDA.xsl";
        private const string warningFileName = "WARNING READ THIS.txt";

        private const string outgoingVirtualPath = "~/Content/Cda/";
        private const string outgoingPhysicalPath = "Content\\cda\\"; 
        
        private const string outgoingCdaDocsSessionKey = "OutgoingCdaDocs";

        private const string uploadFileKey = "UploadFile";

        private const int patientMatchesPerPage = 10; 

        // *** Default constructor used by MVC ***
        public CdaController() : base() {}

        [HttpGet]
        public ActionResult Index(string dfn, string page)
        {
            // *** Get patient demographics ***
            CdaIndex model = new CdaIndex();
            model.Patient = this.CurrentPatient;

            // *** Get page requested ***
            int pageNum = this.GetPage(page); 

            // *** Get exchange history data ***
            CdaDocumentListResult result = this.DashboardRepository.CdaDocuments.GetExchangeHistory(dfn, pageNum, DefaultResultsPerPage);

            // *** Check result ***
            if (!result.Success)
            {
                model.DocumentList = new List<CdaDocumentData>();
                if (!string.IsNullOrWhiteSpace(result.Message))
                    this.Error(result.Message);
            }
            else
            {
                // *** Add document list to model ***
                model.DocumentList = result.DocumentList;

                // *** Set paging data ***
                model.Paging.SetPagingData(DefaultResultsPerPage,pageNum, result.TotalResults);
                model.Paging.BaseUrl = Url.Action("Index", new { page = "" });
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult Options(string dfn, string documentType)
        {
            ActionResult returnResult; 

            // *** Get patient demographics ***
            CdaOptions model = new CdaOptions();
            model.Patient = this.CurrentPatient;

            IheDocumentType docType;

            // *** Parse document title ***
            if (Enum.TryParse<IheDocumentType>(documentType, out docType))
            {                
                List<TiuNoteTitle> titles = null;
                string titleDescription = ""; 

                // *** Determine document type + get corresponding titles ***
                model.DocumentType = docType; 

                switch (docType)
                {
                    case IheDocumentType.APHP:
                        titles = new List<TiuNoteTitle>() { TiuNoteTitle.OBHPConsult, TiuNoteTitle.OBHistory };
                        titleDescription = "OB H&P Consult/History";
                        model.SourceTypeDictionary.Add("OBNote", "OB H&P Consult");
                        break;

                    case IheDocumentType.APS:
                        titles = new List<TiuNoteTitle>() { TiuNoteTitle.OBFollowUpNote };
                        titleDescription = "OB Follow Up Note";
                        model.SourceTypeDictionary.Add("OBNote", "OB Follow Up");
                        break;

                    case IheDocumentType.PPVS:
                        titles = new List<TiuNoteTitle>(); // { TiuNoteTitle.NursePostpartumMaternal, TiuNoteTitle.NursePostpartumDelivery };
                        titleDescription = "Pregnancy";
                        model.SourceTypeDictionary.Add("OBNote", "Pregnancy");
                        model.SourceTypeDictionary.Remove("DateRange");

                        // *** Get the pregnancies ***
                        List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

                        // *** Get the selection ***
                        model.SelectDictionary = PregnancyUtilities.GetPregnanciesSelectionPpvs(pregList);

                        break;

                    case IheDocumentType.XDR_I:
                        titles = new List<TiuNoteTitle>(); 
                        titleDescription = "Radiology Report";
                        model.SourceTypeDictionary.Add("OBNote", "Report");
                        model.SourceTypeDictionary.Remove("DateRange");

                        // *** Get radiology reports ***
                        RadiologyReportsResult radResult = this.DashboardRepository.Radiology.GetReports(dfn);

                        if (radResult.Success)
                        {
                            if (radResult.Items.Count > 0)
                            {
                                model.SelectDictionary.Add("", "(Select)");
                                foreach (var item in radResult.Items)
                                {
                                    string key = string.Format("{0}|{1}", item.ExamDateTime.ToString("O"), item.Procedure); 

                                    model.SelectDictionary.Add(key, string.Format("{0} - {1}", item.ExamDateTimeDisplay, item.Procedure));
                                }
                            }                            
                        }

                        break; 
                }

                if (titles != null)
                {
                    // *** Get notes based on titles ***
                    NoteListResult result = this.DashboardRepository.Notes.GetNotesByTitle(titles, dfn, 1, 100, "");

                    // *** Add to dictionary ***
                    if (result.Success)
                        if (result.Notes.Count > 0)
                        {
                            model.SelectDictionary.Add("-1", "(Select)"); 
                            foreach (TiuNote note in result.Notes)
                                model.SelectDictionary.Add(note.Ien, string.Format("{0} on {1}", titleDescription, note.DocumentDateTime));
                        }

                    // *** Message if none available ***
                    if (model.SelectDictionary.Count == 0)
                        model.SelectDictionary.Add("-1", string.Format("(No {0} Notes Found)", titleDescription));
                }

                returnResult = View(model);
            }
            else
            {
                this.Error(string.Format("An error has occurred: Unknown document type, [{0}]", documentType));
                returnResult = RedirectToAction("Index", new { dfn = dfn, page = "1" });
            }

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Generate(CdaOptions options)
        {
            ActionResult returnResult; 

            // *** Generate document based on options selected ***

            this.CurrentPatientDfn = options.Patient.Dfn;

            // *** Get the patient ***
            CdaDocumentModel model = new CdaDocumentModel();
            model.Patient = this.CurrentPatient;

            // *** Validate the options ***
            if (options.Validate() == true)
            {
                // *** Gather up the source data for the document ***
                CdaCollector collector = new CdaCollector(this.DashboardRepository);
                CdaSourceResult sourceResult = collector.GetSource(options);

                if (!sourceResult.Success)
                {
                    if (!string.IsNullOrWhiteSpace(sourceResult.Message))
                        this.Error(sourceResult.Message);
                }
                else
                {
                    // *** Serialize ***
                    string xmlContent = "";
                    string recipient = ""; 
                    string sender = "";

                    switch (options.DocumentType)
                    {
                        case IheDocumentType.APHP:
                            // *** Use translator to convert from source to Rich CDA Doc ***
                            AphpDocument aphpDoc = CdaDocumentFactory.CreateAphpDocument(sourceResult.Source);

                            // *** Get Raw ***
                            RawAphpDocument rawAphp = aphpDoc.ToRawDocument();

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializeAphp(rawAphp);
                            recipient = aphpDoc.Recipient.ToString();
                            sender = aphpDoc.RecordTarget.ProviderOrganization.Name;
                            break;

                        case IheDocumentType.APS:
                            ApsDocument apsDoc = CdaDocumentFactory.CreateApsDocument(sourceResult.Source);

                            RawApsDocument rawAps = apsDoc.ToRawDocument();

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializeAps(rawAps);
                            recipient = apsDoc.Recipient.ToString();
                            sender = apsDoc.RecordTarget.ProviderOrganization.Name;
                            
                            break;

                        case IheDocumentType.APE:
                            ApeDocument apeDoc = CdaDocumentFactory.CreateApeDocument(sourceResult.Source);
                            RawApeDocument rawApe = apeDoc.ToRawDocument();

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializeApe(rawApe);
                            recipient = apeDoc.Recipient.ToString();
                            sender = apeDoc.RecordTarget.ProviderOrganization.Name; 
                            
                            break;

                        case IheDocumentType.APL:
                            AplDocument aplDoc = CdaDocumentFactory.CreateAplDocument(sourceResult.Source);
                            RawAplDocument rawApl = aplDoc.ToRawDocument(); 

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializeApl(rawApl); 
                            recipient = aplDoc.Recipient.ToString();
                            sender = aplDoc.RecordTarget.ProviderOrganization.Name; 
                            
                            break;

                        case IheDocumentType.PPVS:
                            PpvsDocument ppvsDoc = CdaDocumentFactory.CreatePpvsDocument(sourceResult.Source);
                            RawPpvsDocument rawPpvs = ppvsDoc.ToRawDocument();

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializePpvs(rawPpvs);
                            recipient = ppvsDoc.Recipient.ToString();
                            sender = ppvsDoc.RecordTarget.ProviderOrganization.Name;

                            break;

                        case IheDocumentType.XDR_I:
                            XdriDocument xdriDoc = CdaDocumentFactory.CreateXdriDocument(sourceResult.Source);
                            RawXdriDocument rawXdri = xdriDoc.ToRawDocument();

                            // *** Serialize ***
                            xmlContent = CdaUtility.SerializeXdri(rawXdri);
                            recipient = xdriDoc.Recipient.ToString();
                            sender = xdriDoc.RecordTarget.ProviderOrganization.Name; 

                            break; 
                    }

                    if (!string.IsNullOrWhiteSpace(xmlContent))
                    {
                        // *** Create the model data ***
                        model.Data = CdaDocumentData.Create(
                            sourceResult.Source.DocumentId, 
                            xmlContent, 
                            options.Patient.Dfn, 
                            options.DocumentType, 
                            recipient, 
                            sender);

                        // *** Construct file name ***
                        string firstPart = CdaUtility.GetDocumentAbbreviation(options.DocumentType);
                        string fileName = PrepareFile(firstPart, model.Patient.Name, xmlContent);

                        // *** 
                        if (!string.IsNullOrWhiteSpace(fileName))
                            model.FileName = Url.Content(fileName);
                        else
                            this.Error("The document could not be generated");
                    }
                }

                returnResult = View("PreviewDocument", model);
            }
            else
            {
                this.Error(options.ValidationMessage);
                returnResult = RedirectToAction("Options", new { dfn = options.Patient.Dfn, documentType = options.DocumentType.ToString() });
            }

            return returnResult; 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Download(CdaDocumentModel model)
        {
            // *** Download the passed in (relative) file name ***

            ActionResult returnResult;

            this.CurrentPatientDfn = model.Patient.Dfn; 
            model.Patient = this.CurrentPatient; 

            model.Data.ImportDateTime = DateTime.Now;

            // *** Get full local name ***
            string fullName = this.Request.MapPath(model.FileName);

            model.Data.DocumentContent = System.IO.File.ReadAllText(fullName);

            IenResult iheResult = this.DashboardRepository.CdaDocuments.SaveDocument(model.Data);

            if (!iheResult.Success)
            {
                this.Error(iheResult.Message);
                returnResult = RedirectToAction("Options", new { dfn = model.Patient.Dfn });
            }
            else
            {
                // *** Get the name only ***
                string nameOnly = Path.GetFileName(model.FileName);

                // *** Return a FileResult ***
                // returnResult = File(fullName, "text/xml", nameOnly);

                returnResult = ProcessFileOutput(model, fullName);

            }

            return returnResult; 
        }

        private ActionResult ProcessFileOutput(CdaDocumentModel model, string fullName)
        {
            ActionResult returnResult;

            CdaSettingsResult settingsResult = this.DashboardRepository.Settings.GetCdaSettings();

            if (!settingsResult.Success)
                this.Error(settingsResult.Message);
            else
            {
                if (!Directory.Exists(settingsResult.CdaExportFolder))
                    this.Error("The file could not be exported.  The destination directory does not exist.  Please check your export folder configuration.");
                else
                {
                    CopyStyleSheet(settingsResult.CdaExportFolder);
                    CopyWarningFile(settingsResult.CdaExportFolder);

                    //string newName = Path.Combine(settingsResult.CdaExportFolder, nameOnly);
                    string firstPart = CdaUtility.GetDocumentAbbreviation(model.Data.DocumentType);

                    string newName = this.GetUniqueFileName(firstPart, model.Patient.Name, settingsResult.CdaExportFolder);

                    if (!string.IsNullOrWhiteSpace(newName))
                    {
                        System.IO.File.Copy(fullName, newName);

                        this.Information(string.Format("The document has been saved to '{0}'", newName));
                    }
                    else
                        this.Error("Could not generate unique name for the file");
                }
            }

            returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn });

            return returnResult;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Export(CdaDocumentModel model)
        {
            // *** Download the passed in (relative) file name ***

            ActionResult returnResult;

            this.CurrentPatientDfn = model.Patient.Dfn;
            model.Patient = this.CurrentPatient; 

            // *** Get full local name ***
            string fullName = this.Request.MapPath(model.FileName);

            // *** Get the name only ***
            string nameOnly = Path.GetFileName(model.FileName);

            // *** Return a FileResult ***
            //returnResult = File(fullName, "text/xml", nameOnly);
            returnResult = ProcessFileOutput(model, fullName);

            return returnResult; 
        }

        [HttpGet]
        public ActionResult DownloadStyleSheet()
        {
            // *** Download the style sheet ***

            ActionResult returnResult;

            // *** Get full local name ***
            string fullName = this.Request.MapPath(outgoingVirtualPath + styleSheetFileName);

            // *** Return FileResult ***
            returnResult = File(fullName, "text/xml", styleSheetFileName);

            return returnResult;
        }

        [HttpGet]
        public ActionResult DocumentView(string dfn, string ien)
        {
            // *** Show a single document ***

            // *** Get patient demographics ***
            CdaDocumentModel model = new CdaDocumentModel();
            model.Patient = this.CurrentPatient;

            // *** Get the data ***
            CdaDocumentResult result = this.DashboardRepository.CdaDocuments.GetDocumentData(ien);

            // *** Check for success ***
            if (!result.Success)
            {
                model.Data = new CdaDocumentData();
                if (!string.IsNullOrWhiteSpace(result.Message))
                    this.Error(result.Message);
            }
            else
            {
                // *** Add resulting data to model ***
                model.Data = result.DocumentData;

                // *** Create a guid for the file name ***                
                string tempFileName = string.Format("{0}.xml", Guid.NewGuid());

                // *** Combine with path for full name ***
                string fullFileName = Path.Combine(FullOutgoingPath, tempFileName);
                
                // *** Write the content ***
                string fileName = WriteTemporaryFile(fullFileName, result.DocumentData.DocumentContent);

                // *** Check result ***
                if (!string.IsNullOrWhiteSpace(fileName))
                    model.FileName = Url.Content(fileName);
                else
                    this.Error("The document could not be generated");
            }

            return View(model); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Upload(CdaIndex model)
        {
            ActionResult returnResult = null; 

            if (this.Request.Files != null)
                if (this.Request.Files.Count > 0)
                {
                    HttpPostedFileBase file = this.Request.Files[0];
                    if (file != null && file.ContentLength > 0)
                    {
                        string fileName = string.Format("{0}.xml", Guid.NewGuid());

                        string path = Path.Combine(Server.MapPath("~/Content/Cda"), fileName);

                        file.SaveAs(path);

                        this.TempData[uploadFileKey] = path; 

                        returnResult = RedirectToAction("PreviewUpload", new { dfn = model.Patient.Dfn });
                    }
                }

            if (returnResult == null) 
                returnResult = RedirectToAction("Index", new { @dfn = model.Patient.Dfn });

            return returnResult;
        }

        [HttpGet]
        public ActionResult PreviewUpload(string dfn)
        {
            // *** Preview the upload file if it is supported ***

            ActionResult returnResult = null;

            CdaDocumentModel model = new CdaDocumentModel();

            model.Patient = this.CurrentPatient;

            // *** First verify that this is a file we can work with ***

            // *** Get the file name from temp data ***
            string file = (string)this.TempData.Peek(uploadFileKey);

            //// *** Get the string content ***
            //string documentContent = System.IO.File.ReadAllText(file); 

            //// *** Check if document is supported using repository method ***
            ////BrokerOperationResult result = this.DashboardRepository.CdaDocuments.DocumentIsSupported(documentContent);
            ////bool supported = CdaUtility.DocumentIsSupported(documentContent); 
            //Nullable<IheDocumentType> docType = CdaUtility.GetDocumentType(documentContent);

            CdaImporter importer = new CdaImporter(file);

            Nullable<IheDocumentType> docType = importer.DocumentType; 

            // *** Check result ***
            if (!docType.HasValue)
            {
                this.Error("The document is not a supported document format");
                returnResult = RedirectToAction("Index", new { @dfn = dfn });
            }
            else
            {
                // *** Display it ***

                string fileNameOnly = Path.GetFileName(file); 

                string virtualPath = Url.Content("~/Content/Cda/" + fileNameOnly); 

                model.FileName = virtualPath;
                
                returnResult = View(model); 
            }

            return returnResult;
        }

        [HttpGet]
        public ActionResult PatientMatch(string dfn, string page)
        {
            CdaPatientMatch matchModel = new CdaPatientMatch();

            // *** Set current patient ***
            //this.CurrentPatientDfn = dfn;
            //BasePatient currentPatient = this.CurrentPatient; 

            // *** Add dfn to model ***
            //matchModel.CurrentPatientDfn = dfn;
            matchModel.Patient = this.CurrentPatient; 

            // *** Get integer for page ***
            int pageVal = this.GetPage(page); 

            // *** Get the file name from temp data ***
            string file = (string)this.TempData.Peek(uploadFileKey);

            // *** Get the string content ***
            //string documentContent = System.IO.File.ReadAllText(file); 

            // *** Find the patient in the document ***
            //PatientDemographicsResult result = this.DashboardRepository.CdaDocuments.GetDocumentPatient(documentContent);
            //CdaPatient extractedPatient = CdaUtility.ExtractDocumentPatient(documentContent);

            CdaImporter importer = new CdaImporter(file);
            
            CdaRecordTarget recTarget = importer.ExtractRecordTarget(); 

            string noExtractMessage = "The system could not extract the patient information from this document";
            if (recTarget == null)
                this.Error(noExtractMessage); 
            else 
            {
                if (string.IsNullOrWhiteSpace(recTarget.Patient.Name.Last) || string.IsNullOrWhiteSpace(recTarget.Patient.Name.First))
                    this.Error(noExtractMessage);
                else
                {
                    // *** Add document patient to model ***
                    matchModel.DocumentPatient = new BasePatient();
                    matchModel.DocumentPatient.LastName = recTarget.Patient.Name.Last;
                    matchModel.DocumentPatient.FirstName = recTarget.Patient.Name.First;
                    matchModel.DocumentPatient.FullSSN = recTarget.SSN;
                    matchModel.DocumentPatient.DateOfBirth = recTarget.Patient.DateOfBirth;
                    if (recTarget.SSN.Length >= 9)
                        matchModel.DocumentPatient.Last4 = recTarget.SSN.Substring(5, 4);

                    // *** See if we have a match with current ***
                    MatchType tempMatchType = CdaMatchingUtility.GetMatchType(matchModel.DocumentPatient, matchModel.Patient);
                    switch (tempMatchType)
                    {
                        case MatchType.Exact:

                            // *** Create a matched patient for view ***
                            CdaMatchedPatient matchPat = new CdaMatchedPatient();

                            // *** Set match type and pat values ***
                            matchPat.MatchType = tempMatchType;
                            matchPat.Patient = matchModel.Patient;

                            // *** Make sure list exists and add ***
                            if (matchModel.MatchingPatients == null)
                                matchModel.MatchingPatients = new List<CdaMatchedPatient>();
                            matchModel.MatchingPatients.Add(matchPat);

                            // *** Set proper paging values...hide ***
                            matchModel.Paging.SetPagingData(patientMatchesPerPage, pageVal, 1);

                            break;

                        case MatchType.Partial:
                        case MatchType.None:

                            // *** Do a "progressive" search to find matches ***
                            PatientSearchResult searchResult =
                                this.DashboardRepository.Patients.ProgressiveSearch(
                                    matchModel.DocumentPatient.LastName,
                                    matchModel.DocumentPatient.FirstName,
                                    pageVal,
                                    patientMatchesPerPage);

                            // *** Check result ***
                            if (!searchResult.Success)
                            {
                                if (!string.IsNullOrWhiteSpace(searchResult.Message))
                                    this.Error(searchResult.Message);
                            }
                            else
                            {
                                // *** Do we have any patients to work with ***
                                if (searchResult.Patients != null)
                                    foreach (SearchPatient pat in searchResult.Patients)
                                    {
                                        // *** Create a matched patient for each ***
                                        CdaMatchedPatient tempMatch = new CdaMatchedPatient();
                                        tempMatch.Patient = (BasePatient)pat;
                                        tempMatch.MatchType = CdaMatchingUtility.GetMatchType(matchModel.DocumentPatient, tempMatch.Patient);
                                        matchModel.MatchingPatients.Add(tempMatch);
                                    }

                                // *** Set paging values ***
                                matchModel.Paging.SetPagingData(DefaultResultsPerPage, pageVal, searchResult.TotalResults);
                                matchModel.Paging.BaseUrl = Url.Action("PatientMatch", new { dfn = dfn, page = "" });
                            }
                            break;
                    }
                }            
            }
            
            return View(matchModel);
        }

        [HttpGet]
        public ActionResult DataImport(string dfn)
        {
            ActionResult returnResult; 

            CdaDataImportModel model = new CdaDataImportModel(); 
            
            // *** Set current patient ***
            this.CurrentPatientDfn = dfn;
            model.Patient = this.CurrentPatient;

            // *** Get the file name from temp data ***
            string file = (string)this.TempData.Peek(uploadFileKey);

            // *** Create the importer ***
            CdaImporter importer = new CdaImporter(file);

            // *** Determine document type ***
            Nullable<IheDocumentType> docType = importer.DocumentType; 

            // *** Check document type ***
            if (!docType.HasValue)
                this.Error("Invalid document.  The document type could not be determined");
            else
            {
                // *** Add document type to the model ***
                model.DocumentType = docType.Value;

                // *** Extract the elements as observations ***
                model.Observations = importer.ExtractDataElements(); 
            }

            // *** Check if we have any ***
            if (model.Observations.Count > 0)
                returnResult = View(model);
            else
            {
                // *** If none, skip observation confirmation view ***
                this.Information("No discrete data elements found to import");
                returnResult = View(model); // RedirectToAction("FinishImport");
            }

            return returnResult; 
        }

        //private void AddPregnancySelectionToModel(string dfn, CdaDataImportModel model)
        //{
        //    // *** Get a list of pregnancies ***
        //    List<PregnancyDetails> pregList = PregnancyUtilities.GetPregnancies(this.DashboardRepository, dfn);

        //    // *** Get pregnancy selection dictionary ***
        //    model.Pregnancies = PregnancyUtilities.GetPregnanciesSelection(pregList, false);

        //    // *** Default to current pregnancy ***
        //    foreach (PregnancyDetails preg in pregList)
        //        if (preg.RecordType == PregnancyRecordType.Current)
        //            model.PregnancyIen = preg.Ien; 
        //}

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FinishImport(CdaDataImportModel model)
        {
            ActionResult returnResult;

            this.CurrentPatientDfn = model.Patient.Dfn; 

            // *** Get the file name from temp data ***
            string file = (string)this.TempData.Peek(uploadFileKey);

            // *** Get the string content ***
            //string documentContent = System.IO.File.ReadAllText(file);

            CdaImporter importer = new CdaImporter(file);

            // *** Get data from document ***
            CdaExtractedHeader header = importer.ExtractDocumentHeader();

            bool fail = false; 

            // *** Check result ***
            if (header == null)
            {
                this.Error("Header information could not be extracted from this document"); 
                fail = true; 
            }
            else
            {
                // *** Create new document ***
                CdaDocumentData newDocument = CreateNewCdaDocument(header, model.Patient.Dfn, importer.DocumentContent);                 

                if (string.IsNullOrWhiteSpace(newDocument.Sender))
                    newDocument.Sender = "Unknown"; 

                // *** Save the document ***
                IenResult result = this.DashboardRepository.CdaDocuments.SaveDocument(newDocument);

                // *** Check result ***
                if (!result.Success)
                {
                    if (!string.IsNullOrWhiteSpace(result.Message))
                        this.Error(result.Message);
                    fail = true;
                }
                else
                {
                    // *** Get CDA IEN ***
                    string exchangeDocIen = result.Ien; 

                    // *** Get full local name ***
                    string styleSheetFile = this.Request.MapPath(outgoingVirtualPath + styleSheetFileName);

                    // *** Convert content to text ***
                    string textContent = CdaUtility.ConvertDocToText(importer.DocumentContent, styleSheetFile); 

                    // *** Save as progress note ***

                    IenResult ienResult = this.DashboardRepository.Notes.CreateNote(TiuNoteTitle.DashboardCdaIncoming, model.Patient.Dfn, textContent, newDocument.Title, null, "");

                    // *** Check result ***
                    if (!ienResult.Success)
                    {
                        if (!string.IsNullOrWhiteSpace(ienResult.Message))
                            this.Error(ienResult.Message);
                        fail = true;
                    }
                    else
                    {
                        // *** Sign note ***
                        if (!string.IsNullOrWhiteSpace(model.ESig))
                        {
                            BrokerOperationResult signResult = this.DashboardRepository.Notes.SignNote(ienResult.Ien, model.ESig);

                            if (!signResult.Success)
                                this.Error(string.Format("The note could not be signed: {0}", signResult.Message));
                        }

                        this.ImportDataElements(model, exchangeDocIen); 
                     
                        // *** Report success ***
                        this.Information("The document has been successfully imported into the dashboard");
                    }                
                }
            }

            // *** Determine where to go from here ***
            if (fail)
                returnResult = RedirectToAction("DataImport", new { dfn = model.Patient.Dfn });
            else
            {
                // *** Clean up ***
                System.IO.File.Delete(file);
                TempData.Remove(uploadFileKey);

                returnResult = RedirectToAction("Index", new { dfn = model.Patient.Dfn });
            }

            return returnResult; 
        }

        private void ImportDataElements(CdaDataImportModel model, string exchangeDocIen)
        {
            if (model.Observations.Any(o => o.SelectedForImport == true))
            {
                switch (model.DocumentType)
                {
                    case IheDocumentType.APHP:
                        // *** Create pregnancy observations + save ***
                        PregnancyHistory pregHist = GetPregnancyHistory(model.Patient.Dfn, "", exchangeDocIen, model.Observations);

                        BrokerOperationResult pregHistResult = this.DashboardRepository.Pregnancy.SavePregnancyHistory(model.Patient.Dfn, pregHist);

                        if (!pregHistResult.Success)
                            this.Error(string.Format("Error saving discrete data elements: {0}", pregHistResult.Message));

                        break;

                    case IheDocumentType.APS:

                        PregnancyResult pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(model.Patient.Dfn);

                        if (!pregResult.Success)
                            this.Error(string.Format("Error saving discrete data elements: unable to determine working pregnancy ({0})", pregResult.Message));
                        else
                        {
                            List<Observation> obsList = GetEddObservations(model.Observations, model.Patient.Dfn, pregResult.Pregnancy.Ien, exchangeDocIen);

                            if (obsList.Count > 0)
                            {
                                BrokerOperationResult saveResult = this.DashboardRepository.Observations.SaveObservations(obsList);

                                if (!saveResult.Success)
                                    this.Error(string.Format("Error saving discrete data elements: {0}", saveResult.Message));
                            }
                        }

                        break;

                    case IheDocumentType.APE:

                        List<PatientEducationItem> edList = this.GetEdItems(model, exchangeDocIen); 

                        if (edList.Count > 0)
                            foreach (var item in edList)
                            {
                                IenResult ienResult = this.DashboardRepository.Education.SavePatientItem(item);

                                if (!ienResult.Success)
                                    this.Error(string.Format("Error saving discrete data elements: {0}", ienResult.Message));
                            }
                        
                        break;

                    case IheDocumentType.MDS:                   
                    case IheDocumentType.PPVS:

                        pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(model.Patient.Dfn);

                        if (!pregResult.Success)
                            this.Error(string.Format("Error saving discrete data elements: unable to determine working pregnancy ({0})", pregResult.Message));
                        else
                        {
                            List<Observation> obsList = GetPostpartumObservations(model.Observations, model.Patient.Dfn, pregResult.Pregnancy.Ien, exchangeDocIen);

                            if (obsList.Count > 0)
                            {
                                BrokerOperationResult saveResult = this.DashboardRepository.Observations.SaveObservations(obsList);

                                if (!saveResult.Success)
                                    this.Error(string.Format("Error saving discrete data elements: {0}", saveResult.Message));
                            }
                        }

                        break;

                    case IheDocumentType.NDS:

                        // TODO: How to associate baby observations with babies 
                        pregResult = this.DashboardRepository.Pregnancy.GetCurrentOrMostRecentPregnancy(model.Patient.Dfn);

                        if (!pregResult.Success)
                            this.Error(string.Format("Error saving discrete data elements: unable to determine working pregnancy ({0})", pregResult.Message));
                        else
                        {
                            List<Observation> obsList = GetDashboardObservations(model.Observations, model.Patient.Dfn, pregResult.Pregnancy.Ien, exchangeDocIen, "BabyDetails");

                            if (obsList.Count > 0)
                            {
                                BrokerOperationResult saveResult = this.DashboardRepository.Observations.SaveObservations(obsList);

                                if (!saveResult.Success)
                                    this.Error(string.Format("Error saving discrete data elements: {0}", saveResult.Message));
                            }
                        }

                        break; 
                }
            }
        }

        private List<PatientEducationItem> GetEdItems(CdaDataImportModel model, string exchangeDocIen)
        {
            List<PatientEducationItem> returnList = new List<PatientEducationItem>();

            if (model.Observations.Count > 0)
                foreach (var item in model.Observations)
                {
                    PatientEducationItem patItem = new PatientEducationItem()
                    {
                        PatientDfn = model.Patient.Dfn,
                        CompletedBy = "External Clinician", 
                        Code = item.Code,
                        Description = item.DisplayName
                    };

                    patItem.CodingSystem = CodingSystemUtility.GetCodingSystemName(item.CodeSystem);
                    DateTime tempDate = DateTime.MinValue;
                    if (DateTime.TryParse(item.EffectiveTime, out tempDate))
                        patItem.CompletedOn = tempDate;
                    patItem.ItemType = EducationItemType.Other;                    

                    returnList.Add(patItem); 
                }

            return returnList; 
        }

        private PregnancyHistory GetPregnancyHistory(string dfn, string pregIen, string ien, List<CdaObservationModel> list)
        {
            PregnancyHistory hist = new PregnancyHistory(); 

            if (list != null) 
                foreach (CdaObservationModel item in list) 
                    if (item.SelectedForImport) 
                        if (PregnancyHistory.IsPregnancyHistoryCode(item.Code))
                        {
                            Observation tempObs = new Observation()
                            {
                                Code = item.Code, 
                                Description = item.DisplayName, 
                                PatientDfn = dfn,
                                Value = item.Value, 
                                Category = hist.Category
                            };

                            tempObs.EntryDate = VistaDates.ParseDateString(item.EffectiveTime, VistaDates.UserDateFormat);
                            tempObs.CodeSystem = CodingSystemUtility.GetCodingSystemName(item.CodeSystem); 

                            // *** Associate observations with a specific note ***
                            tempObs.ExchangeDocumentIen = ien; 

                            // *** Associate with specific pregnancy ***
                            tempObs.PregnancyIen = pregIen; 

                            hist.Observations[item.Code] = tempObs; 
                        }

            return hist; 
        }

        //private List<Observation> GetBabyObservations(List<CdaObservationModel> list, string dfn, string pregIen, string docIen)
        //{
        //    List<Observation> obsList = GetDashboardObservations(list, dfn, pregIen, docIen, "BabyDetails");

        //    return obsList;
        //}

        private List<Observation> GetPostpartumObservations(List<CdaObservationModel> list, string dfn, string pregIen, string docIen)
        {
            List<Observation> obsList = GetDashboardObservations(list, dfn, pregIen, docIen, "DeliveryDetails");

            // *** Use "Outcome" category for Birth date ***
            foreach (var obs in obsList)
                if (obs.Code == "75092-7")
                    obs.Category = "Outcome";

            return obsList;
        }

        private List<Observation> GetEddObservations(List<CdaObservationModel> list, string dfn, string pregIen, string docIen)
        {
            List<Observation> obsList = GetDashboardObservations(list, dfn, pregIen, docIen, "EDD");

            string twoPartFormat = "{0}|{1}";

            string tempDate;

            // *** Use "Pregnancy" category for LMP ***
            foreach (var obs in obsList)
            {
                switch (obs.Code)
                {
                    case EddUtility.LmpDateCode:
                        obs.Value = VistaDates.StandardizeDateFormat(obs.Value); 
                        obs.Category = "Pregnancy";
                        break;

                    case EddUtility.EddCode:
                        tempDate = VistaDates.StandardizeDateFormat(obs.Value); 
                        obs.Value = string.Format(twoPartFormat, tempDate, true);
                        break; 

                    case EddUtility.EddFromLMPCode:
                        tempDate = VistaDates.StandardizeDateFormat(obs.Value); 
                        obs.Value = string.Format(twoPartFormat, tempDate, false);
                        break; 

                    case EddUtility.EstimatedGestationalAgeCode:
                        string threePartFormat = "{0}|{1}|{2}";
                        tempDate = (obs.EntryDate == DateTime.MinValue) ? "" : obs.EntryDate.ToString(VistaDates.VistADateOnlyFormat);
                        string days = Util.Piece(obs.Value, " ", 1); 
                        obs.Value = string.Format(threePartFormat, tempDate ,false, days);
                        break; 
                }
                // TODO: Replace codes with refs to EddUtility
            }

            return obsList; 
        }

        private List<Observation> GetDashboardObservations(List<CdaObservationModel> list, string dfn, string pregIen, string noteIen, string category)
        {
            List<Observation> returnList = new List<Observation>();

            // *** Check if we have any to work with ***
            if (list != null)
            {
                // *** Get the items that the user selected for import ***
                List<CdaObservationModel> importList = list
                    .Where(o => o.SelectedForImport == true)
                    .ToList();

                // *** Create the observation ***
                foreach (CdaObservationModel item in importList)
                {
                    Observation tempObs = new Observation()
                    {
                        Code = item.Code,
                        Description = item.DisplayName,
                        PatientDfn = dfn,
                        Value = item.Value,
                        Category = category
                    };

                    tempObs.EntryDate = VistaDates.ParseDateString(item.EffectiveTime, VistaDates.UserDateFormat);
                    tempObs.CodeSystem = CodingSystemUtility.GetCodingSystemName(item.CodeSystem);

                    // *** Associate observations with a specific note ***
                    tempObs.ExchangeDocumentIen = noteIen;

                    // *** Associate with specific pregnancy ***
                    tempObs.PregnancyIen = pregIen;

                    if (item.BabyNumber > 0)
                        tempObs.BabyNumber = item.BabyNumber.ToString(); 

                    returnList.Add(tempObs);
                }
            }

            return returnList; 
        }

        private Dictionary<string, string> GetNoteDataDictionary(List<CdaObservationModel> list)
        {
            // *** Add observations to a simple string dictionary for addition to the note data ***

            Dictionary<string, string> returnVal = new Dictionary<string, string>();

            if (list != null)
                foreach (var item in list)
                    returnVal.Add(string.Format("{0}:{1}", item.CodeSystem, item.Code), item.Value); 

            return returnVal; 
        }

        private CdaDocumentData CreateNewCdaDocument(CdaExtractedHeader header, string dfn, string documentContent)
        {
            CdaDocumentData newDocument = new CdaDocumentData();

            // *** Data from extracted header ***
            newDocument.Id = header.Id;
            newDocument.CreationDateTime = header.CreationDateTime;
            newDocument.DocumentType = header.DocumentType;
            newDocument.IntendedRecipient = header.IntendedRecipient;
            newDocument.Sender = header.Sender;
            newDocument.Title = header.Title;

            // *** Set other values ***
            newDocument.DocumentContent = documentContent;
            newDocument.ExchangeDirection = ExchangeDirection.Inbound;
            newDocument.ImportDateTime = DateTime.Now;
            newDocument.PatientDfn = dfn;

            return newDocument; 
        }

        private string FullOutgoingPath
        {
            get
            {
                return Path.Combine(this.Request.PhysicalApplicationPath, outgoingPhysicalPath);
            }
        }

        private string GetUniqueFileName(string docName, string patientName, string path)
        {
            // *** Gets a unique name based on document, patient, date, and a counter ***

            // *** Returns "" if not able to find unique name ***

            string returnVal = ""; 

            // *** Create the base name from document, patient, and date ***
            string baseName = string.Format("{0}-{1}-{2}", docName, patientName, DateTime.Now.ToString("MM-dd-yy"));

            // *** Add extension ***
            string fileName = string.Format("{0}.xml", baseName);

            // *** Combine the path and file name ***
            string fullFileName = Path.Combine(path, fileName);

            // *** Check if it already exists ***
            if (System.IO.File.Exists(fullFileName))
            {
                // *** If exists, use counter to find unique ***
                int counter = 1;
                fullFileName = Path.Combine(path, string.Format("{0}-{1}.xml", baseName, counter));

                // *** Check if name with counter exists ***
                while ((System.IO.File.Exists(fullFileName) && counter < 100))
                {
                    // *** Bump the counter and create a new name ***
                    counter += 1;
                    fullFileName = Path.Combine(path, string.Format("{0}-{1}.xml", baseName, counter));
                }

                // *** If we tried less than 100, then success ***
                if (counter < 100)
                    returnVal = fullFileName;
            }
            else
                returnVal = fullFileName;

            return returnVal; 
        }

        private string PrepareFile(string docName, string patientName, string documentContent) 
        {
            string returnVal = ""; 

            // *** Create a new file ***
            string fullFileName = GetUniqueFileName(docName, patientName, FullOutgoingPath);

            // *** If empty, then no unique file name could be acquired ***
            if (string.IsNullOrWhiteSpace(fullFileName))
                this.Error("The system could not generate the file");
            else
            {
                returnVal = WriteTemporaryFile(fullFileName, documentContent); 
            }

            return returnVal; 
        }

        private string WriteTemporaryFile(string fullFileName, string documentContent)
        {
            string returnVal = ""; 

            // *** Make a copy ***
            System.IO.File.WriteAllText(fullFileName, documentContent);

            // *** Create the session file list for outgoing files ***
            List<string> docList;
            if (Session[outgoingCdaDocsSessionKey] == null)
            {
                docList = new List<string>();
                Session[outgoingCdaDocsSessionKey] = docList;
            }
            else
                docList = (List<string>)Session[outgoingCdaDocsSessionKey];

            // *** Add the document to the session list for cleanup later ***
            docList.Add(fullFileName);

            // *** Set content to relative path for access in View ***
            returnVal = outgoingVirtualPath + Path.GetFileName(fullFileName);

            return returnVal; 
        }

        private void CopyStyleSheet(string destinationFolder)
        {
            string source = this.Request.MapPath(outgoingVirtualPath + styleSheetFileName);

            string destination = Path.Combine(destinationFolder, styleSheetFileName);

            if (!System.IO.File.Exists(destination))
                System.IO.File.Copy(source, destination); 

        }

        private void CopyWarningFile(string destinationFolder)
        {
            string source = this.Request.MapPath(outgoingVirtualPath + warningFileName);

            string destination = Path.Combine(destinationFolder, warningFileName);

            if (!System.IO.File.Exists(destination))
                System.IO.File.Copy(source, destination);

        }        

    }
}
