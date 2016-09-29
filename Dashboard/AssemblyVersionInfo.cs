using System.Reflection;

[assembly: AssemblyVersion("1.0.0.0")]

// *** Summary of changes ***

// *** 07/03/2016 2.0.0 This release is dependent upon DSIO_1_P5_T9.KID
// ***                   Reorganize IHE documents and sections into folders 
// ***                   Add values to allergy hl7 intolerance mapping 
// ***                   Fix typo on OB H&P note selection label 
// ***                   Create "Unknown" observation for APHP document if no family history is present so the document can validate
// ***                   Create "Unknown" observation for APHP document if history of present illness does not exist so the document can validate
// ***                   Configure Text4Baby service reference to use HTTPS, transport security, + update TEST credentials 
// ***                   PPVS: Allow user to create a Postpartum Visit Summary IHE document per the specifications 
// ***                   Correct allergy date display for IHE docs
// ***                   Correct medication id generation for IHE docs 
// ***                   PPVS: Allow user to select a pregnancy to base the document on 
// ***                   PPVS: Add elements to baby information
// ***                   PPVS: Add elements to delivery information 
// ***                   Create unknown family history item if no history found for IHE documents 
// ***                   Create "No Known Problems" item if no problems found for IHE documents 
// ***                   Create unknown medications item if no medications found in VPR result for IHE documents 
// ***                   XDR-I: Allow user to create an XDR-I document per IHE specifications 
// ***                   Modify cda.cs to ensure that mediaType is present for XDR-I document 
// *** 07/11/2016 2.0.1  This release is dependent upon KID build DSIO P5 T11
// ***                   IHE: Correct error message if intended recipient data is not entered
// ***                   PPVS: Add Labor & Delivery Events section
// ***                   IHE: Allow Cda Observations to be created from POCD observations for data import 
// ***                   Correct dsio observation parsing to use TIU. and IHE. for identifiers
// ***                   IHE: Create importer to handle IHE document importing processing 
// ***                   APS: Allow discrete data elements to be imported 
// ***                   APE: Allow education topics/items to be imported 
// ***                   MDS: Allow maternal discharge summary data to be imported 
// ***                   PPVS: Allow post-partum visit summary data to be imported 
// ***                   NDS: Allow newborn dishcarge summary data to be imported 
// ***                   Correct outcome observation date format 
// ***                   Show "Imported" column on EDD history 
// ***                   IHE: Add effective time to all text observations
// ***                   APS: Add effective time to EDD observations 
// ***                   Make sure IHE exchange document IEN is saved with the observations 
// ***                   PPVS: Add LOINC code to Delivery Details Provider (Attending Physician) 
// *** 07/19/2016 2.0.2  This release is dependent upon KID build DSIO P5 T12                   
// ***                   Display outcomes pie chart on dashboard page
// ***                   Allow date range for outcomes pie chart to be set by the user 
// ***                   Allow fileman date hours value to be 24 and bump day accordingly 
// *** 07/22/2016 2.0.3  This release is dependent upon KID build DSIO P5 T15
// ***                   Correct Date/Time not appearing in APS Allergies if the allergy is active 
// ***                   Correct an error which occurred when importing an item that has no discrete data elements to import 
// ***                   Correct the observation code for anesthesia consult planned and type of anesthesia 
// ***                   Correct "Return To Options" button in CDA document preview 
// ***                   Correct "History of Present Illness" observation translation 
// ***                   Correct "Social History" narrative observation translation 
// ***                   Modify pregnancy outcome translation from preg history RPC
// ***                   Modify start date from preg history RPC to use 1/1/1900 when getting all data 
// *** 07/25/2016 2.0.4  This release is dependent upon KID build DSIO P5 T16
// ***                   Change CdaCode SNOMED-CT description 
// ***                   Set CdaCode.DisplayName to "" to avoid null references 
// ***                   Allow SNOMED CT to be parsed by CdaUtility to determine coding system 
// ***                   Set Place of Delivery based on observation 
// ***                   Sort observations oldest to newest before processing for pregnancies view 
// ***                   Make sure latex allergy appears on APHP document 
// ***                   Use "low" date for latex allergy observation since it is active 
// ***                   Set latex allergy negation properly in history of past illness section 
// *** 07/27/2016 2.0.5  This release is dependent upon KID build DSIO P5 T16
// ***                   PPVS: Make sure that Newborn Delivery Info section is always included 
// ***                   IHE: Make sure physical exam subsection observations are always included (data) 
// ***                   NDS: Correct Newborn Delivery Info discrete data import 
// ***                   IHE: Use "Narrative" when present to create text observations 
// ***                   PPVS: Correct stillborn observation to contain correct date/time 
// ***                   IHE: Correct date/time on "PQ" (quantity) observations 
// ***                   XDR-I: Don't crash if two different reports have the exact same date/time. Use date/time + procedure as "key"
// ***                   IHE: Correct social history section observations to always have "code" 
// ***                   APS: Make sure that the antepartum visit summary flow sheet always has the proper value 
// *** 07/29/2016 2.0.6  This release is dependent upon KID build DSIO P5 T18
// ***                   PPVS: Make sure the Postpartum Hospitalization Treatment section appears
// ***                   PPVS: Make sure the postpartum complications are shown in the L&D events section 
// ***                   PPVS: Make sure discharge diet appears in the Postpartum Hospitalization Treatment section 
// ***                   PPVS: Make sure the procedures & interventions section appears in the Postpartum Hospitalization Treatment section 
// ***                   PPVS: Make sure the procedures & interventions section appears in the Newborn Delivery Info section 
// ***                   PPVS: Make sure IPV Risk, Depression Screening appear in the social history section 
// ***                   PPVS: Make sure the Mother Discharge Date appears in the L&D events section properly
// ***                   PPVS: Make sure the Pediatrician Name appears in the Newborn Care Plan section  
// ***                   IHE: Check that observations are created properly before adding them to the document to prevent null reference errors
// *** 08/18/2016 2.0.7  This release is dependent upon KID build DSIO P8 T1
// ***                   Do not show an error if the imported IHE document contains more than 100 rows of data
// ***                   Correct the code for the GA observation to 11884-4
// ***                   Make sure all pages have a title 
// ***                   Rename Date to ExamDate in DSIO OBSERVATION
// ***                   Rename LastModified to EntryDate in DSIO OBSERVATION
// ***                   Rename ObservationDate to ExamDate in OBSERVATION
// ***                   Add EntryDate to OBSERVATION 
// ***                   Use EntryDate, which maps to Last Modified in Vista, for observations in IHE documents
// ***                   Use ExamDate, which maps to Date in Vista, for flowsheet observations in APS
// ***                   Make sure APS flowsheet observations are sorted by exam date
// ***                   Correct import of EDD observations from APS document 
// *** 09/14/2016 2.0.8  This release is dependent upon KID build DSIO 2
// ***                   Mods for making public + adding to GitHub
// ***                   Solution moved to VS 2015
// ***                   Show friendly message if an individual line within a note has more than 999 characters. 
// ***                   Correct the interim EDD by PE LOINC code so that the APS validates (xx-EDD-by-PE)
// ***                   Modify logic for pregnancy selection in a contact note. 
// ***                       Don't allow change if completing a checklist item 
// ***                       Don't allow change if note is already assocated with a pregnancy 
// ***                       Only allow change if creating a note from "Add New Note" button 
// ***                       Also, make sure the proper pregnancy is displayed once selected 
// ***                   Update Text4Baby API passwords
// ***                   Remove unneeded references to Microsoft.Web.MVC

[assembly: AssemblyFileVersion("2.0.8.0")]

// *** DEPLOYMENT NOTE:  Add skip rule to deploy.cmd command line parameters to prevent replacement of web.config file
// ***                   va.gov.artemis.ui.deploy.cmd /T "-skip:objectName=filePath,absolutePath=web\.config" 
// ***                                                   "-skip:objectName=dirPath,absolutePath=\\Content\\logs"
 