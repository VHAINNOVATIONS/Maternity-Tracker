Routine DSIO10 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO10^INT^64180,40511^Sep 19, 2016@11:15
DSIO10 ;DSS/TFF - DSIO OBSERVATION;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
OBS(RET,IEN,DFN,DATES,OBJECT,REF,REL,CAT,CODE,VAL,VALCD,NEG,QUAL,NAR,AB) ; RPC: DSIO SAVE OBSERVATION
 ;
 ;    IEN = IF NOT NULL THEN EDIT
 ;    DFN = PATIENT
 ;  DATES = OBSERVATION^START^END
 ; OBJECT = OBJECTS OF OBSERVATION (ARRAY)
 ;          FB.IEN (FETUS/BABY)
 ;          PG.IEN (PREGNANCY)
 ;    REF = OBJECTS OF REFERENCE (ARRAY)
 ;         TIU.IEN (NOTE)
 ;         IHE.IEN (IHE DOCUMENT)
 ;    REL = RELATIONSHIP
 ;    CAT = CATEGORY
 ;   CODE = SYS NAME^SYS VALUE^CODE^DISPLAY NAME
 ;    VAL = TYPE^UNIT^VALUE
 ;  VALCD = SYS NAME^SYS VALUE^CODE^DISPLAY NAME
 ;    NEG = NEGATION (T/F)
 ;   QUAL = QUALIFIERS (ARRAY OF QUALIFIER^VALUE)
 ;    NAR = NARRATIVE (ARRAY OF TEXT)
 ;  **SYS = $S(SYS="LNC":"LOINC",SYS="SCT":"SNOMED-CT",1:SYS)
 ;
 ; RETURN: IEN OR -1^MESSAGE
 ;
 N OBSD,STRT,END,VTYP,VUNT,SYS,CDSV,CDIS,VALCDS,VALCDSV,VALCDIS,IENS,DIK
 N DA,X,Y,IPT,CT,%X,%Y,OIEN
 S DATES=$G(DATES),OBSD=$P(DATES,U),STRT=$P(DATES,U,2),END=$P(DATES,U,3)
 S VAL=$G(VAL)
 S VTYP=$P(VAL,U)                                          ; VALUE TYPE
 S VUNT=$P(VAL,U,2)                                        ; VALUE UNIT
 S VAL=$P(VAL,U,3)                                         ; VALUE
 S NEG=$$UP^XLFSTR($E($G(NEG),1)),NEG=$S(NEG="Y"!(NEG="T")!(NEG=1):1,1:0)  ; NEGATION
 D:'$G(AB) AB^DSIO2("OBSD,STRT,END,REL,CAT,VAL,VTYP,VUNT")
 S:$G(OBSD)'="@" OBSD=$$DT^DSIO2($G(OBSD))                 ; OBSERVATION DATE
 S:$G(STRT)'="@" STRT=$$DT^DSIO2($G(STRT))                 ; START
 S:$G(END)'="@" END=$$DT^DSIO2($G(END))                    ; END
 ; *** CODE (SYS^SYSVAL^CODE^DISPLAY NAME)
 S CODE=$G(CODE)
 S SYS=$$UP^XLFSTR($P(CODE,U))                             ; SYSTEM NAME
 S SYS=$S(SYS="LNC":"LOINC",SYS="SCT":"SNOMED-CT",1:SYS)
 S CDSV=$P(CODE,U,2)                                       ; SYSTEM VALUE
 S CDIS=$P(CODE,U,4)                                       ; DISPLAY NAME
 S CODE=$P(CODE,U,3)                                       ; CODE
 D:'$G(AB) AB^DSIO2("CODE,SYS,CDSV,CDIS")
 I CODE="@"!($G(AB)&('$G(IEN))&(CODE="")) S RET="-1^Code is required" Q
 ; *** VALUE CODE (SYS^SYSVAL^CODE^DISPLAY NAME)
 S VALCD=$G(VALCD)
 S VALCDS=$$UP^XLFSTR($P(VALCD,U))                         ; CODING SYSTEM
 S VALCDS=$S(VALCDS="LNC":"LOINC",VALCDS="SCT":"SNOMED-CT",1:VALCDS)
 S VALCDSV=$P(VALCD,U,2)                                   ; SYSTEM VALUE
 S VALCDIS=$P(VALCD,U,4)                                   ; DISPLAY NAME
 S VALCD=$P(VALCD,U,3)                                     ; CODE
 D:'$G(AB) AB^DSIO2("VALCD,VALCDS,VALCDSV,VALCDIS")
 ; *** Determine to Update or Create New
 S IEN=$G(IEN)
 I 'IEN S IEN=$$OIEN I IEN=-1 S RET="-1^Failed to update observation."  Q
 I 'IEN,'$D(^DPT(+$G(DFN))) S RET="-1^Patient entry not found." Q
 I IEN,OBSD="@" D  Q:$D(RET)
 . I $$GET1^DIQ(19641.12,IEN_",",.09,"I")'="" D  Q
 . . S RET="-1^Observation has already been PUSHed, so it cannot be deleted."
 . S DIK="^DSIO(19641.12,",DA=IEN D ^DIK S RET=1
 S IENS=$S(IEN:IEN_",",1:"+1,") I IENS["+",OBSD="" S OBSD=$$NOW^XLFDT
 S:$G(OBSD)'="" IPT(19641.12,IENS,.01)=OBSD                ; DATE OF OBSERVATION
 S:$G(DFN) IPT(19641.12,IENS,.02)=DFN                      ; PATIENT
 S:$G(CAT)'="" IPT(19641.12,IENS,.03)=CAT                  ; CATEGORY
 S:$G(REL)'="" IPT(19641.12,IENS,.04)=REL                  ; RELATIONSHIP
 S:STRT'="" IPT(19641.12,IENS,.05)=STRT                    ; START
 S:END'="" IPT(19641.12,IENS,.06)=END                      ; END
 S IPT(19641.12,IENS,.07)=DUZ                              ; UPDATED BY
 S IPT(19641.12,IENS,.08)=$$NOW^XLFDT                      ; MODIFIED
 S:VTYP'="" IPT(19641.12,IENS,4.1)=VTYP                    ; VALUE TYPE
 S:VAL'="" IPT(19641.12,IENS,4.2)=VAL                      ; VALUE
 S:VUNT'="" IPT(19641.12,IENS,4.3)=VUNT                    ; VALUE UNIT
 S IPT(19641.12,IENS,4.4)=NEG                              ; NEGATION
 D UPDATE^DIE(,"IPT","IEN") K IPT
 S (RET,IEN)=$S(IEN:IEN,$G(IEN(1)):IEN(1),1:"") I 'IEN S RET="-1^Failed to build observation." Q
 I SYS'="LOINC",SYS'="SNOMED-CT" D LCODE^DSIO2(CODE,SYS,IEN_";DSIO(19641.12,")
 ; *** OBJECTS OF OBSERVATION/OBJECTS OF REFERENCE
 D TOBJ(IEN,.OBJECT,.REF)
 ; *** SAVE CODE AND VALUE CODE
 S IPT(19641.17,"?+1,"_IEN_",",.01)="C"                    ; CODE TYPE
 S:CODE'="" IPT(19641.17,"?+1,"_IEN_",",1)=CODE            ; CODE
 S:CDIS'="" IPT(19641.17,"?+1,"_IEN_",",2)=CDIS            ; DISPLAY NAME
 S:SYS'="" IPT(19641.17,"?+1,"_IEN_",",3)=SYS              ; SYSTEM NAME
 S:CDSV'="" IPT(19641.17,"?+1,"_IEN_",",4)=CDSV            ; SYSTEM VALUE
 D UPDATE^DIE(,"IPT") K IPT
 S IPT(19641.17,"?+1,"_IEN_",",.01)="V"                    ; CODE TYPE
 S:VALCD'="" IPT(19641.17,"?+1,"_IEN_",",1)=VALCD          ; CODE
 S:VALCDIS'="" IPT(19641.17,"?+1,"_IEN_",",2)=VALCDIS      ; DISPLAY NAME
 S:VALCDS'="" IPT(19641.17,"?+1,"_IEN_",",3)=VALCDS        ; SYSTEM NAME
 S:VALCDSV'="" IPT(19641.17,"?+1,"_IEN_",",4)=VALCDSV      ; SYSTEM VALUE
 D UPDATE^DIE(,"IPT") K IPT
 ; *** QUALIFIERS
 S CT=$NA(QUAL) F  S CT=$Q(@CT) Q:CT=""  D
 . S IPT(19641.125,"?+1,"_IEN_",",.01)=$P(@CT,U)
 . S IPT(19641.125,"?+1,"_IEN_",",.02)=$P(@CT,U,2)
 . D UPDATE^DIE(,"IPT") K IPT
 ; *** NARRATIVE
 I $D(NAR)>9 K ^TMP($J,"DSIO OBS") D
 . S %X="NAR(",%Y="^TMP($J,""DSIO OBS"",1" D %XY^%RCR
 . D WP^DIE(19641.12,IEN_",",6,"K","^TMP($J,""DSIO OBS"")")
 . K ^TMP($J,"DSIO OBS")
 D OPUSH(DFN,IEN)
 Q
 ;
OIEN() ; Find the Observation Push configuration record
 ;       Is this Observation required to be updated?
 ;       If it is then return the IEN of the last observation using the data supplied.
 ;
 ; NULL = Not configurated, not enough information, carry on
 ;   -1 = Not allowed to continue
 ;
 N CD,DF,PUSH,CT,I,OBJ,OUT,OIEN,DATE,FDA,MSG
 S CD=$G(CODE),DF=$G(DFN)
 I CD=""&($G(IEN)) S CD=$$GETCODE(IEN,"C",1)
 I DF=""&($G(IEN)) S DF=$$GET1^DIQ(19641.12,IEN_",",.02,"I")
 I CD=""!(DF="") Q ""
 S PUSH=$O(^DSIO(19641.123,"C",CODE,"")) Q:'PUSH ""           ; Not Configured
 Q:'$P($G(^DSIO(19641.123,PUSH,0)),U,5) ""                    ; Update is NOT True
 S CT=$NA(OBJECT) F I=0:1 S CT=$Q(@CT) Q:CT=""  S OBJ(I)=$$OBJECT(@CT)
 D OBG(.OUT,,DF,.OBJ,$G(REF),,,$G(REL),$G(CAT),SYS,CD,"1,1") Q:+$G(@OUT@(0))=0 ""
 S OIEN=$P($G(@OUT@(1,0)),U,2) K @OUT Q:'OIEN "-1"
 I '$G(AB),OBSD="" S OBSD=$$NOW^XLFDT
 S DATE=$$GET1^DIQ(19641.12,OIEN_",",.09,"I") I DATE'="" D  Q:$D(MSG) -1
 . S FDA(19641.127,"?+1,"_OIEN_",",.01)=DATE
 . D UPDATE^DIE(,"FDA",,"MSG") K FDA Q:$D(MSG)
 . S FDA(19641.12,OIEN_",",.09)=""
 . D UPDATE^DIE(,"FDA",,"MSG")
 Q OIEN
 ;       
 ;
TOBJ(IEN,OBJECT,REF) ; Transform Objects of Observation and Reference and Save
 ;
 ; OBJECT = OBJECTS OF OBSERVATION (ARRAY)
 ;          FB.IEN (FETUS/BABY)
 ;          PG.IEN (PREGNANCY)
 ;    REF = OBJECTS OF REFERENCE (ARRAY)
 ;         TIU.IEN (NOTE)
 ;         IHE.IEN (IHE DOCUMENT)
 ;
 N CT,IPT
 ; *** SET UP OBJECTS OF OBSERVATION
 S CT=$NA(OBJECT) F  S CT=$Q(@CT) Q:CT=""  D
 . S IPT(19641.121,"?+1,"_IEN_",",.01)=$$OBJECT(@CT)
 . D UPDATE^DIE(,"IPT") K IPT
 ; *** SAVE OBJECTS OF REFERENCE
 S CT=$NA(REF) F  S CT=$Q(@CT) Q:CT=""  D
 . S IPT(19641.16,"?+1,"_IEN_",",.01)=$$OBJECT(@CT)
 . D UPDATE^DIE(,"IPT") K IPT
 Q
 ;
OBJECT(OBJECT) ; Transform External Object to Internal/ Validate Internal
 N OBJ,IEN,GL
 S (OBJ,IEN)=""
 I $G(OBJECT)?.A1".".N D
 . S OBJ=$P(OBJECT,"."),IEN=$P(OBJECT,".",2)
 . S OBJ=$S(OBJ="FB":"DSIO(19641.112,",OBJ="PG":"DSIO(19641.13,",OBJ="TIU":"TIU(8925,",OBJ="IHE":"DSIO(19641.6,",1:"")
 S:OBJ=""&($G(OBJECT)[";") OBJ=$P(OBJECT,";",2),IEN=+OBJECT
 Q:OBJ=""!('IEN) ""
 S GL=U_OBJ_+IEN_")" Q:$D(@GL) +IEN_";"_OBJ
 Q ""
 ;
OPUSH(DFN,OIEN) ; Push Observation
 N CODE,X,VAL,IEN,INPUT,ROU,RET,IPT
 S CODE=$$GETCODE(OIEN,"C",1) Q:CODE=""
 S (X,VAL)=$$UP^XLFSTR($$GET1^DIQ(19641.12,OIEN_",",4.2))
 Q:$$GET1^DIQ(19641.12,OIEN_",",.09,"I")'=""      ; *** ALREADY PUSHED
 S IEN=$O(^DSIO(19641.123,"C",CODE,"")) Q:IEN=""
 S INPUT=$$GET1^DIQ(19641.123,IEN_",",1)
 S ROU=$$GET1^DIQ(19641.123,IEN_",",2) Q:ROU=""
 S TMP=$NA(^TMP($J,"SETDATA VALUE")) K @TMP
 X:INPUT'="" INPUT X:ROU'="" ROU
 S RET=$$HISTORY^DSIO6(IEN_";DSIO(19641.123,",DFN_";DPT(",ROU)
 I RET D
 . S IPT(19641.12,OIEN_",",.09)=$$GET1^DIQ(19641.124,RET_",",.01,"I")
 . D UPDATE^DIE(,"IPT") K IPT
 D OPDEL(IEN,OIEN,RET)
 Q
 ;
GETCODE(IEN,IX,PC) ; Get Observation Code from Codes Multiple
 N IENS
 S PC=+$G(PC)
 S IENS=$O(^DSIO(19641.12,IEN,3,"B",IX,"")) Q:IENS="" ""
 Q $G(^DSIO(19641.12,IEN,3,IENS,PC))
 ;
OPDEL(PUSH,OIEN,HIS) ; Delete Actions
 ;
 ; Some observations may be non-clinical in nature and be set to be deleted
 ; after the data is pushed.
 ;   1 TRUE = DELETE THE OBSERVATION
 ;   2 BOTH = DELETE THE OBSERVATION AND HISTORY
 ;
 N DEL,DIK,DA,X,Y
 S DEL=$$GET1^DIQ(19641.123,PUSH_",",.04,"I") Q:'DEL
 S DIK="^DSIO(19641.12,",DA=OIEN D ^DIK
 I DEL=2 K DIK,DA,X,Y S DIK="^DSIO(19641.124,",DA=HIS D ^DIK
 Q
 ;
OBG(RET,IEN,DFN,OBJECT,REF,FDT,TDT,REL,CAT,SYS,CODE,SORT) ; RPC: DSIO GET OBSERVATIONS
 ;
 ;    IEN = IF NOT NULL THEN RETURN ONLY
 ; OBJECT = OBJECTS OF OBSERVATION (ARRAY)
 ;          FB.IEN (FETUS/BABY)
 ;          PG.IEN (PREGNANCY)
 ;    REF = OBJECTS OF REFERENCE (ARRAY)
 ;         TIU.IEN (NOTE)
 ;         IHE.IEN (IHE DOCUMENT)
 ; *** OBJECT AND REF - The entry must have at least the provided values
 ;    FDT = FROM DATE
 ;    TDT = TO DATE
 ;    REL = RELATIONSHIP
 ;    CAT = CATEGORY
 ;    SYS = CODING SYSTEM
 ;          **SYS = $S(SYS="LNC":"LOINC",SYS="SCT":"SNOMED-CT",1:SYS)
 ;
 ; RETURN:
 ;  L^IEN^DFN^DATE^OBJ OF OBS;EXTERNAL VALUE|...^OBJ OF REF;EXTERNAL VALUE|...^
 ;    REL^CAT^START^END^PUSHED^CODE^SYS^SYS VALUE^DISPLAY NAME^VALUE CODE^
 ;    VALUE SYS^VALUE SYS VALUE^VALUE DISPLAY NAME^VALUE TYPE^VALUE^VALUE UNIT^
 ;    NEGATION^UPDATED BY^MODIFIED DATE^QUALIFIERS(NAME;VALUE)|...
 ;  C^IEN^NARRATIVE
 ;
 N RCT,TS,DATE,STRT,END
 S RET=$NA(^TMP($J,"DSIO OBG")) K @RET S @RET@(0)="0^Nothing found."
 I $G(IEN) D FLDS(IEN,1) S:$D(@RET@(1)) @RET@(0)=1 Q
 I '$D(^DPT(+$G(DFN))) S @RET@(0)="-1^Patient entry not found." Q
 D OBJL(.OBJECT),OBJL(.REF),SORT($G(SORT))
 ; *** RANGE
 S FDT=$S($G(FDT)'="":$$FMADD^XLFDT($$DT^DSIO2(FDT),,,,-1),1:"")
 S TDT=$$DT^DSIO2($G(TDT)) S:TDT="" TDT=$$NOW^XLFDT
 ; *** FILTERS
 S REL=$$UP^XLFSTR($G(REL)),CAT=$$UP^XLFSTR($G(CAT))
 S SYS=$$UP^XLFSTR($G(SYS)),CODE=$G(CODE)
 S SYS=$S(SYS="LNC":"LOINC",SYS="SCT":"SNOMED-CT",1:SYS)
 S (RCT,TS)=0,DATE=FDT
 F  S DATE=$O(^DSIO(19641.12,"P",DFN,DATE)) Q:DATE=""  Q:DATE>TDT  D
 . S IEN="" F  S IEN=$O(^DSIO(19641.12,"P",DFN,DATE,IEN)) Q:IEN=""  D
 . . ; *** OBJECT AND REF - The entry must have at least the provided values
 . . I $D(OBJECT) Q:$$CONTAIN(IEN,.OBJECT,1)
 . . I $D(REF) Q:$$CONTAIN(IEN,.REF,2)
 . . I CODE'="",$$GETCODE(IEN,"C",1)'=CODE Q
 . . I SYS'="",$$GETCODE(IEN,"C",3)'=SYS Q
 . . I REL'="",$$UP^XLFSTR($$GET1^DIQ(19641.12,IEN_",",.04))'=REL Q
 . . I CAT'="",$$UP^XLFSTR($$GET1^DIQ(19641.12,IEN_",",.03))'=CAT Q
 . . S TS=TS+1 I STRT'="",TS'>STRT Q
 . . S RCT=RCT+1 I END'="",RCT>END Q
 . . D FLDS(IEN,RCT)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
CONTAIN(IEN,VALS,ND) ; Does the entry contain all objects?
 N CT,FLG
 S CT="" F  S CT=$O(VALS(CT)) Q:CT=""  D  Q:$D(FLG)
 . I '$D(^DSIO(19641.12,IEN,ND,"B",CT)) S FLG=1
 Q $D(FLG)
 ;
OBJL(ARY) ; Prep Object List
 N CT,OUT,NEW
 S CT=$NA(ARY) F  S CT=$Q(@CT) Q:CT=""  D
 . S OUT=$$OBJECT(@CT) I OUT'="" S NEW(OUT)=""
 K ARY I $D(NEW) M ARY=NEW
 Q
 ;
FLDS(IEN,ND) ; Continue
 N OUT,LINE,FLD,STR
 D GETS^DIQ(19641.12,IEN_",","*","IE","OUT") Q:'$D(OUT)
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR="L^"_IEN_U
 S STR=STR_FLD(.02,"I")_U                               ; DFN
 S STR=STR_$$FMTE^XLFDT(FLD(.01,"I"),"5Z")_U            ; DATE OF OBSERVATION
 S STR=STR_$$OBJ(IEN,1)_U                               ; OBJECTS OF OBSERVATION
 S STR=STR_$$OBJ(IEN,2)_U                               ; OBJECTS OF REFERENCE
 S STR=STR_FLD(.04,"I")_U                               ; RELATIONSHIP
 S STR=STR_FLD(.03,"I")_U                               ; CATEGORY
 S STR=STR_$$FMTE^XLFDT(FLD(.05,"I"),"5Z")_U            ; START
 S STR=STR_$$FMTE^XLFDT(FLD(.06,"I"),"5Z")_U            ; END
 S STR=STR_$$FMTE^XLFDT(FLD(.09,"I"),"5Z")_U            ; PUSHED
 S STR=STR_$$GETCODE(IEN,"C",1)_U                       ; CODE
 S STR=STR_$$GETCODE(IEN,"C",3)_U                       ; CODE SYSTEM NAME
 S STR=STR_$$GETCODE(IEN,"C",4)_U                       ; CODE SYSTEM VALUE
 S STR=STR_$$GETCODE(IEN,"C",2)_U                       ; CODE DISPLAY NAME
 S STR=STR_$$GETCODE(IEN,"V",1)_U                       ; VALUE CODE
 S STR=STR_$$GETCODE(IEN,"V",3)_U                       ; VALUE SYSTEM NAME
 S STR=STR_$$GETCODE(IEN,"V",4)_U                       ; VALUE SYSTEM VALUE
 S STR=STR_$$GETCODE(IEN,"V",2)_U                       ; VALUE DISPLAY NAME
 S STR=STR_FLD(4.1,"I")_U                               ; VALUE TYPE
 S STR=STR_FLD(4.2,"I")_U                               ; VALUE
 S STR=STR_FLD(4.3,"I")_U                               ; VALUE UNIT
 S STR=STR_FLD(4.4,"E")_U                               ; NEGATION
 S STR=STR_$$NAME^DSIO2(FLD(.07,"E"))_U                 ; UPDATED BY
 S STR=STR_$$FMTE^XLFDT(FLD(.08,"I"),"5Z")_U            ; MODIFIED DATE
 S STR=STR_$$QUAL(IEN)                                  ; QUALIFIERS
 S @RET@(ND,0)=STR
 S LINE=0 F  S LINE=$O(FLD(6,LINE)) Q:'LINE  S @RET@(ND,LINE)="C^"_IEN_U_FLD(6,LINE)
 Q
 ;
OBJ(IEN,ND) ; OBJECTS
 N OBJ,Q,STR
 D GETS^DIQ(19641.12,IEN_",",ND_"*","I","OBJ")
 S Q=$NA(OBJ) F  S Q=$Q(@Q) Q:Q=""  D
 . S STR=$G(STR)_$$EOBJ(@Q)_"|"
 Q $E($G(STR),1,($L($G(STR))-1))
 ;
EOBJ(OBJ) ; Transform to External Form
 N STR
 S STR=$S(OBJ[8925:"TIU."_+OBJ,OBJ[19641.6:"IHE."_+OBJ,OBJ[19641.13:"PG."_+OBJ,OBJ[19641.112:"FB."_+OBJ,1:"")
 S:STR'="" STR=STR_";"_$$GET1^DIQ($TR($P(OBJ,"(",2),","),+OBJ_",",.01)
 Q STR
 ;
QUAL(IEN) ; QUALIFIERS
 N QUAL,Q,STR
 D GETS^DIQ(19641.12,IEN_",","5*","I","QUAL")
 S Q=$NA(QUAL) F  S Q=$Q(@Q) Q:Q=""  D
 . S STR=$G(STR)_$$TITLE^XLFSTR(@Q)
 . I $QS(Q,3)=".01" S STR=STR_";"
 . I $QS(Q,3)=".02" S STR=STR_"|"
 Q $E($G(STR),1,($L($G(STR))-1))
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
