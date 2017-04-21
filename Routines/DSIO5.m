DSIO5 ;DSS/TFF - DSIO TRIGGERS;08/26/2016 16:00
 ;;3.0;MATERNITY TRACKER;;Feb 02, 2017;Build 1
 ;
 ;
 ;
 Q
 ;
TRIGGER(FLE,NUM) ; Flag patients off of ^PXRMINDX
 Q:'$G(FLE)!('$G(NUM))
 N CON,IEN
 S CON=0 F  S CON=$O(^DSIO(FLE,"B",CON)) Q:'CON  D
 . S IEN=0 F  S IEN=$O(^DSIO(FLE,"B",CON,IEN)) Q:'IEN  D
 . . Q:$P($G(^DSIO(FLE,IEN,0)),U,2)    ; *** INACTIVE
 . . D TRG(FLE,NUM,CON,IEN)
 Q
TRG(FLE,NUM,CIEN,PIEN) ; Continue
 ;
 ; CIEN = Control IEN (.01 VALUE)
 ; PIEN = Pointer IEN (DSIO RECORD IEN)
 ;
 N CD,CONTROL,ST,DFN,FLG,LRDT,RDT,LIEN,IEN,FDA
 I FLE=19641.31 D  Q   ; *** PROBLEM
 . ; *** PXRMINDX is by ICD,10D,SCT
 . I CIEN[";ICD9(" D
 . . S CD=$$GET1^DIQ(80,+CIEN_",",1.1)
 . . S CD=$S(CD["ICD-9":"ICD",CD["ICD-10":"10D",1:"") Q:CD=""
 . . S CONTROL=$$GET1^DIQ(80,+CIEN_",",.01)
 . I CIEN[";LEX(757.02," D
 . . S CD=$$GET1^DIQ(757.02,+CIEN_",",2) Q:CD=""
 . . S CONTROL=$$GET1^DIQ(757.02,+CIEN_",",1)
 . Q:'$D(CONTROL)
 . ; *** C:CRONIC, A:ACUTE, U:UNKNOWN
 . F ST="C","A","U" D
 . . S DFN=0 F  S DFN=$O(^PXRMINDX(NUM,CD,"ISPP",CONTROL,"A",ST,DFN)) Q:'DFN  D
 . . . Q:$D(FLG(DFN))  Q:'$$SEX^DSIO4(DFN)
 . . . S LRDT=$O(^DSIO(FLE,PIEN,2,"C",DFN,""),-1),RDT=""
 . . . F  S RDT=$O(^PXRMINDX(NUM,CD,"ISPP",CONTROL,"A",ST,DFN,RDT),-1) Q:RDT=""  Q:LRDT'=""&(RDT<LRDT)  D
 . . . . S LIEN=$O(^DSIO(FLE,PIEN,2,"C",DFN,RDT,""),-1),IEN=""
 . . . . F  S IEN=$O(^PXRMINDX(NUM,CD,"ISPP",CONTROL,"A",ST,DFN,RDT,IEN),-1) Q:IEN=""  Q:LIEN'=""&(IEN<=LIEN)  D
 . . . . . S FDA(19641.312,"+1,"_PIEN_",",.01)=DFN
 . . . . . S FDA(19641.312,"+1,"_PIEN_",",.02)=RDT
 . . . . . S FDA(19641.312,"+1,"_PIEN_",",.03)=IEN
 . . . . . D UPDATE^DIE(,"FDA") K FDA S FLG(DFN)="" D RES(DFN,CONTROL,"PROBLEM")
 I FLE=19641.33 D      ; *** LAB
 . S CD=0 F  S CD=$O(^DSIO(FLE,PIEN,1,CD)) Q:'CD  D
 . . S CONTROL(+$P($G(^DSIO(FLE,PIEN,1,CD,0)),U))=$P($G(^DSIO(FLE,PIEN,1,CD,0)),U,2)
 . S DFN=0 F  S DFN=$O(^PXRMINDX(NUM,"IP",CIEN,DFN)) Q:'DFN  D
 . . Q:$D(FLG(DFN))  Q:'$$SEX^DSIO4(DFN)
 . . S LRDT=$O(^DSIO(FLE,PIEN,2,"C",DFN,""),-1),RDT=""
 . . F  S RDT=$O(^PXRMINDX(NUM,"IP",CIEN,DFN,RDT),-1) Q:RDT=""  Q:LRDT'=""&(RDT<LRDT)  D
 . . . S LIEN=$O(^DSIO(FLE,PIEN,2,"C",DFN,RDT,""),-1),IEN=""
 . . . F  S IEN=$O(^PXRMINDX(NUM,"IP",CIEN,DFN,RDT,IEN),-1) Q:IEN=""  Q:LIEN'=""&(IEN=LIEN)  D
 . . . . ; IEN = 19;CH;7019774.9;386
 . . . . Q:$P(IEN,";",2)'="CH"
 . . . . S ST=+$$GET1^DIQ(63.04,$P(IEN,";",3)_","_+IEN_",",.05,"I") Q:'$D(CONTROL(ST))
 . . . . ; ^LR(19,"CH",7019774.9,386)="11.1^L^^755"
 . . . . Q:$P($G(^LR(+IEN,"CH",$P(IEN,";",3),$P(IEN,";",4))),U)<CONTROL(ST)
 . . . . S FDA(19641.332,"+1,"_PIEN_",",.01)=DFN
 . . . . S FDA(19641.332,"+1,"_PIEN_",",.02)=RDT
 . . . . S FDA(19641.332,"+1,"_PIEN_",",.03)=IEN
 . . . . D UPDATE^DIE(,"FDA") K FDA S FLG(DFN)=""
 . . . . D RES(DFN,$$GET1^DIQ(60,CIEN_",",.01),"LAB")
 Q
 ;
RES(DFN,CODE,ID) ; Record Tracking Log
 N OUT D REC^DSIO1(.OUT,DFN,2,"Controlled "_ID_" ("_CODE_")",,"TRIGGER")
 Q
 ;
 ; -------------------------------- PROBLEMS ----------------------------------
 ;
PROBLEM(RET) ; RPC: DSIO CHECK CONTROLLED PROBLEMS
 S:$D(ZTQUEUED) ZTREQ="@"
 S RET=1 D TRIGGER(19641.31,9000011)
 Q
 ;
 ; ---------------------------------- LABS ------------------------------------
 ;
LAB(RET) ; RPC: DSIO CHECK CONTROLLED LABS
 ;
 ; Process:
 ;  1) Loop through the ^PXRMINDX(63,"IP" OR "PI" for female patients for
 ;     controlled labs. "IP" is item/patient for subscripted by test then
 ;     by patient and is the direction on this RPC.
 ;     - ^PXRMINDX(63,"IP",1,3,2980224.1,"19;CH;7019774.9;386")=""
 ;  2) If the .05 of the LRIDT of 63.04 equals the specimen in the control
 ;     then check the first piece of the test node.
 ;     - $$GET1^DIQ(63.04,7019774.9_","_19_",",.05,"I")
 ;     - ^LR(19,"CH",7019774.9,386)="11.1^L^^755"
 ;  3) If the result is a number and is => the control result then create
 ;     a tracking log.
 ;  4) If the result is not a number then check if the result is equal to
 ;     any special value listed in the control file.
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 S RET=1 D TRIGGER(19641.33,63)
 Q
 ;
 ; -------------------------------- CONSULTS ----------------------------------
 ;
CONSULT(RET) ; RPC: DSIO CHECK CONTROLLED CONSULTS
 S:$D(ZTQUEUED) ZTREQ="@"
 N CON,IEN,STAT,RDT,GMR,DFN,FDA,RES,OUT S RET=1
 S CON=0 F  S CON=$O(^DSIO(19641.35,"B",CON)) Q:'CON  D
 . S IEN=0 F  S IEN=$O(^DSIO(19641.35,"B",CON,IEN)) Q:'IEN  D
 . . Q:$P($G(^DSIO(19641.35,IEN,0)),U,2)    ; *** INACTIVE
 . . S STAT=$P($G(^DSIO(19641.35,IEN,0)),U,3) Q:STAT=""
 . . S RDT="" F  S RDT=$O(^GMR(123,"AE",CON,STAT,RDT),-1) Q:RDT=""  D
 . . . S GMR="" F  S GMR=$O(^GMR(123,"AE",CON,STAT,RDT,GMR),-1) Q:GMR=""  D
 . . . . S DFN=$$GET1^DIQ(123,GMR_",",.02,"I") Q:'$$SEX^DSIO4(DFN)
 . . . . Q:$D(^DSIO(19641.35,"C",GMR,STAT))
 . . . . S FDA(19641.352,"+1,"_IEN_",",.01)=GMR
 . . . . S FDA(19641.352,"+1,"_IEN_",",.02)=STAT
 . . . . D UPDATE^DIE(,"FDA") K FDA
 . . . . S RES="Controlled CONSULT ("_$$GET1^DIQ(123,GMR_",",1)_") on "
 . . . . S RES=RES_$$GET1^DIQ(123,GMR_",",.01)_" with a status of "
 . . . . S RES=RES_$$GET1^DIQ(100.01,STAT_",",.01)
 . . . . D REC^DSIO1(.OUT,DFN,2,RES,,"TRIGGER")
 Q
