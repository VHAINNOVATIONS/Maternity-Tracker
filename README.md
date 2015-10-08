Maternity-Tracker
=================
The VistA namespace for Maternity tracker is: DSIO  
           The VistA numberspace for DSIO is: 19641

Installation Instructions
=========================
Pre-Installation
----------------
Extract DSIO_TITLES.zip to your database’s default directory. If you don’t know you can find the information in the KERNEL SYSTEM PARAMERTS file under record IEN 1 as the PRIMARY HFS DIRECTORY field. During installation you will be prompted with “Enter directory name or path” with it defaulted to your PRIMARY HFS DIRECTORY this is asking where are your TIU DOCUMENT TITLE XML DOCS 

Installation
------------
Normal KIDS install through Kernel Installation & Distribution System

Post Installation
-----------------
* oCNTFramework.bpl is a Delphi package used for created new oCNTs. If you are not a developer and don’t plan on creating new oCNTs then you don’t need this package.

Borlndmm.dll is required to work with CPRS, COM, and the form dlls – if this dll is not present next to the CPRS exe and at the minimum level as listed in this document then this program will not work appropriately.

User Setup
==========
Assign the Menu Context DSIO DDCS CONTEXT to users needing access to the DDCS Form Templates (oCNTs).
Assign the Menu Context DSIO GUI CONTEXT to users needing access to the MCC Dashboard.

Assign the Menu Context DSIO DDCS MAIN to users needing access to the VistA side configuration options.
Assign the Menu Context DSIO TRIGGER ENTER/EDIT to users needing access to the VistA side configuration to add, delete, and edit entries to trigger to Maternity Tracker for Problems, Consults, and Lab Results.

From the “Systems Manager Menu” option…

          Core Applications ...
          Device Management ...
   FM     VA FileMan ...
          Menu Management ...
          Programmer Options ...
          Operations Management ...
          Spool Management ...
          Information Security Officer Menu ...
          Taskman Management ...
          User Management ...
          Application Utilities ...
          Capacity Planning ...
          HL7 Main Menu ...
          Manage Mailman ...

Select Systems Manager Menu <TEST ACCOUNT> Option: USER Management

          Add a New User to the System
          Grant Access by Profile
          Edit an Existing User
          Deactivate a User
          Reactivate a User
          List users
          User Inquiry
          Switch Identities
          File Access Security ...
          Clear Electronic signature code
          Electronic Signature Block Edit
          List Inactive Person Class Users
          Manage User File ...
          OAA Trainee Registration Menu ...
          Person Class Edit
          Reprint Access agreement letter

Select User Management <TEST ACCOUNT> Option: EDIT an Existing User
Select NEW PERSON NAME: TF

<image>

Assign the Security Key DSIO CONFIG to users needing access to the GUI side configuration form.

From the “Key Management” option…

          Allocation of Security Keys
          De-allocation of Security Keys
          Enter/Edit of Security Keys
          All the Keys a User Needs
          Allocate/De-Allocate Exclusive Key(s)
          Change user's allocated keys to delegated keys
          Delegate keys
          Keys For a Given Menu Tree
          List users holding a certain key
          Remove delegated keys
          Show the keys of a particular user

Select Key Management <TEST ACCOUNT> Option: allocation of Security Keys

Allocate key: DSIO DDCS CONFIG  

Another key: 

Holder of key: FONTANA,THEO F            TF       

Another holder: 

You've selected the following keys: 

DSIO DDCS CONFIG

You've selected the following holders: 

FONTANA,THEO F

You are allocating keys.  Do you wish to proceed? YES//

DSIO DDCS CONFIG being assigned to:
     FONTANA,THEO F

Create OE/RR ENTRY
==================
This file is accessed by CPRS to use COM. There are only two fields required to use DSIO DDCS and that’s the NAME and OBJECT GUID fields. The GUID must look EXACTLY as seen below (with braces {}) but the name can be determined by the site.

INPUT TO WHAT FILE: OE/RR COM OBJECTS// 
EDIT WHICH FIELD: ALL// 

Select OE/RR COM OBJECTS NAME:    DSIO DDCS FORM BUILDER
NAME: DSIO DDCS FORM BUILDER  Replace 
OBJECT GUID: {F4401FE9-4F5C-4633-B409-E7CEC0CE863F}
           Replace 
INACTIVE: 
PARAM1: 
DESCRIPTION:
  No existing text
  Edit? NO//

Link TIU Titles in CPRS
=======================
The title must have be edited through the EDIT SHARED TEMPLATE option in CPRS with the title and COM entry.

In CPRS select a patient and navigate to the “Notes” tab and select the “Edit Templates” option under the “Options” menu. Select Document Titles and add a new template. This template must be a “Template Type” of “COM Object” with the “Associated Title” linked to the TIU Note Title you wish to have access this program with the “COM Object” field linked to the DSIO DDCS COM entry you created in the OE/RR COM Objects file.

<image>

For more information check out the documentation in the VA VDL.
http://www.va.gov/vdl/application.asp?appid=61 

Schedule the Task to PUSH Discreet Data
=======================================
You may schedule the option DSIO DDCS CHECK STATUS to meet your needs. This option will look for captured data in the DSIO DDCS DATA file and in there are new records that have not been PUSHed it will check the DSIO DDCS CONTROL file if the TRIGGER event is acceptable and if so it will PUSH the data based on the linked DSIO DDCS REPORT ITEMS.

In the “Taskman Management” option…

          Schedule/Unschedule Options
          One-time Option Queue
          Taskman Management Utilities ...
          List Tasks
          Dequeue Tasks
          Requeue Tasks
          Delete Tasks
          Print Options that are Scheduled to run
          Cleanup Task List
          Print Options Recommended for Queueing

Select Taskman Management <TEST ACCOUNT> Option: SCHedule/Unschedule Options

Select OPTION to schedule or reschedule: DSIO DDCS CHECK STATUS       Run DDCS C
ontrol Triggers for PUSH
  Are you adding 'DSIO DDCS CHECK STATUS' as 
    a new OPTION SCHEDULING (the 143RD)? No// Y  (Yes)

 
*Set the fields appropriate to your site.

Register the COM Object
=======================
In Windows, open the command prompt as an administrator and navigate to the COM Object that is located on the workstation that is accessing the DDCS Form Templates/oCNTs. Once your terminal is pointing to the same directory in which your COM resides run the command “regsvr32 DDCSFormBuilder.dll” without quotes.

<image>

Setting the Location Parameter
==============================
This parameter is required as it and the configuration file needs to be able to build the absolute path that will allow COM to access and open the form dll. In this case if I am accessing the TIU Note Title that is under DDCS control (NURSE POSTPARTUM – MATERNAL) then the oCNT_NursePostpartumMaternal.dll must then be located where the parameter indicates so: C:\Users\DSSDeveloper\Desktop\DDCS\_output\ oCNT_NursePostpartumMaternal.dll

Set the LOCATION parameter to the location of the dlls.

Select PARAMETER DEFINITION NAME: DSIO DDCS LOCATION     DSIO DDCS LOCATION

------ Setting DSIO DDCS LOCATION  for System: SMA.FO-ALBANY.MED.VA.GOV ------
LOCATION: C:\Users\DSSDeveloper\Desktop\DDCS\_output
  Replace 

Optional
========

If you wish to launch COM as an order check you can:

Select PARAMETER DEFINITION NAME:    ORWCOM ORDER ACCEPTED   COM Object on Order Acceptance

ORWCOM ORDER ACCEPTED may be set for the following:

     1   User          USR    [choose from NEW PERSON]
     3   Service       SRV    [choose from SERVICE/SECTION]
     5   Division      DIV    [choose from INSTITUTION]
     6   System        SYS    [SMA.FO-ALBANY.MED.VA.GOV]

Enter selection: 6  System   SMA.FO-ALBANY.MED.VA.GOV

---- Setting ORWCOM ORDER ACCEPTED  for System: SMA.FO-ALBANY.MED.VA.GOV ----
Select Order Display Group: LAB  LABORATORY

Order Display Group: LABORATORY//   LABORATORY   LABORATORY
COM Object: DSIO DDCS FORM BUILDER//   DSIO DDCS FORM BUILDER

The following is done by the post install build but for knowledge and understanding some of the associations has been listed here so if something is not opening up correctly then you may have to check this associations.

Advanced Setup
==============
This patch transports configuration data so nothing below this line is required at the installation site.

Create CONTROL entries that allow you capture discreet data:

Create your control entries. You can use FileMan or the DSIO DDCS CONTROL option to assist you. You will need to know the object you wish to control and the expected destination of the data (the object that data is associated to).

For example, we need to CONTROL the TIU document title OB H&P INITIAL which is IEN 93 (in my database – you would have to check yours) in file 8925.1. So I need to CONTROL 93;TIU(8925.1, where 93 is the IEN and the right of the semi-colon is the global reference. I know that notes are stored in 8925 so I will use this file as my destination file and that entries in this file are directly associated to a patient because the patient pointer is field .02.

Select DSIO DDCS CONTROL CONTROL OBJECT:    93;TIU(8925.1,     TEXT INTEGRATION UTILITIES
CONTROL OBJECT: 93;TIU(8925.1,// 
INACTIVE: 
DESTINATION FILE: TIU DOCUMENT// 
PATIENT ORIENTED: YES// 
PATIENT FIELD: .02// 
SHARE: LIMITED// 
FORM: OB HISTORY NOTE - NURSE// 
PATIENT LOOKUP CODE: 
TRIGGER LOGIC: I $$GET1^DIQ(DDCSFLE,SIEN_",",.05)="COMPLETED"
           Replace 
PRE PUSH: N LNK S LNK=$$SPG^DSIO3($G(DFN),SIEN,$$PG^DSIO4($G(DFN)))
           Replace 
POST PUSH: 
PACKAGE: TEXT INTEGRATION UTILITIES//

Next we will create our FORM (interface) and link back to our control object we just created.

Now, we need to create our FORM which will inform the GUI how it should be configured. We will be using two files which exist as the newer 19641.42.

First we should create the new form configuration. We can add on overrides to every control within the dll. For the purposes of creating additional interfaces from a single dll you first need to create copies, name them appropriately, and create new entries in this file using those file names. You may then need to create a CONTROL NAME within the configuration of PAGE# where # is one through nine – you can hide the display of these pages by setting HIDE FROM NOTE equal to TRUE.

DSIO DDCS FORM CONFIGURATION (19641.42) will guide us through creating a form configuration entry.

DSIO DDCS PARAMETER (#19641.492) allows for additional form settings to be changed.
