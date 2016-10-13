Routine DSIO15 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO15^INT^64180,40690^Sep 19, 2016@11:18
DSIO15 ;DSS/TFF - DSIO PREGNANCY;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
PREG(RET,IEN,DFN,DATES,TYP,FOF,OBP,FAP,BAB,POST,COM,HRD,AB) ; RPC: DSIO SAVE PREG DETAILS
 ;
 ; CREATE, UPDATE, or DELETE a PREGNANCY HISTORY record
 ;
 ;    DFN = PATIENT IEN
 ;    IEN = If not null then edit unless ###@ then delete
 ;  DATES = EDC^END^EDD
 ;    TYP = C(urrent),H(istorical)
 ;    FOF = IEN, U(nspecified), S(pouse)
 ;    OBP = OB (VARIABLE POINTER)
 ;          NVA.IEN (NON-VA) (19641.1)
 ;           VA.IEN (VA) (200)
 ;    FAP = FACILITY (VARIABLE POINTER)
 ;          NVA.IEN (NON-VA) (19641.1)
 ;           VA.IEN (VA) (4)
 ;    BAB = NUMBER
 ;            IF 1,2,3 THEN THREE BABIES WILL BE ADDED
 ;            IF 1,2@,3 THEN BABY 2 WILL BE DELETED
 ;            *** + is the next number.
 ;   POST = ADDITIONAL DETAILS (CARET DELIMITED STRING)
 ;            1: GESTATIONAL AGE (#W#D or # (in days))
 ;            2: LENGTH OF LABOR (NUMBER (IN HOURS))
 ;            3: TYPE OF DELIVERY (TEXT 1-20 CHARACTERS)
 ;            4: ANESTHESIA (TEXT 1-50 CHARACTERS)
 ;            5: PRETERM DELIVERY (0:NO,1:YES)
 ;            6: OUTCOME
 ;            7: HIGH RISK FLAG (0:FALSE,1:TRUE)
 ;            8: DAYS IN HOSPITAL
 ;    COM = COMMENTS (ARRAY of Text)
 ;    HRD = HIGH RISK DESCRIPTION (ARRAY of Text)
 ;
 ; X-REFS on EDD and STATUS
 ; If EDD>DT then update WV PATIENT - CURRENTLY PREGNANT (#.13) to 'YES'
 ; and EDC (#.14) with the EDD value
 ;
 ; RETURN: IEN^IEN;BABY|...
 ;         OR -1^MESSAGE
 ;
 N EDC,END,EDD,CT,FLD,IENS,IPT,STR S RET=-1
 I $G(IEN)?.N1"@" D DELETE(+IEN) Q
 S DATES=$G(DATES)
 S EDC=$P(DATES,U),END=$P(DATES,U,2),EDD=$P(DATES,U,3)
 ; *** POST PREGNANCY DATA
 F CT=1:1:8 S FLD("3."_CT)=$P($G(POST),U,CT)
 D:'$G(AB) AB^DSIO2("EDC,END,EDD,FOF,OBP,FAP,BAB,FLD")
 S:$G(EDC)'="@" EDC=$$DT^DSIO2($G(EDC))
 S:$G(END)'="@" END=$$DT^DSIO2($G(END))
 S:$G(EDD)'="@" EDD=$$DT^DSIO2($G(EDD))
 S TYP=$$UP^XLFSTR($E($G(TYP))) S:TYP=""!(TYP="C") TYP=$S(EDD>DT:"C",EDD&(EDD<DT):"H",1:"")
 I '$G(IEN) D  Q:$P(RET,U,2)'=""
 . I '$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 . S IENS="+1,",IPT(19641.13,IENS,.01)=$$NOW^XLFDT               ; DATE RECORDED
 . S:TYP="" TYP="C"
 S:$G(IEN) IENS=+IEN_","
 S:EDC'="" IPT(19641.13,IENS,.02)=EDC                            ; EDC
 I $G(DFN),$D(^DPT(DFN)) S IPT(19641.13,IENS,.03)=DFN            ; PATIENT
 S:TYP'="" IPT(19641.13,IENS,.04)=TYP                            ; STATUS
 S:END'="" IPT(19641.13,IENS,.07)=END                            ; END
 I $G(OBP)'="",$$VPG(.OBP,0) S IPT(19641.13,IENS,.08)=OBP        ; OB
 I $G(FAP)'="",$$VPG(.FAP,1) S IPT(19641.13,IENS,.09)=FAP        ; FACILITY
 S IPT(19641.13,IENS,1.1)=DUZ                                    ; UPDATED BY
 S:$G(FLD(3.1))'="" IPT(19641.13,IENS,3.1)=$$G1^DSIO4(FLD(3.1))  ; GESTATIONAL AGE
 S:$G(FLD(3.2))'="" IPT(19641.13,IENS,3.2)=FLD(3.2)              ; LENGTH OF LABOR
 S:$G(FLD(3.3))'="" IPT(19641.13,IENS,3.3)=FLD(3.3)              ; TYPE OF DELIVERY
 S:$G(FLD(3.4))'="" IPT(19641.13,IENS,3.4)=FLD(3.4)              ; ANESTHESIA
 S FLD(3.5)=$E($$UP^XLFSTR(FLD(3.5)),1)
 S FLD(3.5)=$S(FLD(3.5)="Y"!(FLD(3.5)="T"):1,FLD(3.5)="N"!(FLD(3.5)="F"):0,1:"")
 S:$G(FLD(3.5))'="" IPT(19641.13,IENS,3.5)=FLD(3.5)              ; PRETERM DELIVERY
 S:$G(FLD(3.6))'="" IPT(19641.13,IENS,3.6)=FLD(3.6)              ; OUTCOME
 S:$G(FLD(3.7))'="" IPT(19641.13,IENS,3.7)=FLD(3.7)              ; HIGH RISK FLAG
 S:$G(FLD(3.8))'="" IPT(19641.13,IENS,3.8)=FLD(3.8)              ; DAYS IN HOSPITAL
 D UPDATE^DIE(,"IPT",$S($G(IEN):"",1:"IEN")) K IPT
 S (RET,IEN)=$S($G(IEN):+IEN,$G(IEN(1)):IEN(1),1:"") I 'IEN S RET="-1^Failed to Update." Q
 S DFN=$$GET1^DIQ(19641.13,IEN_",",.03,"I")
 I $G(FOF)'="" D
 . S FOF=$$FOF^DSIO9(DFN,FOF)
 . S IPT(19641.13,IEN_",",.05)=FOF                               ; FATHER OF FETUS/BABY
 S:EDD'="" IPT(19641.13,IEN_",",.06)=$S(EDD="@":"@",1:$$EDD(EDD,IEN))  ; EDD
 D:$D(IPT) UPDATE^DIE(,"IPT") K IPT
 ; *** BABIES
 I $G(BAB)'="" D
 . I BAB="+" S RET=IEN_U_$$BAB("+",IEN) Q
 . F CT=1:1:$L(BAB,",") D
 . . I $P(BAB,",",CT) S STR=$G(STR)_$$BAB($P(BAB,",",CT),IEN)_"|"
 . Q:'$D(STR)
 . I $E(STR,$L(STR))="|" S STR=$E(STR,1,($L(STR)-1))
 . S RET=IEN_U_STR
 ; *** COMMENTS
 I $D(COM)>9 K ^TMP($J,"DSIO PREG") D
 . S %X="COM(",%Y="^TMP($J,""DSIO PREG"",1" D %XY^%RCR
 . D WP^DIE(19641.13,IEN_",",4,"K","^TMP($J,""DSIO PREG"")")
 . K ^TMP($J,"DSIO PREG")
 I '$G(AB)&('$D(COM)!($G(COM(+$O(COM(""))))="")) D
 . K ^TMP($J,"DSIO PREG") S ^TMP($J,"DSIO PREG",1)=""
 . D WP^DIE(19641.13,IEN_",",4,"K","^TMP($J,""DSIO PREG"")")
 . K ^TMP($J,"DSIO PREG")
 ; *** HIGH RISK DESCRIPTION
 I $D(HRD)>9 K ^TMP($J,"DSIO PREG") D
 . S %X="HRD(",%Y="^TMP($J,""DSIO PREG"",1" D %XY^%RCR
 . D WP^DIE(19641.13,IEN_",",5,"K","^TMP($J,""DSIO PREG"")")
 . K ^TMP($J,"DSIO PREG")
 I '$G(AB)&('$D(HRD)!($G(HRD(+$O(HRD(""))))="")) D
 . K ^TMP($J,"DSIO PREG") S ^TMP($J,"DSIO PREG",1)=""
 . D WP^DIE(19641.13,IEN_",",5,"K","^TMP($J,""DSIO PREG"")")
 . K ^TMP($J,"DSIO PREG")
 Q
 ;
VPG(VAL,TYP) ; Validate variable pointer for Pregnancy File
 Q:VAL="@" 1
 N LOC,IEN,FLG
 S LOC=$P(VAL,"."),IEN=+$P(VAL,".",2)
 Q:"^NVA^VA^"'[(U_LOC_U) 0
 I 'TYP D  Q:$D(FLG) 0
 . I (LOC="NVA"&('$D(^DSIO(19641.1,IEN))))!(LOC="VA"&('$D(^VA(200,IEN)))) S FLG=1
 . S VAL=IEN_";VA(200,"
 I TYP D  Q:$D(FLG) 0
 . I (LOC="NVA"&('$D(^DSIO(19641.1,IEN))))!(LOC="VA"&('$D(^DIC(4,IEN)))) S FLG=1
 . S VAL=IEN_";DIC(4,"
 I LOC="NVA" S VAL=IEN_";DSIO(19641.1,"
 Q 1
 ;
EDD(DATE,PIEN) ; Create an EDD record and return the IEN
 Q:'$G(PIEN) ""
 N DFN,FLG,IPT,IEN
 S DFN=$$GET1^DIQ(19641.13,PIEN_",",.03,"I") Q:'DFN ""
 S FLG=$O(^DSIO(19641.03,"C",DFN,DATE,"")) Q:FLG FLG
 S IPT(19641.03,"+1,",.01)=DATE            ; ESTIMATED DELIVERY DATE
 S IPT(19641.03,"+1,",.02)=DFN             ; PATIENT
 S IPT(19641.03,"+1,",.03)=DUZ             ; ENTERED BY
 S IPT(19641.03,"+1,",.04)=$$NOW^XLFDT     ; DATE ENTERED
 S IPT(19641.03,"+1,",2.1)=PIEN
 D UPDATE^DIE(,"IPT","IEN")
 Q $G(IEN(1))
 ;
BAB(VAL,PIEN) ; Record baby to pregnancy
 N DIK,DA,X,Y,IPT,IEN,NUM
 I '$D(DFN) N DFN S DFN=$$GET1^DIQ(19641.13,PIEN_",",.03,"I")
 Q:'DFN ""
 S IEN=$O(^DSIO(19641.112,"C",DFN,PIEN,+VAL,""))
 I VAL["@" D  Q ""
 . Q:'IEN
 . S DA=IEN,DIK="^DSIO(19641.112," D ^DIK
 . ; *** Delete from Pregnancy
 . S DA=$O(^DSIO(19641.13,PIEN,2,"B",IEN,""))
 . S DA(1)=PIEN,DIK="^DSIO(19641.13,"_DA(1)_",2," D ^DIK
 S:'IEN IEN="+1"
 S (NUM,IPT(19641.112,IEN_",",.01))=$$NUM    ; NUMBER
 S IPT(19641.112,IEN_",",.02)=DFN            ; PATIENT
 S IPT(19641.112,IEN_",",.03)=PIEN           ; PREGNANCY
 K IEN D UPDATE^DIE(,"IPT","IEN") Q:'$G(IEN(1)) ""
 S IPT(19641.132,"+1,"_PIEN_",",.01)=IEN(1)
 D UPDATE^DIE(,"IPT")
 Q IEN(1)_";"_NUM
 ;
NUM() ; Set Baby Number for new entries
 Q $O(^DSIO(19641.112,"C",DFN,PIEN,""),-1)+1
 ;
PREGG(RET,IEN,DFN,SORT,NCOM) ; RPC: DSIO GET PREG DETAILS
 ;
 ; If IEN = "C" get only the CURRENT pregnancy
 ;
 ; RETURN:
 ;  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
 ;    EDD^END^OB IEN|OB^FACILITY IEN|FACILITY^
 ;    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE^LENGTH OF DELIVERY^
 ;    TYPE OF DELIVERY^ANESTHESIA^PRETERM DELIVERY^BIRTH TYPE^
 ;    IEN;BABY#|IEN;BABY#^OUTCOME^HIGH RISK FLAG(0,1)^DAYS IN HOSPITAL
 ;    
 ;  C^IEN^COMMENT
 ;  H^IEN^COMMENT
 ;
 N RCT,TS,DATE,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO PREG")) K @RET S @RET@(0)="0^Nothing found."
 I $G(IEN) D P1(IEN,1) S:$D(@RET@(1)) @RET@(0)=1 Q
 I $G(IEN)="C" Q:'$G(DFN)  D  Q
 . S IEN=$$PG^DSIO4(DFN) Q:'IEN
 . D P1(IEN,1) S @RET@(0)=1
 Q:'$G(DFN)
 I '$$CHECK^DSIO2($G(DFN)) S @RET@(0)="0^Patient entry not found." Q
 S (RCT,TS)=0,DATE=""
 F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE),-1) Q:DATE=""  D
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN),-1) Q:IEN=""  D
 . . S TS=TS+1 I STRT'="",TS'>STRT Q
 . . S RCT=RCT+1 I END'="",RCT>END Q
 . . D P1(IEN,RCT)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
P1(IEN,ND) ; Continue
 N OUT,CT,FLD,STR,HT
 D GETS^DIQ(19641.13,IEN_",","*","IE","OUT") Q:'$D(OUT)
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S FLD($QS(CT,3),$QS(CT,4))=@CT
 S STR="L^"_IEN_U_$$FMTE^XLFDT(FLD(.01,"I"),"5Z")_U         ; DATE RECORDED
 S STR=STR_$$FMTE^XLFDT(FLD(.02,"I"),"5Z")_U                ; EDC
 S STR=STR_FLD(.03,"I")_"|"_$$NAME^DSIO2(FLD(.03,"E"))_U    ; PATIENT
 S STR=STR_FLD(.04,"E")_U                                   ; STATUS
 S STR=STR_$$NAME^DSIO2(FLD(.05,"I"))_U                     ; FATHER OF FETUS/BABY
 S STR=STR_$$FMTE^XLFDT($$GET1^DIQ(19641.03,FLD(.06,"I")_",",.01,"I"),"5Z")_U    ; EDD
 S STR=STR_$$FMTE^XLFDT(FLD(.07,"I"),"5Z")_U                ; END
 S STR=STR_$S(FLD(.08,"I"):+FLD(.08,"I"),1:"")_"|"_$$NAME^DSIO2(FLD(.08,"E"))_U  ; OB
 S STR=STR_$S(FLD(.09,"I"):+FLD(.09,"I"),1:"")_"|"_$$NAME^DSIO2(FLD(.09,"E"))_U  ; FACILITY
 S STR=STR_FLD(1.1,"I")_"|"_$$NAME^DSIO2(FLD(1.1,"E"))_U    ; UPDATED BY
 S STR=STR_FLD(3.1,"I")_U                                   ; GESTATIONAL AGE
 S STR=STR_FLD(3.2,"I")_U                                   ; LENGTH OF LABOR
 S STR=STR_FLD(3.3,"I")_U                                   ; TYPE OF DELIVERY
 S STR=STR_FLD(3.4,"I")_U                                   ; ANESTHESIA
 S STR=STR_FLD(3.5,"E")_U                                   ; PRETERM DELIVERY
 S STR=STR_FLD(999.1,"E")_U                                 ; BIRTH TYPE (C)
 S STR=STR_$$FETUS(IEN)_U                                   ; BABIES
 S STR=STR_$$OT^DSIO03(FLD(3.6,"I"))_U                      ; OUTCOME
 S STR=STR_+FLD(3.7,"I")_U                                  ; HIGH RISK FLAG
 S STR=STR_+FLD(3.8,"I")                                    ; DAYS IN HOSPITAL
 S @RET@(ND)=STR Q:$D(NCOM)
 ; *** COMMENTS
 S CT=0 F  S CT=$O(FLD(4,CT)) Q:'CT  S @RET@(ND,CT)="C^"_IEN_U_FLD(4,CT)
 ; *** HIGH RISK DESCRIPTION
 S CT=$O(@RET@(ND,""),-1)
 S HT=0 F  S HT=$O(FLD(5,HT)) Q:'HT  S @RET@(ND,(CT+HT))="H^"_IEN_U_FLD(5,HT)
 Q
 ;
FETUS(IEN) ; Return Baby String as IEN;Number|...
 N OUT,CT,STR
 D GETS^DIQ(19641.13,IEN_",","2*","IE","OUT") Q:'$D(OUT) ""
 S CT="" F  S CT=$O(OUT(19641.132,CT)) Q:CT=""  D
 . S STR=$G(STR)_OUT(19641.132,CT,.01,"I")_";"_OUT(19641.132,CT,.01,"E")_"|"
 I $E(STR,$L(STR))="|" S STR=$E(STR,1,($L(STR)-1))
 Q $G(STR)
 ;
 ;
HPG(RET,RSTRT,RSTOP,SORT) ; RPC: DSIO GET PREG HISTORY RANGE
 ;
 ; Get all historical pregnancies (for all patients) where the End Date falls within a specific range
 ; File 19641.13, Index S - PREGNANCY END  (19641.13,.07)
 ;
 N RCT,TS,DATE,IEN,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO HPG")) K @RET S @RET@(0)="0^Nothing found."
 S RSTRT=$$DT^DSIO2($G(RSTRT)),RSTOP=$$DT^DSIO2($G(RSTOP)) Q:RSTRT=""!(RSTOP="")
 S (RCT,TS)=0,DATE=RSTRT
 F  S DATE=$O(^DSIO(19641.13,"S",DATE)) Q:DATE=""  Q:DATE>=RSTOP  D
 . S IEN=0 F  S IEN=$O(^DSIO(19641.13,"S",DATE,IEN)) Q:'IEN  D
 . . S TS=TS+1 I STRT'="",TS'>STRT Q
 . . S RCT=RCT+1 I END'="",RCT>END Q
 . . S @RET@(RCT)=$$HPG1(IEN)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
HPG1(IEN) ; Continue
 N OUT,STR
 D PREGG^DSIO15(.OUT,IEN,,,1) S STR=$G(@OUT@(1)) K @OUT
 Q STR
 ;
DELETE(IEN) ; Delete Pregnancy
 N DIK,DA,X,Y,CT Q:'$G(IEN)
 ; *** DELETE BABIES
 I $D(^DSIO(19641.13,IEN,2)) D
 . S DIK="^DSIO(19641.112,"
 . S DA=0 F  S DA=$O(^DSIO(19641.13,IEN,2,"B",DA)) Q:'DA  D ^DIK
 ; *** DSIO EDD HISTORY
 ;     DSIO OBSERVATIONS
 S CT=0 F  S CT=$O(^DSIO(19641.03,"P",IEN,CT)) Q:'CT  D
 . S DIK="^DSIO(19641.12,",DA=$$GET1^DIQ(19641.03,CT_",",2.2,"I") D:DA ^DIK
 . S DIK="^DSIO(19641.03,",DA=CT D ^DIK
 ; *** DSIO OBSERVATIONS
 S DIK="^DSIO(19641.12,"
 S DA=0 F  S DA=$O(^DSIO(19641.12,"OBJ",IEN_";DSIO(19641.13,",DA)) Q:'DA  D ^DIK
 ; *** DSIO MCC PATIENT CHECKLIST
 S CT=$NA(^DSIO(19641.76,"C",IEN)) F  S CT=$Q(@CT) Q:CT=""  Q:$QS(CT,3)'=IEN  D
 . S DA(1)=$QS(CT,4),DA=$QS(CT,5),DIK="^DSIO(19641.76,"_DA(1)_",1," D ^DIK
 ; *** DSIO PREGNANCY-NOTE
 S CT=$NA(^DSIO(19641.83,"P",IEN)) F  S CT=$Q(@CT) Q:CT=""  Q:$QS(CT,3)'=IEN  D
 . S DA(1)=$QS(CT,4),DA=$QS(CT,5),DIK="^DSIO(19641.83,"_DA(1)_",1," D ^DIK
 ; *** DELETE the PREGNANCY
 S DIK="^DSIO(19641.13,",DA=+IEN D ^DIK S:'$D(^DSIO(19641.13,+IEN)) RET=1
 Q
 ;
OPTION ; OPTION: DSIO DELETE PREGNANCY
 N DIR,DA,X,Y,DIRUT,IEN
 S DIR("A")="Select PREGNANCY HISTORY to DELETE"
 S DIR(0)="PO^19641.13:AEQ" D ^DIR Q:$D(DIRUT)!(Y<1)  S IEN=+Y
 W !!,$$CJ^XLFSTR("****** ARE YOU SURE? THIS CANNOT BE UNDONE! ******",80),!!
 S DIR("A")="I am sure that I want to DELETE this PREGNANCY HISTORY record"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR Q:$D(DIRUT)!(Y<1)
 D DELETE(IEN)
 Q
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
