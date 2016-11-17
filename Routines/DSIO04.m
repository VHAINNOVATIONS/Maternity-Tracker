Routine DSIO04 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO04^INT^64203,38329^Oct 12, 2016@10:38
DSIO04 ;DSS/TFF - DSIO OCNT PUSH SUPPORT DIALOGS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;**1**;Aug 26, 2016;Build 1
 ;
 ;
 ; 
 Q
 ;
 ; ----------------------------------------------------------------------------
 ; * CONTROL(DDCSC), RECORD(DDCSR), 
 ;   SIEN(DESTINATION IEN), DESTINATION FILE(DDCSFLE),
 ;   DFN, INTERFACE/FORM(DDCSFRM), ELEMENT IEN(DDCSE), ELEMENT NAME(DDCSEN)
 ; ----------------------------------------------------------------------------
 ;
EDUCAT ; Education
 ;
 ; INDEX ^ ITEM ^ CODE ^ CATEGORY
 ;
 N OUT,LN
 D GETS^DSIO62(.OUT,$$IEN^DSIO62("EDUCATIONLISTVIEW")) Q:'$D(OUT)
 S LN=$NA(OUT) F  S LN=$Q(@LN) Q:LN=""  D
 . Q:$P(@LN,U,3)=""!($P(@LN,U)'["TRUE")
 . D O^DSIO03(DFN,,,$P(@LN,U,4),$P(@LN,U,3),"SCT",$P(@LN,U,2),"True")
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
FAMILY ; Family History
 ;
 ;  2 : IEN
 ;  3 : NAME
 ;  4 : SEX
 ;  5 : DATE OF BIRTH
 ;  6 : YEARS OF EDUCATION
 ;  7 : STREET ADDRESS 1
 ;  8 : STREET ADDRESS 2
 ;  9 : STREET ADDRESS 3
 ; 10 : CITY
 ; 11 : STATE
 ; 12 : ZIP
 ; 13 : PHONE HOME
 ; 14 : PHONE WORK
 ; 15 : PHONE CELL
 ; 16 : PHONE FAX
 ; 17 : PATIENT NAME
 ; 18 : DFN
 ; 19 : RELATIONSHIP
 ; 20 : STATUS
 ; 21 : DIAGNOSIS|
 ; 22 : COMMENTS
 ;
 N OUT,CT,LN,PR,DATES,I,ID,ADDR,PHONE,PROB,FDA
 D GETS^DSIO62(.OUT,$$IEN^DSIO62("LVPERSONLIST")) Q:'$D(OUT)
 S CT=1 F  S CT=$O(OUT(CT)) Q:'CT  S LN=OUT(CT) D
 . K PR,DATES,ADDR,PHONE,PROB
 . ;I $P(LN,U,2)["-"&($P(LN,U,2)'["+") D SAVE^DSIO9(.PR,+$P(LN,U,2),,"@") Q
 . I $P(LN,U,2)["+" D SAVE^DSIO9(.PR,,DFN,$P(LN,U,3),,,,,,,,,1) Q:'PR  S $P(LN,U,2)=+PR
 . S DATES=$$DT^DSIO2($P(LN,U,5))
 . ; *** ADDRESS
 . S I=7 F ID=1,2,3,"CITY","STATE","ZIP" S ADDR(I)=ID_U_$P(LN,U,I),I=I+1
 . ; *** PHONE NUMBERS
 . S I=13 F ID="H","WP","MC" S PHONE(I)=ID_U_$P(LN,U,I),I=I+1
 . ; *** DIAGNOSIS
 . F I=1:1:$L($P(LN,U,21),"|") S PROB(I)=$P($P(LN,U,21),"|",I)
 . K PR D SAVE^DSIO9(.PR,+$P(LN,U,2),DFN,$P(LN,U,3),DATES,.ADDR,.PHONE,$P(LN,U,6),$P(LN,U,4),$P(LN,U,19),$P(LN,U,20),.PROB,1)
 . S FDA(19641.11,+$P(LN,U,2)_",",4)=$P(LN,U,22)
 . D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
GENETI ; Genetic Screening
 N I,LN,VAL,OUT,NAR
 ; CONTROL_BOOLEAN ; CONTROL_NARRATIVE ; CODE_SYSTEM ; CODE ; DISPLAY NAME
 F I=1:1 S LN=$P($T(GENETI+I^DSIO05),";;",2) Q:LN=""  D
 . K OUT,NAR S VAL=$$UP^XLFSTR($$GET1^DSIO62($$IEN^DSIO62($P(LN,";"))))
 . I $P(VAL,U)="TRUE" D
 . . S VAL=$$CKVAL($P(VAL,U,2)) Q:VAL="Unknown"!(VAL="")
 . . S OUT=$P($$GET1^DSIO62($$IEN^DSIO62($P(LN,";",2))),U,2) S:OUT'="" NAR(1)=OUT
 . . D O^DSIO03(DFN,,"FAMMEMB",,$P(LN,";",4),$P(LN,";",3)_"^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.4",$P(LN,";",5),VAL,,.NAR)
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
INFECT ; Infection History
 N I,LN,VAL,OUT,NAR
 ; CONTROL_BOOLEAN ; CONTROL_NARRATIVE ; CODE_SYSTEM ; CODE ; DISPLAY NAME
 F I=1:1 S LN=$P($T(INFECT+I^DSIO05),";;",2) Q:LN=""  D
 . K OUT,NAR S VAL=$$UP^XLFSTR($$GET1^DSIO62($$IEN^DSIO62($P(LN,";"))))
 . I $P(VAL,U)="TRUE" D
 . . S VAL=$$CKVAL($P(VAL,U,2)) Q:VAL="Unknown"!(VAL="")
 . . S OUT=$P($$GET1^DSIO62($$IEN^DSIO62($P(LN,";",2))),U,2) S:OUT'="" NAR(1)=OUT
 . . D O^DSIO03(DFN,,,,$P(LN,";",4),$P(LN,";",3)_"^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.6",$P(LN,";",5),VAL,,.NAR)
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
MEDICA ; Medical History
 N I,LN,VAL,OUT,NAR
 ; CONTROL_BOOLEAN ; CONTROL_NARRATIVE ; CODE_SYSTEM ; CODE ; DISPLAY NAME
 F I=1:1 S LN=$P($T(MEDICA+I^DSIO05),";;",2) Q:LN=""  D
 . K OUT,NAR S VAL=$$UP^XLFSTR($$GET1^DSIO62($$IEN^DSIO62($P(LN,";"))))
 . I $P(VAL,U)="TRUE" D
 . . S VAL=$$CKVAL($P(VAL,U,2)) Q:VAL="Unknown"!(VAL="")
 . . S OUT=$P($$GET1^DSIO62($$IEN^DSIO62($P(LN,";",2))),U,2) S:OUT'="" NAR(1)=OUT
 . . D O^DSIO03(DFN,,,,$P(LN,";",4),$P(LN,";",3)_"^1.3.6.1.4.1.19376.1.5.3.1.1.16.5.1",$P(LN,";",5),VAL,,.NAR)
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
OBSPRE ; OB Flow Sheet
 N OUT,CT Q:'$G(DFN)
 D GETS^DSIO62(.OUT,$$IEN^DSIO62("SGSTANDARD")) Q:'$D(OUT)
 S CT=0 F  S CT=$O(OUT(CT)) Q:'CT  D
 . D OB1($P($P(OUT(CT),U),","),$P($P(OUT(CT),U),",",2),$P(OUT(CT),U,2,999))
 Q
 ;
OB1(COL,ROW,VAL) ; Data by Column
 Q:VAL=""
 N DIS,SYS,CODE,UNT,DATE,PREG,EDC,OBJ
 S DIS=$$OB2("D",COL),SYS=$$OB2("S",COL),CODE=$$OB2("C",COL)
 S UNT=$$OB2("U",COL),DATE=$$DT^DSIO2($$OB3(ROW))
 Q:CODE=""
 S PREG=$$OB4(DATE) I 'PREG D  Q:'PREG
 . S PREG=$$PG^DSIO4(DFN) Q:'PREG
 . S EDC=$$GET1^DIQ(19641.13,PREG_",",.02,"I") Q:EDC=""  S:DATE<EDC PREG=-1
 S OBJ(0)="PG."_PREG
 D O^DSIO03(DFN,.OBJ,,,CODE,SYS_"^1.3.6.1.4.1.19376.1.5.3.1.1.11.2.3.2",DIS,VAL_U_UNT,,,DATE,,$$OB5)
 Q
 ;
OB2(TYP,COL) ; Return Element by Column
 ;
 ; COL ; DIS ; SYS ; CODE ; UNIT
 ;
 N I,LN,OUT
 F I=1:1 S LN=$P($T(OBSPRE+I^DSIO05),";;",2) Q:LN=""  D  Q:$D(OUT)
 . I $P(LN,";")=COL D
 . . I TYP="D" S OUT=$P(LN,";",2) Q
 . . I TYP="S" S OUT=$P(LN,";",3) Q
 . . I TYP="C" S OUT=$P(LN,";",4) Q
 . . I TYP="U" S OUT=$P(LN,";",5)
 Q $G(OUT)
 ;
OB3(ROW) ; Return Date by Row
 N CT,RET
 S CT=0 F  S CT=$O(OUT(CT)) Q:'CT  D
 . I $P($P(OUT(CT),U),",")=0,$P($P(OUT(CT),U),",",2)=ROW D
 . . S RET=$TR($P(OUT(CT),U,2),"@"," ")
 Q $G(RET)
 ;
OB4(DATE) ; Return Pregnancy that occured during the data of...
 N OUT,CT,IEN
 D HPG^DSIO15(.OUT,$$FMADD^XLFDT(DATE,-365),$$FMADD^XLFDT(DATE,365)) I '$G(@OUT@(0)) K @OUT Q 0
 S CT=$NA(@OUT) F  S CT=$Q(@CT) Q:CT=""  Q:$QS(CT,1)'=$J!($QS(CT,2)'="DSIO HPG")  D  Q:$G(IEN)
 . Q:+$P(@CT,U,5)'=DFN
 . I DATE'<$$DT^DSIO2($P(@CT,U,4)),DATE'>$$DT^DSIO2($P(@CT,U,9)) S IEN=$P(@CT,U,2)
 K @OUT
 Q +$G(IEN)
 ;
OB5() ; Return observation IEN based on Date
 N CT,I,OBJECT,OUT,IEN
 S CT=$NA(OBJ) F I=0:1 S CT=$Q(@CT) Q:CT=""  S OBJECT(I)=$$OBJECT^DSIO10(@CT)
 D OBG^DSIO10(.OUT,,DFN,.OBJECT,,DATE,DATE,,,"LOINC",CODE,"1,1") Q:+$G(@OUT@(0))=0 ""
 S IEN=$P($G(@OUT@(1,0)),U,2) K @OUT Q:'IEN ""
 Q IEN
 ;
 ; ----------------------------------------------------------------------------
 ;
PREGHI ; Pregnancy History
 ;
 ;   1) L
 ;   2) IEN
 ;   3) DATE RECORDED
 ;   4) EDC
 ;   5) DFN|PATIENT
 ;   6) STATUS
 ;   7) FOF|(IEN OR IDENTIFIER)
 ;   8) EDD
 ;   9) PREGNANCY END
 ;  10) OB IEN|OB
 ;  11) FACILITY IEN|FACILITY
 ;  12) UPDATED BY IEN|UPDATED BY
 ;  13) GESTATIONAL AGE
 ;  14) LENGTH OF LABOR
 ;  15) TYPE OF DELIVERY  (C or V)
 ;  16) ANESTHESIA
 ;  17) PRETERM DELIVERY
 ;  18) BIRTH TYPE
 ;  19) IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU|
 ;  20) OUTCOME
 ;  21) HIGH RISK FLAG
 ;  22) DAYS IN HOSPITAL
 ;
 ;  C^IEN^COMMENT
 ;  B^IEN|BABY|#^COMMENT
 ;
 N ROWS,CT,LN,PREG,DATES,FAC,FA,STR,OBJ,I,BCT,DNOTES,OUT
 D GETS^DSIO62(.ROWS,$$IEN^DSIO62("##TCONFIGCOLLECTION##")) Q:'$D(ROWS)
 ; *** PREGNANCY
 ; Update Pregnancies and Babies
 S CT=0 F  S CT=$O(ROWS(CT)) Q:'CT  S LN=ROWS(CT) D
 . K OLD,PREG,DATES,FAC,FA,STR
 . I $P(LN,U)="L" D
 . . I $P(LN,U,2)["+" D PREG^DSIO15(.PREG,,DFN,,"H",,,,,,,,1) Q:'PREG  D PR1(+PREG)
 . . S OBJ(0)="PG."_$P(LN,U,2)
 . . Q:$$GET1^DIQ(19641.13,$P(LN,U,2)_",",.04,"I")="C"   ; *** Do NOT process the CURRENT!
 . . ; DATES = EDC^END^EDD
 . . F I=4,9,8 S DATES=$S($D(DATES):DATES_U,1:"")_$$DT^DSIO2($P(LN,U,I))
 . . I $P($P(LN,U,11),"|",2)'="" D  K:$G(FAC)'?1"NVA.".N FAC
 . . . S FAC=$$UP^XLFSTR($P($P(LN,U,11),"|",2))
 . . . I $D(^DSIO(19641.1,"F",FAC)) D  Q
 . . . . S FAC="NVA."_$O(^DSIO(19641.1,"F",FAC,""))
 . . . D SENT^DSIO1(.FA,,FAC,"F",,,,,1) I FA S FAC="NVA."_+FA
 . . ; *** OBSERVATIONS -------------------------------------------------------
 . . ;     BABY LEVEL
 . . ; Add/Update Babies
 . . S BCT=0 F I=1:1:$L($P(LN,U,19),"|") S STR=$P($P(LN,U,19),"|",I) D
 . . . D:STR'="" PR2($P(LN,U,2),STR) K OBJ(1)
 . . ; *** OBSERVATIONS -------------------------------------------------------
 . . ;     PREGNANCY LEVEL
 . . I BCT D
 . . . ;     OBS BABY COUNT
 . . . D O^DSIO03(DFN,.OBJ,,"Pregnancy","FetusBabyCount","OTHER","Fetus/Baby Count",BCT)
 . . . ;     OBS BIRTH DATE OF FETUS
 . . . D O^DSIO03(DFN,.OBJ,,"Outcome","75092-7","LOINC","Birth Date of Fetus",$P(LN,U,9))
 . . ;     OBS GESTATIONAL AGE
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","412726003","SNOMED-CT","Gestational Age at Birth",$$G1^DSIO4($P(LN,U,13)))
 . . S STR=$$UP^XLFSTR($E($P(LN,U,15),1))
 . . ;     OBS DELIVERY TYPE
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","CesareanDelivery","OTHER",,$S(STR="C":"True",1:"False"))
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","NormalSpontaneousVaginalDelivery","OTHER",,$S(STR="V":"True",1:"False"))
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","OtherDelivery","OTHER",,$S(STR="":"True",1:"False"))
 . . S STR=$S(STR="C":"Cesarean Delivery",STR="V":"Normal Spontaneous Vaginal Delivery (NSVD)",1:"Other")
 . . ;     OBS OBSTETRIC DELIVERY METHOD
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","57071-3","LOINC","Obstetric Delivery Method",STR)
 . . ;     OBS DAYS IN HOSPITAL
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","DaysInHospital","OTHER",,$P(LN,U,22))
 . . ;     OBS PREGNANCY OUTCOME
 . . I $$UP^XLFSTR($P(LN,U,20))="TERMINATION" D
 . . . D O^DSIO03(DFN,.OBJ,,"PregnancyTerminationOutcome","Indication","OTHER",,"Unknown")
 . . D O^DSIO03(DFN,.OBJ,,"Outcome","OutcomeType","OTHER","Pregnancy Outcome",$$OT^DSIO03($P(LN,U,20)))
 . . ; *** UPDATE PREGNANCY
 . . K PREG D PREG^DSIO15(.PREG,$P(LN,U,2),DFN,DATES,,,,$G(FAC),,U_$P(LN,U,14)_"^^"_$P(LN,U,16),,,1)
 . ; *** DELIVERY COMMENTS
 . I $P(LN,U)="C" D
 . . S DNOTES(+$P(LN,U,2),+$O(DNOTES(+$P(LN,U,2),""),-1)+1)=$P(LN,U,3,9999)
 ;     *** OBS PREGANCY NOTES
 I $D(DNOTES) D
 . S CT=0 F  S CT=$O(DNOTES(CT)) Q:'CT  D
 . . Q:$$GET1^DIQ(19641.13,CT_",",.04,"I")="C"   ; *** Do NOT process the CURRENT!
 . . S OBJ(0)="PG."_CT K OUT M OUT=DNOTES(CT)
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","Notes","OTHER",,,,.OUT)
 ;     OBS TOTAL PREGNANCIES, STILLBIRTHS, PRETERM, LIVING, TERM BIRTHS
 D CALC^DSIO01
 Q
 ;
PR1(IEN) ; Update IEN
 ;
 ;  C^IEN^COMMENT
 ;  B^IEN|BABY|#^COMMENT
 ;
 N OLD,CT
 S OLD=$P(LN,U,2),$P(LN,U,2)=IEN
 S CT=0 F  S CT=$O(ROWS(CT)) Q:'CT  D
 . I $P(ROWS(CT),U)="C",$P(ROWS(CT),U,2)=OLD S $P(ROWS(CT),U,2)=IEN
 . I $P(ROWS(CT),U)="B",+$P(ROWS(CT),U,2)=OLD D
 . . S $P(ROWS(CT),U,2)=IEN_"|"_$P($P(ROWS(CT),U,2),"|",2,3)
 Q
 ;
PR2(PREG,LN) ; Update Baby
 ;
 ; LN = IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
 ;
 N PG,CT,RN
 I $P(LN,";")["+" D PREG^DSIO15(.PG,PREG,DFN,,,,,,"+",,,,1) Q:'$P(PG,U,2)  S $P(LN,";")=+$P(PG,U,2)
 Q:$P(LN,";")'?.N
 S OBJ(1)="FB."_+LN,BCT=BCT+1
 D O^DSIO03(DFN,.OBJ,,"BabyDetails","46098-0","LOINC","Sex",$$SEX^DSIO01($P(LN,";",4)))              ; OBS GENDER
 D O^DSIO03(DFN,.OBJ,,"BabyDetails","9272-6","LOINC","One Minute APGAR",$P(LN,";",7))                ; OBS APGAR1 (1 MINUTE)
 D O^DSIO03(DFN,.OBJ,,"BabyDetails","9274-2","LOINC","Five Minute APGAR",$P(LN,";",8))               ; OBS APGAR2 (5 MINUTE)
 D O^DSIO03(DFN,.OBJ,,"BabyDetails","AdmittedToIcu","OTHER","",$S(+$P(LN,";",10):"True",1:"False"))  ; OBS NICU
 D O^DSIO03(DFN,.OBJ,,"BabyDetails","8339-4","LOINC","Birth Weight",$P($P(LN,";",5),"."))            ; OBS BIRTH WEIGHT IN GRAMS
 K ^TMP($J,"DSIO04 PR2")
 S CT=0 F  S CT=$O(ROWS(CT)) Q:'CT  S RN=ROWS(CT) D
 . Q:$P(RN,U)'="B"!(+$P(RN,U,2)'=PREG)!($P($P(RN,U,2),"|",3)'=$P(LN,";",2))
 . S ^TMP($J,"DSIO04 PR2",$O(^TMP($J,"DSIO04 PR2",""),-1)+1)=$P(RN,U,3,999)
 I $D(^TMP($J,"DSIO04 PR2")) D
 . D WP^DIE(19641.112,+LN_",",1,"K","^TMP($J,""DSIO04 PR2"")")
 K ^TMP($J,"DSIO04 PR2")
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
RETURN ; Return to Clinic
 N PREG,OBJ,VAL
 S PREG=$$PG^DSIO4($G(DFN)) Q:'PREG  S OBJ(0)="PG."_PREG
 S VAL=$$RE1($$EGET1^DSIO62("EDTRTCWEEKS"),$$UP^XLFSTR($$EGET1^DSIO62("CBTIMEUNIT")))_"^day"
 D O^DSIO03(DFN,.OBJ,,,"57070-5","LOINC^1.3.6.1.4.1.19376.1.5.3.1.1.11.2.3.2","Date next clinic visit",VAL)
 Q
 ;
RE1(N,U) ; How many days until next visit
 S U=$S(U["DAY":1,U["WEEK":7,U["MONTH":30,U["YEAR":365,1:0)
 Q N*U
 ;
 ; ----------------------------------------------------------------------------
 ;
SOCIAL ; Social History
 N CAT,PREG,OBJ,VAL,VA,VB,VS,NAR
 S CAT="Social History",PREG=$$PG^DSIO4($G(DFN)) Q:'PREG  S OBJ(0)="PG."_PREG
 I $$TGET1^DSIO62("CKSMOKEYES") D
 . S VAL=$$EGET1^DSIO62("SPNCIGYRS")+$$EGET1^DSIO62("SPNCIGARYRS")+$$EGET1^DSIO62("SPNPIPEYRS")
 . D O^DSIO03(DFN,.OBJ,,CAT,"229819007","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Smoking",VAL_"^{pack}/a")
 I $$TGET1^DSIO62("CHECKBOX25") D
 . S VAL=$$EGET1^DSIO62("SPNEXERCISE")_"^{times}/wk"
 . K NAR D WGETS^DSIO62(.NAR,$$IEN^DSIO62("EDEXERCISE"))
 . D O^DSIO03(DFN,.OBJ,,CAT,"256235009","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Exercise",VAL,,.NAR)
 I $$TGET1^DSIO62("CKALCOHOLYES") D
 . S VA=$$SO1($$EGET1^DSIO62("SPNWINE"),$$UP^XLFSTR($$EGET1^DSIO62("CBWINE")))
 . S VB=$$SO1($$EGET1^DSIO62("SPNBEER"),$$UP^XLFSTR($$EGET1^DSIO62("CBBEER")))
 . S VS=$$SO1($$EGET1^DSIO62("SPNSPIRIT"),$$UP^XLFSTR($$EGET1^DSIO62("CBSPIRIT")))
 . D O^DSIO03(DFN,.OBJ,,CAT,"160573003","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","ETOH (Alcohol) Use",(VA+VB+VS)_"^{drink}/a")
 S VAL=$S($$TGET1^DSIO62("CHECKBOX18"):"True",$$TGET1^DSIO62("CHECKBOX19"):"False",1:"") D
 . Q:VAL=""  K NAR D WGETS^DSIO62(.NAR,$$IEN^DSIO62("EDDIET"))
 . D O^DSIO03(DFN,.OBJ,,CAT,"364393001","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Diet",VAL,,.NAR)
 S VAL=$S($$TGET1^DSIO62("CHECKBOX28"):"True",$$TGET1^DSIO62("CHECKBOX29"):"False",1:"") D
 . Q:VAL=""  K NAR D WGETS^DSIO62(.NAR,$$IEN^DSIO62("EDEMPLOYED"))
 . D O^DSIO03(DFN,.OBJ,,CAT,"364703007","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Employment",VAL,,.NAR)
 S VAL=$S($$TGET1^DSIO62("CHECKBOX7"):"True",$$TGET1^DSIO62("CHECKBOX8"):"False",1:"") D
 . Q:VAL=""  K NAR D WGETS^DSIO62(.NAR,$$IEN^DSIO62("EDTOXIC"))
 . D O^DSIO03(DFN,.OBJ,,CAT,"425400000","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Toxic Exposure",VAL,,.NAR)
 S VAL=$S($$TGET1^DSIO62("CKDRUGSYES"):"True",$$TGET1^DSIO62("CKDRUGSNO"):"False",1:"") D
 . D:VAL'="" O^DSIO03(DFN,.OBJ,,CAT,"363908000","SCT^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Drug Use",VAL)
 K NAR D WGETS^DSIO62(.NAR,$$IEN^DSIO62("MELIFEOTHER")) Q:'$D(NAR)
 D O^DSIO03(DFN,.OBJ,,CAT,"29762-2","LNC^1.3.6.1.4.1.19376.1.5.3.1.4.13.4","Other Social History",,,.NAR)
 Q
 ;
SO1(N,U) ; How much Alcohol in a Year
 S U=$S(U["DAY":365,U["WEEK":52,U["MONTH":12,U["YEAR":1,1:0)
 Q N*U
 ;
 ; -- COMMON ------------------------------------------------------------------
 ;
CKVAL(VAL) ; Transform Value for Checkboxes of Yes, No, and Unknown
 S VAL=$$UP^XLFSTR($E(VAL,1))
 Q $S(VAL="Y"!(VAL="T"):"True",VAL="N"!(VAL="F"):"False",VAL="U":"Unknown",1:"")
