Routine DSIO13 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO13^INT^64156,59960^Aug 26, 2016@16:39
DSIO13 ;DSS/CMW/TFF - DSIO ORDER RPCS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; DETAIL^ORQ2
 ; AGET^ORWORR
 ; GET4LST^ORWORR
 ;
 Q
 ;
AGET(RET,DFN,FILTER,GROUPS,DTFROM,DTTHRU,SORT) ; RPC: DSIO GET ORDER LIST
 ;                                               ORRC ORDERS BY PATIENT
 ;
 ; INPUT
 ; ----------------------------------------------------------------
 ;     DFN = Patient ID
 ;  FILTER = # indicates which orders to return, default=2 (current)
 ;  GROUPS = Display grp of orders to show (default=ALL)
 ; DETAILS = Get Order detail
 ;
 ; RETURN:
 ;   ~IFN^Grp^ActTm^StrtTm^StopTm^Sts^Sig^Nrs^Clk^PrvID^PrvNam^ActDA^Flag^DCType^ChrtRev^DEA#^^Schedule
 ;   tOrder Text (repeating as necessary)
 ;
 N OUT,TXT,ORYD,IFNLST,CT,DETLS,RCT,TS,NCT,STRT,FLGS,END,FLGE D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO AGET")) K @RET S @RET@(0)="0^No orders found."
 I '$G(DFN) S @RET@(0)="-1^Patient DFN is required." Q
 S DTFROM=$$DT1^DSIO2($G(DTFROM)) S:'$L($G(DTFROM)) DTFROM=0
 S DTTHRU=$$DT1^DSIO2($G(DTTHRU)) S:'$L($G(DTTHRU)) DTTHRU=0
 D AGET^ORWORR(.OUT,$G(DFN),.FILTER,.GROUPS,DTFROM,DTTHRU) K @OUT@(.1)
 S TXT=2,ORYD=$H M IFNLST=@OUT K @OUT
 S CT=0 F  S CT=$O(IFNLST(CT)) Q:'CT  S IFNLST(CT)=$P(IFNLST(CT),"^")
 D GET4LST^ORWORR(.DETLS,.IFNLST) Q:'$G(DETLS)
 S (RCT,TS,CT)=0,NCT=1
 F  S CT=$O(DETLS(CT)) Q:CT=""  Q:'CT  D
 . I $E(DETLS(CT),1)="~" S TS=TS+1 I STRT'="" Q:TS'>STRT  S FLGS=1
 . I $E(DETLS(CT),1)="~" S RCT=RCT+1 I END'="",RCT>END S FLGE=1 Q
 . I STRT'="",END'="" Q:'$D(FLGS)!($D(FLGE))
 . S @RET@(NCT)=$$FORMAT(DETLS(CT)),NCT=NCT+1
 S:$G(TS) @RET@(0)=TS
 Q
 ;
FORMAT(VAL) ; Format the order information
 S $P(VAL,U,2)=$P(VAL,U,2)_":"_$$GET1^DIQ(100.98,$P(VAL,U,2)_",",.01)
 S $P(VAL,U,3)=$$FMTE^XLFDT($P(VAL,U,3),"5Z")
 S $P(VAL,U,6)=$P(VAL,U,6)_":"_$$GET1^DIQ(100,$P(VAL,U)_",",5)
 S $P(VAL,U,11)=$$NAME^DSIO2($P(VAL,U,11))
 S $P(VAL,U,19)=$P($P(VAL,U,19),":",2)_":"_$$NAME^DSIO2($P($P(VAL,U,19),":"))
 Q VAL
 ;
DETAIL(RET,ORID,DFN) ; RPC: DSIO GET ORDER DETAIL
 ;                          ORQQPXRM REMINDER DETAIL
 ;
 N ORVP
 S RET=$NA(^TMP($J,"DSIO ORD")) K @RET S @RET@(0)="-1^No entries found."
 I '$G(ORID) S @RET@(0)="-1^Order IEN required." Q
 I '$G(DFN) S @RET@(0)="-1^Patient DFN required." Q
 S ORVP=DFN_";DPT(" D DETAIL^ORQ2(.RET,ORID)
 Q
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
