Routine DSIO03 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO03^INT^64180,40431^Sep 19, 2016@11:13
DSIO03 ;DSS/TFF - DSIO OBSERVATION PUSH;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
CREATE(RET,NA,CD,SY,DL) ; Create Observation PUSH
 ;
 ; NA = NAME
 ; CD = CODE
 ; SY = CODE SYSTEM
 ; DL = 0:FALSE, 1:TRUE, 2:BOTH
 ; *For delete observation and transaction
 ;
 N FDA,IEN S RET=0
 Q:$G(NA)=""!($G(CD)="")
 S FDA(19641.123,"?+1,",.01)=NA
 S FDA(19641.123,"?+1,",.02)=CD
 S FDA(19641.123,"?+1,",.03)=$G(SY,"OTHER")
 S FDA(19641.123,"?+1,",.04)=$S(+$G(DL)<3&(+$G(DL)>0):DL,1:0)
 D UPDATE^DIE(,"FDA","IEN") S:$G(IEN(1)) RET=IEN(1)
 Q
 ;
 ; OBSERVATION CREATION -------------------------------------------------------
 ;
O(DFN,OBJECT,REL,CAT,CODE,SYS,DIS,VAL,NEG,NAR,DATES,REF,IEN) ; Generic Entry
 ;
 ;    DFN = PATIENT
 ; OBJECT = OBJECTS OF OBSERVATION (ARRAY)
 ;          FB.IEN (FETUS/BABY)
 ;          PG.IEN (PREGNANCY)
 ;    REL = RELATIONSHIP
 ;    CAT = CATEGORY
 ;   CODE = STANDARD CODE
 ;    SYS = STANDARD SYSTEM ^ OID
 ;          ** OBSERVATION 9TH INPUT
 ;             SYS NAME^SYS VALUE^CODE^DISPLAY NAME
 ;             $P(SYS,U)_U_$P(SYS,U,2)_U_CODE_U_DIS
 ;    VAL = (input = VALUE^UNIT) -> OBS = TYPE^UNIT^VALUE
 ;    NEG = NEGATION  (T/F)
 ;    NAR = NARRATIVE (ARRAY OF TEXT)
 ;  DATES = OBSERVATION^START^END
 ;
 Q:'$G(DFN)!($G(CODE)="")
 N I,OUT,CT,UNT,SYSN,SYSV
 I $G(REF)'=-1 K REF S REF(0)="TIU."_+DDCSR
 S DATES=$G(DATES) F I=1:1:3 S $P(DATES,U,I)=$$DT^DSIO2($P(DATES,U,I))
 I $P(DATES,U)="" S $P(DATES,U)=$$NOW^XLFDT
 S REL=$G(REL),CAT=$G(CAT),DIS=$G(DIS),UNT=$P($G(VAL),U,2),VAL=$P($G(VAL),U),NEG=$G(NEG)
 S SYSN=$S($P($G(SYS),U)'="":$P(SYS,U),1:"OTHER"),SYSV=$P($G(SYS),U,2)
 D OBS^DSIO10(.OUT,$G(IEN),DFN,DATES,.OBJECT,.REF,REL,CAT,SYSN_U_SYSV_U_CODE_U_DIS,U_UNT_U_VAL,,,,.NAR,1)
 Q
 ;
 ; PUSH -----------------------------------------------------------------------
 ;
LAS ; LACTATION STATUS (CODE: Lactating)
 ;
 ; DSIO PATIENT #19641
 ;   3  LACTATION HISTORY (Multiple-19641.04), [3;0]
 ;         .01  LACTATION DATE (MD), [0;1]
 ;         .02  END DATE (D), [0;2]
 ;
 Q:$G(X)=""!('$G(DFN))
 N IPT,IENS
 I X="YES" D
 . Q:$$LACT^DSIO4(DFN)="YES"
 . S IPT(19641.04,"?+1,"_DFN_",",.01)=$$NOW^XLFDT
 I X="NO" D
 . Q:$$LACT^DSIO4(DFN)="NO"
 . S IENS=$$LACE^DSIO4(DFN)_","_DFN_","
 . S:'IENS IENS="?+1,"_DFN_",",IPT(19641.04,IENS,.01)=$$NOW^XLFDT
 . S IPT(19641.04,IENS,.02)=$$NOW^XLFDT
 D:$D(IPT) UPDATE^DIE(,"IPT")
 Q
 ;
PATIENT(FLD) ; Update Patient Element
 Q:$G(X)=""!('$G(DFN))
 N IPT
 S IPT(19641,DFN_",",FLD)=X
 D UPDATE^DIE("E","IPT")
 Q
 ;
BABY(FLD) ; Update Baby Information
 Q:'$G(DFN)!('$G(OIEN))
 N IEN,IPT
 S IEN=$$OBJ("DSIO(19641.112,") Q:'IEN
 I FLD=.06 S X=$$BW(X)
 S IPT(19641.112,IEN_",",FLD)=X
 D UPDATE^DIE("E","IPT")
 Q
 ;
BW(VAL) ; Convert Birth Weight
 Q:VAL?.N +VAL
 N V,L,O
 S V=$TR($$UP^XLFSTR(VAL)," "),L="",O=""
 Q:V["G" +V
 I V["LB" D
 . S L=$P(V,"LB") S:L'="" L=+$$WEIGHT^XLFMSMT(L,"LB","G")
 . S V=$S(V["LBS":$P(V,"LBS",2),1:$P(V,"LB",2))
 I V["OZ" S O=$P(V,"OZ") S:O'="" O=+$$WEIGHT^XLFMSMT(O,"OZ","G")
 Q L+O
 ;
PREG(FLD) ; Update Pregnancy Element
 Q:$G(X)=""!('$G(DFN))
 N V,IEN,IPT S V=X
 I FLD=3.1,$$UP^XLFSTR($P(X,"|",2))="TRUE" D EDD("ULT") Q
 I FLD=3.1 D
 . I $$UP^XLFSTR($P(V,U,2))="WKS" S V=$$G2^DSIO4(+V_"W") Q
 . I V?.N S V=$$G2^DSIO4(V)
 I FLD=3.6 D
 . S V=$$OTV(V)
 . I V="Preterm" S X="YES" D PREG(3.5) Q
 . I V="Full Term" S X="NO" D PREG(3.5) Q
 . I V="Stillbirth" S X="YES" D BABY(.07)
 . I V="Stillbirth"!(V="Spontaneous Abortion")!(V="Termination") D
 . . S X="DEMISE" D BABY(.011)
 S IEN=$$OBJ("DSIO(19641.13,") Q:'IEN
 S IPT(19641.13,IEN_",",FLD)=V
 D UPDATE^DIE("E","IPT")
 Q
 ;
MHIST(FLD) ; Update Menstrual History
 Q:$G(X)=""!('$G(DFN))
 N LMP,IEN,IPT
 S LMP=$$GET1^DIQ(19641,DFN_",",1.2,"I") Q:'LMP
 I FLD=1.5!(FLD=1.8)!(FLD=1.9) D
 . S X=$$UP^XLFSTR($E(X,1)),X=$S(X="Y"!(X="T"):"YES",1:"NO")
 S IPT(19641.01,LMP_",",FLD)=X
 D UPDATE^DIE("E","IPT")
 Q
 ;
ODM(VAL) ; Validate and transform a obsteric delivery method
 S VAL=$$UP^XLFSTR($G(VAL))
 Q $S("^V^C^O^"[(U_VAL_U):VAL,VAL["VAGIN":"V",VAL["CESAR":"C",1:"O")
 ;
OT(VAL) ; Transform OutcomeType from End User to Observation value
 S VAL=$$UP^XLFSTR($TR(VAL," "))
 Q:VAL["FULLTERM" "FullTermDelivery"
 Q:VAL["PRETERM" "PretermDelivery"
 Q:VAL["SPONTANEOUS" "SpontaneousAbortion"
 Q:VAL["STILLBIRTH" "StillBirth"
 Q:VAL["TERMINATION" "PregnancyTermination"
 Q:VAL["ECTOPIC" "Ectopic"
 Q "Unknown"
 ;
OTV(VAL) ; Transform OutcomeType from observation value to VistA (End User)
 S VAL=$$UP^XLFSTR(VAL)
 Q:VAL="FULLTERMDELIVERY" "Full Term"
 Q:VAL="PRETERMDELIVERY" "Preterm"
 Q:VAL="SPONTANEOUSABORTION" "Spontaneous Abortion"
 Q:VAL="STILLBIRTH" "Stillbirth"
 Q:VAL="PREGNANCYTERMINATION" "Termination"
 Q:VAL="ECTOPIC" "Ectopic"
 Q "Unknown"
 ;
GA(TYP) ; Update Gestational Age for Pregnancy
 ;
 ; TYP = "D" or "W"
 ;
 N PREG,FLD,FWK,FDY,IPT
 S PREG=$$OBJ("DSIO(19641.13,") Q:'PREG
 S FLD=$$UP^XLFSTR($$GET1^DIQ(19641.13,PREG_",",3.1))
 S FWK=+$P(FLD,"W"),FDY=+$P($P(FLD,"D"),"W",2)
 S IPT(19641.13,PREG_",",3.1)=$S(TYP="W":X_"W"_FDY_"D",TYP="D":FWK_"W"_X_"D",1:"")
 D UPDATE^DIE(,"IPT")
 Q
 ;
PTXT ; Add to the Pregnacy History Comments
 D TXT(19641.13,4,"DSIO(19641.13,")
 Q
 ;
BTXT ; Add to the Baby Comments
 D TXT(19641.112,1,"DSIO(19641.112,")
 Q
 ;
TXT(FLE,FLD,OBJ) ; Observation narrative as a value
 N OUT,CT,I
 D OBG^DSIO10(.OUT,OIEN) I '$D(@OUT@(0)) K @OUT Q
 K ^TMP("DSIO03",$J)
 S I=1,CT=$NA(@OUT) F  S CT=$Q(@CT) Q:CT=""  Q:$QS(CT,2)'="DSIO OBG"  D
 . I $P(@CT,U)="C" S ^TMP("DSIO03",$J,I)=$P(@CT,U,3,99),I=I+1
 D:I>1 WP^DIE(FLE,$$OBJ(OBJ)_",",FLD,,"^TMP(""DSIO03"",$J)")
 K @OUT,^TMP($J,"DSIO OBG"),^TMP("DSIO03",$J)
 Q
 ;
 ; EDD/LMP --------------------------------------------------------------------
 ;
EDD(TYP) ; EDD Observation
 ;
 ; EDD BY LMP              "LMP"  11779-6         LOINC  X: EDD  |TRUE
 ; EDD BY ECD              "ECD"  33067-0         LOINC  X: EVENT|TRUE
 ; EDD BY ULTRASOUND       "ULT"  11884-4         LOINC  X: EVENT|TRUE|GA
 ; EDD BY EMBRYO TRANSFER  "EMB"  EmbryoTransfer  OTHER  X: EVENT|TRUE
 ; EDD BY OTHER            "OTH"  OtherEdd        OTHER  X: EVENT|TRUE|GA
 ; EDD BY UNKNOWN          "EDD"  11778-8         LOINC  X: EDD  |TRUE
 ;
 N PREG,ISF,DATE,PG,EDD,GA,IED,FDA
 S PREG=$$PG^DSIO4(DFN) Q:'PREG
 S ISF=$$UP^XLFSTR($E($P($G(X),"|",2),1)) S ISF=$S(ISF="T"!(ISF="Y")!(ISF=1):1,1:0) Q:'ISF
 S DATE=$$DT^DSIO2($P(X,"|")) Q:DATE=""
 D:TYP="ECD" PREG^DSIO15(.PG,PREG,DFN,DATE,,,,,,,,,1)               ; ECD
 S EDD=$S(TYP="EDD"!(TYP="LMP"):DATE,1:$$CALEDD(TYP,DATE,$P(X,"|",3))) Q:EDD=""
 S GA=$$CALGA(TYP,$S(TYP="EDD"!(TYP="LMP"):$$FMADD^XLFDT(EDD,-280),1:DATE),EDD,$P(X,"|",3))
 D PREG^DSIO15(.PG,PREG,DFN,"^^"_EDD,,,,,,GA,,,1)                   ; EDD and GA
 S IED=$$GET1^DIQ(19641.13,PREG_",",.06,"I") Q:'IED
 S FDA(19641.03,IED_",",.02)=DFN                                    ; PATIENT
 S FDA(19641.03,IED_",",.03)=DUZ                                    ; ENTERED BY
 S FDA(19641.03,IED_",",.04)=$$NOW^XLFDT                            ; DATE ENTERED
 S FDA(19641.03,IED_",",1.1)=$G(^DSIO(19641.12,+$G(OIEN),6,1,0))    ; METHOD OF CALCULATION
 S FDA(19641.03,IED_",",1.2)=1                                      ; IS FINAL
 S FDA(19641.03,IED_",",2.1)=PREG                                   ; DSIO PREGNANCY HISTORY
 S FDA(19641.03,IED_",",2.2)=$G(OIEN)                               ; DSIO OBSERVATIONS
 D FILE^DIE(,"FDA")
 Q
 ;
CALEDD(TYP,DATE,GA) ; Calculate EDD (Again?)
 I GA["W"!(GA["D") S GA=$$G1^DSIO4(GA)
 I TYP="ECD" Q $$FMADD^XLFDT(DATE,266)
 I TYP="ULT" Q $$FMADD^XLFDT(DATE,(280-GA))
 I TYP="EMB" Q $$FMADD^XLFDT(DATE,262)
 I TYP="OTH" Q $$FMADD^XLFDT(DATE,(280-GA))
 Q
 ;
CALGA(TYP,EVENT,EDD,GADD) ; Calculate the GA (Again?) - in Days
 N DATE,GA
 S DATE=$S(DT<EDD:DT,1:EDD),GA=$$FMDIFF^XLFDT(DATE,EVENT)
 I TYP="LMP" Q GA
 I TYP="ECD" Q GA+14
 I TYP="ULT" Q GA+GADD
 I TYP="EMB" Q GA+18
 I TYP="OTH" Q GA+GADD
 I TYP="EDD" Q GA
 Q 0
 ;
LMP ; Push LMP
 ;
 ; Last Menstrual Period  8665-2    LNC  X: DATE|QUALIIER
 ;                        21840007  SCT  X: DATE
 ;                        11779-6   LNC  X: DATE|isFinal|GA  **DATE = EDD
 ;
 N DATE,FDA,QU,LEN
 S DATE=$$DT^DSIO2($P(X,"|"))
 S DATE=$S($G(CODE)="11779-6":$$FMADD^XLFDT(DATE,-280),1:DATE) Q:DATE=""
 S FDA(19641.01,"?+1,",.01)=DATE                        ; LAST MENSTRAL PERIOD
 S FDA(19641.01,"?+1,",.02)=DFN                         ; PATIENT
 S FDA(19641.01,"?+1,",.03)=DUZ                         ; ENTERED BY
 S FDA(19641.01,"?+1,",.04)=$$NOW^XLFDT                 ; DATE ENTERED
 S:$G(CODE)="8665-2" QU=$$UP^XLFSTR($E($P(X,"|",2),1))
 S:$D(QU) FDA(19641.01,"?+1,",.05)=QU                   ; QUALIFIER
 D UPDATE^DIE(,"FDA","LEN") K FDA Q:'$G(LEN(1))
 S FDA(19641,DFN_",",1.2)=LEN(1)
 D UPDATE^DIE(,"FDA") K FDA
 Q 
 ;
 ; UTILITIES ------------------------------------------------------------------
 ;
OBJ(TYP) ; Get Object of Observation IEN from Observation
 N CT,IEN
 S CT="" F  S CT=$O(^DSIO(19641.12,OIEN,1,"B",CT)) Q:CT=""  D  Q:$G(IEN)
 . Q:CT'[TYP
 . S IEN=+CT
 Q +$G(IEN)
 ;
OBX(DFN,OBJ,DATES,REF,REL,CAT,SYS,CODE) ; Observation Exists
 N RET,OUT
 S DFN=$G(DFN),DATES=$G(DATES),REF=$G(REF),REL=$G(REL)
 S CAT=$G(CAT),SYS=$G(SYS),CODE=$G(CODE)
 D OBG^DSIO10(.RET,,DFN,.OBJ,REF,DATES,DATES,REL,CAT,SYS,CODE)
 S OUT=$S($G(@RET@(0)):1,1:0) K @RET
 Q OUT
