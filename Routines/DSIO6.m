Routine DSIO6 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO6^INT^64180,40900^Sep 19, 2016@11:21
DSIO6 ;DSS/TFF - DSIO DISCREET DATA - DDCS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 ; ---------------------- DISCREET DATA CONTROL & STORAGE ---------------------
 ;
 ; DSIO6   -  DSIO DISCREET DATA
 ; DSIO61  -  DSIO DDCS SPECIAL LOOKUP
 ; DSIO62  -  DSIO DDCS SPECIAL LOOKUP
 ; DSIO63  -  DSIO DDCS CONFIGURE AND REPORT
 ; DSIO64  -  DSIO DDCS DATA RETURN
 ; DSIO65  -  DSIO DDCS FORM SUPPORT
 ; DSIO66  -  DSIO DDCS DIALOG SUPPORT
 ; DSIO67  -  DSIO DDCS ELEMENT OBSERVATIONS
 ;
 ;CONTROL & SAVE --------------------------------------------------------------
 ; 19641.4    (DSIO DDCS CONTROL)            - CONTROL, Validate to Continue
 ; 19641.41   (DSIO DDCS DATA)               - COLLECTION, of data elements for a control
 ; 19641.4941 (DSIO DDCS SHARED DATA)        - COLLECTION, of data elements for a control by DFN
 ; 19641.45   (DSIO DDCS ELEMENT)            - ELEMENT, the discreet data element
 ;
 ;CONFIGURE & REPORT ----------------------------------------------------------
 ; 19641.42   (DSIO DDCS FORM CONFIGURATION) - THE FORM TO BE RENDERED
 ; 19641.425  (DSIO DDCS CONTROLS)           - FORM CONTROLS
 ; 19641.4258 (DSIO DDCS CONTROL PROPERTIES) - FORM CONTROL PROPERTIES
 ; 19641.401  (DSIO DDCS REPORT ITEMS)       - PUSH ACTION FOR FORM CONTROLS
 ; 19641.49   (DSIO DDCS DIALOGS)            - DIALOG DLL
 ; 19641.492  (DSIO DDCS PARAMETER)          - NON SYSTEM LEVEL CONFIGURATION
 ;
 ;OBSERVATION -----------------------------------------------------------------
 ; 19641.122  (DSIO DDCS OBSERVATION CONFIG) - ALLOWS OBSERVATIONS FOR ELEMENTS CREATED DURING PUSH
 ; 19641.12   (DSIO OBSERVATIONS)
 ; 19641.123  (DSIO OBSERVATION PUSH)
 ;
 Q
 ;
STORED(RET,OBJECT,SIEN,INFACE,IDATA,ACT) ; RPC: DSIO DDCS STORE
 ;
 ; INPUT PARAMETERS:
 ; -----------------
 ; OBJECT = OBJECT of CONTROL
 ;          Example: 500000042;PXRMD(801.41,
 ;                   Which is the Reminder Dialog of IEN 500000042
 ;         = O=### (ORDER IEN)
 ;         = N=### ( NOTE IEN)
 ;
 ;   SIEN = Destination IEN - Record of Control
 ;
 ; INFACE = IEN;DSIO(19641.42, (or NAME)
 ;          or IEN;DSIO(19641.49,
 ;
 ;  IDATA = CONTROL^(INDEXED^VALUE)
 ;          (If a CONTROL is repeated then it will be considered multi-valued)
 ;
 ;    ACT = If 1 then Task
 ;
 S RET=-1 Q:$G(OBJECT)=""!'$G(SIEN)!('$D(IDATA))
 N CONTROL
 S INFACE=$$INFACE^DSIO65($G(INFACE),1)
 S CONTROL=$$OBJECT^DSIO65(OBJECT) Q:'CONTROL
 Q:$$GET1^DIQ(19641.4,CONTROL_",",.02,"I")  ; INACTIVE
 I $G(ACT)=1 S RET=$$TASK Q
 D SETDATA
 Q
 ;
TASK() ; TASK Discreet Data Storage
 ; SET AS A TASK AND RETURN THE TASK ID
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="SETDATA^DSIO6",ZTDESC="DSIO DISCREET DATA STORAGE"
 S ZTDTH=$$FMTH^XLFDT($$NOW^XLFDT),ZTIO="DSIO DDCS",ZTPRI=10
 S ZTSAVE("CONTROL")="",ZTSAVE("SIEN")=""
 S ZTSAVE("INFACE")="",ZTSAVE("IDATA(")=""
 D ^%ZTLOAD
 Q $G(ZTSK,-1)
 ;
SETDATA ; Save data as DISCREET ELEMENTS for a RECORD
 ;
 ; INCOMING: OBJECT,SIEN,INFACE,IDATA
 ;
 N DLAYGO,DFLE,DFN,SHARE,FDA,DATA,DIC,X,Y,FORM,SFORM
 S DLAYGO=19641.41
 ; *** DESTINATION FILE required to create RECORD
 S DFLE=$$GET1^DIQ(19641.4,CONTROL_",",.03,"I") Q:'DFLE
 ; *** DFN via CONTROL and DESTINATION IEN - SHARE only if DFN
 S DFN=$$DFN(CONTROL,SIEN)
 ; *** RECORD of DATA is like a Variable Pointer
 S FDA(19641.41,"?+1,",.01)=SIEN_";"_$TR(^DIC(DFLE,0,"GL"),U)
 S FDA(19641.41,"?+1,",.02)=CONTROL
 D UPDATE^DIE(,"FDA","DATA") K FDA Q:'$G(DATA(1))
 Q:'$$ACT(INFACE,"SAVE")
 S SHARE=$$SHARE^DSIO64(CONTROL,INFACE)
 ; *** Build the INTERFACE
 S FDA(19641.411,"?+1,"_DATA(1)_",",.01)=INFACE
 S FDA(19641.411,"?+1,"_DATA(1)_",",.02)=SHARE
 D UPDATE^DIE(,"FDA","FORM") K FDA Q:'$G(FORM(1))
 ; *** Populate the INTERFACE in DDCS DATA or DDCS SHARED
 I SHARE D
 . S DIC="^DSIO(19641.4941,",DIC(0)="XL",X="`"_DFN D ^DIC Q:+Y<1
 . S FDA(19641.49411,"?+1,"_DFN_",",.01)=INFACE
 . D UPDATE^DIE(,"FDA","SFORM") K FDA Q:'$G(SFORM(1))
 . ; *** DATA SHUFFLE
 . S ^DSIO(19641.4941,DFN,1,"S",INFACE,SFORM(1))=""
 . D SETDATA1(19641.494111,SFORM(1)_","_DFN_",",.IDATA)
 D SETDATA1(19641.4111,FORM(1)_","_DATA(1)_",",.IDATA)
 D END(FORM(1),DATA(1))
 Q
 ;
SETDATA1(FLE,IENS,DATA) ; Continue
 ;
 ; ARRAY OF DATA: CONTROL^(INDEXED^VALUE)
 ;           (If a CONTROL is repeated then it will be considered multi-valued)
 ;                CONTROL = The name of the control that was passed up from
 ;                          configuration
 ;                INDEXED = If it is multi-valued as items with those items as
 ;                          a list rather than word processing (stored within wp)
 ;                  VALUE = The user supplied value
 ;
 N CT,CI,CONTROL,BUILD,FDA,IEN,EIEN
 S SAVE=$NA(^TMP($J,"SETDATA1")) K @SAVE
 I $G(ACT)="C" D
 . S CONTROL="##TCONFIGCOLLECTION##",BUILD(CONTROL)=""
 . S CI=1,CT=$NA(DATA) F  S CT=$Q(@CT) Q:CT=""  D
 . . S @SAVE@(CONTROL,CI)=@CT,CI=CI+1
 I '$D(ACT) D
 . S CT=$NA(DATA) F  S CT=$Q(@CT) Q:CT=""  D
 . . S CONTROL=$$UP^XLFSTR($P(@CT,U)) Q:CONTROL=""
 . . S BUILD(CONTROL)=""
 . . S @SAVE@(CONTROL,($O(@SAVE@(CONTROL,""),-1)+1))=$P(@CT,U,2,9999)
 S CONTROL="" F  S CONTROL=$O(BUILD(CONTROL)) Q:CONTROL=""  D
 . K IEN,EIEN
 . ; *** Find the IEN for the CONTROL within the DATA or SHARED DATA entry
 . S IEN=$O(^DSIO($E(FLE,1,($L(FLE)-2)),$P(IENS,",",2),1,$P(IENS,","),1,"C",CONTROL,""))
 . ; *** If the control already exists within the captured data then
 . ;     get the DSIO DDCS ELEMENT IEN
 . I IEN S EIEN=^DSIO($E(FLE,1,($L(FLE)-2)),$P(IENS,",",2),1,$P(IENS,","),1,IEN,0)
 . ; *** If this DATA ELEMENT has already been collected  for this CONTROLled
 . ;     INTERFACE then overwrite the value, else create new
 . S EIEN=$$ELE($G(EIEN),CONTROL) Q:'$G(EIEN)
 . S FDA(FLE,$S($G(IEN):IEN,1:"+1")_","_IENS,.01)=EIEN
 . D UPDATE^DIE(,"FDA") K FDA
 K @SAVE
 Q
 ;
ELE(IEN,CONTROL) ; Set DSIO DDCS ELEMENT
 ;
 ; *** The ELEMENT of form control may already exist but it is
 ;     only required to be unique among a single instance of an
 ;     INTERFACE so if it isn't we need to recreate it. This
 ;     determination happened before entering here.
 ;
 ;     IEN = Record of 19641.45
 ; CONTROL = Name of GUI Control
 ;
 N FDA,CCLASS
 S:'$G(IEN) IEN="+1"
 S FDA(19641.45,IEN_",",.01)=CONTROL         ; CONTROL
 S CCLASS=$$CCLASS^DSIO62(INFACE,CONTROL)
 S:CCLASS FDA(19641.45,IEN_",",.02)=CCLASS   ; CLASS
 D UPDATE^DIE(,"FDA",$S(IEN'["+":"",1:"IEN")) K FDA
 S IEN=$S(IEN'["+":+IEN,$G(IEN(1)):IEN(1),1:"") Q:'IEN ""
 D WP^DIE(19641.45,IEN_",",1,"K","^TMP($J,""SETDATA1"",CONTROL)")
 K ^TMP($J,"SETDATA1",CONTROL)
 Q $G(IEN)
 ;
END(IFORM,IDATA) ; SETDATA END
 I $$ACT(IFORM,"SUBMIT") D PUSH(IDATA) Q
 S RET=IDATA
 Q
 ;
PUSH(DATA) ; PUSH Data out of DDCS
 ;
 ; * CONTROL(DDCSC), RECORD(DDCSR), 
 ;   SIEN(DESTINATION IEN), DESTINATION FILE(DDCSFLE),
 ;   DFN, INTERFACE/FORM(DDCSFRM), ELEMENT IEN(DDCSE), ELEMENT NAME(DDCSEN)
 ;
 S DATA=+$G(DATA)
 Q:$P($G(^DSIO(19641.41,DATA,0)),U,3)'=""       ; *** ALREADY PUSHED
 Q:$D(^DSIO(19641.41,"ERROR"))                  ; *** PUSH has ERRORed - maybe in another entry
 ; *** PUSH START (It must have started and failed!)
 I $P($G(^DSIO(19641.41,DATA,0)),U,4)'="" S ^DSIO(19641.41,"ERROR")="" Q
 N DDCSC,DDCSR,SIEN,DDCSFLE,DFN,INFACE,DDCSFRM,FIEN,RPT,DDCSEN,EIEN
 N DDCSE,PRE,POST,FDA,DIE,DA,X,Y
 S FDA(19641.41,DATA_",",.04)=$$NOW^XLFDT       ; *** If PUSH fails we shouldn't keep retrying!
 D FILE^DIE(,"FDA") K FDA
 S DDCSR=$P($G(^DSIO(19641.41,DATA,0)),U),SIEN=+DDCSR
 S DDCSC=$P($G(^DSIO(19641.41,DATA,0)),U,2) Q:'DDCSC
 S DDCSFLE=$P($G(^DSIO(19641.4,DDCSC,0)),U,3)
 S DFN=$$DFN(DDCSC,+DDCSR)
 I '$$TRIGGER(DDCSC) D  Q                       ; *** Not ready to PUSH
 . S FDA(19641.41,DATA_",",.03)=""
 . S FDA(19641.41,DATA_",",.04)=""
 . D FILE^DIE(,"FDA") K FDA
 S PRE=$G(^DSIO(19641.4,DDCSC,3)) X:PRE'="" PRE
 ; *** VITALS
 D VP^DSIO65(DFN,DDCSR)
 ; *** MULTIPLE INTERFACES/FORMS
 ;     - Push the whole form at once if the option exists, then traverse the elements and push
 ;       that way if you have to run a routine for some heavy lifting you can still take
 ;       advantage of the smaller configurable elements.
 S INFACE="" F  S INFACE=$O(^DSIO(19641.41,DATA,1,"B",INFACE)) Q:INFACE=""  D
 . S DDCSFRM=$$INFACE^DSIO65(INFACE)
 . S FIEN=$O(^DSIO(19641.41,DATA,1,"B",INFACE,""))
 . K RPT I DDCSFRM[";DSIO(19641.42," D
 . . ; *** PUSH the whole FORM at once
 . . S RPT=$P($G(^DSIO(19641.42,+DDCSFRM,0)),U,4) D:RPT REPORT(RPT)
 . K RPT I DDCSFRM[";DSIO(19641.49," D
 . . ; *** PUSH the whole FORM at once
 . . S RPT=$P($G(^DSIO(19641.49,+DDCSFRM,0)),U,6) D:RPT REPORT(RPT)
 . ; *** BY SAVED ELEMENTS
 . S DDCSEN="" F  S DDCSEN=$O(^DSIO(19641.41,DATA,1,FIEN,1,"C",DDCSEN)) Q:DDCSEN=""  D
 . . S EIEN=$O(^DSIO(19641.41,DATA,1,FIEN,1,"C",DDCSEN,""))
 . . S DDCSE=+$G(^DSIO(19641.41,DATA,1,FIEN,1,EIEN,0))
 . . I DDCSFRM[";DSIO(19641.42," D
 . . . S RPT=$$REPORT^DSIO65(+DDCSFRM,DDCSEN) D:RPT REPORT(RPT)
 . . . ; *** OBSERVATION
 . . . D OBF^DSIO67(+DDCSFRM,DDCSEN,DDCSE)
 . . I DDCSFRM[";DSIO(19641.49," D
 . . . S RPT=$$REPORT^DSIO66(+DDCSFRM,DDCSEN) D:RPT REPORT(RPT)
 . . . ; *** OBSERVATION
 . . . D OBD^DSIO67(+DDCSFRM,DDCSEN,DDCSE)
 S POST=$G(^DSIO(19641.4,DDCSC,4)) X:POST'="" POST
 S DIE="^DSIO(19641.41,",DA=DATA,DR=".03///"_$$NOW^XLFDT D ^DIE
 Q
 ;
REPORT(RPT) ; Run Report Item
 S RPT=+$G(RPT) Q:'RPT
 Q:$P($G(^DSIO(19641.401,RPT,0)),U,2)  ; INACTIVE
 N RTRF,RROU,HIS
 S RTRF=$G(^DSIO(19641.401,RPT,1)) X:RTRF'="" RTRF
 S RROU=$G(^DSIO(19641.401,RPT,2)) X:RROU'="" RROU
 S HIS=$$HISTORY($$GET1^DIQ(19641.4,DDCSC_",",.01),DDCSR_"|"_DDCSFRM,RROU)
 Q
 ;
HISTORY(TRIG,OBJ,ROU) ; HISTORY LOG
 ;
 ; TRIG = HISTORY LOG TRIGGER
 ;           OBSERVATIONS = Observation File
 ;                   DDCS = Control File
 ;  ROU = ROUTINE used to process report item
 ;
 N DLAYGO,IPT,IEN
 S DLAYGO=19641.124
 S IPT(19641.124,"+1,",.01)=$$NOW^XLFDT       ; DATE
 S IPT(19641.124,"+1,",.02)=TRIG              ; TRIGGER
 S IPT(19641.124,"+1,",.03)=DUZ               ; USER
 S IPT(19641.124,"+1,",.04)=$G(OBJ)           ; OBJECT
 S IPT(19641.124,"+1,",1)=$G(ROU)             ; CODE
 D UPDATE^DIE(,"IPT","IEN")
 Q $G(IEN(1))
 ;
 ; ---------------------------------- UTILITIES -------------------------------
 ;
DFN(CONTROL,SIEN) ; Get DFN from CONTROL File
 S CONTROL=+$G(CONTROL) Q:'CONTROL ""
 Q:'$P($G(^DSIO(19641.4,CONTROL,0)),U,4) ""
 N DDCSFLE,DDCSFLD,XDFN
 S DDCSFLE=$P($G(^DSIO(19641.4,CONTROL,0)),U,3)         ; DESTINATION FILE
 S DDCSFLD=$P($G(^DSIO(19641.4,CONTROL,0)),U,5)         ; PATIENT FIELD
 Q:DDCSFLD $$GET1^DIQ(DDCSFLE,$G(SIEN)_",",DDCSFLD,"I")
 S XDFN=$G(^DSIO(19641.4,CONTROL,1)) X:XDFN'="" XDFN    ; PATIENT LOOKUP CODE
 Q $G(DFN)
 ;
ACT(IEN,FUN) ; Determine if the INTERFACE is allowed to preform a function
 ;
 ; IEN = IEN;DSIO(19641.42, IEN;DSIO(19641.49, or OTHER
 ; FUN = RESTORE,SAVE,SUBMIT
 ;
 ; A = DO NOT RESTORE
 ; B = DO NOT SAVE
 ; C = DO NOT PUSH
 ; D = SUBMIT NOW (PUSH on SAVE rather than waiting for the trigger)
 ;
 N ACT,FLG,FLE
 ; *** OTHER - Can be saved but no record to PUSH
 I $G(IEN)="OTHER" S:FUN="SAVE" FLG=1 G A1
 Q:'$G(IEN) 0
 S FLE=$TR($P(IEN,"(",2),",")
 S ACT=$$GET1^DIQ(FLE,+$G(IEN)_",",$S(FLE[.42:.02,FLE[.49:.05,1:""))
 I FUN="SAVE" S:ACT'="B" FLG=1 G A1
 I FUN="RESTORE" S:ACT'="A" FLG=1 G A1
 I FUN="SUBMIT" S:ACT="D" FLG=1 G A1
 Q 0
 ;
A1 ; Continue
 Q +$G(FLG)
 ;
TRIGGER(IEN) ; Check the Trigger logic from the Controlled Object to
 ;             determine PUSH
 ;
 ; *Expected Variables: DFLE,SIEN
 ;  C = DO NOT PUSH
 ;
 N FORM,TRIG
 S FORM=$P($G(^DSIO(19641.4,IEN,0)),U,7) Q:'FORM 0
 Q:$P($G(^DSIO(19641.42,FORM,0)),U,2)["C" 0
 S TRIG=$G(^DSIO(19641.4,IEN,2)) Q:TRIG="" 1
 I 1 X TRIG Q:'$T 0
 Q 1
 ;
ERROR ; Remove the Error Lock on 19641.41 and delete any PUSH START entries that
 ;      do not have a PUSHED entry
 ;
 N IEN,FDA
 K ^DSIO(19641.41,"ERROR")
 S IEN=0 F  S IEN=$O(^DSIO(19641.41,"PUSH",IEN)) Q:'IEN  D
 . I $P($G(^DSIO(19641.41,IEN,0)),U,4)'="",$P($G(^DSIO(19641.41,IEN,0)),U,3)="" D
 . . W !!,"   RECORD UPDATED: ",IEN
 . . S FDA(19641.41,IEN_",",.04)="" D FILE^DIE(,"FDA") K FDA
 W !!,$$CJ^XLFSTR(" FINISHED CLEAN UP ",79,"*"),!
 Q
 ;
 ; --------------------------------- TRIGGER ----------------------------------
 ;
TRIG ; Attempt to PUSH unPUSHed records
 N DDCSD,DDCSC
 S DDCSD=0 F  S DDCSD=$O(^DSIO(19641.41,"PUSH",DDCSD)) Q:'DDCSD  D
 . S DDCSC=$P($G(^DSIO(19641.41,DDCSD,0)),U,2) Q:'DDCSC
 . D PUSH(DDCSD)
 Q
