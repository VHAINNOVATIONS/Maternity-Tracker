Routine DSIO0P saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO0P^INT^64156,66849^Aug 26, 2016@18:34
DSIO0P ;DSS/TFF - PRE/POST INSTALL;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 ;
 Q
 ;
PRE ; PRE-INSTALL ACTIONS
 N DIU D BMES^XPDUTL("  Deleting data dictionaries:")
 ; ----------------------------------------------------------------
 S DIU=19641.99,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO CODES(#19641.99)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.4) S:$D(^DIC(19641.4)) ^DSIO(19641.4,0)="DSIO DDCS CONTROL^19641.4I^^0"
 S DIU=19641.4,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS CONTROL(#19641.4)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.4258) S:$D(^DIC(19641.4258)) ^DSIO(19641.4258,0)="DSIO DDCS CONTROL PROPERTIES^19641.4258^^0"
 S DIU=19641.4258,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS CONTROL PROPERTIES(#19641.4258)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.425) S:$D(^DIC(19641.425)) ^DSIO(19641.425,0)="DSIO DDCS CONTROLS^19641.425^^0"
 S DIU=19641.425,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS CONTROLS(#19641.425)")
 ; ----------------------------------------------------------------
 S DIU=19641.41,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS DATA(#19641.41)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.49) S:$D(^DIC(19641.49)) ^DSIO(19641.49,0)="DSIO DDCS DIALOGS^19641.49^^0"
 S DIU=19641.49,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS DIALOGS(#19641.49)")
 ; ----------------------------------------------------------------
 S DIU=19641.45,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS ELEMENT(#19641.45)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.42) S:$D(^DIC(19641.42)) ^DSIO(19641.42,0)="DSIO DDCS FORM CONFIGURATION^19641.42I^^0"
 S DIU=19641.42,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS FORM CONFIGURATION(#19641.42)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.122) S:$D(^DIC(19641.122)) ^DSIO(19641.122,0)="DSIO DDCS OBSERVATION CONFIG^19641.122^^0"
 S DIU=19641.122,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS OBSERVATION CONFIG(#19641.122)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.492) S:$D(^DIC(19641.492)) ^DSIO(19641.492,0)="DSIO DDCS PARAMETER^19641.492IP^^0"
 S DIU=19641.492,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS PARAMETER(#19641.492)")
 ; ----------------------------------------------------------------
 S DIU=19641.124,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS PUSH HISTORY(#19641.124)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.401) S:$D(^DIC(19641.401)) ^DSIO(19641.401,0)="DSIO DDCS REPORT ITEMS^19641.401I^^0"
 S DIU=19641.401,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS REPORT ITEMS(#19641.401)")
 ; ----------------------------------------------------------------
 S DIU=19641.4941,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS SHARED DATA(#19641.4941)")
 ; ----------------------------------------------------------------
 S DIU=19641.493,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO DDCS VITALS CONTRACEPTION(#19641.493)")
 ; ----------------------------------------------------------------
 S DIU=19641.03,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO EDD HISTORY(#19641.03)")
 ; ----------------------------------------------------------------
 S DIU=19641.8,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO EDUCATION(#19641.8)")
 ; ----------------------------------------------------------------
 S DIU=19641.1,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO EXTERNAL ENTITIES(#19641.1)")
 ; ----------------------------------------------------------------
 S DIU=19641.112,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO FETUS/BABY(#19641.112)")
 ; ----------------------------------------------------------------
 S DIU=19641.6,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO IHE DOCUMENT(#19641.6)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.61) S:$D(^DIC(19641.61)) ^DSIO(19641.61,0)="DSIO IHE DOCUMENT TYPE^19641.61^^0"
 S DIU=19641.61,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO IHE DOCUMENT TYPE(#19641.61)")
 ; ----------------------------------------------------------------
 S DIU=19641.7,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC CHECKLIST(#19641.7)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.73) S:$D(^DIC(19641.73)) ^DSIO(19641.73,0)="DSIO MCC CHECKLIST CAT^19641.73^^0"
 S DIU=19641.73,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC CHECKLIST CAT(#19641.73)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.74) S:$D(^DIC(19641.74)) ^DSIO(19641.74,0)="DSIO MCC CHECKLIST COMSTAT^19641.74^^0"
 S DIU=19641.74,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC CHECKLIST COMSTAT(#19641.74)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.72) S:$D(^DIC(19641.72)) ^DSIO(19641.72,0)="DSIO MCC CHECKLIST DCT^19641.72^^0"
 S DIU=19641.72,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC CHECKLIST DCT(#19641.72)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.71) S:$D(^DIC(19641.71)) ^DSIO(19641.71,0)="DSIO MCC CHECKLIST TYPE^19641.71^^0"
 S DIU=19641.71,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC CHECKLIST TYPE(#19641.71)")
 ; ----------------------------------------------------------------
 S DIU=19641.76,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MCC PATIENT CHECKLIST(#19641.76)")
 ; ----------------------------------------------------------------
 S DIU=19641.01,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO MENSTRUAL HISTORY(#19641.01)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.123) S:$D(^DIC(19641.123)) ^DSIO(19641.123,0)="DSIO OBSERVATION PUSH^19641.123OI^^0"
 S DIU=19641.123,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO OBSERVATION PUSH(#19641.123)")
 ; ----------------------------------------------------------------
 S DIU=19641.12,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO OBSERVATIONS(#19641.12)")
 ; ----------------------------------------------------------------
 S DIU=19641,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO PATIENT(#19641)")
 ; ----------------------------------------------------------------
 S DIU=19641.81,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO PATIENT EDUCATION(#19641.81)")
 ; ----------------------------------------------------------------
 S DIU=19641.11,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO PERSON(#19641.11)")
 ; ----------------------------------------------------------------
 S DIU=19641.13,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO PREGNANCY HISTORY(#19641.13)")
 ; ----------------------------------------------------------------
 S DIU=19641.83,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO PREGNANCY-NOTE(#19641.83)")
 ; ----------------------------------------------------------------
 K ^DSIO(19641.5) S:$D(^DIC(19641.5)) ^DSIO(19641.5,0)="DSIO TITLE CONFIGURATION^19641.5P^^0"
 S DIU=19641.5,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TITLE CONFIGURATION(#19641.5)")
 ; ----------------------------------------------------------------
 S DIU=19641.2,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRACKING HISTORY(#19641.2)")
 ; ----------------------------------------------------------------
 S DIU=19641.23,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRACKING REASON(#19641.23)")
 ; ----------------------------------------------------------------
 S DIU=19641.22,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRACKING SOURCE(#19641.22)")
 ; ----------------------------------------------------------------
 S DIU=19641.35,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRIGGER CONSULTS(#19641.35)")
 ; ----------------------------------------------------------------
 S DIU=19641.33,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRIGGER LABS(#19641.33)")
 ; ----------------------------------------------------------------
 S DIU=19641.31,DIU(0)="T" D EN^DIU2
 D MES^XPDUTL("    DSIO TRIGGER PROBLEMS(#19641.31)")
 ; ----------------------------------------------------------------
 Q
 ;
POST ; Post Install
 D ^DSIO99,FLE,OBS
 Q
 ;
FLE ; Update 19641.4
 N NAM,NAME,FLE,IEN,NEW,IPT,PACK
 S NAM=0 F  S NAM=$O(^DSIO(19641.4,"B",NAM)) Q:NAM=""  D
 . Q:$E(NAM)'="<"&($E($P(NAM,";"),$L($P(NAM,";")))'=">")
 . S NAME=$E(NAM,2,$L($P(NAM,";"))-1) Q:NAME=""
 . S FLE=U_$P(NAM,";",2)_"0)",FLE=$P(@FLE,U) Q:FLE=""
 . S FLE=$O(^DIC("B",FLE,"")) Q:'FLE
 . S IEN=$$FIND1^DIC(FLE,,"XM",NAME) Q:'IEN
 . S NEW($O(^DSIO(19641.4,"B",NAM,"")))=IEN_";"_$P(NAM,";",2)
 I $D(NEW) D
 . S IEN=0 F  S IEN=$O(NEW(IEN)) Q:'IEN  D
 . . I $D(^DSIO(19641.4,"B",NEW(IEN))) D
 . . . N DIK,DA
 . . . S DA=$O(^DSIO(19641.4,"B",NEW(IEN),"")),DIK="^DSIO(19641.4," D ^DIK
 . . S IPT(19641.4,IEN_",",.01)=NEW(IEN)
 . . S PACK=$$GET1^DIQ(19641.4,IEN_",",99.1,"I")
 . . S IPT(19641.4,IEN_",",99.1)=$S(PACK=516:$$FIND1^DIC(9.4,,"XM","TIU"),PACK=26:$$FIND1^DIC(9.4,,"XM","LAB SERVICE"),1:"")
 . . D UPDATE^DIE(,"IPT")
 Q
 ;
OBS ; Clean up Outcome Observations and Update Pregnancy Outcome field (3.6)
 N IEN,FDA,CON,CODE,DIK,DA
 S IEN=0 F  S IEN=$O(^DSIO(19641.13,IEN)) Q:'IEN  D
 . S FDA(19641.13,IEN_",",3.6)=$$OUT($$GET1^DIQ(19641.13,IEN_",",3.6,"I"))
 . D UPDATE^DIE(,"FDA") K FDA
 ; *** DELETE OSERVATIONS
 ;     11996-6, 57062-2, 11637-6, 11638-4, 11639-2, GravidaParaSummary
 S DIK="^DSIO(19641.12,",IEN=0 F  S IEN=$O(^DSIO(19641.12,IEN)) Q:'IEN  D
 . S CODE=$$GETCODE^DSIO10(IEN,"C",1)
 . I CODE="11996-6"!(CODE="57062-2")!(CODE="11637-6")!(CODE="11638-4")!(CODE="11639-2")!(CODE="GravidaParaSummary") D
 . . S DA=IEN D ^DIK
 Q
 ;
OUT(X) ; Determine Outcome
 Q:X="U" "Unknown"
 Q:X="F" "Full Term"
 Q:X="P" "Preterm"
 Q:X="AS" "Spontaneous Abortion"
 Q:X="S" "Stillbirth"
 Q:X="AI" "Termination"
 Q:X="E" "Ectopic"
 Q X
