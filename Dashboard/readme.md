## MCC Dashboard

The MCC Dashboard is a tool to track pregnant patients during pregnancy and postpartum. 

The dashboard is a **Visual Studio 2015** solution containing projects.  Here are the projects included 
and a brief description: 

### --va.gov.artemis.cda 

This project handles most of the processing of CDA (Clinical Document Architecture) and IHE (Integrating the Healthcare Enterprise) documents 

### --va.gov.artemis.commands 

This project contains commands for interacting with VistA data. Note that installation of a KID file (DSIO) is required. 

### --va.gov.artemis.command.tests 

This project contains tests for the VistA commands. 

### --va.gov.artemis.core 

This project contains logging and tracing functionality 

### --va.gov.artemis.mock 

This project contains basic mock objects for use in testing 

### --va.gov.artemis.ui 

This project contains the bulk of the UI for the dashboard 

### --va.gov.artemis.ui.data

This project contains models and processing for UI-related data 

### --va.gov.artemis.ui.tests

This project contains UI tests 

### --va.gov.artemis.vista

This project contains the base functionality for connecting to VistA

### --va.gov.artemis.vista.tests

This project contains tests for the VistA project 

## Preparing a release of the dashboard 

	(1) Build the solution (ctrl+shift+b)

	(2) Unit tests 

		(a) Add test configuration data to the app.config files found in the test projects 
		(b) Run all tests and verify success 

	(3) Publish 
		(a) Right-click on the va.gov.artemis.ui project and select "Publish.."

## Dependencies 

The dashboard's primary dependency is on the DSIO routines found in the KID files. 

## Configuration 

The configuration of the website is done through the web.config file where values for the following can be set: 

	(1) VistA server and port
	(2) CDA Export folder 
	(3) Text4Baby credentials 
