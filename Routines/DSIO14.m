DSIO14 ;DSS/TFF - DSIO IHE;08/26/2016 16:00
 ;;3.0;MATERNITY TRACKER;;Feb 02, 2017;Build 1
 ;Originally Submitted to OSEHRA 2/21/2017 by DSS, Inc. 
 ;Authored by DSS, Inc. 2014-2017
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
 N DTC,DTI,FDA,UIEN,ERR
 I '$G(IEN),'$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 S DATES=$G(DATES)
 ; *** DT CREATION
 S DTC=$P(DATES,U)
 I $L(DTC),DTC'="@" S DTC=$$DT^DSIO2(DTC)
 ; *** DT IMPORT/EXPORT
 S DTI=$P(DATES,U,2)
 I $L(DTI),DTI'="@" S DTI=$$DT^DSIO2(DTI)
 ; *** DOCUMENT TYPE
 I $G(TYP)'="" S TYP=$$TYP(TYP) S:'TYP TYP=""
 ; *** DIRECTION
 S DIRECT=$$UP^XLFSTR($E($G(DIRECT),1)) S:"^I^O^"'[(U_DIRECT_U) DIRECT=""
 ; *** AB = Delete if Null unless set
 D:'$G(AB) AB^DSIO2("DTC,DTI,TYP,DIRECT,GUID,TITLE,FAC,REC")
 S IEN=$S($G(IEN):IEN,$L(GUID)&(GUID'="@"):$O(^DSIO(19641.6,"GUID",GUID,"")),1:"")
 I IEN="" S IEN="?+1" D
 . S FDA(19641.6,IEN_",",.01)=$$NOW^XLFDT                ; DT OF ENTRY
 S IEN=IEN_","
 I $G(DFN)'="",DFN'="@" S FDA(19641.6,IEN,.02)="`"_DFN   ; PATIENT
 S:$G(DTC)'="" FDA(19641.6,IEN,.03)=DTC                  ; DT CREATION
 S:$G(DTI)'="" FDA(19641.6,IEN,.04)=DTI                  ; DT IMPORT/EXPORT
 S:$G(TYP)'="" FDA(19641.6,IEN,.05)=$S(TYP'="@":"`",1:"")_TYP   ; DOCUMENT TYPE
 S:$G(DIRECT)'="" FDA(19641.6,IEN,.06)=DIRECT            ; DIRECTION
 S:$G(GUID)'="" FDA(19641.6,IEN,.07)=GUID                ; GUID/ID
 S:$G(TITLE)'="" FDA(19641.6,IEN,1.1)=TITLE              ; DOCUMENT TITLE
 S:$G(FAC)'="" FDA(19641.6,IEN,1.2)=FAC                  ; SENDING FACILITY/PROVIDER
 S:$G(REC)'="" FDA(19641.6,IEN,1.3)=REC                  ; INTENDED RECIPIENT
 D UPDATE^DIE("E","FDA","UIEN","ERR")
 I $D(ERR) S RET="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S RET=$S($G(UIEN(1)):UIEN(1),1:+IEN)
 ; *** DOCUMENT CONTENT
 I $D(DOC)>9 K ^TMP($J,"DSIO14 SAVE") D
 . D XY^DSIO2(.DOC,$NA(^TMP($J,"DSIO14 SAVE")))
 . D WP^DIE(19641.6,RET_",",2,"K","^TMP($J,""DSIO14 SAVE"")")
 . K ^TMP($J,"DSIO14 SAVE")
 Q
 ;
TYP(X) ; Create the Document Type and return the IEN
 Q:$G(X)="" ""
 N DLAYGO,DIC,DA,Y
 S DLAYGO=19641.61,DIC="^DSIO(19641.61,",DIC(0)="XL" D ^DIC
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
 N G1,G2,G3,G4,G5,V
 S (G1,G2,G3,G4,G5)=""
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
 N RCT,TS,STRT,END
 D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO14 GET")) K @RET S @RET@(0)="0^Nothing found."
 I $G(DOC) D  Q
 . Q:'$G(IEN)
 . K @RET D GETS^DIQ(19641.6,IEN_",",2,"E",RET)
 . K @RET@(19641.6,IEN_",",2,"E")
 . I '$D(@RET) S @RET@(0)="0^No document saved."
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
