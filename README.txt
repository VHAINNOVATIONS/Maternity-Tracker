Maternity-Tracker
=================
The Maternity Tracker project is a collection of changes to existing programs
such as CPRS and SMART and new programs such as oCNT and the MCC Dashboard.

The VistA namespace for Maternity tracker is: DSIO
           The VistA numberspace for DSIO is: 19641

SMART: This is an independent project. Maternity Tracker fixes some bugs and
       extends the SMART Alerts to utilize the TIU ComObject functionality. Some
	   of these changes are modifications to CPRS. For more information see
	   DSIO_SMART.pdf.
	   
 CPRS: Maternity Tracker applies some modifications to capture discreet data
       from Reminder Dialogs. These functionality is also part of oCNTs. For
	   more information see DSIO_DDCS.pdf (Discreet Data Control and Storage).
	   To see changes see DSIO_CPRS.pdf.
	   
 oCNT: Open Source Custom Note Template. This program uses the TIU ComObject
       functionality to aid the user in creating a TIU Document. For more
	   information see DSIO_oCNT.pdf.
	   
 CORE: These are the new and modified M Components to VistA that make up the
       core of Maternity Tracker. Please see DSIO_CORE.pdf for more information.
	   
	   
------------------------------------ FILES ------------------------------------

19641        DSIO PATIENT
19641.1      DSIO NON-VA ENTITIES
19641.11     DSIO PERSON
19641.112    DSIO FETUS/BABY
19641.12     DSIO OBSERVATIONS
19641.122    DSIO OBSERVATION CATEGORY
19641.13     DSIO PREGNANCY HISTORY
  
19641.2      DSIO TRACKING HISTORY
19641.22     DSIO TRACKING SOURCE
19641.23     DSIO TRACKING REASON

19641.31     DSIO CPRS PROBLEM
19641.33     DSIO LAB TEST

19641.4      DSIO NOTE CONTROL
19641.401    DSIO REPORT ITEMS
19641.402    DSIO REMINDER ELEMENTS
19641.409    DSIO NOTE PUSH HISTORY
19641.41     DSIO NOTE DATA
19641.43     DSIO NOTE S
19641.44     DSIO NOTE M
19641.45     DSIO NOTE WP

19641.48     DSIO OCNT CONFIGURATION
19641.49     DSIO OCNT DIALOGS

19641.5      DSIO TITLE CONFIGURATION

19641.6      DSIO IHE DOCUMENT
19641.61     DSIO IHE DOCUMENT TYPE

----------------------------------- ROUTINES -----------------------------------

DSIO0        DSIO OCNT SUPPORT
DSIO1        DISO GENERAL RPCS
DSIO2        DSIO X-REFERENCES AND UTILITIES
DSIO3        DSIO TIU AND IHE SUPPORT
             TIU SPECIFIC UTILITIES
DSIO3A       DSIO DISCREET DATA
DSIO3V1      DSIO VPR FOR IHE (MODIFIED CLONE)
DSIO3V2      DSIO VPR FOR IHE (MODIFIED CLONE)
DSIO3V3      DSIO VPR FOR IHE (MODIFIED CLONE)
DSIO4        DSIO PREGNANCY
             PREGNANCY RELATED X-REFERENCE SUPPORT
DSIO5
DSIO5O1
DSIO5O2
DSIO5O3
DSIO5R