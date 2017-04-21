DSIO11 ;DSS/CMW - DSIO MCC CHECKLIST;08/26/2016 16:00
 ;;3.0;MATERNITY TRACKER;;Feb 02, 2017;Build 1
 ;
 ;
 ;
 Q
 ;
CHKGET(RET,IEN,SORT) ; RPC: DSIO GET MCC CHECKLIST
 ;
 ;    IEN = IEN FOR EXISTING MCC CHECK LIST ENTRY
 ; RET(0) = # (TOT ENTRIES)
 ; RET(#) = IEN:DESC^#:TYPE^#:DCT^DCV^#:CAT^LNK
 ;
 N LST,TOT,RETLST,CNT,FLD,OUT,I,CT,NIEN
 I $G(SORT)'?.N1",".N S SORT=""
 S RET=$NA(^TMP("DSIO MCCHK",$J)) K @RET S @RET@(0)="0^No entries found."
 S IEN=+$G(IEN)
 I IEN,$$GET1^DIQ(19641.7,IEN_",",.01,"I")="" S @RET@(0)="-1^Checklist IEN not found." Q
 I 'IEN D
 . S (IEN,TOT)=0 F  S IEN=$O(^DSIO(19641.7,IEN)) Q:'IEN  S TOT=TOT+1,LST(TOT)=IEN
 E  S LST(1)=IEN,TOT=1
 I $G(SORT) D
 . D SORTA^DSIO2(.LST,.RETLST)
 I '$G(SORT) M RETLST=LST
 S CNT="" F  S CNT=$O(RETLST(CNT)) Q:'CNT  D
 . S IEN=+RETLST(CNT)
 . S FLD=".01;.02;.03;.04;.05;.06;.1;"
 . K OUT D GETS^DIQ(19641.7,IEN_",",FLD,"E","OUT")
 . S I=0,@RET@(CNT)=IEN,CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S I=I+1 D
 . . I $QS(CT,3)=".01" S @(CT)=IEN_":"_@(CT)
 . . I $QS(CT,3)=".02" S NIEN=$$FIND1^DIC(19641.71,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . I $QS(CT,3)=".03" S NIEN=$$FIND1^DIC(19641.72,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . I $QS(CT,3)=".05" S NIEN=$$FIND1^DIC(19641.73,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . I $QS(CT,3)=".06" S NIEN=$$FIND1^DIC(19641.8,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . S $P(@RET@(CNT),U,I)=@CT
 S @RET@(0)=TOT
 K LST
 Q
 ;
PATGET(RET,DFN,CIEN,HIEN,CSI,SORT) ; RPC: DSIO GET MCC PATIENT CHECKLIST
 ;
 ; CIEN - IEN FOR EXISTING MCC CHECK LIST ENTRY (not req)
 ;  DFN - Unique DFN identifier for a patient (req)
 ; HIEN - Pregnancy ID pointing to a pregnancy history entry (not req)
 ;  CSI - Completion Status IEN (not req)
 ; SORT - Sort field (ex: 1,10) (not req)
 ;
 ; RET(0)  =# (TOT ENTRIES)
 ; RET(CHK)=PIEN:PATIENT^CIEN:DESC^#:HIEN^#:TYPE^#:DCT^DCV^#:CAT^ILNK^UPDTBY^UPDTDT
 ; RET(PAT)=SDDT^#:INPROG^#:COMST^COMBY^COMDT^COMLNK^NOTE^EDUC
 ;
 N DIEN,RCT,TS,STRT,END D S^DSIO2($G(SORT))
 S DFN=+$G(DFN),CIEN=+$G(CIEN),HIEN=$G(HIEN),CSI=$G(CSI)
 S RET=$NA(^TMP("DSIO MCCPAT",$J)) K @RET S @RET@(0)="0^No entries found."
 I CSI S @RET@(0)="0^No entries found for this Completion Status."
 I DFN,'HIEN D
 . I 'CIEN D
 . . I '$$CHECK^DSIO2(DFN) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . . I '$D(^DSIO(19641.76,"B",DFN)) S @RET@(0)="-1^Patient Checklist IEN not found." Q
 . . S DIEN=$O(^DSIO(19641.76,"B",DFN,""))
 . . I $$GET1^DIQ(19641.76,DIEN_",",.01,"I")="" S RET(0)="-1^Patient Checklist - No entry found for this DFN." Q
 . . D PIEN
 . I CIEN D
 . . I '$$CHECK^DSIO2(DFN) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . . I '$D(^DSIO(19641.76,"B",DFN)) S @RET@(0)="-1^Patient Checklist IEN not found." Q
 . . S DIEN=$O(^DSIO(19641.76,"B",DFN,""))
 . . I $$GET1^DIQ(19641.76,DIEN_",",.01,"I")="" S RET(0)="-1^Patient Checklist - No entry found for this DFN." Q
 . . I $$GET1^DIQ(19641.761,CIEN_","_DIEN_",",.01,"I")="" S @RET@(0)="-1^MCC Checklist IEN not found." Q
 . . S @RET@(1)=$$CIEN(CIEN_","_DIEN_","),@RET@(0)=1
 I HIEN D
 . I '$D(^DSIO(19641.76,"C",HIEN)) S @RET@(0)="-1^Pregnancy History IEN not found." Q
 . S DIEN=$O(^DSIO(19641.76,"C",HIEN,""))
 . D HIEN
 Q
 ;
PIEN ; Get all checklist items for a patient
 ; *RCT, *TS, *CIEN, *DIEN, *STRT, *END
 S (RCT,TS,CIEN)=0
 F  S CIEN=$O(^DSIO(19641.76,DIEN,1,CIEN)) Q:'CIEN  D
 . Q:'$$STATUS(CIEN_","_DIEN_",")
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S @RET@(RCT)=$$CIEN(CIEN_","_DIEN_",")
 S:$G(TS) @RET@(0)=TS
 Q
 ;
HIEN ; Get all checklist items for a patient
 ; *RCT, *TS, *CIEN, *HIEN, *DIEN, *PIEN, *STRT, *END
 S (RCT,TS,CIEN)=0
 F  S CIEN=$O(^DSIO(19641.76,"C",HIEN,DIEN,CIEN)) Q:'CIEN  D
 . Q:'$$STATUS(CIEN_","_DIEN_",")
 . S PIEN=$$GET1^DIQ(19641.76,DIEN_",",.01,"I")
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S @RET@(RCT)=$$CIEN(CIEN_","_DIEN_",")
 S:$G(TS) @RET@(0)=TS
 Q
 ;
STATUS(IENS) ; Check completion status
 ; *CSI
 Q:'$G(CSI) 1
 N DSI S DSI=$$GET1^DIQ(19641.761,IENS,.12,"I")
 I $$GET1^DIQ(19641.74,CSI_",",.01,"I")="" S @RET@(0)="-1^MCC Completion Status IEN not found." Q 0
 I CSI'=DSI S @RET@(0)="-1^No entries found for Completion Status." Q 0
 Q 1
 ;
CIEN(IENS) ; Get single checklist entry
 ; *CIEN
 N OUT,LINE,FLD,STR
 D GETS^DIQ(19641.761,IENS,"*","IE","OUT") Q:'$D(OUT) ""
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=DFN_":"_$$NAME^DSIO2($$GET1^DIQ(2,DFN_",",.01))_U                 ; DFN : PATIENT
 S STR=STR_CIEN_":"_FLD(.01,"I")_U                                       ; IEN : Description
 S STR=STR_FLD(.02,"I")_":"_$$FMTE^XLFDT($$GET1^DIQ(19641.13,FLD(.02,"I")_",",.01),"5Z")_U   ; PregnancyHistoryLink
 S STR=STR_FLD(.03,"I")_":"_FLD(.03,"E")_U                               ; IEN : CheckListType
 S STR=STR_FLD(.04,"I")_":"_FLD(.04,"E")_U                               ; IEN : DueCalculationType
 S STR=STR_FLD(.05,"I")_U                                                ; DueCalculationValue
 S STR=STR_FLD(.06,"I")_U                                                ; Category
 S STR=STR_FLD(.07,"I")_U                                                ; ItemLink
 S STR=STR_FLD(.08,"I")_":"_$$NAME^DSIO2(FLD(.08,"E"))_U                 ; IEN : LastUpdatedBy
 S STR=STR_$$FMTE^XLFDT(FLD(.09,"I"),"5Z")_U                             ; LastUpdatedDate
 S STR=STR_$$FMTE^XLFDT(FLD(.1,"I"),"5Z")_U                              ; SpecificDueDate
 S STR=STR_FLD(.11,"I")_":"_FLD(.11,"E")_U                               ; In Progress
 S STR=STR_FLD(.12,"I")_":"_FLD(.12,"E")_U                               ; CompletionStatus
 S STR=STR_FLD(.13,"I")_":"_$$NAME^DSIO2(FLD(.13,"E"))_U                 ; CompletedBy
 S STR=STR_$$FMTE^XLFDT(FLD(.14,"I"),"5Z")_U                             ; CompleteDate
 S STR=STR_FLD(.15,"I")_U                                                ; CompletionLink
 S STR=STR_FLD(.16,"I")_U                                                ; Note
 S STR=STR_FLD(.17,"I")_":"_FLD(.17,"E")                                 ; EducationItemLink
 Q STR
 ;
MCCHK(RET,DSCIEN,DSDESC,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK,DSEDU) ; RPC: DSIO SAVE MCC CHECKLIST
 N DSFLG,DSIPT,UIEN,ERR
 S DSCIEN=+$G(DSCIEN) S RET(0)=0
 I DSCIEN>0 S DSFLG=DSCIEN_","
 I DSCIEN<1 D  Q:$G(RET(0))
 . I $G(DSDESC)=""!($G(DSTYP)="")!($G(DSDCT)="")!($G(DSDCV)="") D  Q
 . . S RET(0)="-1^Required Checklist parameter not found."
 . S DSCIEN=$O(^DSIO(19641.7,"B",DSDESC,""))
 . S DSFLG=$S(DSCIEN:DSCIEN_",",1:"+1,")
 ; *** DESCRIPTION
 S DSIPT(19641.7,DSFLG,.01)=$G(DSDESC)
 ; *** CHECKLIST TYPE
 I $$GET1^DIQ(19641.71,$G(DSTYP)_",",.01,"I")="" S RET(0)="-1^Checklist Type - IEN not found." Q
 S DSIPT(19641.7,DSFLG,.02)="`"_DSTYP
 ; *** DUE CALCULATION TYPE
 I $$GET1^DIQ(19641.72,$G(DSDCT)_",",.01,"I")="" S RET(0)="-1^Due Calculation Type - IEN not found." Q
 S DSIPT(19641.7,DSFLG,.03)="`"_DSDCT
 ; *** DUE CALCULATION VALUE
 S DSIPT(19641.7,DSFLG,.04)=+$G(DSDCV)
 ; *** CATEGORY
 S DSIPT(19641.7,DSFLG,.05)=$G(DSCAT)
 ; *** EDUCATION ITEM LINK
 I $G(DSEDU)'="" S DSIPT(19641.7,DSFLG,.06)="`"_DSEDU
 S DSIPT(19641.7,DSFLG,.1)=$G(DSLNK)
 S DSIPT(19641.7,DSFLG,.2)="`"_DUZ
 S DSIPT(19641.7,DSFLG,.21)=DT
 ; *** CREATE (OR EDIT) THE ENTRY
 D UPDATE^DIE("E","DSIPT","UIEN","ERR")
 I $D(ERR) S RET(0)="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S RET(0)=$S($G(UIEN(1)):UIEN(1),1:+DSFLG)
 Q
 ;
PATCHK(RET,DSPIEN,DSCIEN,DSDESC,DSHIEN,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK,DSSDT,DSCST,DSCLK,DSNOTE,DSINP,DSEDU) ; RPC: DSIO SAVE MCC PATIENT CHECKLIST
 N DSDT,DSIEN,DSFLG,DSIPT,UIEN,ERR,DSPIENH,DSIP S RET(0)=0
 I '$G(DSPIEN),$G(DSDESC)=""!('$G(DSHIEN))!('$G(DSTYP)) D  Q
 . S RET(0)="-1^Required Patient Checklist parameter not found."
 I '$G(DSDCT)!($G(DSDCV)="")!('$G(DSCST)) D  Q
 . S RET(0)="-1^Required Patient Checklist parameter not found."
 S DSDT=$$NOW^XLFDT,DSPIEN=+$G(DSPIEN)
 I '$$CHECK^DSIO2($G(DSPIEN)) S RET(0)="-1^DSIO PATIENT entry not found." Q
 S DSIEN=$O(^DSIO(19641.76,"B",DSPIEN,"")) I 'DSIEN D
 . S DSFLG="+1,"
 . S DSIPT(19641.76,DSFLG,.01)="`"_DSPIEN
 . D UPDATE^DIE("E","DSIPT","UIEN","ERR")
 . I $D(ERR) S RET(0)="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 . S (DSIEN,RET(0))=$S($G(UIEN(1)):UIEN(1),1:+DSFLG)
 S DSCIEN=+$G(DSCIEN) I DSCIEN D
 . S DSFLG=DSCIEN_","_DSIEN_","
 . I $$GET1^DIQ(19641.761,DSFLG_",",.01,"I")="" D
 . . S RET(0)="-1^Patient Checklist - CIEN not found."
 I 'DSCIEN S DSFLG="+1,"_DSIEN_","
 S DSIPT(19641.761,DSFLG,.01)=DSDESC
 S DSPIENH=$$GET1^DIQ(19641.13,DSHIEN_",",.03,"I") I $G(DSPIENH)="" D  Q
 . S RET(0)="-1^Pregnancy History IEN not found."
 I DSPIEN'=DSPIENH S RET(0)="-1^Pregnancy History does not match Patient." Q
 S DSIPT(19641.761,DSFLG,.02)="`"_DSHIEN       ; PREGNANCY HISTORY LINK
 S DSIPT(19641.761,DSFLG,.03)="`"_DSTYP        ; CHECKLIST TYPE
 S DSIPT(19641.761,DSFLG,.04)="`"_DSDCT        ; DUE CALCULATION TYPE
 S DSIPT(19641.761,DSFLG,.05)=+DSDCV           ; DUE CALCULATION VALUE
 S DSIPT(19641.761,DSFLG,.06)=DSCAT            ; CATEGORY
 S DSIPT(19641.761,DSFLG,.07)=$G(DSLNK)        ; ITEM LINK
 S DSIPT(19641.761,DSFLG,.08)="`"_DUZ          ; LAST UPDATED BY
 S DSIPT(19641.761,DSFLG,.09)=DSDT             ; LAST UPDATED DATE
 S DSIPT(19641.761,DSFLG,.1)=$$DT^DSIO2($G(DSSDT))               ; SPECIFIC DUE DATE
 S DSIP=$S(+$G(DSIP)>0:1,1:0)
 S DSIPT(19641.761,DSFLG,.11)=$G(DSINP)        ; IN PROGRESS
 I DSCST,$$GET1^DIQ(19641.74,DSCST_",",.01,"I")="" D  Q
 . S RET(0)="-1^Completion Status not found."
 S DSIPT(19641.761,DSFLG,.12)=$S(DSCST:"`"_DSCST,1:"")           ; COMPLETION STATUS
 I DSCST D
 . S DSIPT(19641.761,DSFLG,.13)="`"_DUZ        ; COMPLETED BY
 . S DSIPT(19641.761,DSFLG,.14)=DSDT           ; COMPLETION DATE
 S DSIPT(19641.761,DSFLG,.15)=$G(DSCLK)        ; COMPLETION LINK
 S DSIPT(19641.761,DSFLG,.16)=$G(DSNOTE)       ; NOTE
 S DSIPT(19641.761,DSFLG,.17)=$S($G(DSEDU):"`"_$G(DSEDU),1:"")   ; EDUCATION ITEM LINK
 K UIEN D UPDATE^DIE("E","DSIPT","UIEN","ERR")
 I $D(ERR) S RET(0)="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S RET(0)=DSPIEN_U_$S($G(UIEN(1)):UIEN(1),1:DSCIEN)
 Q
 ;
MCCDEL(RET,CIEN) ; RPC: DSIO DELETE MCC CHECKLIST
 N DIK,DA
 S CIEN=+$G(CIEN),RET(0)=-1
 I 'CIEN S RET(0)="-1^Checklist IEN is required to delete." Q
 I $$GET1^DIQ(19641.7,CIEN_",",.01,"I")="" S RET(0)="-1^Checklist item not found." Q
 S DIK="^DSIO(19641.7,",DA=CIEN D ^DIK
 S:'$D(^DSIO(19641.7,CIEN)) RET(0)="1^MCC CHECKLIST ITEM: "_CIEN_" DELETED"
 Q
 ;
PATDEL(RET,PIEN,CIEN) ; RPC: DSIO DELETE MCC PAT CHKLST 
 N IEN,DIK,DA S RET(0)=0
 S PIEN=+$G(PIEN),CIEN=+$G(CIEN)
 I 'PIEN!('CIEN) S RET(0)="-1^Required parameters missing." Q
 I '$$CHECK^DSIO2(PIEN) S RET(0)="-1^DSIO PATIENT entry not found." Q
 S IEN=$O(^DSIO(19641.76,"B",PIEN,""))
 I $$GET1^DIQ(19641.76,IEN_",",.01,"I")="" D  Q
 . S RET(0)="-1^No entry found for this Patient."
 S CIEN=+$G(CIEN)
 I $$GET1^DIQ(19641.761,CIEN_","_IEN_",",.01,"I")="" D  Q
 . S RET(0)="-1^Patient Checklist not found."
 S DA(1)=$G(IEN),DIK="^DSIO(19641.76,"_DA(1)_",1,",DA=CIEN D ^DIK
 I '$D(^DSIO(19641.76,IEN,1,CIEN)) D
 . S RET(0)="1^MCC Patient checklist deleted from patient."
 Q
