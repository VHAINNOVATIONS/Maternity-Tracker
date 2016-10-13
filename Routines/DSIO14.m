Routine DSIO14 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO14^INT^64180,40670^Sep 19, 2016@11:17
DSIO14 ;DSS/TFF - DSIO IHE;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
SAVE(RET,IEN,DFN,DATES,TYP,DIRECT,GUID,TITLE,FAC,REC,DOC,AB) ; RPC: DSIO SAVE IHE DOC
 ;
 ;    IEN = IF NULL THEN NEW
 ;    DFN = PATIENT IEN
 ;  DATES = DT CREATION^DT IMPORT/EXPORT
 ;    TYP = DOCUMENT TYPE
 ; DIRECT = DIRECTION
 ;   GUID = GUID
 ;  TITLE = DOCUMENT TITLE
 ;    FAC = SENDING FACILITY/PROVIDER
 ;    REC = INTENDED RECIPIENT
 ;    DOC = ARRAY OF TEXT
 ;
 ; RETURN: IEN OR -1^MESSAGE
 ; 
 N DTC,DTI,IPT
 I '$G(IEN),'$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 S DTC=$P(DATES,U),DTI=$P(DATES,U,2)
 S DIRECT=$$UP^XLFSTR($E($G(DIRECT),1)) S:"^I^O^"'[(U_DIRECT_U) DIRECT=""
 D:'$G(AB) AB^DSIO2("DFN,DTC,DTI,TYP,DIRECT,GUID,TITLE,FAC,REC")
 S:$G(DTC)'="@" DTC=$$DT^DSIO2($G(DTC))
 S:$G(DTI)'="@" DTI=$$DT^DSIO2($G(DTI))
 S IEN=$S($G(IEN):IEN,GUID'="":$O(^DSIO(19641.6,"GUID",GUID,"")),1:"")
 S:IEN="" IEN="?+1"
 S:IEN["+" IPT(19641.6,IEN_",",.01)=$$NOW^XLFDT            ; DT OF ENTRY
 S IPT(19641.6,IEN_",",.02)=DFN                            ; PATIENT
 S:$G(DTC)'="" IPT(19641.6,IEN_",",.03)=DTC                ; DT CREATION
 S:$G(DTI)'="" IPT(19641.6,IEN_",",.04)=DTI                ; DT IMPORT/EXPORT
 S:$G(TYP)'="" IPT(19641.6,IEN_",",.05)=$$TYP(TYP)         ; DOCUMENT TYPE
 S:$G(DIRECT)'="" IPT(19641.6,IEN_",",.06)=DIRECT          ; DIRECTION
 ;S IPT(19641.6,IEN_",",.07)=$$GUID($S(IEN["+":"",1:IEN),$G(GUID))
 S:$G(GUID)'="" IPT(19641.6,IEN_",",.07)=GUID              ; GUID/ID
 S:$G(TITLE)'="" IPT(19641.6,IEN_",",1.1)=TITLE            ; DOCUMENT TITLE
 S:$G(FAC)'="" IPT(19641.6,IEN_",",1.2)=FAC                ; SENDING FACILITY/PROVIDER
 S:$G(REC)'="" IPT(19641.6,IEN_",",1.3)=REC                ; INTENDED RECIPIENT
 D UPDATE^DIE(,"IPT",$S($G(IEN):"",1:"IEN")) K IPT
 S (RET,IEN)=$S($G(IEN):+IEN,$G(IEN(1)):IEN(1),1:"") I 'IEN S RET="-1^Failed to Update." Q
 ; *** DOCUMENT CONTENT
 I $D(DOC)>9 K ^TMP($J,"DSIO14 SAVE") D
 . S %X="DOC(",%Y="^TMP($J,""DSIO14 SAVE"",1" D %XY^%RCR
 . D WP^DIE(19641.6,IEN_",",2,"K","^TMP($J,""DSIO14 SAVE"")")
 . K ^TMP($J,"DSIO14 SAVE")
 Q
 ;
TYP(TYP) ; Create the Document Type and return the IEN
 Q:$G(TYP)="" ""
 N DLAYGO,DIC,DA,X,Y
 S DLAYGO=19641.61,DIC="^DSIO(19641.61,",DIC(0)="XL",X=TYP D ^DIC
 Q $S(Y:+Y,1:"")
 ;
GUID(IEN,GUID) ; Find or Generate a GUID
 I IEN,GUID'="",$O(^DSIO(19641.6,"GUID",GUID,""))=IEN Q GUID
 I 'IEN,GUID'="",'$O(^DSIO(19641.6,"GUID",GUID,"")),GUID?8E1"-"4E1"-"4E1"-"4E1"-"12E Q GUID
 F  Q:$$GEN(.GUID)
 Q GUID
 ;
GEN(GUID) ; Generate and Determine that GUID is unique
 N TST S TST=$$G I '$O(^DSIO(19641.6,"GUID",TST,"")) S GUID=TST Q 1
 Q 0
 ;
G() ; Generate GUID
 ; 21EC2020-3AEA-4069-A2DD-08002B30309D
 N G1,G2,G3,G4,G5 S (G1,G2,G3,G4,G5)=""
 F V="8^G1","4^G2","4^G3","4^G4","12^G5" S @$P(V,U,2)=$$GP(+V,@$P(V,U,2))
 Q G1_"-"_G2_"-"_G3_"-"_G4_"-"_G5
 ;
GP(NUM,VAR) ; Generate GUID Segment
 N I F I=1:1:NUM S VAR=VAR_$R($S($R(9)<5:26,1:9))_U
 S VAR=$E(VAR,1,($L(VAR)-1))
 F I=1:1:NUM S:$L($P(VAR,U,I))=2 $P(VAR,U,I)=$$A($P(VAR,U,I))
 Q $TR(VAR,U)
 ;
A(NUM) ; Return Alpha
 Q $E("ABCDEFGHIJKLMNOPQRSTUVWXYZ",NUM)
 ;
 ; ----------------------------------------------------------------------------
 ;
GD(RET,IEN) ; RPC: DSIO GET IHE CONTENT
 D GET(.RET,$G(IEN),,,1)
 Q
 ;
GET(RET,IEN,DFN,SORT,DOC) ; RPC: DSIO GET IHE DOCS
 ;
 ; IEN^DATE OF ENTRY^DFN^DATE OF CREATION^DATE OF IMPORT/EXPORT^DOCUMENT TYPE^
 ; DIRECTION^GUID/ID^DOCUMENT TITLE^SENDING FACILITY/PROVIDER^INTENDED RECIPIENT
 ;
 N RCT,TS,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO14 GET")) K @RET S @RET@(0)="0^Nothing found."
 I $G(DOC) D  Q
 . Q:'$G(IEN)
 . K @RET D GETS^DIQ(19641.6,IEN_",",2,"E",RET)
 . K @RET@(19641.6,IEN_",",2,"E") S:'$D(@RET) @RET@(0)=""
 I $G(IEN) D  Q
 . Q:'$D(^DSIO(19641.6,IEN))
 . S @RET@(1)=$$FLDS(IEN),@RET@(0)=1
 I '$$CHECK^DSIO2($G(DFN)) S @RET@(0)="0^Patient entry not found." Q
 S (RCT,TS,IEN)=0
 F  S IEN=$O(^DSIO(19641.6,"P",DFN,IEN)) Q:'IEN  D
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S @RET@(RCT)=$$FLDS(IEN)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
FLDS(IEN) ; Return Transformed Fields
 N OUT,LINE,FLD,STR
 D GETS^DIQ(19641.6,IEN_",","*","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=IEN_U
 S STR=STR_$$FMTE^XLFDT(FLD(.01,"I"),"5Z")_U            ; DT OF ENTRY
 S STR=STR_FLD(.02,"I")_U                               ; DFN
 S STR=STR_$$FMTE^XLFDT(FLD(.03,"I"),"5Z")_U            ; DT CREATION
 S STR=STR_$$FMTE^XLFDT(FLD(.04,"I"),"5Z")_U            ; DT IMPORT/EXPORT
 S STR=STR_$$GET1^DIQ(19641.61,FLD(.05,"I")_",",.01)_U  ; DOCUMENT TYPE
 S STR=STR_FLD(.06,"E")_U                               ; DIRECTION
 S STR=STR_FLD(.07,"I")_U                               ; GUID/ID
 S STR=STR_FLD(1.1,"I")_U                               ; DOCUMENT TITLE
 S STR=STR_FLD(1.2,"I")_U                               ; SENDING FACILITY/PROVIDER
 S STR=STR_FLD(1.3,"I")                                 ; INTENDED RECIPIENT
 Q STR
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
