Routine DSIO11 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO11^INT^64180,40571^Sep 19, 2016@11:16
DSIO11 ;DSS/CMW - DSIO MCC CHECKLIST;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
CHKGET(RET,IEN,SORT) ; RPC: DSIO GET MCC CHECKLIST
 ; IEN - IEN FOR EXISTING MCC CHECK LIST ENTRY
 ; RET(0)=# (TOT ENTRIES)
 ; RET(#)=IEN:DESC^#:TYPE^#:DCT^DCV^#:CAT^LNK
 ;
 N I,TOTFLG,ERR S TOT=0
 I $G(SORT)'?.N1",".N S SORT=""
 S IEN=+$G(IEN),RET=""
 S RET=$NA(^TMP("DSIO MCCHK",$J)) K @RET S @RET@(0)="-1^No entries found."
 I IEN>0,$$GET1^DIQ(19641.7,IEN_",",.01,"I")="" S @RET@(0)="-1^Checklist IEN not found." Q
 K LST S LST(1)=IEN,TOT=1
 I IEN<1 D
 . K LST S (IEN,TOT)=0 F  S IEN=$O(^DSIO(19641.7,IEN)) Q:'IEN  S TOT=TOT+1,LST(TOT)=IEN
 ; SORT
 I $G(SORT) D  ;RUN SORT LOGIC
 . D SORTA(.LST,.RETLST)
 I '$G(SORT) M RETLST=LST
 S CNT="" F  S CNT=$O(RETLST(CNT)) Q:'CNT  D
 . S IEN=+RETLST(CNT)
 . S FLD=".01;.02;.03;.04;.05;.06;.1;"
 . K OUT D GETS^DIQ(19641.7,IEN_",",FLD,"E","OUT")
 . S I=0,@RET@(CNT)=IEN,CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  D
 . . S I=I+1
 . . I $QS(CT,3)=".01" S @(CT)=IEN_":"_@(CT)
 . . I $QS(CT,3)=".02" S NIEN=$$FIND1^DIC(19641.71,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . I $QS(CT,3)=".03" S NIEN=$$FIND1^DIC(19641.72,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . I $QS(CT,3)=".05" S NIEN=$$FIND1^DIC(19641.73,,"X",@(CT)) S @(CT)=NIEN_":"_@(CT)
 . . ;KAR 11-26-14
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
 ; RET(0)=# (TOT ENTRIES)
 ;              1            2       3      4     5   6    7      8     9      10
 ; RET(CHK)=PIEN:PATIENT^CIEN:DESC^#:HIEN^#:TYPE^#:DCT^DCV^#:CAT^ILNK^UPDTBY^UPDTDT
 ;           11     12       13    14     15    16    17   18
 ; RET(PAT)=SDDT^#:INPROG^#:COMST^COMBY^COMDT^COMLNK^NOTE^EDUC
 ;
 N DIEN,RCT,TS,STRT,END D S^DSIO2($G(SORT))
 S DFN=+$G(DFN),CIEN=+$G(CIEN),HIEN=$G(HIEN),CSI=$G(CSI)
 S RET=$NA(^TMP("DSIO MCCPAT",$J)) K @RET S @RET@(0)="-1^No entries found."
 I CSI S @RET@(0)="-1^No entries found for this Completion Status."
 I DFN,'HIEN D
 . I 'CIEN D
 . . I '$$CHECK^DSIO2(DFN) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . . I '$D(^DSIO(19641.76,"B",DFN)) S @RET@(0)="-1^Patient Checklist IEN not found." Q
 . . S DIEN=$O(^DSIO(19641.76,"B",DFN,""))
 . . I $$GET1^DIQ(19641.76,DIEN_",",.01,"I")="" S RET(0)="-1^Patient Checklist - No entry found for this DFN." Q
 . . D PIEN
 . I CIEN D
 . . I '$$CHECK^DSIO2(DFN) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . . I '$D(^DSIO(19641.76,"B",DFN)) S QUIT=1,@RET@(0)="-1^Patient Checklist IEN not found." Q
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
 Q:'$G(CSI) 1
 N DSI S DSI=$$GET1^DIQ(19641.761,IENS,.12,"I")
 I $$GET1^DIQ(19641.74,CSI_",",.01,"I")="" S @RET@(0)="-1^MCC CompletionStatus IEN not found." Q 0
 I CSI'=DSI S @RET@(0)="-1^CompletionStatus no entries found." Q 0
 Q 1
 ;
CIEN(IENS) ; Get single checklist entry
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
 ;           1      2     3     4     5     6     7     8
MCCHK(RET,DSCIEN,DSDESC,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK,DSEDU) ; RPC: DSIO SAVE MCC CHECKLIST
 ; KAR - 11-24-14 ADDED PARAMETER 8: DSEDU POINTER TO 19641.8
 ; input parameters
 ; MCCHK(.RET,CIEN,DESC,TYP,DCT,DCV,CAT,LNK,EDUC)
 ;
 N DSFLG,DSIPT
 S DSCIEN=+$G(DSCIEN) K DSIPT,RET
 I DSCIEN>0 S DSFLG=DSCIEN_","
 I DSCIEN<1 D  Q:$G(RET(0))
 . I $G(DSDESC)=""!($G(DSTYP)="")!($G(DSDCT)="")!($G(DSDCV)="") S RET(0)="-1^Required Checklist parameter not found." Q
 . S DSCIEN=$O(^DSIO(19641.7,"B",DSDESC,""))
 . I $G(DSCIEN) S DSFLG=DSCIEN_"," Q 
 . S DSFLG="+1,"
 ;
 ;Description
 S DSIPT(19641.7,DSFLG,.01)=DSDESC ;
 ;CheckListType
 I $$GET1^DIQ(19641.71,DSTYP_",",.01,"I")="" S RET(0)="-1^ChecklistType - ien not found." Q
 S DSIPT(19641.7,DSFLG,.02)=+DSTYP
 ;DueCalculationType
 I $$GET1^DIQ(19641.72,DSDCT_",",.01,"I")="" S RET(0)="-1^DueCalculationType - ien not found." Q
 S DSIPT(19641.7,DSFLG,.03)=+DSDCT
 ;DueCalculationValue
 S DSIPT(19641.7,DSFLG,.04)=+DSDCV
 ;Category
 ;I DSCAT>0,$$GET1^DIQ(19641.74,DSCAT_",",.01,"I")="" S RET(0)="-1^Category - ien not found." Q
 S DSIPT(19641.7,DSFLG,.05)=DSCAT
 ;EducationItemLink
 I $G(DSEDU)'="" S DSIPT(19641.7,DSFLG,.06)=DSEDU
 S DSIPT(19641.7,DSFLG,.1)=DSLNK ;ItemLink
 S DSIPT(19641.7,DSFLG,.2)=DUZ ;LastUpdatedBy
 S DSIPT(19641.7,DSFLG,.21)=DT ;LastUpdatedDate
 ;
 ; CREATE (OR EDIT) THE ENTRY
 K ERR
 D UPDATE^DIE("","DSIPT",$S(+$G(DSCIEN)>0:"",1:"DSCIEN"),"ERR")
 I $D(ERR("DIERR","1","TEXT",1)) S RET(1)="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S (DSCIEN,RET(0))=$S(+$G(DSCIEN)>0:DSCIEN,+$G(DSCIEN(1))>0:DSCIEN(1),1:-1)
 ;
 K DSCIEN,DSDESC,DSFLG,DSIPT,DSPIEN,DSHIEN,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK,DSEDU
 Q
 ;
 ;           *1     2    *3     *4      *5    *6    *7    8     9    10    *11    12     13    14     15   ; (*=req parameter)
PATCHK(RET,DSPIEN,DSCIEN,DSDESC,DSHIEN,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK,DSSDT,DSCST,DSCLK,DSNOTE,DSINP,DSEDU) ; RPC: DSIO SAVE MCC PATIENT CHECKLIST
 ; KAR 11-24-14 ADDED PARAMETER 15
 ; input parameters
 ;
 N DSFLG,DSIPT,DSDT S DSIEN=""
 I $G(DSPIEN),$G(DSDESC)=""!($G(DSHIEN)="")!($G(DSTYP)="") S RET(0)="-1^Required Patient Checklist parameter not found." Q
 I $G(DSDCT)=""!($G(DSDCV)="")!($G(DSCST)="") S RET(0)="-1^Required Patient Checklist parameter not found." Q
 ;
 S DSDT=$$NOW^XLFDT
 ;CHECK PATIENT PIEN
 S DSPIEN=+$G(DSPIEN) S DSIEN=0 K DSIPT,RET
 I DSPIEN>0 D  Q:$G(RET(0))
 . I '$$CHECK^DSIO2($G(DSPIEN)) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . S DSIEN=$O(^DSIO(19641.76,"B",DSPIEN,""))
 . ;I $$GET1^DIQ(19641.76,DSIEN_",",.01,"I")="" S RET(0)="-1^Patient Checklist - No entry found for this PIEN." Q
 . ;I DSIEN>0 S DSFLG01=DSIEN
 ;NEW PIEN ENTRY
 I DSIEN<1 D  Q:$G(RET(1))
 . S DSFLG="+1,"
 . S DSIPT(19641.76,DSFLG,.01)=DSPIEN
 . K ERR,DSIEN D UPDATE^DIE("","DSIPT",$S(+$G(DSIEN)>0:"",1:"DSIEN"),"ERR")
 . S (DSIEN,RET)=$S(+$G(DSIEN)>0:DSIEN,+$G(DSIEN(1))>0:DSIEN(1),1:-1)
 . I $G(DSIEN(1))<1 S RET(0)="-1^Patient Checklist - No entry created." Q
 ;
 S DSCIEN=+$G(DSCIEN)
 I DSCIEN>0 D  Q:$G(RET(0))
 . S DSFLG=DSCIEN_","_DSIEN_","
 . I $$GET1^DIQ(19641.761,DSFLG_",",.01,"I")="" S RET(0)="-1^Patient Checklist - CIEN not found." Q
 I DSCIEN<1 D  Q:$G(RET(0))
 . ;I DSIEN>0 S DSCIEN=$O(^DSIO(19641.76,DSIEN,1,"B",DSDESC,""))
 . ;I $G(DSCIEN) S DSFLG=DSCIEN_","_DSIEN_"," Q
 . S DSFLG="+1,"_DSIEN_","
 ;Description
 S DSIPT(19641.761,DSFLG,.01)=DSDESC
 ; ERROR
 ;PregnancyHistoryLink
 S DSPIENH=$$GET1^DIQ(19641.13,DSHIEN_",",.03,"I") I $G(DSPIENH)="" S RET(0)="-1^Pregnancy History  - ien not found." Q
 I DSPIEN'=DSPIENH S RET(0)="-1^Pregnancy History PIEN does not match Patient PIEN." Q
 S DSIPT(19641.761,DSFLG,.02)=DSHIEN
 ; ERROR
 ;CheckListType
 I $$GET1^DIQ(19641.71,DSTYP_",",.01,"I")="" S RET(0)="-1^ChecklistType - ien not found." Q
 S DSIPT(19641.761,DSFLG,.03)=+DSTYP
 ;DueCalculationType
 I $$GET1^DIQ(19641.72,DSDCT_",",.01,"I")="" S RET(0)="-1^DueCalculationType - ien not found." Q
 S DSIPT(19641.761,DSFLG,.04)=+DSDCT
 ;DueCalculationValue
 S DSIPT(19641.761,DSFLG,.05)=+DSDCV
 ;Category
 ;I DSCAT>0,$$GET1^DIQ(19641.73,DSCAT_",",.01,"I")="" S RET(0)="-1^Category - ien not found." Q
 S DSIPT(19641.761,DSFLG,.06)=DSCAT
 ; 
 S DSIPT(19641.761,DSFLG,.07)=DSLNK ;ItemLink
 S DSIPT(19641.761,DSFLG,.08)=DUZ ;LastUpdatedBy
 S DSIPT(19641.761,DSFLG,.09)=DSDT ;LastUpdatedDate
 ;
 S DSIPT(19641.761,DSFLG,.1)=DSSDT ;SpecificDueDate
 S DSIP=$S(+$G(DSIP)>0:1,1:0)
 S DSIPT(19641.761,DSFLG,.11)=DSINP ;Inprogress
 ;
 ;CompletionStatus
 I DSCST>0,$$GET1^DIQ(19641.74,DSCST_",",.01,"I")="" S RET(0)="-1^CompletionStatus - ien not found." Q
 S DSIPT(19641.761,DSFLG,.12)=DSCST ;CompletionStatus
 ;
 I DSCST>1 D
 . S DSIPT(19641.761,DSFLG,.13)=DUZ ;CompletedBy
 . S DSIPT(19641.761,DSFLG,.14)=DSDT ;CompleteDate
 S DSIPT(19641.761,DSFLG,.15)=DSCLK ;CompletionLink
 S DSIPT(19641.761,DSFLG,.16)=DSNOTE ;Note
 ;EducationItemLink
 I $G(DSEDU)'="" S DSIPT(19641.761,DSFLG,.17)=DSEDU ;EducationItemLink
 ;
 ; CREATE (OR EDIT) THE ENTRY
 K ERR D UPDATE^DIE("","DSIPT",$S(+$G(DSCIEN)>0:"",1:"DSCIEN"),"ERR")
 I $D(ERR("DIERR","1","TEXT",1)) S RET(1)="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S (DSCIEN)=$S(+$G(DSCIEN)>0:DSCIEN,+$G(DSCIEN(1))>0:DSCIEN(1),1:-1)
 S RET(0)=DSPIEN_"^"_DSCIEN
 ;
 K DSCIEN,DSDESC,DSFLG,DSIPT,DSPIEN,DSHIEN,DSTYP,DSDCT,DSDCV,DSCAT,DSLNK
 Q
 ;
MCCDEL(RET,DSCIEN) ; RPC: DSIO DELETE MCC CHECKLIST
 ;
 ; input parameters
 ; MCCHK(.RET,CIEN) - CIEN FOR CHECKLIST TO DELETE
 ;
 N DSFLG,DSIPT
 S DSCIEN=+$G(DSCIEN) K DSIPT,RET
 I $G(DSCIEN)<1 S RET(0)="-1^Required Checklist Delete parameter CIEN missing." Q
 I $$GET1^DIQ(19641.7,DSCIEN_",",.01,"I")="" S RET(0)="-1^Checklist Delete CIEN not found." Q
 S DIK="^DSIO(19641.7,",DA=DSCIEN
 D ^DIK
 S RET(0)="-1^MCC CHECKLIST CIEN: "_DSCIEN_" DELETED"
 Q
 ;
 ;           *1     *2    ; (*=req parameter)
PATDEL(RET,DSPIEN,DSCIEN) ; RPC: DSIO DELETE MCC PAT CHKLST 
 ;
 ; input parameters
 ;
 N DSIEN
 ;CHECK PATIENT PIEN
 I $G(DSPIEN)=""!($G(DSCIEN)="") S RET(0)="-1^Required Patient Checklist Delete parameter missing." Q 
 S DSPIEN=+$G(DSPIEN) S DSIEN=0 K DSIPT,RET
 I DSPIEN>0 D  Q:$G(RET(0))
 . I '$$CHECK^DSIO2($G(DSPIEN)) S RET(0)="-1^DSIO PATIENT entry not found." Q
 . S DSIEN=$O(^DSIO(19641.76,"B",DSPIEN,""))
 . I $$GET1^DIQ(19641.76,DSIEN_",",.01,"I")="" S RET(0)="-1^Patient Checklist - No entry found for this PIEN." Q
 ;
 S DSCIEN=+$G(DSCIEN)
 I DSCIEN>0 D  Q:$G(RET(0))
 . S DSFLG=DSCIEN_","_DSIEN_","
 . I $$GET1^DIQ(19641.761,DSFLG_",",.01,"I")="" S RET(0)="-1^Patient Checklist - CIEN not found." Q
 S DSFLG=DSCIEN_","_DSIEN_","
 S DA(1)=DSIEN,DIK="^DSIO(19641.76,"_DA(1)_",1,",DA=DSCIEN
 ;S DA(1)=DSIEN,DIK="^DSIO(19641.76,"_DA(1)_",""SB","",",DA=DSCIEN
 D ^DIK
 S RET(0)="-1^MCC PATIENT CHECKLIST CIEN: "_DSCIEN_" DELETED FROM PATIENT PIEN: "_DSPIEN
 Q
 ;
SORTA(IN,OUT) ; CREATE PAGING (ARRAY)
 N PG,CNT,PGX,PGS K OUT
 S PG=+SORT,CNT=$P(SORT,",",2),PGS=0
 I '$G(PG)!'$G(CNT) Q
 S PGX=PG*CNT
 I PG>1 S PGS=PGX-CNT
 F  S PGS=$O(IN(PGS)) Q:PGS=""!(PGS>PGX)  D
 .S OUT(PGS)=IN(PGS)
 Q
