Routine DSIO65 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO65^INT^64204,59332^Oct 13, 2016@16:28
DSIO65 ;DSS/TFF - DSIO DDCS FORM SUPPORT;08/26/2016 16:00
 ;;2.0;DSIO 2.0;**1,2**;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; LIST^ORQQAL
 ; LIST^ORQQPL
 ; LIST^ORQQPS
 ; FASTVIT^ORQQVI
 ;
 Q
 ;
 ; --- DSIO DDCS CONFIGURATION
 ;
 ; DSIO DDCS CONFIGURATION (PARAMETER) for system level configuration
 ;     INSTANCES: LOCATION
 ;
CONFIG(RET,INFACE,INST) ; RPC: DSIO DDCS CONFIGURATION
 ;
 ; INPUT PARAMETERS:
 ; -----------------
 ; INFACE = IEN;DSIO(19641.42, or IEN;DSIO(19641.49,
 ;
 ;   INST = The Name of the set to which the data is associated
 ;          Example: LOCATION
 ;
 S RET="" Q:$G(INST)=""
 S INFACE=$$INFACE^DSIO65($G(INFACE))
 I INST="LOCATION" D  Q
 . S RET=$$GET^XPAR("SYS","DSIO DDCS LOCATION") Q:RET=""
 . I $E(RET,$L(RET))'="\"&($E(RET,$L(RET))'="/") D
 . . S RET=RET_$S(RET["\":"\",RET["/":"/",1:"")
 . Q:INFACE'[";DSIO(19641.42,"
 . S RET=RET_$$GET1^DIQ(19641.42,+INFACE_",",.05)
 Q:INFACE'[";DSIO(19641.42,"
 S RET=$$GET1^DIQ(19641.492,+INFACE_",",$$FLDNUM^DILFD(19641.492,INST))
 Q
 ;
CANCEL(RET,TASKS) ; RPC: DSIO DDCS CANCEL AUTOSAVE
 ;
 ; The Form has been closed and saved so cancel pending tasks to save
 ; TASKS =  TASK NUMBERS (ARRAY)
 ;
 N CT,FLG
 S RET=-1 Q:'$D(TASKS)
 S CT=$NA(TASKS) F  S CT=$Q(@CT) Q:CT=""  D
 . I '$$ASKSTOP^%ZTLOAD(@CT) S FLG=1
 S:'$D(FLG) RET=1
 Q
 ;
TRACK(RET,OBJECT) ; RPC: DSIO DDCS CONTROLLED
 ;
 ; RETURN
 ;   IEN ^ 19641.4:.01 ^ *IEN;DSIO(19641.42, ^ FILENAME
 ;   IEN ^ 19641.4:.01 ^ (*PAGE|PAGE|PAGE)   ^ FILENAME
 ;   - *Is the interface/form 19641.42 while the sub elements are the pages
 ;   else 0
 ;   else -1 for error
 ;
 S RET=0 Q:$G(OBJECT)=""
 I $D(^DSIO(19641.41,"ERROR")) S RET=-1 Q
 N IEN S IEN=$$OBJECT(OBJECT) Q:'IEN
 Q:$$GET1^DIQ(19641.4,IEN_",",.02,"I")                                  ; INACTIVE
 S RET=IEN_U
 S RET=RET_$$GET1^DIQ(19641.4,IEN_",",.01)_U                            ; NAME of OBJECT  (Soft Pointer)
 S RET=RET_"*"_$$GET1^DIQ(19641.4,IEN_",",.07,"I")_";DSIO(19641.42,"_U  ; 19641.42        (FORM/INTERFACE)
 S RET=RET_$$GET1^DIQ(19641.4,IEN_",",".07:.05","I")                    ; FILENAME
 Q
 ;
OBJECT(OBJECT) ; Return Object IEN
 Q:$G(OBJECT)="" ""
 ; *** Coming in as an ORDER IEN, must build the control object
 I OBJECT["O=" S OBJECT=$$ORDER(OBJECT)
 ; *** Coming in as a note, must build the control object
 I OBJECT["N=" S OBJECT=$$NOTE(OBJECT)
 Q:OBJECT="" ""
 Q $O(^DSIO(19641.4,"B",OBJECT,""))
 ;
ORDER(OBJECT) ; Object from Order
 N ORD,OID
 S ORD=+$G(^OR(100,+$P(OBJECT,"=",2),.1,1,0)) Q:'ORD ""
 S OID=$$GET1^DIQ(101.43,ORD_",",2)
 Q +OID_";"_$S($P(OID,";99",2)="LRT":"LAB(60,",1:"")
 ;
NOTE(OBJECT) ; Object from Note
 Q $$GET1^DIQ(8925,$P(OBJECT,"=",2)_",",.01,"I")_";TIU(8925.1,"
 ;
INFACE(VAL,FLG) ; Determine Interface/Form
 N RET
 I $G(VAL)="" Q "OTHER"
 I $G(VAL)?.N!($G(VAL)[";DSIO(19641.42,") D  Q:$D(RET) RET
 . I $D(^DSIO(19641.42,+VAL)) S RET=+VAL_";DSIO(19641.42,"
 I $G(VAL)[";DSIO(19641.49,",$D(^DSIO(19641.49,+VAL)) D  Q:$D(RET) RET
 . S RET=+VAL_";DSIO(19641.49,"
 I $G(VAL)'="",$D(^DSIO(19641.42,"B",VAL)) D  Q:$D(RET) RET
 . S RET=$O(^DSIO(19641.42,"B",VAL,""))_";DSIO(19641.42,"
 I $G(VAL)'="",$D(^DSIO(19641.42,"P",VAL)) D  Q:$D(RET) RET
 . I $D(FLG) S RET=VAL Q
 . S RET=$O(^DSIO(19641.42,"P",VAL,""))_";DSIO(19641.42,"
 Q $G(RET,"OTHER")
 ;
REPORT(FORM,CON) ; Get the Report Item for a Control for an Interface/Form
 N PG,IEN
 S PG=$O(^DSIO(19641.42,FORM,1,"CONTROL",CON,"")) Q:'PG ""
 S IEN=$O(^DSIO(19641.42,FORM,1,"CONTROL",CON,PG,""))
 Q $P($G(^DSIO(19641.42,FORM,1,PG,1,IEN,0)),U,3)
 ;
 ; --------------------------------ALLERGIES-----------------------------------
 ;
ORQQAL(RET,DFN) ; RPC: DSIO DDCS ORQQAL LIST
 ; GET AND FORMAT ALLERGIES
 ; allergy ien^allergen/reactant^severity^reaction/symptom
 ;
 N OUT,I,ND,NAME,P,CT
 S RET(0)="An unknown error occured."
 D LIST^ORQQAL(.OUT,DFN) Q:'$D(OUT)
 S RET(0)="ALLERGIES: "
 I "^No Allergy Assessment^No Known Allergies^No allergies found.^"[(U_$P(OUT($O(OUT(""),-1)),U,2)_U) D  Q
 . S RET(0)=RET(0)_$P(OUT($O(OUT(""),-1)),U,2)
 S RET(1)="Allergen/Reactant"_$$REPEAT^XLFSTR(" ",25)_"| Severity   | Reactions/Symptoms"
 S RET(2)=$$REPEAT^XLFSTR("=",77)
 S I=3,ND=$NA(OUT) F  S ND=$Q(@ND) Q:ND=""  D
 . S NAME=$P(@ND,U,2)         ; *** NAME UP TO 41 CHAR LENGTH
 . S RET(I)=$E(NAME,1,41)_$$REPEAT^XLFSTR(" ",42-$L($E(NAME,1,41)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,3)
 . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",55-$L(RET(I)))
 . S RET(I)=RET(I)_"| "_$P($P(@ND,U,4),";"),P=2,I=I+1
 . I $L(NAME)>41 F CT=42:41:$L(NAME) D  S I=I+1
 . . S RET(I)=$E(NAME,CT,CT+41)_$$REPEAT^XLFSTR(" ",42-$L($E(NAME,CT,CT+41)))
 . . S RET(I)=RET(I)_"| "_$$REPEAT^XLFSTR(" ",53-$L(RET(I)))_"| "
 . . I $P(@ND,U,4)[";" S RET(I)=RET(I)_$P($P(@ND,U,4),";",P),P=P+1
 . I $L($P(@ND,U,4),";")>=P F CT=P:1:$L($P(@ND,U,4),";") D  S I=I+1
 . . S RET(I)=$G(RET(I))_$$REPEAT^XLFSTR(" ",42-$L($G(RET(I))))_"| "
 . . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",55-$L(RET(I)))_"| "
 . . S RET(I)=RET(I)_$P($P(@ND,U,4),";",P),P=P+1
 . S I=I+1
 . ; *** Uncomment for ROW LINES
 . ; S RET(I)=$$REPEAT^XLFSTR("-",77),I=I+1
 Q
 ;
 ; --------------------------------ACTIVE MEDS---------------------------------
 ;
ORQQPS(RET,DFN) ; RPC: DSIO DDCS ORQQPS LIST
 ; GET AND FORMAT ACTIVE MEDICATIONS
 ; id^nameform^stop date^route^schedule/infusion rate^refills remaining
 ;
 N OUT,I,ND,NAME,P,CT
 S RET(0)="An unknown error occured."
 D LIST^ORQQPS(.OUT,DFN,"","") Q:'$D(OUT)
 S RET(0)="ACTIVE MEDICATIONS: "
 I $P(OUT($O(OUT(""),-1)),U,2)["No medications found." D  Q
 . S RET(0)=RET(0)_$P(OUT($O(OUT(""),-1)),U,2)
 S RET(1)="Medication"_$$REPEAT^XLFSTR(" ",20)_"| Stop Date  | Route  "
 S RET(1)=RET(1)_"| Schedule   | Refills"
 S RET(2)=$$REPEAT^XLFSTR("=",77)
 S I=3,ND=$NA(OUT) F  S ND=$Q(@ND) Q:ND=""  D
 . S NAME=$P(@ND,U,2)         ; *** NAME UP TO 29 CHAR LENGTH
 . S RET(I)=$E(NAME,1,29)_$$REPEAT^XLFSTR(" ",30-$L($E(NAME,1,29)))
 . S RET(I)=RET(I)_"| "_$$FMTE^XLFDT($P(@ND,U,3),"5ZD")
 . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",43-$L(RET(I)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,4)
 . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",52-$L(RET(I)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,5)
 . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",65-$L(RET(I)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,6),I=I+1
 . I $L(NAME)>29 F CT=30:29:$L(NAME) D  S I=I+1
 . . S RET(I)=$E(NAME,CT,CT+29)_$$REPEAT^XLFSTR(" ",30-$L($E(NAME,CT,CT+29)))
 . . S RET(I)=RET(I)_"| "_$$REPEAT^XLFSTR(" ",41-$L(RET(I)))
 . . S RET(I)=RET(I)_"| "_$$REPEAT^XLFSTR(" ",50-$L(RET(I)))
 . . S RET(I)=RET(I)_"| "_$$REPEAT^XLFSTR(" ",63-$L(RET(I)))_"|"
 . S I=I+1
 . ; *** Uncomment for ROW LINES
 . ; S RET(I)=$$REPEAT^XLFSTR("-",77),I=I+1
 Q
 ;
 ; -------------------------------ACTIVE PROBS---------------------------------
 ;
ORQQPL(RET,DFN) ; RPC: DSIO DDCS ORQQPL LIST
 ; GET AND FORMAT ACTIVE PROBLEMS
 ; ien^description^ICD^onset^last modified^SC^SpExp
 ;
 N OUT,I,ND,NAME,CT
 S RET(0)="An unknown error occured."
 D LIST^ORQQPL(.OUT,DFN,"A") Q:'$D(OUT)
 S RET(0)="ACTIVE PROBLEMS: "
 I $P(OUT($O(OUT(""),-1)),U,2)["No problems found." D  Q
 . S RET(0)=RET(0)_$P(OUT($O(OUT(""),-1)),U,2)
 S RET(1)="Problem"_$$REPEAT^XLFSTR(" ",45)_"| ICD        | SCT"
 S RET(2)=$$REPEAT^XLFSTR("=",77)
 S I=3,ND=$NA(OUT) F  S ND=$Q(@ND) Q:ND=""  D
 . S NAME=$P(@ND,U,2)         ; *** NAME UP TO 51 CHAR LENGTH
 . S RET(I)=$E(NAME,1,51)_$$REPEAT^XLFSTR(" ",52-$L($E(NAME,1,51)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,4)
 . S RET(I)=RET(I)_$$REPEAT^XLFSTR(" ",65-$L(RET(I)))
 . S RET(I)=RET(I)_"| "_$P(@ND,U,14),I=I+1
 . I $L(NAME)>51 F CT=52:51:$L(NAME) D  S I=I+1
 . . S RET(I)=$E(NAME,CT,CT+51)_$$REPEAT^XLFSTR(" ",52-$L($E(NAME,CT,CT+51)))
 . . S RET(I)=RET(I)_"| "_$$REPEAT^XLFSTR(" ",63-$L(RET(I)))_"| "
 . S I=I+1
 . ; *** Uncomment for ROW LINES
 . ; S RET(I)=$$REPEAT^XLFSTR("-",77),I=I+1
 Q
 ;
 ; -----------------------------------VITALS-----------------------------------
 ;
ORQQVI(RET,DFN) ; RPC: DSIO DDCS ORQQVI VITALS
 N EDD,SEX,PREPREGWT,CT
 I '$G(DFN) S RET(0)=-1 Q
 D FASTVIT^ORQQVI(.RET,DFN)
 S RET($O(RET(""),-1)+1)="^AGE^"_$$GET1^DIQ(2,DFN_",",.033)
 S EDD=$$FMTE^XLFDT($$GET1^DIQ(19641.03,$$GET1^DIQ(19641.13,$$PG^DSIO4(DFN)_",",.06,"I")_",",.01,"I"),"5Z")
 I EDD'="" S RET($O(RET(""),-1)+1)="^EDD^"_EDD
 S SEX=$$GET1^DIQ(2,DFN_",",.02)
 I SEX'="" S RET($O(RET(""),-1)+1)="^SEX^"_SEX
 S PREPREGWT=$$GET1^DIQ(19641.13,$$PG^DSIO4(DFN)_",",3.9)
 I PREPREGWT'="" S RET($O(RET(""),-1)+1)="^PREPREGWT^"_PREPREGWT
 S CT=$NA(RET) F  S CT=$Q(@CT) Q:CT=""  D
 . S $P(@CT,U,4)=$$FMTE^XLFDT($P(@CT,U,4),"5Z")
 Q
 ;
LMP(RET,DFN,INFACE) ; RPC: DSIO DDCS VITALS LMP
 ;
 ; INFACE = IEN;DSIO(19641.42, (or NAME)
 ;          or IEN;DSIO(19641.49,
 ;
 ; RETURN:
 ;  (0)LMP^MENSES^FREQUENCY^MENARCHE^HCG^AMOUNT^DURATION^ON_CONTRACEPTION^QUALIFIER^PRIOR_MENSES^
 ;     MENSES_MONTHLY^BIRTH_PILLS_CONCEPTION
 ;  (#)C1^^<LIST of COMMENTS>
 ;  (#)C2^^<LIST of CONTRACEPTION>
 ;
 N IEN,RC,I,CT,NM
 I '$G(DFN) S RET(0)=-1 Q
 S RET(0)="",IEN=$$GET1^DIQ(19641,DFN_",",1.2,"I")
 S RC=$$UP^XLFSTR($$GET1^DIQ(19641.01,IEN_",",1.7))                           ; RECENT CONTRACEPTIVE
 S I=1,CT="" F  S CT=$O(^DSIO(19641.493,"B",CT)) Q:CT=""  D
 . S NM=^DSIO(19641.493,+$O(^DSIO(19641.493,"B",CT,"")),0) Q:NM=""
 . I $$UP^XLFSTR(NM)=RC S RET(I)="C2^TRUE^"_NM
 . E  S RET(I)="C2^^"_NM
 . S I=I+1
 Q:'IEN
 S RET(0)=$$FMTE^XLFDT($$GET1^DIQ(19641.01,IEN_",",.01,"I"),"5ZD")_U          ; LMP
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.1,"I")_U                       ; MENSES
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.2)_U                           ; FREQUENCY
 S RET(0)=RET(0)_$$GET1^DIQ(19641,DFN_",",1.1)_U                              ; MENARCHE
 S RET(0)=RET(0)_$$FMTE^XLFDT($$GET1^DIQ(19641.01,IEN_",",1.6,"I"),"5ZD")_U   ; HCG
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.3,"I")_U                       ; AMOUNT
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.4,"I")_U                       ; DURATION
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.5,"I")_U                       ; ON CONTRACEPTION
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",.05,"I")_U                       ; QUALIFIER
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.8,"I")_U                       ; MENSES MONTHLY
 S RET(0)=RET(0)_$$GET1^DIQ(19641.01,IEN_",",1.9,"I")                         ; PILLS ON CONCEPTION
 I $P($G(^DSIO(19641.01,IEN,2,0)),U,4)>0 D                                    ; COMMENTS
 . S I=$O(RET(""),-1)+1,CT=0 F  S CT=$O(^DSIO(19641.01,IEN,2,CT)) Q:'CT  D
 . . D VC(^DSIO(19641.01,IEN,2,CT,0))
 Q
 ;
VC(LN) ; Restore saved comments
 N CT
 F CT=1:1:$L(LN,$C(13,10)) S RET(I)="C1^^"_$P(LN,$C(13,10),CT),I=I+1
 I $P(RET(I-1),U,3)="" K RET(I-1) S I=I-1
 Q
 ;
VS(RET,OBJECT,SIEN,DATA) ; RPC: DSIO DDCS ORQQVI VITALS SAVE
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
 ;   DATA = "VIT"^PRE_PREGNANCY_WEIGHT
 ;          "EDD"^CRITERIA                   ^EVENT_DATE^GESTATIONAL_AGE^EDD
 ;          "EDD"^CRITERIA|OTHER-DISPLAY-NAME^EVENT_DATE^GESTATIONAL_AGE^EDD
 ;          "LMP"^LMP^MENSES^FREQUENCY^AMOUNT^DURATION^ON_CONTRACEPTION^RECENT_CONTRACEPTIVE^
 ;                hCG+^MENARCHE^QUALIFIER^MENSES_MONTHLY^PILLS_ON_CONCEPTION
 ;          "COM"^TEXT
 ;
 S RET=0 Q:$G(OBJECT)=""!'$G(SIEN)
 N CONTROL,DFLE,DFN,DIC,DA,X,Y,FDA,IEN,CT
 S CONTROL=$$OBJECT^DSIO65(OBJECT) Q:'CONTROL
 Q:$$GET1^DIQ(19641.4,CONTROL_",",.02,"I")  ; INACTIVE
 ; *** DESTINATION FILE required to create RECORD
 S DFLE=$$GET1^DIQ(19641.4,CONTROL_",",.03,"I") Q:'DFLE
 ; *** DFN via CONTROL and DESTINATION IEN - SHARE only if DFN
 S DFN=$$DFN^DSIO6(CONTROL,SIEN) Q:'DFN
 S DIC="^DSIO(19641.4941,",DIC(0)="XL",X="`"_DFN D ^DIC Q:+Y<1
 ; *** RECORD of DATA is like a Variable Pointer
 S FDA(19641.49412,"?+1,"_DFN_",",.01)=SIEN_";"_$TR(^DIC(DFLE,0,"GL"),U)
 D UPDATE^DIE(,"FDA","IEN") K FDA Q:'$G(IEN(1))
 S CT=$NA(DATA) F  S CT=$Q(@CT) Q:CT=""  D
 . I $P(@CT,U)="VIT" D VSVIT(IEN(1),$P(@CT,U,2,999))
 . I $P(@CT,U)="EDD" D VSEDD(IEN(1),$P(@CT,U,2,999))
 . I $P(@CT,U)="LMP" D VSLMP(IEN(1),$P(@CT,U,2,999))
 . I $P(@CT,U)="COM" D VSCOM(IEN(1),$P(@CT,U,2,999))
 S RET=1
 Q
 ;
VSVIT(IEN,LN) ; VITALS
 ;
 ; PRE_PREGNANCY_WEIGHT
 ;
 N FDA
 S:$P(LN,U) FDA(19641.49412,IEN_","_DFN_",",4.1)=$P(LN,U)
 D UPDATE^DIE(,"FDA")
 Q
 ;
VSEDD(IEN,LN) ; EDD
 ;
 ; CRITERIA                   ^EVENT_DATE^GESTATIONAL_AGE^EDD
 ; CRITERIA|OTHER-DISPLAY-NAME^EVENT_DATE^GESTATIONAL_AGE^EDD
 ;
 N I,FDA
 F I=2,4 S $P(LN,U,I)=$$DT^DSIO2($P(LN,U,I))
 S $P(LN,U,3)=$$G1^DSIO4($$UP^XLFSTR($TR($P(LN,U,3)," ")))
 F I=1:1:$L(LN,U) S FDA(19641.494121,"?+1,"_IEN_","_DFN_",",".0"_I)=$P(LN,U,I)
 D UPDATE^DIE(,"FDA")
 Q
 ;
VSLMP(IEN,LN) ; LMP
 ;
 ; LMP^MENSES^FREQUENCY^AMOUNT^DURATION^ON_CONTRACEPTION^RECENT_CONTRACEPTIVE^hCG+^
 ; MENARCHE^QUALIFIER^MENSES_MONTHLY^PILLS_ON_CONCEPTION
 ;
 N I,FDA
 F I=1,8 S $P(LN,U,I)=$$DT^DSIO2($P(LN,U,I))
 F I=1:1:9 S FDA(19641.49412,IEN_","_DFN_",","2.0"_I)=$P(LN,U,I)
 S FDA(19641.49412,IEN_","_DFN_",",2.1)=$P(LN,U,10)
 F I=11,12 S FDA(19641.49412,IEN_","_DFN_",","2."_I)=$P(LN,U,I)
 D UPDATE^DIE(,"FDA")
 Q
 ;
VSCOM(IEN,LN) ; COMMENTS
 K ^TMP($J,"DSIO VSCOM") S ^TMP($J,"DSIO VSCOM",1)=LN
 D WP^DIE(19641.49412,IEN_","_DFN_",",3,"K","^TMP($J,""DSIO VSCOM"")")
 K ^TMP($J,"DSIO VSCOM")
 Q
 ;
VP(DFN,RECORD) ; VITALS PUSH
 ;
 ; RECORD = NAME of DSIO DDCS DATA (19641.41)
 ;
 Q:'$G(DFN)!($G(RECORD)="")
 N IEN,VAL,PG,OBJ,IEDD,LMP,NOD,FDA
 S IEN=$O(^DSIO(19641.4941,DFN,2,"B",RECORD,"")) Q:'IEN
 ; *** VITALS OBSERVATIONS
 S VAL=$P($G(^DSIO(19641.4941,DFN,2,IEN,4)),U) I VAL D  K VAL
 . ; *** PRE PREGNANCY WEIGHT
 . S PG=$$PG^DSIO4(DFN) Q:'PG  S OBJ(0)="PG."_PG
 . D O^DSIO03(DFN,.OBJ,,,"8348-5","LNC","Body weight Measured --pre pregnancy",VAL_"^lbs")
 ; *** EDD OBSERVATIONS
 I $P($G(^DSIO(19641.4941,DFN,2,IEN,1,0)),U,4) D
 . S IEDD=0 F  S IEDD=$O(^DSIO(19641.4941,DFN,2,IEN,1,IEDD)) Q:'IEDD  D
 . . D VPEDD($$UP^XLFSTR($G(^DSIO(19641.4941,DFN,2,IEN,1,IEDD,0))))
 ; *** MENARCHE OBSERVATION
 S VAL=$P($G(^DSIO(19641.4941,DFN,2,IEN,2)),U,9)
 D:VAL O^DSIO03(DFN,,,,"398700009","SCT^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5","Menarche",VAL_"^years")
 ; *** LMP OBSERVATION
 S LMP=$$FMTE^XLFDT($P($G(^DSIO(19641.4941,DFN,2,IEN,2)),U),"5Z")
 D:LMP'="" O^DSIO03(DFN,,,"Pregnancy","8665-2","LOINC","Last Menstrual Period",LMP_"|"_$P($G(^DSIO(19641.4941,DFN,2,IEN,2)),U,10))
 ; *** DSIO MENSTRUAL HISTORY
 S LMP=$$GET1^DIQ(19641,DFN_",",1.2,"I") Q:'LMP
 Q:$$GET1^DIQ(19641.01,LMP_",",.01,"I")'=$P($G(^DSIO(19641.4941,DFN,2,IEN,2)),U)
 S NOD=$G(^DSIO(19641.4941,DFN,2,IEN,2))
 S FDA(19641.01,LMP_",",.02)=DFN            ; PATIENT
 S FDA(19641.01,LMP_",",.03)=DUZ            ; ENTERED BY
 S FDA(19641.01,LMP_",",.04)=$$NOW^XLFDT    ; DATE ENTERED
 S FDA(19641.01,LMP_",",1.1)=$P(NOD,U,2)    ; MENSES
 S FDA(19641.01,LMP_",",1.3)=$P(NOD,U,4)    ; AMOUNT
 S FDA(19641.01,LMP_",",1.4)=$P(NOD,U,5)    ; DURATION
 S FDA(19641.01,LMP_",",1.5)=$P(NOD,U,6)    ; ON CONTRACEPTION
 S FDA(19641.01,LMP_",",1.7)=$P(NOD,U,7)    ; RECENT CONTRACEPTIVE
 D UPDATE^DIE(,"FDA") K FDA
 D WP^DIE(19641.01,LMP_",",2,"K","^DSIO(19641.4941,"_DFN_",2,"_IEN_",3)")
 ; *** OBSERVATIONS
 ;     *** FREQUENCY
 D O^DSIO03(DFN,,,,"364306002","SCT^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5","Duration of Menstrual Flow Frequency",$P(NOD,U,3)_"^day")
 ;     *** hCG+
 D O^DSIO03(DFN,,,,"67900009","SCT^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5","hCG+",$$FMTE^XLFDT($P(NOD,U,8),"5Z"))
 ;     *** MENSES MONTHLY
 D O^DSIO03(DFN,,,,"364307006","SCT^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5","Menses Monthly",$S($P(NOD,U,11)="Y":"True",1:"False"))
 ;     *** PILLS ON CONCEPTION
 D O^DSIO03(DFN,,,,"xx-onbcp","SCT^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.5","on Birth Control Pills at conception",$S($P(NOD,U,12)="Y":"True",1:"False"))
 Q
 ;
VPEDD(NODE) ; EDD
 ;
 ; NODE = CRITERIA                   ^EVENT_DATE^GESTATIONAL_AGE^EDD
 ;        CRITERIA|OTHER-DISPLAY-NAME^EVENT_DATE^GESTATIONAL_AGE^EDD
 ;
 ;  *** The second piece of the the x (value) for the observation will always
 ;      be true here because the vitals GUI is only going to send down the
 ;      information if it has been marked as final.
 ;
 ; EDD BY LMP              "LMP"  11779-6         LOINC  X: EDD  |TRUE
 ; EDD BY ECD              "ECD"  33067-0         LOINC  X: EVENT|TRUE
 ; EDD BY ULTRASOUND       "ULT"  11884-4         LOINC  X: EVENT|TRUE|GA
 ; EDD BY EMBRYO TRANSFER  "EMB"  EmbryoTransfer  OTHER  X: EVENT|TRUE
 ; EDD BY OTHER            "OTH"  OtherEdd        OTHER  X: EVENT|TRUE|GA
 ; EDD BY UNKNOWN          "EDD"  11778-8         LOINC  X: EDD  |TRUE
 ;
 ; *GESTATION AGE (GA) = 11884-4
 ;
 N TYP,PREG,OBJ
 S TYP=$P($P(NODE,U),"|") Q:TYP=""
 S $P(NODE,U,2)=$$FMTE^XLFDT($P(NODE,U,2),"5Z")
 S $P(NODE,U,4)=$$FMTE^XLFDT($P(NODE,U,4),"5Z")
 S PREG=$$PG^DSIO4(DFN) Q:'PREG  S OBJ(0)="PG."_PREG
 I TYP="LMP" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","11779-6","LOINC","Delivery Date Estimated From Last Menstrual Period",$P(NODE,U,4)_"|True")
 . D O^DSIO03(DFN,.OBJ,,"Pregnancy","8665-2","LOINC","Last Menstrual Period",$P(NODE,U,2)_"|"_$P($G(^DSIO(19641.4941,DFN,2,IEN,2)),U,10))
 I TYP="ECD" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","33067-0","LOINC","Estimated Conception Date",$P(NODE,U,2)_"|True")
 I TYP="ULT" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","11884-4","LOINC","Gestational Age Estimated",$P(NODE,U,2)_"|True|"_$P(NODE,U,3))
 I TYP="EMB" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","EmbryoTransfer","OTHER","Embryo Transfer",$P(NODE,U,2)_"|True")
 I TYP="OTH" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","OtherEdd","OTHER",$P($P(NODE,U),"|",2,99),$P(NODE,U,2)_"|True|"_$P(NODE,U,3))
 I TYP="EDD" D
 . D O^DSIO03(DFN,.OBJ,,"EDD","11778-8","LOINC","Estimated Delivery Date",$P(NODE,U,4)_"|True")
 Q
 ;
RDATE() ; Get Record Date - Only works if the record is a TIU Note
 Q:$G(RECORD)'[";TIU(8925," ""
 Q $$FMTE^XLFDT($$GET1^DIQ(8925,+RECORD_",",1201,"I"),"5DZ")
