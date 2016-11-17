Routine DSIO1 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO1^INT^64156,59918^Aug 26, 2016@16:38
DSIO1 ;DSS/TFF - DSIO GENERAL RPCS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$DOB^DPTLK1
 ; $$SCREEN^DPTLK1
 ; $$SSN^DPTLK1
 ;
 Q
 ;
 ; ------------------------------ PATIENT SEARCH ------------------------------
 ;
PATIENT(RET,KEY,SORT) ; RPC: DSIO PATIENT LIST
 ;
 ;  KEY  SSN: SSN
 ;        BS: LAST 4
 ;       BS5: FIRST LETTER OF LAST NAME + LAST 4 OF SSN
 ;         B: PARTIAL NAME - TO - FULL NAME
 ; SORT     : PAGE#,CT
 ;
 ; RETURN FORMAT:
 ;  DFN^LASTNAME,FIRSTNAME^SSN(LAST 4)^DATE OF BIRTH^VETERAN STATUS^
 ;  LOCATION(WARD)^ROOM/BED^SERVICE CONNECTED^CURRENTLY TRACKING^
 ;  SSN^CITY^STATE^ZIP^SENSITIVE STATUS (1,0)
 ;
 ;  CURRENTLY TRACKING: 0:NO,1:YES,2:FLAG
 ; IF NOTHING IS FOUND: RET(0)="0^Patient(s) not found."
 ;
 S RET=$NA(^TMP($J,"DSIO PATIENT")) K @RET S @RET@(0)="0^Patient(s) not found."
 S KEY=$G(KEY) D PAR^DSIO2
 ; *** LIST BY FULL SSN
 I KEY?9N!(KEY?3N1"-"2N1"-"4N) D LIST($TR(KEY,"-",""),"SSN") Q
 ; *** LIST BY LAST 4
 I KEY?4N D LIST(KEY,"BS") Q
 ; *** LIST BY FIRST LETTER OF LAST NAME + LAST 4 OF SSN
 I KEY?1A4N D LIST(KEY,"BS5") Q
 ; *** ALL PATIENTS, ASSUME NAME OR PARTIAL NAME
 D LIST(KEY,"B")
 Q
 ;
LIST(KEY,IX) ; Get Patient List
 N RCT,TS,KCT,CT,DFN,STRT,END D S^DSIO2($G(SORT))
 S (RCT,TS)=0
 S (KCT,CT)=$E(KEY,1,($L(KEY)-1))_$$M^DSIO2($E(KEY,$L(KEY)))
 F  S CT=$O(^DPT(IX,CT)) Q:CT=""  Q:$L(KCT)>1&($$KEY^DSIO2(CT,KEY))  D
 . Q:$$KEY^DSIO2(CT,KEY)
 . S DFN=0 F  S DFN=$O(^DPT(IX,CT,DFN)) Q:'DFN  D
 . . Q:$$GET1^DIQ(2,DFN_",",.02,"I")'="F"
 . . S TS=TS+1 I STRT'="",TS'>STRT Q
 . . S RCT=RCT+1 I END'="",RCT>END Q
 . . S @RET@(RCT)=$$FLDS(DFN)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
FLDS(DFN) ; Return Transformed Fields
 ;
 ; DFN^LASTNAME,FIRSTNAME^SSN(LAST 4)^DATE OF BIRTH^VETERAN STATUS^
 ; LOCATION(WARD)^ROOM/BED^SERVICE CONNECTED^CURRENTLY TRACKING^
 ; SSN^CITY^STATE^ZIP^SENSITIVE STATUS(1,0)
 ;
 N OUT,LINE,FLD,SSN,STR
 D GETS^DIQ(2,DFN_",",".01;1901;.1;.101;.301;.09;.114;.115;.116","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S SSN=$$SSN^DPTLK1(DFN)
 S STR=DFN_U
 S STR=STR_$$NAME^DSIO2(FLD(.01,"E"))_U                ; NAME
 S STR=STR_$S(SSN?.N:$E(SSN,6,9),1:SSN)_U              ; LAST FOUR
 S STR=STR_$$FMTE^XLFDT($$DT^DSIO2($$DOB^DPTLK1(DFN,0)),"5Z")_U   ; DATE OF BIRTH
 S STR=STR_FLD(1901,"E")_U                             ; VETERAN STATUS
 S STR=STR_FLD(.1,"I")_U                               ; WARD LOCATOIN
 S STR=STR_FLD(.101,"I")_U                             ; ROOM-BED
 S STR=STR_FLD(.301,"E")_U                             ; SERVICE CONNECTED?
 S STR=STR_$$TRACK^DSIO4(DFN,1)_U                      ; TRACKING STATUS
 S STR=STR_FLD(.09,"I")_U                              ; SOCIAL SECURITY NUMBER
 S STR=STR_FLD(.114,"I")_U                             ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(.115,"I")_",",1)_U         ; STATE
 S STR=STR_FLD(.116,"I")_U                             ; ZIP CODE
 S STR=STR_$$SCREEN^DPTLK1(DFN)                        ; SENSITIVE STATUS
 Q STR
 ;
 ; ------------------------------ PATIENT FIELDS ------------------------------
 ;
INFO(RET,DFN) ; RPC: DSIO GET PATIENT INFORMATION
 ;
 ; RETURN:
 ;   FIELD NUMBER^VALUE (*** HIGH RISK = Field#^(TRUE,FALSE)^COMMENTS)
 ;   0^MESSAGE
 ;
 N OUT,LINE
 I '$$CHECK^DSIO2($G(DFN)) S RET(0)="0^Patient entry not found." Q
 D GETS^DIQ(19641,DFN_",",".01:999999","E","OUT")
 I '$D(OUT) S RET(0)="0^Nothing found." Q
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  D
 . S RET($QS(LINE,3))=$QS(LINE,3)_U_@LINE
 S RET(3)="3^"_$$FMTE^XLFDT($P($G(^DSIO(19641,DFN,3,+$$LACE^DSIO4(DFN),0)),U),"5ZS")
 I $P($G(RET(999.15)),U,2)="TRUE" S $P(RET(999.15),U,3)=$$HR^DSIO4($$PG^DSIO4(DFN))
 Q
 ;
PATSET(RET,DFN,FLD,VAL) ; RPC: DSIO SET PATIENT INFORMATION
 S RET=0 I '$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 N TRVAL,OUT,IPT,ERR
 I $G(FLD)=.01 S RET="-1^You cannot change the PATIENT NAME." Q
 I '$$VFIELD^DILFD(19641,$G(FLD)) S RET="-1^Not a valid field." Q
 I $G(FLD)=999.22 D EMAIL Q
 I $$GET1^DID(19641,FLD,,"TYPE")="COMPUTED" S RET="-1^You cannot set a computed field." Q
 I "^.04^1.2^"[(U_FLD_U) S RET="-1^This field cannot be set directly." Q
 S TRVAL=$S($$GET1^DID(19641,FLD,,"TYPE")="DATE/TIME":$$DT^DSIO2($G(VAL)),1:$G(VAL))
 D VAL^DIE(19641,DFN,FLD,,TRVAL,.OUT) I TRVAL'=OUT S RET="-1^The value is not valid." Q
 S IPT(19641,DFN_",",FLD)=TRVAL
 D FILE^DIE("E","IPT","ERR") I '$D(ERR) S RET=1
 Q
 ;
EMAIL ; Update the patient's email address
 I $G(VAL)="" S RET="-1^Cannot leave the patient's email address blank." Q
 D VAL^DIE(2,DFN,.133,,VAL,.OUT) I VAL'=OUT S RET="-1^The value is not valid." Q
 S IPT(2,DFN_",",.133)=VAL
 D FILE^DIE("E","IPT","ERR") I '$D(ERR) S RET=1
 Q
 ;
 ; ----------------------------- PATIENT TRACKING -----------------------------
 ;
TRCLIST(RET,TYP,SORT) ; RPC: DSIO GET TRACKING
 ;
 ; RETURN MATERNITY TRACKING LISTS
 ;
 ;   TYP "": ALL LOGS
 ;        T: ALL CURRENTLY TRACKED PATIENTS
 ;        F: ALL CURRENTLY FLAGGED PATIENTS
 ;      DFN: ALL LOGS FOR A PATIENT
 ;       F#: ALL CURRENTLY FLAGGED LOGS FOR A PATIENT
 ;  SORT   : PAGE#,CT
 ;
 S RET=$NA(^TMP($J,"DSIO TRCLIST")) K @RET S @RET@(0)="0^No entries found."
 D PAR^DSIO2 S TYP=$G(TYP)
 ;
 ; *** GET ALL CURRENTLY TRACKED PATIENTS
 ;     P^DFN^LASTNAME,FIRSTNAME^LAST 4^DOB^PHONE^EDD^OB^PLANNED DELV LOC^
 ;     CURRENTLY PREGNANT^CURRENTLY LACATING^LAST CONTACT DATE^
 ;     NEXT CONTACT DATE^NEXT CHECKLIST DATE^HIGH RISK FLAG^HIGH RISK DETAILS^T4BSTAT
 ;     ^DSIO(19641.2,"TRACKING",PATIENT NAME,DFN,DA)=""
 I TYP="T" D T1("TRACKING",4) Q
 ;
 ; *** GET ALL CURRENTLY FLAGGED PATIENTS
 ;     P^DFN^LASTNAME,FIRSTNAME^LAST 4^DOB^PHONE^REASON
 ;     ^DSIO(19641.2,"FLAGGED",PATIENT NAME,DFN,DA)=""
 I TYP="F" D T1("FLAGGED",5) Q
 ;
 ; *** GET ALL LOGS FOR A PATIENT
 ;     L^IEN^TRACKING DT(E)^DFN^LASTNAME,FIRSTNAME^USER^ACTION^SOURCE^REASON|REASON
 ;     C^IEN^COMMENT
 ;     ^DSIO(19641.2,DFN,1,"B",LOG DATE,DA)=""
 I TYP D T1("B",2,+TYP) Q
 ;
 ; *** GET CURRENTLY FLAGGED ENTRIES FOR A PATIENT
 ;     ^DSIO(19641.2,DFN,1,"FLAG",LOG DATE,DA)
 I TYP?1"F".N D T1("FLAG",3,$E(TYP,2,$L(TYP))) Q
 ;
 ; *** GET ALL LOGS
 ;     ^DSIO(19641.2,"C",LOG DATE,DFN,DA)=""
 I TYP="" D T1("C",1)
 Q
 ;
T1(IX,FLG,KEY) ; Get Tracking List
 N RCT,TS,NAME,DATE,DFN,IEN,STRT,END D S^DSIO2($G(SORT))
 S (RCT,TS)=0
 I FLG=1 D
 . ; IX: C                   ^DSIO(19641.2,"C",DATE,DFN,DA)=""
 . S DATE="" F  S DATE=$O(^DSIO(19641.2,"C",DATE),-1) Q:DATE=""  D
 . . S DFN=0 F  S DFN=$O(^DSIO(19641.2,"C",DATE,DFN)) Q:'DFN  D
 . . . S IEN="" F  S IEN=$O(^DSIO(19641.2,"C",DATE,DFN,IEN),-1) Q:IEN=""  D T2
 I FLG=2!(FLG=3) S DFN=$$M^DSIO2(KEY) D
 . ; IX: B, FLAG             ^DSIO(19641.2,DFN,1,IX,DATE,DA)=""
 . F  S DFN=$O(^DSIO(19641.2,DFN)) Q:DFN'=KEY  D
 . . S DATE="" F  S DATE=$O(^DSIO(19641.2,DFN,1,IX,DATE),-1) Q:DATE=""  D
 . . . S IEN="" F  S IEN=$O(^DSIO(19641.2,DFN,1,IX,DATE,IEN),-1) Q:IEN=""  D T2
 I FLG=4!(FLG=5) D
 . ; IX: TRACKING, FLAGGED   ^DSIO(19641.2,IX,PATIENT-NAME,DFN,DA)=""
 . S NAME="" F  S NAME=$O(^DSIO(19641.2,IX,NAME)) Q:NAME=""  D
 . . S DFN=0 F  S DFN=$O(^DSIO(19641.2,IX,NAME,DFN)) Q:'DFN  D
 . . . S IEN="" F  S IEN=$O(^DSIO(19641.2,IX,NAME,DFN,IEN),-1) Q:IEN=""  D T2
 S:$G(TS) @RET@(0)=TS
 Q
 ;
T2 ; Continue
 S TS=TS+1 I STRT'="",TS'>STRT Q
 S RCT=RCT+1 I END'="",RCT>END Q
 D TGET(FLG)
 Q
 ;
TGET(F) ; Return Unique String of Data
 N OUT,LINE,FLD
 D GETS^DIQ(19641.24,IEN_","_DFN_",",".01;.02;.03;.04","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 ;
 ; L^IEN^TRACKING DT(E)^DFN^LASTNAME,FIRSTNAME^USER^ACTION^SOURCE^REASON|REASON
 ; C^IEN^COMMENT
 I F=1 D TG0    ; ALL
 I F=2 D TG0    ; ALL LOGS FOR A PATIENT
 I F=3 D TG0    ; ALL FLAGGED LOGS FOR A PATIENT
 ;
 ; P^DFN^LASTNAME,FIRSTNAME^LAST 4^DOB^PHONE^EDD^OB^PLANNED DELV LOC^
 ; CURRENTLY PREGNANT^CURRENTLY LACATING^LAST CONTACT DATE^
 ; NEXT CONTACT DATE^NEXT CHECKLIST DATE^HIGH RISK FLAG^HIGH RISK DETAILS^T4BSTAT
 I F=4 D TG4    ; TRACKING
 ;
 ; P^DFN^LASTNAME,FIRSTNAME^LAST 4^DOB^PHONE^REASON
 I F=5 D TG5    ; FLAGGED
 Q
 ;
TG0 ; 1,2,3
 N STR
 S STR="L^"_IEN_U
 S STR=STR_$$FMTE^XLFDT(FLD(.01,"I"),"5ZS")_U          ; TRACKING DATE
 S STR=STR_DFN_U                                       ; DFN
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN,.01))_U       ; PATIENT
 S STR=STR_$$NAME^DSIO2(FLD(.03,"E"))_U                ; USER
 S STR=STR_FLD(.02,"I")_U                              ; ACTION
 S STR=STR_FLD(.04,"I")_U                              ; SOURCE
 S STR=STR_$$RES                                       ; REASON
 S @RET@(RCT,0)=STR D COM                              ; COMMENTS
 Q
TG4 ; 4
 N SSN,DOB,PHONE,EDD,OB,LOC,PREG,LAC,STR
 D TGV
 S STR="P^"_DFN_U
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN,.01))_U       ; PATIENT
 S STR=STR_SSN_U                                       ; LAST FOUR
 S STR=STR_DOB_U                                       ; BIRTH DATE
 S STR=STR_PHONE_U                                     ; PHONE
 S STR=STR_EDD_U                                       ; ESTIMATED DATE OF DELIVERY
 S STR=STR_OB_U                                        ; OB
 S STR=STR_LOC_U                                       ; PLANNED DELIVERY LOCATION
 S STR=STR_PREG_U                                      ; CURRENTLY PREGNANT
 S STR=STR_LAC_U                                       ; CURRENTLY LACTATING
 S STR=STR_$$FMTE^XLFDT($$GET1^DIQ(19641,DFN_",",.05,"I"),"5ZS")_U    ; LAST CONTACT DATE
 S STR=STR_$$FMTE^XLFDT($$GET1^DIQ(19641,DFN_",",.03,"I"),"5ZS")_U    ; NEXT CONTACT DATE
 S STR=STR_$$FMTE^XLFDT($$GET1^DIQ(19641,DFN_",",.06,"I"),"5ZS")_U    ; NEXT CHECKLIST DATE
 S STR=STR_$$GET1^DIQ(19641,DFN_",",999.15)_U          ; HIGH RISK FLAG
 S STR=STR_$$HR^DSIO4($$PG^DSIO4(DFN))_U               ; HIGH RISK DESCRIPTION
 S STR=STR_$$GET1^DIQ(19641,DFN_",",4.1)               ; T4BSTAT
 S @RET@(RCT)=STR
 Q
TG5 ; 5
 N SSN,DOB,PHONE,EDD,OB,LOC,PREG,LAC,STR
 D TGV
 S STR="P^"_DFN_U
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN,.01))_U       ; PATIENT
 S STR=STR_SSN_U                                       ; LAST FOUR
 S STR=STR_DOB_U                                       ; BIRTH DATE
 S STR=STR_PHONE_U                                     ; PHONE
 S STR=STR_$$RES                                       ; REASON
 S @RET@(RCT)=STR
 Q
 ;
TGV ; Get Common Variables
 S SSN=$$SSN^DPTLK1(DFN) I SSN?.N S SSN=$E(SSN,6,9)
 S DOB=$$FMTE^XLFDT($$DT^DSIO2($$DOB^DPTLK1(DFN,0)),"5Z")
 S PHONE=$$GET1^DIQ(2,DFN,.131)
 S EDD=$$FMTE^XLFDT($$GET1^DIQ(19641.03,$$GET1^DIQ(19641.13,$$PG^DSIO4(DFN)_",",.06,"I")_",",.01,"I"),"5Z")
 S OB=$$TITLE^XLFSTR($$GET1^DIQ(19641.13,$$PG^DSIO4(DFN)_",",.08))
 S LOC=$$TITLE^XLFSTR($$GET1^DIQ(19641.13,$$PG^DSIO4(DFN)_",",.09))
 S PREG=$$PSTAT^DSIO4(DFN),LAC=$$LACT^DSIO4(DFN)
 Q
 ;
RES() ; Reason Multiple
 N RES,R,STR
 D GETS^DIQ(19641.24,IEN_","_DFN_",","1*","I","RES")
 S R=$NA(RES) F  S R=$Q(@R) Q:R=""  D
 . S STR=$G(STR)_$$TITLE^XLFSTR(@R)_"|"
 Q $E($G(STR),1,($L($G(STR))-1))
 ;
COM ; Comment Multiple
 N COM,C,CT
 D GETS^DIQ(19641.24,IEN_","_DFN_",",2,,"COM")
 S CT=1,C=$NA(COM) F  S C=$Q(@C) Q:C=""  D
 . Q:$QL(C)<4
 . S @RET@(RCT,CT)="C^"_IEN_U_@C,CT=CT+1
 Q
 ;
REC(RET,DFN,ACT,RES,COM,SOR) ; RPC: DSIO CREATE TRACKING LOG
 ;
 ; MCC DASHBOARD PURPOSE -  TO CHANGE THE TRACKING STATUS OF A PATIENT
 ;
 ;  INPUT PARAMETER:
 ;         DFN : PATIENT NUMBER
 ;         ACT : ACTION 
 ;                0: STOP
 ;                1: START
 ;                2: FLAG
 ;                3: REJECT
 ;                4: ACCEPT
 ;         RES : REASON  - #^#^#
 ;         COM : COMMENT - ARRAY
 ;         SOR : SOURCE  - DEFAULT IS DASHBOARD
 ;
 ; RETURN: -1^ERROR OR IEN
 ;
 N DSIOSILENT,DIC,DA,X,Y,DLAYGO,IPT,IEN,I,%X,%Y
 S DSIOSILENT=1,RET=-1
 I '$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 S DLAYGO=19641.2,DIC="^DSIO(19641.2,",DIC(0)="XL",X="`"_DFN
 D ^DIC I +Y<1 S RET="-1^Failed to create log." Q
 ; *** TRACKING STATUS/EVENT
 S ACT=$E($G(ACT),1) S ACT=$S(ACT?1N:ACT,1:"")
 I ACT="" S RET="-1^EVENT TYPE could not be identified." Q
 I ACT<0!(ACT>4) S RET="-1^EVENT TYPE reference number is invalid." Q
 I $$TRACK^DSIO4(DFN,1)=1,ACT'=0 S RET="-1^EVENT TYPE can only be to STOP an already TRACKED patient." Q
 S SOR=$$UP^XLFSTR($G(SOR,"DASHBOARD"))
 S IPT(19641.22,"?+1,",.01)=SOR
 S:SOR="DASHBOARD"!(SOR="FILEMAN") IPT(19641.22,"?+1,",.02)=1
 S DLAYGO=19641.22 D UPDATE^DIE(,"IPT") K IPT
 S IPT(19641.24,"+1,"_DFN_",",.01)=$$NOW^XLFDT
 S IPT(19641.24,"+1,"_DFN_",",.02)=ACT
 S IPT(19641.24,"+1,"_DFN_",",.03)=DUZ
 S IPT(19641.24,"+1,"_DFN_",",.04)=SOR
 S DLAYGO=19641.24 D UPDATE^DIE(,"IPT","IEN") K IPT
 I '$G(IEN(1)) S RET="-1^Failed to create log." Q
 ; *** UPDATE THE DSIO PATIENT FILE
 S IPT(19641,DFN_",",.02)=$S(ACT=3:0,ACT=4:1,1:ACT)
 D FILE^DIE(,"IPT") K IPT
 ; *** BUILD THE REASON MULTIPLE
 S RES=$G(RES) F I=1:1:$L(RES,U) D
 . S IPT(19641.241,"?+1,"_IEN(1)_","_DFN_",",.01)=$P(RES,U,I)
 . D UPDATE^DIE(,"IPT") K IPT
 ; *** SET THE COMMENT WORD PROCESSING FIELD
 ;     WE CAN'T PROCESS THE ZERO NODE WITH WP^DIE SO INSTEAD OF MERGING
 ;     WE CAN USE %XY^%RCR TO CONCATENATE A SUBSCRIPT
 I $D(COM)>9 K ^TMP($J,"DSIO REC") D
 . S %X="COM(",%Y="^TMP($J,""DSIO REC"",1" D %XY^%RCR
 . D WP^DIE(19641.24,IEN(1)_","_DFN_",",2,"K","^TMP($J,""DSIO REC"")")
 . K ^TMP($J,"DSIO REC")
 S RET=$S(SOR="DASHBOARD":1,1:IEN(1))
 Q
 ;
 ; -------------------------------- SELECTION ---------------------------------
 ;
SELECT(RET,TYP) ; RPC: DSIO SELECT LIST
 ;
 ; RETURN DROP DOWN LIST
 ;
 ;  TYP : 'S' FOR FILE 19641.22
 ;  TYP : 'R' FOR FILE 19641.23
 ;
 ;  LETTER^ENTRY^A : ADD AN ENTRY TO ONE OF THE ABOVE FILES
 ;  LETTER^ENTRY^D : DELETE AN ENTRY FROM ONE OF THE ABOVE FILES
 ;
 ;  RETURN LIST FOR SUCCESS OR RET(0)="-1^MESSAGE" FOR FAILURE
 ;
 N FILE,FLD,DIK,DA,X,Y,IPT,I,CT
 S RET(0)="0^No entries found.",TYP=$$UP^XLFSTR($G(TYP)) Q:TYP=""
 S FILE=$S($P(TYP,U)="S":19641.22,$P(TYP,U)="R":19641.23,1:"") Q:FILE=""
 S FLD=$S(FILE=19641.22:"@;.01;.02I",1:"@;.01")
 I $P(TYP,U,3)="D" D
 . S DIK="^DSIO("_FILE_","
 . S DA=$$FIND1^DIC(FILE,,"X",$$UP^XLFSTR($P(TYP,U,2))) D:DA ^DIK
 I $P(TYP,U,3)="A" D
 . S IPT(FILE,"?+1,",.01)=$$UP^XLFSTR($P(TYP,U,2))
 . D UPDATE^DIE(,"IPT")
 S I=0,CT="" F  S CT=$O(^DSIO(FILE,"B",CT)) Q:CT=""  D
 . Q:$$GET1^DIQ(FILE,$O(^DSIO(FILE,"B",CT,""))_",",.02,"I")
 . S RET(I)=$$TITLE^XLFSTR(CT),I=I+1
 Q
 ;
 ; ----------------------------- EXTERNAL ENTITY ------------------------------
 ;
SENT(RET,IEN,NAME,TYP,ACT,PCON,ADDR,PHONE,AB) ; RPC: DSIO SAVE EXTERNAL ENTITY
 ;
 ;  ADDR = ARRAY OF LABELS: 1,2,3,CITY,STATE,ZIP
 ; PHONE = ARRAY OF LABLES: H,MC,WP,FAX
 ;
 ; RETURN: IEN OR -1^MESSAGE
 ;
 D:'$G(AB) AB^DSIO2("NAME,TYP,ACT,PCON,ADDR,PHONE")
 N IPT,CT,LOC,VAL,ZFLG,DIK,DA,X,Y,PFLG,FLG
 S RET=-1,IEN=$S($G(IEN):IEN,1:"?+1")
 S NAME=$$UP^XLFSTR($G(NAME))
 I IEN,NAME'="",NAME'="@" D  Q:$P(RET,U,2)'=""
 . Q:'$D(^DSIO(19641.1,"B",NAME))
 . Q:$O(^DSIO(19641.1,"B",NAME,""))=IEN
 . S RET="-1^Duplicate name not allowed."
 I IEN,NAME="@" D  Q
 . S DA=IEN,DIK="^DSIO(19641.1," D ^DIK I '$D(^DSIO(19641.1,IEN)) S RET=0
 S:NAME'=""&(NAME'="@") IPT(19641.1,IEN_",",.01)=NAME         ; NAME
 S:$G(TYP)'=""&($G(TYP)'="@") IPT(19641.1,IEN_",",.02)=TYP    ; TYPE
 S:$G(ACT)'="" IPT(19641.1,IEN_",",.03)=ACT                   ; INACTIVE
 S:$G(PCON)'="" IPT(19641.1,IEN_",",.04)=PCON                 ; PRIMARY CONTACT
 I $D(ADDR) D                                           ; ADDRESS
 . S CT=$NA(ADDR) F  S CT=$Q(@CT) Q:CT=""  D
 . . S LOC=$$UP^XLFSTR($P(@CT,U)),VAL=$P(@CT,U,2)
 . . I LOC[1 S IPT(19641.1,IEN_",",1.1)=VAL Q                 ; STREET ADDRESS 1
 . . I LOC[2 S IPT(19641.1,IEN_",",1.2)=VAL Q                 ; STREET ADDRESS 2
 . . I LOC[3 S IPT(19641.1,IEN_",",1.3)=VAL Q                 ; STREET ADDRESS 3
 . . I LOC="CITY" S IPT(19641.1,IEN_",",1.4)=VAL Q            ; CITY
 . . I LOC="STATE",$$FIND1^DIC(5,,"XM",VAL) D
 . . . S IPT(19641.1,IEN_",",1.5)=$$FIND1^DIC(5,,"XM",VAL) Q  ; STATE
 . . I LOC="ZIP" S ZFLG=0 D                                   ; ZIP CODE
 . . . S VAL=$TR(VAL,"-") Q:VAL'?.N
 . . . S ZFLG=1,IPT(19641.1,IEN_",",1.6)=VAL
 D UPDATE^DIE(,"IPT",$S($G(IEN):"",1:"IEN")) K IPT
 S (RET,IEN)=$S($G(IEN):+IEN,$G(IEN(1)):IEN(1),1:"") I 'IEN S RET="-1^Failed to Update." Q
 I $D(PHONE) D                                          ; PHONE
 . S CT=$NA(PHONE) F  S CT=$Q(@CT) Q:CT=""  D
 . . S LOC=$$UP^XLFSTR($P(@CT,U)) Q:"^H^MC^WP^FAX^O^"'[(U_LOC_U)
 . . S PFLG=0
 . . S VAL=$TR($P(@CT,U,2),"()- ") Q:VAL=""!(VAL'?.N)
 . . S IPT(19641.15,"?+1,"_IEN_",",.01)=LOC                   ; PHONE TYPE
 . . S IPT(19641.15,"?+1,"_IEN_",",.02)=VAL                   ; NUMBER
 . . S PFLG=1 D UPDATE^DIE(,"IPT") K IPT
 I $D(PFLG),'PFLG S FLG=1
 I $D(ZFLG),'ZFLG S FLG=$G(FLG)_2
 Q:'$D(FLG)
 S RET=RET_"^Record saved but "_$S(FLG=1:"phone number(s)",FLG=2:"ZIP code",1:"phone number(s) and ZIP code")_" not updated."
 Q
 ;
RENT(RET,TYP,SORT) ; RPC: DSIO GET EXTERNAL ENTITY
 ;
 ; TYP - F        (FACILITIES)
 ;       P        (PROVIDERS)
 ;       NULL     (ALL ENTITIES)
 ;       IEN/NAME (SINGLE ENTITY)
 ;
 ; IEN^NAME^TYPE^INACTIVE^PRIMARY PROVIDER NAME^STREET ADDRESS 1
 ; ^STREET ADDRESS 2^STREET ADDRESS 3^CITY^STATE^ZIP CODE
 ; ^PHONE NUMBER (HOME)^PHONE NUMBER (OFFICE)^PHONE NUMBER (CELL)^FAX NUMBER
 ;
 S RET=$NA(^TMP($J,"DSIO RENT")) K @RET S @RET@(0)="0^No entries found."
 S TYP=$$UP^XLFSTR($G(TYP))
 ; *** SINGLE (IEN)
 I TYP,$D(^DSIO(19641.1,TYP)) D R1("B",TYP) Q
 ; *** FACILITIES/PROVIDERS
 I "^F^P^"[(U_TYP_U) D R1(TYP) Q
 ; *** SINGLE (NAME)
 I TYP'="",$D(^DSIO(19641.1,"B",TYP)) D R1("B",$O(^DSIO(19641.1,"B",TYP,""))) Q
 ; *** ALL
 I TYP="" D R1("B")
 Q
 ;
R1(IX,KEY) ; Get Entity List
 N RCT,TS,CT,IEN,STRT,END D S^DSIO2($G(SORT))
 S KEY=$$GET1^DIQ(19641.1,$G(KEY)_",",.01)
 S (RCT,TS)=0,CT=$E(KEY,1,($L(KEY)-1))_$$M^DSIO2($E(KEY,$L(KEY)))
 F  S CT=$O(^DSIO(19641.1,IX,CT)) Q:CT=""  Q:$$KEY^DSIO2(CT,KEY)  D
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S IEN=$O(^DSIO(19641.1,IX,CT,""))
 . S @RET@(RCT)=$$RFLDS(IEN)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
RFLDS(IEN) ; Return Transformed Fields
 N OUT,LINE,FLD,STR
 D GETS^DIQ(19641.1,IEN_",","*","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=IEN_U
 S STR=STR_$$NAME^DSIO2(FLD(.01,"E"))_U          ; NAME
 S STR=STR_FLD(.02,"I")_U                        ; TYPE
 S STR=STR_+FLD(.03,"I")_U                       ; INACTIVE
 S STR=STR_$$NAME^DSIO2(FLD(.04,"E"))_U          ; PRIMARY CONTACT
 S STR=STR_FLD(1.1,"I")_U                        ; STREET 1
 S STR=STR_FLD(1.2,"I")_U                        ; STREET 2
 S STR=STR_FLD(1.3,"I")_U                        ; STREET 3
 S STR=STR_FLD(1.4,"I")_U                        ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(1.5,"I")_",",1)_U    ; STATE
 S STR=STR_FLD(1.6,"I")_U                        ; ZIP CODE
 S STR=STR_$$PHONE(19641.1,IEN)                  ; PHONE NUMBERS
 Q STR
 ;
PHONE(FLE,IEN) ; Return Phone List
 ;               H ^ WP ^ MC ^ FAX
 N STR,OUT,CT,F,P
 S STR="^^^" D GETS^DIQ(FLE,IEN_",","2*","I","OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  D
 . I $QS(CT,3)=.01 S F=@CT Q
 . I $D(F) D
 . . S P=$S(F="H":1,F="WP":2,F="MC":3,F="FAX":4,1:"") K F
 . . S:P $P(STR,U,P)=$$FORMAT^DSIO2($TR(@CT,"()- "))
 Q STR
