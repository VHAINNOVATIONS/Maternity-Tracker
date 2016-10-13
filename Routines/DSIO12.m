Routine DSIO12 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO12^INT^64180,40623^Sep 19, 2016@11:17
DSIO12 ;DSS/CMW - DSIO CLINICAL RPCS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; URGENCY^ORQORB
 ; REMIND^ORQQPX
 ; REMDET^PXRMRPCA
 ;
 Q
 ;
PROV(RET,LIST) ; RPC: DSIO GET PROVIDER
 ;
 ; LIST - LIST(#)= PIEN (Provider IEN List)
 ;
 ; RETURN:
 ;  IEN^NAME^ADDRESS1^ADDRESS2^ADDRESS3^CITY^STATE^ZIP^PH OFFICE^
 ;  TITLE^SERVICE^NPI
 ;
 N CT,I
 S RET=$NA(^TMP($J,"DSIO PROV")) K @RET S @RET@(0)="-1^Entrie(s) not found."
 S I=0,CT="" F  S CT=$O(LIST(CT)) Q:CT=""  S @RET@(I)=$$PF(+LIST(CT)),I=I+1
 Q
 ;
PF(IEN) ; Provider Fields
 N FLD,OUT,LINE,FLD,STR
 S FLD=".01;.111;.112;.113;.114;.115;.116;.132;8;29;41.99"
 D GETS^DIQ(200,IEN_",",FLD,"IE","OUT") Q:'$D(OUT) IEN_"^Provider Not Found."
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=IEN_U
 S STR=STR_$$NAME^DSIO2(FLD(.01,"I"))_U              ; NAME
 S STR=STR_FLD(.111,"I")_U                           ; STREET ADDRESS 1
 S STR=STR_FLD(.112,"I")_U                           ; STREET ADDRESS 2
 S STR=STR_FLD(.113,"I")_U                           ; STREET ADDRESS 3
 S STR=STR_FLD(.114,"I")_U                           ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(.115,"I")_",",1)_U       ; STATE
 S STR=STR_FLD(.116,"I")_U                           ; ZIP
 S STR=STR_FLD(.132,"I")_U                           ; OFFICE PHONE
 S STR=STR_FLD(8,"E")_U                              ; TITLE
 S STR=STR_FLD(29,"E")_U                             ; SERVICE
 S STR=STR_FLD(41.99,"I")                            ; NPI
 Q STR
 ;
REM(RET,DFN,SORT) ; RPC: DSIO GET REMINDER LIST
 ;                       ORQQPX REMINDERS LIST
 ;
 ; Return patient's currently due PCE clinical reminders.
 ;
 ; RETURN:
 ; -----------------------------
 ; ^TMP("DSIO REMIND",$J,0)=COUNT
 ; ^TMP("DSIO REMIND",$J,1)=IEN^REMINDER PRINT NAME^DATE DUE
 ;
 N LST,RCT,TS,CT,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO12 REM")) K @RET S @RET@(0)="0^Nothing found."
 I '$G(DFN) S @RET@(0)="-1^Patient entry not found." Q
 D REMIND^ORQQPX(.LST,DFN)
 S (RCT,TS,CT)=0
 F  S CT=$O(LST(CT)) Q:'CT  D
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S @RET@(RCT)=$P(LST(CT),"^",1,3)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
DETAIL(RET,DFN,RIEN) ; RPC: DSIO GET REMINDER DETAIL
 ;                          PXRM REMINDER DETAIL
 ;
 ;   RIEN - clinical reminder (811.9 IEN)
 ;
 ; RETURN:
 ;  RET(1)="The reminder ZZ Breast Exam was inactivated 04/13/2005@21:55:15"
 ;
 I $G(DFN),$G(RIEN) D REMDET^PXRMRPCA(.RET,DFN,RIEN)
 S:'$D(RET) RET(0)="0^Entry not found."
 Q
 ;
ALERT(RET,SORT,DFN) ; RPC: DSIO GET NOTIFICATIONS/ALERTS
 ;                    ORWORB FASTUSER
 ;
 ; Return:
 ;  STATUS ^ PATIENT ^ LOCATION ^ URGENCY ^ ALERT DATE/TIME ^ MESSAGE TEXT
 ;
 N FLG,DATE,IEN,ID,RCT,TS,CT,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO12 ALERT")) K @RET S @RET@(0)="0^No tracked patient alerts."
 S FLG=+$G(DFN),(RCT,TS,CT)=0
 S DATE="" F  S DATE=$O(^XTV(8992.1,"D",DATE),-1) Q:DATE=""  D
 . S IEN=0 F  S IEN=$O(^XTV(8992.1,"D",DATE,IEN)) Q:'IEN  D
 . . Q:$$R
 . . S ID=$P(^XTV(8992.1,IEN,0),U)
 . . S DFN=$S(ID["TIU":$$GET1^DIQ($E($P(ID,";"),"TIU")_",",.02,"I"),1:$P(^XTV(8992.1,IEN,0),U,4))
 . . Q:'DFN  Q:'$$TRACK^DSIO4(DFN,1)  I FLG Q:FLG'=DFN
 . . S TS=TS+1 I STRT'="",TS'>STRT Q
 . . S RCT=RCT+1 I END'="",RCT>END Q
 . . S @RET@(RCT)=$$A
 S:$G(TS) @RET@(0)=TS
 Q
 ;
R() ; RECIPIENT
 ;
 ; Stop showing alert if alert was processed(.04) or deleted(.05)
 ;
 N IENS
 S IENS=$O(^XTV(8992.1,IEN,20,"B",DUZ,"")) Q:'IENS 0
 Q $S($P(^XTV(8992.1,IEN,20,IENS,0),U,4)'=""!($P(^XTV(8992.1,IEN,20,IENS,0),U,5)'=""):1,1:0)
 ;
A() ; Get ALERT information from the ALERT DATE/TIME multiple from 8992
 N STR
 S STR=$P(^XTV(8992.1,IEN,0),U,7)_U                        ; STATUS
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN_",",.01))_U       ; PATIENT
 S STR=STR_$G(^DPT(+$G(DFN),.1))_U                         ; LOCATION
 S STR=STR_$$UGY(ID)_U                                     ; URGENCY
 S STR=STR_$$FMTE^XLFDT(DATE,"5Z")_U                       ; ALERT DATE/TIME
 S STR=STR_$P($G(^XTV(8992.1,IEN,1)),U)                    ; MESSAGE TEXT
 Q STR
 ;
UGY(ID) ; Urgency
 N ORN,OUT
 S ORN=$P(ID,";",3) Q:'ORN "N/A"
 D URGENCY^ORQORB(.OUT,ORN)
 Q $S(+OUT=1:"High",+OUT=2:"Moderate",+OUT=1:"Low",1:"N/A")
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
