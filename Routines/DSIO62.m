Routine DSIO62 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO62^INT^64180,40956^Sep 19, 2016@11:22
DSIO62 ;DSS/TFF - DSIO DDCS SPECIAL LOOKUP;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$GOON^VALM1
 ;
 ; *** VIEW OPTION FOR DSIO DDCS DATA ***
 ; *** VIEW OPTION FOR DSIO DDCS SHARED DATA ***
 ; *** VIEW OPTION FOR DSIO DDCS ELEMENT ***
 ;
VIEW ; Display Selection Only
 N SCR,RECORD,IEN,OUT,CONTROL,DFLD,DFN,CT,TYPE,FLD,DATA,LINE,GOON
 S SCR="I $D(^DSIO(19641.4,""D"",Y))"
 S RECORD=$$RECORD^DSIO61("Select DESTINATION FILE",SCR) Q:RECORD=""
 S IEN=$O(^DSIO(19641.41,"B",RECORD,"")) Q:'IEN
 W !,$$REPEAT^XLFSTR("=",79)
 S CONTROL=$$GET1^DIQ(19641.41,IEN_",",.02)
 ; *** Get DFN for SHARED DATA Collection
 S DFN=$$DFN^DSIO6(CONTROL,+RECORD)
 W !," CONTROLLED BY: ",CONTROL,!
 W "        PUSHED: ",$$FMTE^XLFDT($$GET1^DIQ(19641.41,IEN_",",.03),"5Z"),!
 S LINE=3 D GETS^DIQ(19641.41,IEN_",","1*","I","OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  D
 . S TYPE=$S($L($QS(CT,1))=10:"D",1:"I")
 . I TYPE="D" D  Q
 . . S FLD(TYPE,$P($QS(CT,2),",",2),$O(FLD(TYPE,$P($QS(CT,2),",",2),""),-1)+1)=@CT
 . S FLD(TYPE,+$QS(CT,2),$O(FLD(TYPE,+$QS(CT,2),""),-1)+1)=@CT
 S CT=0 F  S CT=$O(FLD("I",CT)) Q:'CT  D  Q:$D(GOON)
 . W !," INTERFACE: ",FLD("I",CT,1) Q:$$GOON
 . W !,"    SHARED: ",$S(FLD("I",CT,2)=1:"YES",1:"NO"),!! Q:$$GOON
 . W " DATA -----------------------------------------",! Q:$$GOON
 . S DATA=0 F  S DATA=$O(FLD("D",CT,DATA)) Q:'DATA  D  Q:$D(GOON)
 . . D DATA(FLD("D",CT,DATA))
 . ; *** DATA is within the DSIO DDCS SHARED DATA File
 . ;     However, this file is by Interface by DFN and not by Record
 . D SHARE(DFN,FLD("I",CT,1))
 Q
 ;
GOON() ; Check LINE count and add page break, quit if the user wishes to do so
 S LINE=LINE+1
 I '(LINE#17),'$$GOON^VALM1 S GOON=1
 Q $S($D(GOON):1,1:0)
 ;
SHARE(DFN,INFACE) ; Get SHARED DATA via DFN and INTERFACE
 Q:'$G(DFN)!($G(INFACE)="")
 N IEN,OUT,CT
 S IEN=$O(^DSIO(19641.4941,DFN,1,"B",INFACE,"")) Q:'IEN
 D GETS^DIQ(19641.49411,IEN_","_DFN_",","1*","I","OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  D DATA(@CT)
 Q
 ;
DATA(IEN) ; DSIO DDCS ELEMENT (19641.45)
 N OUT,CT,FLD
 D GETS^DIQ(19641.45,IEN_",","**","E","OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S FLD($QS(CT,3))=@CT
 W !," -- CONTROL: ",FLD(.01),! Q:$$GOON
 W "      CLASS: ",FLD(.02),! Q:$$GOON
 W "    VALUE -------------------------------------",! Q:$$GOON
 S CT=0 F  S CT=$O(^DSIO(19641.45,IEN,1,CT)) Q:'CT  D  Q:$D(GOON)
 . W "          ",^DSIO(19641.45,IEN,1,CT,0),! Q:$$GOON
 Q
 ;
 ; --------------------------------- UTILITIES --------------------------------
 ;
GET1(IEN) ; Return single line of data
 N OUT,CLASS,CT
 S OUT=$G(^DSIO(19641.45,+$G(IEN),1,1,0)) Q:OUT="" OUT
 S CLASS=$$GET1^DIQ(19641.45,$G(IEN)_",",.03,"I") Q:'CLASS OUT
 Q:$$GET1^DIQ(19641.425,CLASS_",",.03,"I") $$LS
 Q OUT
 ;
EGET1(NAM) ; Element Value
 Q $P($$GET1^DSIO62($$IEN^DSIO62(NAM)),U,2)
 ;
TGET1(NAM) ; True/False Value
 Q $S($$UP^XLFSTR($P($$GET1^DSIO62($$IEN^DSIO62(NAM)),U))="TRUE":1,1:0)
 ;
LS() ; Clean up List type elements
 N I,STR,OUT
 S I=0 F  S I=$O(^DSIO(19641.45,+$G(IEN),1,I)) Q:'I  D  Q:$D(OUT)
 . S STR=$G(^DSIO(19641.45,+$G(IEN),1,I,0)) Q:STR=""
 . I $P(STR,U)["TRUE" S OUT=$P(STR,U,2)
 Q $G(OUT)
 ;
TXT(RET,IEN) ; Return array of data without the leading caret
 N CT,STR
 S CT=0 F  S CT=$O(^DSIO(19641.45,+$G(IEN),1,CT)) Q:'CT  D
 . S STR=^DSIO(19641.45,IEN,1,CT,0) S:$E(STR,1)=U STR=$E(STR,2,$L(STR))
 . S RET(CT)=STR
 Q
 ;
GETS(RET,IEN) ; Return array of data
 N CT
 S CT=0 F  S CT=$O(^DSIO(19641.45,+$G(IEN),1,CT)) Q:'CT  D
 . S RET(CT)=^DSIO(19641.45,IEN,1,CT,0)
 Q
 ;
WGETS(RET,IEN) ; Return array of data without leading carets
 N CT
 S CT=0 F  S CT=$O(^DSIO(19641.45,+$G(IEN),1,CT)) Q:'CT  D
 . S RET(CT)=$P(^DSIO(19641.45,IEN,1,CT,0),U,2,999)
 Q
 ;
IEN(NAM) ; Get a Control IEN for 19641.45
 N TMP
 S TMP=$O(^DSIO(19641.41,+$G(DATA),1,+$G(FIEN),1,"C",NAM,"")) Q:'TMP 0
 Q +$G(^DSIO(19641.41,+$G(DATA),1,+$G(FIEN),1,TMP,0))
 ;
CCLASS(FORM,NAM) ; Get the class of a Control
 Q:'$G(FORM)!($G(NAM)="") 0
 N PG,IEN,CLASS
 I FORM[";DSIO(19641.42," D
 . S PG=$O(^DSIO(19641.42,+FORM,1,"CONTROL",NAM,"")) Q:'PG
 . S ELE=$O(^DSIO(19641.42,+FORM,1,"CONTROL",NAM,PG,"")) Q:'ELE
 . S CLASS=$P($G(^DSIO(19641.42,+FORM,1,PG,1,ELE,0)),U,2)
 I FORM[";DSIO(19641.49," D
 . S ELE=$O(^DSIO(19641.49,+FORM,1,"B",NAM,"")) Q:'ELE
 . S CLASS=$P($G(^DSIO(19641.49,+FORM,1,ELE,0)),U,2)
 Q $S($G(CLASS):CLASS,1:0)
 ;
LIST(FORM,NAM) ; Is a class marked as a list?
 Q:'$G(FORM)!($G(NAM)="") 0
 N CLASS S CLASS=$$CCLASS(FORM,NAM) Q:'CLASS 0
 Q +$$GET1^DIQ(19641.425,CLASS_",",.03,"I")
 ;
CHECK(FORM,NAM) ; Is a class marked as a Check
 Q:'$G(FORM)!($G(NAM)="") 0
 N CLASS S CLASS=$$CCLASS(FORM,NAM) Q:'CLASS 0
 Q +$$GET1^DIQ(19641.425,CLASS_",",.04,"I")
