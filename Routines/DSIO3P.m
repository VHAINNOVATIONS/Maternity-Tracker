DSIO3P ;DSS/TFF - PRE/POST INSTALL;08/26/2016 16:00
 ;;3.0;MATERNITY TRACKER;;Feb 02, 2017;Build 1
 ;Originally Submitted to OSEHRA 2/21/2017 by DSS, Inc. 
 ;Authored by DSS, Inc. 2014-2017
 ;
 ;
 ;
 ;
 Q
 ;
PRE ; PRE-INSTALL ACTIONS
 N DIU,TMP,CT
 D BMES^XPDUTL("  Deleting data dictionaries:")
 S TMP="" F CT=1:1 S TMP=$P($T(FILES+CT),";;",2) Q:TMP=""  D
 . S DIU=$P(TMP,";"),DIU(0)="T" D EN^DIU2
 . D MES^XPDUTL("    "_$P(TMP,";",2)_" (#"_$P(TMP,";")_")")
 ;
 ; *** Delete Data ***
 ;
 K ^DSIO(19641.122) S:$D(^DIC(19641.122)) ^DSIO(19641.122,0)="DSIO DDCS OBSERVATION CONFIG^19641.122^^"
 K ^DSIO(19641.123) S:$D(^DIC(19641.123)) ^DSIO(19641.123,0)="DSIO OBSERVATION PUSH^19641.123OI^^"
 K ^DSIO(19641.4) S:$D(^DIC(19641.4)) ^DSIO(19641.4,0)="DSIO DDCS CONTROL^19641.4I^^"
 K ^DSIO(19641.401) S:$D(^DIC(19641.401)) ^DSIO(19641.401,0)="DSIO DDCS REPORT ITEMS^19641.401I^^"
 K ^DSIO(19641.42) S:$D(^DIC(19641.42)) ^DSIO(19641.42,0)="DSIO DDCS FORM CONFIGURATION^19641.42I^^"
 K ^DSIO(19641.425) S:$D(^DIC(19641.425)) ^DSIO(19641.425,0)="DSIO DDCS CONTROLS^19641.425^^"
 K ^DSIO(19641.4258) S:$D(^DIC(19641.4258)) ^DSIO(19641.4258,0)="DSIO DDCS CONTROL PROPERTIES^19641.4258^^"
 K ^DSIO(19641.49) S:$D(^DIC(19641.49)) ^DSIO(19641.49,0)="DSIO DDCS DIALOGS^19641.49^^"
 K ^DSIO(19641.492) S:$D(^DIC(19641.492)) ^DSIO(19641.492,0)="DSIO DDCS PARAMETER^19641.492IP^^"
 K ^DSIO(19641.5) S:$D(^DIC(19641.5)) ^DSIO(19641.5,0)="DSIO TITLE CONFIGURATION^19641.5P^^"
 ;
 ; *** Update the push cross reference for file 19641.41
 ;
 N IEN S IEN=0 F  S IEN=$O(^DSIO(19641.41,"PUSH",IEN)) Q:'IEN  D
 . S ^DSIO(19641.41,"AP",IEN)=""
 K ^DSIO(19641.41,"PUSH")
 Q
 ;
FILES ; DISO Files
 ;;19641;DSIO PATIENT
 ;;19641.01;DSIO MENSTRUAL HISTORY
 ;;19641.03;DSIO EDD HISTORY
 ;;19641.1;DSIO EXTERNAL ENTITIES
 ;;19641.11;DSIO PERSON
 ;;19641.112;DSIO FETUS/BABY
 ;;19641.12;DSIO OBSERVATIONS
 ;;19641.122;DSIO DDCS OBSERVATION CONFIG
 ;;19641.123;DSIO OBSERVATION PUSH
 ;;19641.124;DSIO DDCS PUSH HISTORY
 ;;19641.13;DSIO PREGNANCY HISTORY
 ;;19641.2;DSIO TRACKING HISTORY
 ;;19641.22;DSIO TRACKING SOURCE
 ;;19641.23;DSIO TRACKING REASON
 ;;19641.31;DSIO TRIGGER PROBLEMS
 ;;19641.33;DSIO TRIGGER LABS
 ;;19641.35;DSIO TRIGGER CONSULTS
 ;;19641.4;DSIO DDCS CONTROL
 ;;19641.401;DSIO DDCS REPORT ITEMS
 ;;19641.41;DSIO DDCS DATA
 ;;19641.42;DSIO DDCS FORM CONFIGURATION
 ;;19641.425;DSIO DDCS CONTROLS
 ;;19641.4258;DSIO DDCS CONTROL PROPERTIES
 ;;19641.45;DSIO DDCS ELEMENT
 ;;19641.48;DSIO OCNT CONFIGURATION
 ;;19641.49;DSIO DDCS DIALOGS
 ;;19641.492;DSIO DDCS PARAMETER
 ;;19641.493;DSIO DDCS VITALS CONTRACEPTION
 ;;19641.4941;DSIO DDCS SHARED DATA
 ;;19641.5;DSIO TITLE CONFIGURATION
 ;;19641.6;DSIO IHE DOCUMENT
 ;;19641.61;DSIO IHE DOCUMENT TYPE
 ;;19641.7;DSIO MCC CHECKLIST
 ;;19641.71;DSIO MCC CHECKLIST TYPE
 ;;19641.72;DSIO MCC CHECKLIST DCT
 ;;19641.73;DSIO MCC CHECKLIST CAT
 ;;19641.74;DSIO MCC CHECKLIST COMSTAT
 ;;19641.76;DSIO MCC PATIENT CHECKLIST
 ;;19641.8;DSIO EDUCATION
 ;;19641.81;DSIO PATIENT EDUCATION
 ;;19641.83;DSIO PREGNANCY-NOTE
 ;;19641.99;DSIO CODES
 ;;
 Q
 ;
POST ; Post Install
 D ^DSIO99
DELIVERY ;
 ; *** Update 19641.13 field 3.3
 ; C: CESAREAN ; V: VAGINAL ; O: OTHER
 N IEN,FDA,VAL
 S IEN=0 F  S IEN=$O(^DSIO(19641.13,IEN)) Q:'IEN  D
 . S VAL=$$GET1^DIQ(19641.13,IEN_",",3.3,"I")
 . S VAL=$S(VAL="C":"CESAREAN",VAL="V":"VAGINAL",VAL="O":"OTHER",1:VAL)
 . S FDA(19641.13,IEN_",",3.3)=VAL
 . D UPDATE^DIE(,"FDA") K FDA
DATA ;
 ; *** Update 19641.4
 N NAM,NAME,FLE,IEN,NEW,DIK,DA,IPT,PACK
 S NAM=0 F  S NAM=$O(^DSIO(19641.4,"B",NAM)) Q:NAM=""  D
 . Q:$E(NAM)'="<"&($E($P(NAM,";"),$L($P(NAM,";")))'=">")
 . S NAME=$E(NAM,2,$L($P(NAM,";"))-1) Q:NAME=""
 . S FLE=U_$P(NAM,";",2)_"0)",FLE=$P(@FLE,U) Q:FLE=""
 . S FLE=$O(^DIC("B",FLE,"")) Q:'FLE
 . S IEN=$$FIND1^DIC(FLE,,"XM",NAME) Q:'IEN
 . S NEW($O(^DSIO(19641.4,"B",NAM,"")))=IEN_";"_$P(NAM,";",2)
 I $D(NEW) D
 . S DIK="^DSIO(19641.4,"
 . S IEN=0 F  S IEN=$O(NEW(IEN)) Q:'IEN  D
 . . I $D(^DSIO(19641.4,"B",NEW(IEN))) D
 . . . K DA S DA=$O(^DSIO(19641.4,"B",NEW(IEN),"")) D ^DIK
 . . S IPT(19641.4,IEN_",",.01)=NEW(IEN)
 . . S PACK=$$GET1^DIQ(19641.4,IEN_",",99.1,"I")
 . . S:PACK=516 PACK=$$FIND1^DIC(9.4,,"XM","TEXT INTEGRATION UTILITIES")
 . . S:PACK=26 PACK=$$FIND1^DIC(9.4,,"XM","LAB SERVICE")
 . . S IPT(19641.4,IEN_",",99.1)=$S(PACK:PACK,1:"")
 . . D UPDATE^DIE(,"IPT") K IPT
 S NAM=0 F  S NAM=$O(^DSIO(19641.4,"B",NAM)) Q:NAM=""  D
 . Q:$E(NAM)'="<"&($E($P(NAM,";"),$L($P(NAM,";")))'=">")
 . K DA S DA=$O(^DSIO(19641.4,"B",NAM,"")) D ^DIK
 S IEN=0 F  S IEN=$O(^DSIO(19641.4,IEN)) Q:'IEN  D
 . S IPT(19641.4,IEN_",",99.1)="TEXT INTEGRATION UTILITIES"
 . D UPDATE^DIE("E","IPT") K IPT
 S IEN=0 F  S IEN=$O(^DSIO(19641.42,IEN)) Q:'IEN  D
 . S IPT(19641.42,IEN_",",99.1)="TEXT INTEGRATION UTILITIES"
 . D UPDATE^DIE("E","IPT") K IPT
 Q
