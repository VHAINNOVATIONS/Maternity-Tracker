using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Xml.Xsl;
using VA.Gov.Artemis.CDA;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.CDA.IHE;
using VA.Gov.Artemis.CDA.IHE.Sections;
using VA.Gov.Artemis.CDA.Raw;
using VA.Gov.Artemis.CDA.RecordTarget;
using VA.Gov.Artemis.Vista.Utility;
using VA.Gov.Artemis.Core; 

namespace VA.Gov.Artemis.CDA
{
    public class CdaUtility
    {
        // *** Names and abbreviations for the document types - index is DocumentType enum ***
        public static string[] DocumentTypeName = { "Antepartum History & Physical", "Antepartum Summary", "Antepartum Laboratory", "Antepartum Education", "Maternal Discharge Summary", "Newborn Discharge Summary", "Postpartum Visit Summary", "Imaging Report" };
        public static string[] DocumentTypeAbbreviation = { "APHP", "APS", "APL", "APE", "MDS", "NDS", "PPVS", "XDR-I" };
        
        // TODO: Update documents supported...
        public static bool[] DocumentTypeIsSupported = { true, true, true, true, false, false, true, true }; 

        //public static CdaExtractedHeader ExtractDocumentHeader(string documentContent)
        //{
        //    CdaExtractedHeader result = null; 

        //    POCD_MT000040ClinicalDocument doc = CdaUtility.DeserializeContent(documentContent);

        //    if (doc != null)
        //    {
        //        result = new CdaExtractedHeader();

        //        DateTime effectiveTime;
        //        CultureInfo enUS = new CultureInfo("en-US");

        //        // *** Document Date/Time ***
        //        if (doc.effectiveTime != null)
        //            if (!string.IsNullOrWhiteSpace(doc.effectiveTime.value))
        //                if (DateTime.TryParseExact(doc.effectiveTime.value, RawCdaDocument.CdaDateFormat, enUS, DateTimeStyles.None, out effectiveTime))
        //                    result.CreationDateTime = effectiveTime;

        //        // *** TODO: Check all document types ***
        //        if (doc.templateId != null)
        //            if (doc.templateId.Length > 0)
        //                foreach (II templateId in doc.templateId)
        //                    if (templateId.root == RawAphpDocument.AphpTemplateId)
        //                        result.DocumentType = IheDocumentType.APHP;

        //        // *** Get document id ***
        //        if (doc.id != null)
        //            result.Id = doc.id.root;

        //        // *** Sender ***
        //        if (doc.recordTarget != null)
        //            if (doc.recordTarget.Length > 0)
        //                if (doc.recordTarget[0].patientRole != null)
        //                    if (doc.recordTarget[0].patientRole.providerOrganization != null)
        //                        if (doc.recordTarget[0].patientRole.providerOrganization.name != null)
        //                            if (doc.recordTarget[0].patientRole.providerOrganization.name[0].Text != null)
        //                                result.Sender = doc.recordTarget[0].patientRole.providerOrganization.name[0].Text[0];

        //        // *** Title ***
        //        if (doc.title != null)
        //            if (doc.title.Text != null)
        //                if (doc.title.Text.Length > 0)
        //                    result.Title = doc.title.Text[0];

        //        // *** Recipient ****
        //        result.IntendedRecipient = ExtractRecipient(doc);
 
        //    }

        //    return result;
        //}

        //private static string ExtractRecipient(POCD_MT000040ClinicalDocument doc)
        //{
        //    // *** Gets the recipient string from a clinical doc ***

        //    string returnValue = "";

        //    // *** Create a working recipient ***
        //    CdaRecipient tempRecipient = new CdaRecipient();

        //    // *** Check for existence and drill down ***
        //    if (doc.informationRecipient != null)
        //        if (doc.informationRecipient.Length > 0)
        //            if (doc.informationRecipient[0].intendedRecipient != null)
        //            {
        //                // *** Organization***
        //                if (doc.informationRecipient[0].intendedRecipient.receivedOrganization != null)
        //                    if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name != null)
        //                        if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name.Length > 0)
        //                            if (doc.informationRecipient[0].intendedRecipient.receivedOrganization.name[0].Text != null)
        //                                tempRecipient.Organization = doc.informationRecipient[0].intendedRecipient.receivedOrganization.name[0].Text[0];

        //                // *** Person Name ***
        //                if (doc.informationRecipient[0].intendedRecipient.informationRecipient != null)
        //                    if (doc.informationRecipient[0].intendedRecipient.informationRecipient.name != null)
        //                    {
        //                        string[] names = GetName(doc.informationRecipient[0].intendedRecipient.informationRecipient.name);
        //                        tempRecipient.FirstName = names[0];
        //                        tempRecipient.LastName = names[1];
        //                    }

        //                // *** Set result ***
        //                returnValue = tempRecipient.ToString();
        //            }

        //    return returnValue;
        //}

        //public static Nullable<IheDocumentType> GetDocumentType(string documentContent)
        //{
        //    Nullable<IheDocumentType> returnVal = null; 

        //    // *** Check if the xml for the passed-in content is supported ***

        //    try
        //    {
        //        POCD_MT000040ClinicalDocument clinicalDocument = CdaUtility.DeserializeContent(documentContent);

        //        if (clinicalDocument != null)
        //        {
        //            // TODO: Support proper document type

        //            // *** Look for document template id matching supported ***
        //            // *** For now only APHP, but could be CCD or other IHE template ***

        //            if (clinicalDocument.templateId != null)
        //                if (clinicalDocument.templateId.Length > 0)
        //                    foreach (II templateId in clinicalDocument.templateId)
        //                        switch (templateId.root)
        //                        {
        //                            case RawAphpDocument.AphpTemplateId:
        //                                returnVal = IheDocumentType.APHP;
        //                                break;

        //                            case RawApsDocument.ApsTemplateId:
        //                                returnVal = IheDocumentType.APS;
        //                                break;

        //                            case RawAplDocument.AplTemplateId:
        //                                returnVal = IheDocumentType.APL;
        //                                break;

        //                            case RawApeDocument.ApeTemplateId:
        //                                returnVal = IheDocumentType.APE;
        //                                break;

        //                            case RawPpvsDocument.PpvsTemplateId:
        //                                returnVal = IheDocumentType.PPVS;
        //                                break;

        //                            case RawXdriDocument.XdriTemplateId:
        //                                returnVal = IheDocumentType.XDR_I;
        //                                break;

        //                            case RawNdsDocument.NdsTemplateId:
        //                                returnVal = IheDocumentType.NDS;
        //                                break;

        //                            case RawMdsDocument.MdsTemplateId:
        //                                returnVal = IheDocumentType.MDS;
        //                                break;
        //                        }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLogger.Log(ex, "Error Retrieving Document Type"); 
        //    }

        //    return returnVal;
        //}

        //public static bool DocumentIsSupported(string documentContent)
        //{
        //    // *** Check if the xml for the passed-in content is supported ***

        //    bool returnVal = false; 

        //    POCD_MT000040ClinicalDocument clinicalDocument = CdaUtility.DeserializeContent(documentContent);

        //    if (clinicalDocument != null)
        //    {
        //        // TODO: Support proper document type

        //        // *** Look for document template id matching supported ***
        //        // *** For now only APHP, but could be CCD or other IHE template ***

        //        if (clinicalDocument.templateId != null)
        //            if (clinicalDocument.templateId.Length > 0)
        //                foreach (II templateId in clinicalDocument.templateId)
        //                    if (templateId.root == RawAphpDocument.AphpTemplateId)
        //                        returnVal = true;

        //    }

        //    return returnVal;
        //}

        public static string GetDocumentAbbreviation(IheDocumentType iheDocumentType)
        {
            return DocumentTypeAbbreviation[(int)iheDocumentType];
        }

        //public static List<POCD_MT000040Observation> ExtractPregnancyObservations(string documentContent)
        //{
        //    // *** Extract basic patient information from the document content ***

        //    List<POCD_MT000040Observation> returnList = new List<POCD_MT000040Observation>(); 

        //    // *** First deserialize it ***
        //    POCD_MT000040ClinicalDocument doc = CdaUtility.DeserializeContent(documentContent);

        //    // *** Check if we have something to work with ***
        //    if (doc != null)
        //        if (doc.component != null)
        //            if (doc.component.Item is POCD_MT000040StructuredBody)
        //            {
        //                POCD_MT000040StructuredBody body = doc.component.Item as POCD_MT000040StructuredBody;

        //                if (body.component != null)
        //                    if (body.component.Length > 0)
        //                        foreach (var item in body.component)
        //                            if (item.section != null)
        //                                if (item.section.code != null)
        //                                    if (item.section.code.code == new PregnancyHistorySection().Code)
        //                                        if (item.section.entry != null)
        //                                            foreach (var entry in item.section.entry)
        //                                                if (entry.Item != null)
        //                                                    if (entry.Item is POCD_MT000040Observation)
        //                                                        returnList.Add(entry.Item as POCD_MT000040Observation); 

        //            }

        //    return returnList;
        //}

        //public static CdaRecordTarget ExtractRecordTarget(string documentContent)
        //{
        //    // *** Extract basic patient information from the document content ***

        //    CdaRecordTarget returnRecordTarget = null; 

        //    // *** First deserialize it ***
        //    POCD_MT000040ClinicalDocument doc = CdaUtility.DeserializeContent(documentContent);

        //    // *** Check if we have something to work with ***
        //    if (doc != null)
        //        if (doc.recordTarget != null)
        //            if (doc.recordTarget.Length > 0)
        //            {
        //                // *** Create the return value ***
        //                returnRecordTarget = new CdaRecordTarget(); 

        //                // *** Get the first record target ***
        //                POCD_MT000040RecordTarget pocdRecordTarget = doc.recordTarget[0];

        //                // *** Make sure we have a patient role section ***
        //                if (pocdRecordTarget.patientRole != null)
        //                {
        //                    // *** Get the SSN ***
        //                    returnRecordTarget.SSN = GetSSN(pocdRecordTarget.patientRole); 

        //                    // *** Make sure we have a patient ***
        //                    if (pocdRecordTarget.patientRole.patient != null)
        //                    {
        //                        // *** Create shortcut for patient ***
        //                        POCD_MT000040Patient pat = pocdRecordTarget.patientRole.patient;

        //                        // *** Get the date of birth ***
        //                        returnRecordTarget.Patient.DateOfBirth = GetDOB(pat); 

        //                        // *** Get the name ***
        //                        string[] name = GetName(pat.name);
        //                        returnRecordTarget.Patient.Name.First = name[0];
        //                        returnRecordTarget.Patient.Name.Last = name[1];

        //                    }
        //                }
        //            }

        //    return returnRecordTarget;
        //}

        public static string ConvertDocToText(string documentContent, string styleSheetFileName)
        {
            // *** Converts the incoming xml document to plain text ***

            string returnVal = "";

            // *** Get transformed ***
            string transformed = GetTransformed(documentContent, styleSheetFileName);

            // *** Do conversion ***
            returnVal = GetFormattedText(transformed);

            return returnVal;
        }

        private static string GetTransformed(string documentContent, string styleSheetFileName)
        {
            // *** Applies the CDA style sheet to the incoming xml document content ***

            string returnVal = "";

            // *** Create xpath doc **
            XPathDocument doc = new XPathDocument(new StringReader(documentContent));

            // *** Create a string build to contain result ***
            StringBuilder sb = new StringBuilder();

            // *** Create the writer to receive the content ***
            using (XmlWriter writer = XmlWriter.Create(sb))
            {
                // *** Create tranform and settings ***
                XslCompiledTransform transform = new XslCompiledTransform();
                XsltSettings settings = new XsltSettings();
                settings.EnableScript = true;
                settings.EnableDocumentFunction = true; 

                // *** Load the style sheet ***
                transform.Load(styleSheetFileName, settings, null);

                // *** Do transform ***
                transform.Transform(doc, writer);
            }

            // *** Get the string result ***
            returnVal = sb.ToString();

            return returnVal;
        }

        private static string GetFormattedText(string html)
        {
            // *** Takes the incoming already transformed html and converts to a somewhat readable txt format for progress notes ***

            StringBuilder result = new StringBuilder();

            // *** Create a reader ***
            StringReader stringReader = new StringReader(html);
            XmlReader xmlReader = XmlReader.Create(stringReader);

            // *** Indexs are Cols, Rows ***
            string[,] tableData = new string[100, 1000];

            // *** Values to keep track of while looping ***
            string curNodeName = "";
            int curCol = 0;
            int curRow = 0;
            bool inTd = false;
            int colCount = 0;
            int rowCount = 0;

            // *** Read item by item ***
            while (xmlReader.Read())
            {
                // *** Take action based on note type ***
                switch (xmlReader.NodeType)
                {
                    case XmlNodeType.Element:

                        // *** Keep track of current node name ***
                        curNodeName = xmlReader.Name;

                        // *** What type is it? ***
                        switch (curNodeName)
                        {
                            case "td":
                            case "th":
                                inTd = true;
                                break;
                        }
                        break;

                    case XmlNodeType.Text:

                        // *** Are we in a td (th) ? ***

                        if (inTd)
                            tableData[curCol, curRow] = xmlReader.Value;
                        else
                            if (curNodeName != "title") // Skip titles.
                                result.Append(xmlReader.Value);

                        break;

                    case XmlNodeType.EndElement:
                        switch (xmlReader.Name)
                        {
                            case "table":

                                // *** Get the table text ***
                                string tableText = GetTableText(curRow, colCount, tableData);

                                result.AppendLine(tableText);

                                // *** Clean up tableData and allow for reuse ***
                                for (int c = 0; c < colCount; c++)
                                    for (int r = 0; r < rowCount; r++)
                                        tableData[c, r] = null;

                                // *** Clean up rows and columns ****
                                colCount = 0;
                                rowCount = 0;
                                curCol = 0;
                                curRow = 0;

                                break;

                            case "td":
                            case "th":

                                // *** Jump to next column ***
                                curCol += 1;
                                inTd = false;

                                break;

                            case "tr":

                                // *** Jump to next row ***
                                curRow += 1;

                                // *** Keep track of column count ***
                                colCount = curCol + 1;

                                // *** Start back at zero for columns ***
                                curCol = 0;

                                break;

                            case "p":
                            case "h1":
                            case "h2":
                            case "h3":
                            case "h4":
                            case "h5":
                            case "paragraph":

                                // *** Get a new line ***
                                result.AppendLine();

                                break;
                        }
                        break;
                }
            }

            return result.ToString();
        }

        private static string GetTableText(int curRow, int colCount, string[,] tableData)
        {
            StringBuilder sb = new StringBuilder();

            int rowCount = curRow + 1;

            // *** Create array to hold column widths *** 
            int[] colWidth = new int[colCount];

            // *** Calculate column widths based on longest value in column ***
            for (int c = 0; c < colCount; c++)
                for (int r = 0; r < rowCount; r++)
                    if (!string.IsNullOrWhiteSpace(tableData[c, r]))
                        if (colWidth[c] < tableData[c, r].Length)
                            colWidth[c] = tableData[c, r].Length;

            // *** Add a blank line before table ***
            sb.AppendLine();

            // *** Loop through table elements and add to return ***
            for (int r = 0; r < rowCount; r++)
            {
                for (int c = 0; c < colCount; c++)
                {
                    // *** Get text for this column ***
                    string tempVal = string.IsNullOrWhiteSpace(tableData[c, r]) ? "" : tableData[c, r];

                    // *** Use pad right to keep all the same ***
                    sb.Append(tempVal.PadRight(colWidth[c] + 5));
                }

                // *** Next row after all columns are done ***
                sb.AppendLine();
            }

            return sb.ToString();
        }

        //private static POCD_MT000040ClinicalDocument DeserializeContent(string content)
        //{
        //    POCD_MT000040ClinicalDocument returnDocument = null;

        //    // *** Create a generic CDA serializer ***
        //    XmlSerializer serializer = new XmlSerializer(typeof(POCD_MT000040ClinicalDocument));

        //    // *** Create an xml reader ***
        //    using (XmlReader xmlReader = XmlReader.Create(new StringReader(content)))
        //    {
        //        // *** Check if it can deserialize ***
        //        if (serializer.CanDeserialize(xmlReader))
        //        {
        //            // *** Deserialize ***
        //            returnDocument = (POCD_MT000040ClinicalDocument)serializer.Deserialize(xmlReader);
        //        }
        //    }

        //    return returnDocument;
        //}

        //private static string GetSSN(POCD_MT000040PatientRole patRole)
        //{
        //    string returnVal = ""; 

        //    // *** SSN ***
        //    if (patRole.id != null)
        //        foreach (II tempII in patRole.id)
        //            if (tempII.root == "2.16.840.1.113883.4.1")
        //                if (!string.IsNullOrWhiteSpace(tempII.extension))
        //                    returnVal = tempII.extension;

        //    return returnVal; 
        //}

        //private static DateTime GetDOB(POCD_MT000040Patient pat)
        //{
        //    DateTime returnDOB = DateTime.MinValue;

        //    CultureInfo enUS = new CultureInfo("en-US");

        //    // *** DOB ***
        //    if (pat.birthTime != null)
        //        if (!string.IsNullOrWhiteSpace(pat.birthTime.value))
        //            DateTime.TryParseExact(pat.birthTime.value, "yyyyMMdd", enUS, DateTimeStyles.None, out returnDOB);

        //    return returnDOB; 
        //}

        //private static string[] GetName(PN[] pn)
        //{
        //    string[] returnName = new string[] {"",""};

        //    // *** Name ***
        //    if (pn != null)
        //        if (pn.Length > 0)
        //        {
        //            PN name = pn[0];
        //            if (name.Items != null)
        //                if (name.Items.Length > 0)
        //                    foreach (ENXP enxp in name.Items)
        //                        if (enxp.Text != null)
        //                            if (enxp.Text.Length > 0)
        //                            {
        //                                if (enxp is engiven)
        //                                    returnName[0] = enxp.Text[0];
        //                                else if (enxp is enfamily)
        //                                    returnName[1] = enxp.Text[0];
        //                            }
        //        }

        //    return returnName; 
        //}

        public static string SerializeAphp(RawAphpDocument rawDoc)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawAphpDocument));

            returnVal = SerializeIheDoc(serializer, rawDoc);

            return returnVal;
        }

        public static string SerializeAps(RawApsDocument rawAps)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawApsDocument));

            returnVal = SerializeIheDoc(serializer, rawAps);

            return returnVal;
        }

        public static string SerializeApe(Raw.RawApeDocument rawApe)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawApeDocument));

            returnVal = SerializeIheDoc(serializer, rawApe);

            return returnVal;
        }

        public static string SerializeApl(RawAplDocument rawApl)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawAplDocument));

            returnVal = SerializeIheDoc(serializer, rawApl);

            return returnVal;            
        }

        private static string SerializeIheDoc(XmlSerializer serializer, object rawDoc)
        {
            string returnVal = ""; 

            // *** Add some xml settings ***
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.Encoding = Encoding.UTF8;
            settings.Indent = true;
            settings.NewLineHandling = NewLineHandling.Replace;

            // *** Get a temp file name ***
            string tempFile = Path.GetTempFileName();

            // *** Create a file stream writer ****
            using (StreamWriter output = new StreamWriter(new FileStream(tempFile, FileMode.Create), Encoding.UTF8))
            {
                // *** Create xml writer ***
                using (XmlWriter xmlWriter = XmlWriter.Create(output, settings))
                {
                    // *** Add the style sheet processing instruction ***
                    xmlWriter.WriteProcessingInstruction("xml-stylesheet", "type=\"text/xsl\" href=\"CDA.xsl\"");

                    // *** Perform serialization ***
                    serializer.Serialize(xmlWriter, rawDoc);
                }
            }

            // *** Grab the text as it is in the file ***
            returnVal = File.ReadAllText(tempFile);

            // **** Delete the temporary file ***
            File.Delete(tempFile);

            return returnVal;
        }

        public static CdaCode GetLabSectionCode(string p)
        {
            CdaCode returnVal = new CdaCode();

            string val = Util.Piece(p, " ", 1);

            switch (val)
            {
                case "CH":
                    returnVal.Code = "18719-5";
                    returnVal.DisplayName = "Chemistry Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc; 
                    break;

                case "SEROL":
                    returnVal.Code = "18727-8";
                    returnVal.DisplayName = "Serology Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    break;

                case "URINE":
                    returnVal.Code = "18729-4";
                    returnVal.DisplayName = "Urinalysis Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    break;

                case "HE":
                    returnVal.Code = "18723-7";
                    returnVal.DisplayName = "Hematology Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    break;

                case "COAG":
                    returnVal.Code = "18720-3";
                    returnVal.DisplayName = "Coagulation Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    break;

                // TODO: others...?                 

                default:
                    returnVal.Code = "26436-6";
                    returnVal.DisplayName = "Laboratory Studies";
                    returnVal.CodeSystem = CodingSystem.Loinc;
                    break;
            }   

            return returnVal; 
        }

        public static string SerializePpvs(RawPpvsDocument rawPpvs)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawPpvsDocument));

            returnVal = SerializeIheDoc(serializer, rawPpvs);

            return returnVal; 
        }

        public static string SerializeXdri(RawXdriDocument rawXdri)
        {
            string returnVal = "";

            // *** Create serializer for specific document ***
            XmlSerializer serializer = new XmlSerializer(typeof(RawXdriDocument));

            returnVal = SerializeIheDoc(serializer, rawXdri);

            return returnVal;
        }
    }
}
