DSIO9 ;DSS/TFF - DSIO PERSON;08/26/2016 16:00
 ;;3.0;MATERNITY TRACKER;;Feb 02, 2017;Build 1
 ;
 ;
 ;
 Q
 ;
SAVE(RET,IEN,DFN,NAME,DOB,ADDR,PHONE,EDU,SEX,REL,STATUS,PROB,AB) ; RPC: DSIO SAVE PERSON
 ;
 ;    IEN = IEN of 19641.11
 ;    DFN = PATIENT IEN
 ;   NAME = PERSON NAME (LAST,FIRST)
 ;    DOB = DATE OF BIRTH
 ;   ADDR = ARRAY OF LABELS: 1,2,3,CITY,STATE,ZIP
 ;  PHONE = ARRAY OF LABLES: H,MC,WP,FAX,O
 ;    EDU = NUMBER OF YEARS OF EDUCATION
 ;    SEX = M,F,U
 ;    REL = P:408.11
 ; STATUS = L,D
 ;   PROB = ARRAY OF ENTRIES (PROBLEMS)
 ;
 ; RETURN: IEN OR -1^MESSAGE
 ;
 N FDA,CT,LOC,VAL,UIEN,ERR
 S DFN=+$G(DFN) S:'DFN!('$D(^DPT(DFN))) DFN=""
 I '$G(IEN),'$$CHECK^DSIO2(DFN) S RET="-1^Patient entry not found." Q
 S NAME=$$UP^XLFSTR($G(NAME))
 S DOB=$$DT^DSIO2($G(DOB)),EDU=+$G(EDU)
 S SEX=$$UP^XLFSTR($E($G(SEX),1)) S:"^M^F^U^"'[(U_SEX_U) SEX=""
 S REL=$$FIND1^DIC(408.11,,"X",$$UP^XLFSTR($G(REL))) S:'REL REL=""
 S STATUS=$$UP^XLFSTR($E($G(STATUS),1)) S:"^L^D^"'[(U_STATUS_U) STATUS=""
 D:'$G(AB) AB^DSIO2("DFN,NAME,DOB,ADDR,PHONE,EDU,SEX,REL,STATUS")
 I $G(IEN) S IEN=IEN_","
 E  I NAME'="",NAME'="@",DFN,$O(^DSIO(19641.11,"C",DFN,NAME,"")) D
 . S IEN=$O(^DSIO(19641.11,"C",DFN,NAME,""))_","
 E  S IEN="?+1,"
 S:$G(NAME)'="" FDA(19641.11,IEN,.01)=NAME             ; NAME
 S:$G(SEX)'="" FDA(19641.11,IEN,.02)=SEX               ; SEX
 S:$G(DOB)'="" FDA(19641.11,IEN,.03)=DOB               ; DATE OF BIRTH
 S:$G(EDU)'="" FDA(19641.11,IEN,.04)=EDU               ; EDUCATION
 S:$G(DFN)'="" FDA(19641.11,IEN,.05)=$S(DFN'="@":"`",1:"")_DFN  ; PATIENT
 S:$G(REL)'="" FDA(19641.11,IEN,.06)=$S(REL'="@":"`",1:"")_REL  ; RELATIONSHIP
 S:$G(STATUS)'="" FDA(19641.11,IEN,.07)=STATUS         ; STATUS
 I $D(ADDR) D
 . S CT=$NA(ADDR) F  S CT=$Q(@CT) Q:CT=""  D               ; ADDRESS
 . . S LOC=$$UP^XLFSTR($P(@CT,U)),VAL=$P(@CT,U,2)
 . . I LOC[1 S FDA(19641.11,IEN,1.1)=VAL Q                 ; STREET ADDRESS 1
 . . I LOC[2 S FDA(19641.11,IEN,1.2)=VAL Q                 ; STREET ADDRESS 2
 . . I LOC[3 S FDA(19641.11,IEN,1.3)=VAL Q                 ; STREET ADDRESS 3
 . . I LOC="CITY" S FDA(19641.11,IEN,1.4)=VAL Q            ; CITY
 . . I LOC="STATE" D  Q                                    ; STATE
 . . . S VAL=$$FIND1^DIC(5,,"XM",$$UP^XLFSTR(VAL))
 . . . S:VAL FDA(19641.11,IEN,1.5)="`"_VAL
 . . I LOC="ZIP" S FDA(19641.11,IEN,1.6)=VAL               ; ZIP CODE
 D UPDATE^DIE("E","FDA","UIEN","ERR") K FDA
 I $D(ERR) S RET="-1^"_$G(ERR("DIERR",1,"TEXT",1)) Q
 S RET=$S($G(UIEN(1)):UIEN(1),1:+IEN)
 I $D(PHONE) D  Q:$D(ERR)                                  ; PHONE
 . S CT=$NA(PHONE) F  S CT=$Q(@CT) Q:CT=""  D  Q:$D(ERR)
 . . S LOC=$$UP^XLFSTR($P(@CT,U)) Q:"^H^MC^WP^FAX^O^"'[(U_LOC_U)
 . . S VAL=$TR($P(@CT,U,2),"()- ")
 . . S IEN=$O(^DSIO(19641.11,+RET,2,"B",LOC,"")) S:IEN="" IEN="?+1"
 . . S FDA(19641.14,IEN_","_+RET_",",.01)=LOC              ; PHONE TYPE
 . . S FDA(19641.14,IEN_","_+RET_",",.02)=VAL              ; NUMBER
 . . D UPDATE^DIE("E","FDA",,"ERR") K FDA
 . . S:$D(ERR) RET="-1^"_$G(ERR("DIERR",1,"TEXT",1))
 ; *** DIAGNOSIS MULTIPLE
 I $D(PROB) D DEL(+RET) D
 . S CT=$NA(PROB) F  S CT=$Q(@CT) Q:CT=""  D  Q:$D(ERR)
 . . S FDA(19641.113,"?+1,"_+RET_",",.01)=$$UP^XLFSTR(@CT)
 . . D UPDATE^DIE("E","FDA",,"ERR") K FDA
 . . S:$D(ERR) RET="-1^"_$G(ERR("DIERR",1,"TEXT",1))
 Q
 ;
DEL(IEN) ; Delete DIAGNOSIS Multiple
 N OUT,DA,DIK,CT
 D GETS^DIQ(19641.11,IEN_",","3*",,"OUT")
 S DA(1)=IEN,DIK="^DSIO(19641.11,"_DA(1)_",3,"
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S DA=+$QS(CT,2) D ^DIK
 Q
 ;
PERSON(RET,DFN,FIND,SEX) ; RPC: DSIO GET PERSON
 ;
 ; IF SEX ADD
 ; ^RELATIONSHIP^STATUS^DIAGNOSIS|DIAGNOSIS
 ;
 ; IF SPOUSE THEN IEN = "S"
 ; IF SEX = 1 THEN DON'T RESTRICT TO FATHER OF FETUS
 ;
 ; IF DFN & FIND=""  THEN
 ;  - All associated Entries
 ; IF DFN & FIND="S" THEN
 ;  - SPOUSE
 ; IF DFN & FIND="NAME,NAME" OR FIND=#(IEN) THEN
 ;  - RETURN IF FOUND AND IF ASSOCIATED TO PATIENT
 ; IF 'DFN & FIND="NAME,NAME" OR FIND=#(IEN) THEN
 ;  - RETURN ENTRIES
 ;
 ; RETURN:
 ;  IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^
 ;  ZIP^PHONE HOME^PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN
 ;
 N IEN,NAM,CT,SP
 S SEX=$G(SEX),RET(0)="-1^PERSON(s) not found."
 I $G(DFN) D  D P3 Q
 . I $G(FIND) D  Q
 . . Q:'$$P2(FIND)
 . . S RET(1)=$$P1(FIND)
 . I $G(FIND)'="" D  Q
 . . I FIND="S"!(FIND="SPOUSE") D  Q
 . . . S SP=$$SPOUSE(DFN) Q:'SP
 . . . D PO(SP)
 . . S IEN=$O(^DSIO(19641.11,"B",$$UP^XLFSTR(FIND),""))
 . . I IEN,$$P2(IEN) S RET(1)=$$P1(IEN)
 . S CT=1,NAM="" F  S NAM=$O(^DSIO(19641.11,"C",DFN,NAM)) Q:NAM=""  D
 . . S IEN=$O(^DSIO(19641.11,"C",DFN,NAM,""))
 . . I $G(SEX)="" D  Q
 . . . Q:$$GET1^DIQ(19641.11,IEN_",",.02,"I")'="M"
 . . . S RET(CT)=$$P1(IEN),CT=CT+1
 . . S:$$GET1^DIQ(19641.11,IEN_",",.02,"I")=SEX RET(CT)=$$P1(IEN),CT=CT+1
 . S SP=$$SPOUSE(DFN) D:SP PO(SP)
 ; *** Find the PERSON
 I $G(FIND),$D(^DSIO(19641.11,FIND)) S RET(1)=$$P1(FIND) D P3 Q
 I $G(FIND)'="" S IEN=$O(^DSIO(19641.11,"B",$$UP^XLFSTR(FIND),"")) D  Q
 . I IEN S RET(1)=$$P1(IEN) D P3
 Q
 ;
P1(IEN) ; Continue with 19641.11
 N OUT,LINE,FLD,STR
 D GETS^DIQ(19641.11,IEN_",","*","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=IEN_U
 S STR=STR_$$NAME^DSIO2(FLD(.01,"I"))_U                     ; NAME
 S STR=STR_FLD(.02,"E")_U                                   ; SEX
 S STR=STR_$$FMTE^XLFDT(FLD(.03,"I"),"5Z")_U                ; DATE OF BIRTH
 S STR=STR_FLD(.04,"I")_U                                   ; EDUCATION
 S STR=STR_FLD(1.1,"I")_U                                   ; STREET 1
 S STR=STR_FLD(1.2,"I")_U                                   ; STREET 2
 S STR=STR_FLD(1.3,"I")_U                                   ; STREET 3
 S STR=STR_FLD(1.4,"I")_U                                   ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(1.5,"I")_",",1)_U               ; STATE
 S STR=STR_FLD(1.6,"I")_U                                   ; ZIP
 S STR=STR_$$PHONE^DSIO1(19641.11,IEN)_U                    ; PHONE NUMBERS 
 S STR=STR_$$NAME^DSIO2(FLD(.05,"E"))_U                     ; PATIENT
 S STR=STR_FLD(.05,"I")                                     ; DFN
 S STR=STR_U_FLD(.06,"E")_U                                 ; RELATIONSHIP
 S STR=STR_FLD(.07,"E")_U                                   ; STATUS
 S STR=STR_$$DG(IEN)                                        ; DIAGNOSIS
 Q STR
 ;
PO(OBJECT) ; Continue with Other
 N FLE,IEN,FLDS,OUT,LINE,FLD
 S FLE=$TR($P($G(OBJECT),"(",2),",") I OBJECT[";DPT(" S FLE=2
 S IEN=+$G(OBJECT)
 S:FLE=2 FLDS=".01;.02;.03;.111;.112;.113;.114;.115;.116;.131;.134;.132"
 D GETS^DIQ(FLE,IEN_",",$S($D(FLDS):FLDS,1:"*"),"IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 I FLE=2 S RET($O(RET(""),-1)+1)=$$PO2 Q
 I FLE=408.13 S RET($O(RET(""),-1)+1)=$$PO408
 Q
 ;
PO2() ; Continue with Other for 2
 N STR
 S STR="S^"
 S STR=STR_$$NAME^DSIO2(FLD(.01,"I"))_U                     ; NAME
 S STR=STR_FLD(.02,"E")_U                                   ; SEX
 S STR=STR_$$FMTE^XLFDT(FLD(.03,"I"),"5Z")_U                ; DATE OF BIRTH
 S STR=STR_U                                                ; EDUCATION
 S STR=STR_FLD(.111,"I")_U                                  ; STREET 1
 S STR=STR_FLD(.112,"I")_U                                  ; STREET 2
 S STR=STR_FLD(.113,"I")_U                                  ; STREET 3
 S STR=STR_FLD(.114,"I")_U                                  ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(.115,"I")_",",1)_U              ; STATE
 S STR=STR_FLD(.116,"I")_U                                  ; ZIP
 S STR=STR_$$FORMAT^DSIO2(FLD(.131,"I"))_U                  ; PHONE (HOME)
 S STR=STR_$$FORMAT^DSIO2(FLD(.132,"I"))_U                  ; PHONE (WORK)
 S STR=STR_$$FORMAT^DSIO2(FLD(.134,"I"))_U                  ; PHONE (CELL)
 S STR=STR_U                                                ; PHONE (FAX)
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN_",",.01))_U        ; PATIENT
 S STR=STR_DFN                                              ; DFN
 Q STR
 ;
PO408() ; Continue with Other for 408.13
 N STR
 S STR="S^"
 S STR=STR_$$NAME^DSIO2(FLD(.01,"I"))_U                     ; NAME
 S STR=STR_FLD(.02,"E")_U                                   ; SEX
 S STR=STR_$$FMTE^XLFDT(FLD(.03,"I"),"5Z")_U                ; DATE OF BIRTH
 S STR=STR_U                                                ; EDUCATION
 S STR=STR_FLD(1.2,"I")_U                                   ; STREET 1
 S STR=STR_FLD(1.3,"I")_U                                   ; STREET 2
 S STR=STR_FLD(1.4,"I")_U                                   ; STREET 3
 S STR=STR_FLD(1.5,"I")_U                                   ; CITY
 S STR=STR_$$GET1^DIQ(5,FLD(1.6,"I")_",",1)_U               ; STATE
 S STR=STR_FLD(1.7,"I")_U                                   ; ZIP
 S STR=STR_$$FORMAT^DSIO2(FLD(1.8,"I"))_U                   ; PHONE (HOME)
 S STR=STR_U                                                ; PHONE (WORK)
 S STR=STR_U                                                ; PHONE (CELL)
 S STR=STR_U                                                ; PHONE (FAX)
 S STR=STR_$$NAME^DSIO2($$GET1^DIQ(2,DFN_",",.01))_U        ; PATIENT
 S STR=STR_DFN                                              ; DFN
 Q STR
 ;
DG(IEN) ; Add DIAGNOSIS to DSIO PERSON return
 N OUT,CT,FLD,STR
 D GETS^DIQ(19641.11,IEN_",","3*",,"OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S STR=$G(STR)_@CT_"|"
 Q $E($G(STR),1,($L($G(STR))-1))
 ;
P2(IEN) ; Check if associated patient
 I $$GET1^DIQ(19641.11,IEN_",",.05,"I")'=DFN D  Q 0
 . S RET(0)="-1^PERSON not associated with PATIENT."
 Q 1
 ;
P3 ; End
 S:$O(RET(""),-1) RET(0)=$O(RET(""),-1)
 Q
 ;
SPOUSE(DFN) ; Get Spouse
 Q:'$G(DFN) 0
 N IEN,FLG
 S IEN=0 F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:'IEN  D  Q:$D(FLG)
 . Q:$$GET1^DIQ(408.12,IEN_",",.02)'="SPOUSE"
 . S FLG=$$GET1^DIQ(408.12,IEN_",",.03,"I")
 Q $S($D(FLG):FLG,1:0)
 ;
SPN(DFN) ; Return Spouse Name
 N SP S SP=$$SPOUSE($G(DFN)) Q:'SP ""
 Q $$GET1^DIQ($S(SP[";DPT(":2,1:$TR($P(SP,"(",2),",")),+SP,.01)
 ;
 ; --------------------- PREGNANCY HISTORY FOF Input Transform
 ;
FOF(DFN,FOF) ; Get DSIO PERSON IEN
 N RET
 S FOF=$$UP^XLFSTR($G(FOF))
 Q:FOF=""!(FOF="U")!(FOF="UNSPECIFIED") "UNSPECIFIED|U"
 D PERSON(.RET,$G(DFN),FOF) Q:'$D(RET(1)) "UNSPECIFIED|U"
 Q:$P($G(RET(1)),U)!($P($G(RET(1)),U)="S") $$UP^XLFSTR($P(RET(1),U,2))_"|"_$P(RET(1),U)
 Q "UNSPECIFIED|U"
