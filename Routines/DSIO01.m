Routine DSIO01 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO01^INT^64203,38329^Oct 12, 2016@10:38
DSIO01 ;DSS/TFF - DSIO OCNT PUSH SUPPORT;08/26/2016 16:00
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
DELV ; NURSE POSTPARTUM - DELIVERY
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
 N ROWS,CT,LN,PREG,DATES,FAC,FA,STR,OBJ,I,BCT,DNOTES,OUT,IFC,IFCF
 D GETS^DSIO62(.ROWS,$$IEN^DSIO62("##TCONFIGCOLLECTION##")) Q:'$D(ROWS)
 ; *** PREGNANCY
 ; Update Pregnancies and Babies
 S CT=0 F  S CT=$O(ROWS(CT)) Q:'CT  S LN=ROWS(CT) D
 . K OLD,PREG,DATES,FAC,FA,STR
 . I $P(LN,U)="L" D
 . . S OBJ(0)="PG."_$P(LN,U,2)
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
 . . . D:STR'="" PR2^DSIO04($P(LN,U,2),STR) K OBJ(1)
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
 . . ;     OBS DAYS IN HOSPITAL
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","DaysInHospital","OTHER",,$P(LN,U,22))
 . . ;     OBS PREGNANCY OUTCOME
 . . I $$UP^XLFSTR($P(LN,U,20))="TERMINATION" D
 . . . D O^DSIO03(DFN,.OBJ,,"PregnancyTerminationOutcome","Indication","OTHER",,"Unknown")
 . . D O^DSIO03(DFN,.OBJ,,"Outcome","OutcomeType","OTHER","Pregnancy Outcome",$$OT^DSIO03($P(LN,U,20)))
 . . ; *** PREGNANCY - Close it out
 . . K PREG D PREG^DSIO15(.PREG,$P(LN,U,2),DFN,DATES,,,,$G(FAC),,U_$P(LN,U,14)_"^^"_$P(LN,U,16),,,1)
 . ; *** DELIVERY COMMENTS
 . I $P(LN,U)="C" D
 . . S DNOTES(+$P(LN,U,2),+$O(DNOTES(+$P(LN,U,2),""),-1)+1)=$P(LN,U,3,9999)
 ;     *** OBS PREGANCY NOTES
 I $D(DNOTES) D
 . S CT=0 F  S CT=$O(DNOTES(CT)) Q:'CT  D
 . . S OBJ(0)="PG."_CT K OUT M OUT=DNOTES(CT)
 . . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","Notes","OTHER",,,,.OUT)
 ; *** OBS OBSTETRIC DELIVERY METHOD
 D D1($S($$TGET1^DSIO62("CKDELIVERYMETHODC"):"Cesarean Delivery",$$TGET1^DSIO62("CKDELIVERYMETHODV"):"Normal Spontaneous Vaginal Delivery (NSVD)",1:"Other"))
 ;     OBS FailedForcepVacuumDelivery
 F IFC="EDCPRIMARYFOR","CBREASONSCPRIMARY","EDREASONSCOTHPRIMARY","CBREASONSCSECONDARY","EDREASONSCOTHSECONDARY" D  Q:$D(IFCF)
 . I $TR($$UP^XLFSTR($$EGET1^DSIO62(IFC))," ")["FAILEDFORCEP" S IFCF=1
 I $D(IFCF),$$TGET1^DSIO62("CKVAGVACUUM") D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","FailedForcepVacuumDelivery","OTHER",,"True")
 ; *** OBS CESAREAN INCISION
 S STR=$$EGET1^DSIO62("RGINCISION") I STR'="" D
 . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","11466000","SNOMED-CT","Cesarean Delivery",STR)
 ; *** OBS TOTAL PREGNANCIES, STILLBIRTHS, PRETERM, LIVING, TERM BIRTHS
 D CALC
 Q
 ;
D1(DF) ; Obstetric Delivery Method
 N IT,V,LS
 F IT="CKVAGSVD","CKVAGVACUUM","CKVAGFORCEPS","CKVAGEPISIOTOMY","CKVAGLACERATIONS","CKVAGVBAC" D
 . Q:'$$TGET1^DSIO62(IT)
 . S V=$$EGET1^DSIO62(IT) Q:$$UP^XLFSTR(V)["VAGINAL DELIVERY"&(DF["Vaginal Delivery")
 . S LS=$S($D(LS):LS_","_V,1:V)
 D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","57071-3","LOINC","Obstetric Delivery Method",$S($D(LS):LS_","_DF,1:DF))
 I $$TGET1^DSIO62("CKVAGVACUUM"),$$TGET1^DSIO62("CKVAGFORCEPS") D
 . D O^DSIO03(DFN,.OBJ,,"DeliveryDetails","ForcepVacuumDelivery","OTHER",,"True")
 Q
 ;
D2() ; Get POST = ADDITIONAL DETAILS (CARET DELIMITED STRING)
 Q U_$$EGET1^DSIO62("SPNLABORLENGTH")_"^^"_$$EGET1^DSIO62("CBANESTHESIA")
 ;
 ; COMMON ---------------------------------------------------------------------
 ;
SEX(IN) ; Translate Sex Code
 S IN=$E($$UP^XLFSTR(IN),1)
 S IN=$S(IN="M":"Male",IN="F":"Female",IN="U":"Unknown",1:"")
 Q IN
 ;
CALC ; Calculated information
 ;     OBS TOTAL PREGNANCIES (CALCULATE)
 D O^DSIO03(DFN,,,"Pregnancy History","11996-6","LOINC","Total Pregnancies (Including Current)",$$TOTAL^DSIO4(DFN),,,,-1)
 ;     OBS TERM BIRTHS       (CALCULATE)
 D O^DSIO03(DFN,,,"Pregnancy History","11639-2","LOINC","Term Births (Live & Stillborn)",$$FULLT^DSIO4(DFN),,,,-1)
 ;     OBS LIVING            (CALCULATE)
 D O^DSIO03(DFN,,,"Pregnancy History","11638-4","LOINC","Living Children",$$LIVIG^DSIO4(DFN),,,,-1)
 ;     OBS PRETERM           (CALCULATE)
 D O^DSIO03(DFN,,,"Pregnancy History","11637-6","LOINC","Preterm Births (Live & Stillborn)",$$PRETM^DSIO4(DFN),,,,-1)
 ;     OBS STILLBIRTHS       (CALCULATE)
 D O^DSIO03(DFN,,,"Pregnancy History","57062-2","LOINC","Stillbirths",$$STILL^DSIO4(DFN),,,,-1)
 ;     OBS SPONTANEOUS ABORTIONS
 D O^DSIO03(DFN,,,"Pregnancy History","11614-5","LOINC","Spontaneous Abortions (Miscarriages)",$$ABORT^DSIO4(DFN,"S"),,,,-1)
 ;     OBS PREGNANCY TERMINATIONS
 D O^DSIO03(DFN,,,"Pregnancy History","11613-7","LOINC","Pregnancy Terminations",$$ABORT^DSIO4(DFN,"T"),,,,-1)
 ;     OBS ECTOPIC PREGNANCIES
 D O^DSIO03(DFN,,,"Pregnancy History","33065-4","LOINC","Ectopic Pregnancies",$$ABORT^DSIO4(DFN,"E"),,,,-1)
 ;     OBS GRAVIDA & PARA SUMMARY
 D O^DSIO03(DFN,,,"Pregnancy History","GravidaParaSummary","OTHER","Gravida & Para Summary",$$GP^DSIO4(DFN),,,,-1)
 Q
