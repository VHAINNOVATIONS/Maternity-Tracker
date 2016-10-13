Routine DSIO61 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO61^INT^64180,40924^Sep 19, 2016@11:22
DSIO61 ;DSS/TFF - DSIO DDCS SPECIAL LOOKUP;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$GOON^VALM1
 ;
 ; *** SET AND VIEW OPTION FOR DSIO DDCS CONTROL ***
 ;
SET ; Editor for 19641.4
 N RECORD,DA,DIE,DR,X,Y,FDA,IEN,DFLE,PFLD
 S RECORD=$$RECORD("Select the FILE to Control") Q:RECORD=""
S1 ; Continue
 ; *** Build like a Variable Pointer
 S FDA(19641.4,"?+1,",.01)=RECORD
 D UPDATE^DIE(,"FDA","IEN") K FDA Q:'$G(IEN(1))
 D VIEW(IEN(1))
 ; *** Edit Entry
 S DA=IEN(1),DIE="^DSIO(19641.4,",DR=".02;.03;.04" D ^DIE
 ; *** PATIENT ORIENTED
 I $$GET1^DIQ(19641.4,IEN(1)_",",.04,"I") D
 . S DFLE=$$GET1^DIQ(19641.4,IEN(1)_",",.03,"I")
 . I DFLE="" W !,"***Destination file required.",! D  Q
 . . S DR=".04////0" D ^DIE
 . S PFLD=$$FIELDS("PATIENT FIELD",$$GET1^DIQ(19641.4,IEN(1)_",",.05),DFLE)
 . S DR=".05////"_$S(PFLD="":"@",1:PFLD) D ^DIE
 . I '$$GET1^DIQ(19641.4,IEN(1)_",",.05,"I") D
 . . W !!,"If no patient field then excute M code to lookup the Patient DFN.",!!
 . . S DR=1 D ^DIE
 . I $$GET1^DIQ(19641.4,IEN(1)_",",.05,"I")="",$$GET1^DIQ(19641.4,IEN(1)_",",1,"I")="" D  Q
 . . S DR=".04////0" D ^DIE
 . W !!,"SHARE this data across all interfaces?",!
 . W "      NO: Data belongs to a single instance of an interface.",!
 . W "     YES: All collected data belongs to all instances of an interface.",!
 . W " LIMITED: YES for interfaces set as such.",!
 . S DR=.06 D ^DIE
 I '$$GET1^DIQ(19641.4,IEN(1)_",",.04,"I") D
 . S DR=".05////@;1////@" D ^DIE
 W !!,"Link the CONTROL OBJECT to a form.",!
 S DR=.07 D ^DIE
 W !!,"Excute code and if true then DDCS will push the data out.",!
 W " *This code will be excuted via a scheduled option for all data entries",!
 W "  linked to this control until they are pushed. Once pushed they will",!
 W "  not be pushed again.",!!
 W " VARIABLES:",!
 W " ==========================================================",!
 W " DDCSC   (CONTROL IEN (19641.4))",!
 W " DDCSR   (Data Record as IEN;Global(File#, '123;TIU(8925,')",!
 W " SIEN    (Destination IEN)",!
 W " DDCSFLE (CONTROL - Destination File)",!
 W " DFN     (If set in Control)",!!
 W " * You should still NEW your variables",!
 S DR=2 D ^DIE
 Q
 ;
VIEW(IEN) ; Display Current Data
 N OUT,CT,FLD
 D GETS^DIQ(19641.4,IEN_",",".01:4","E","OUT")
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  S FLD($QS(CT,3))=@CT
 W !,$$REPEAT^XLFSTR("=",79)
 W !,"   CONTROL OBJECT: ",FLD(.01)
 W !,"         INACTIVE: ",FLD(.02)
 W !," DESTINATION FILE: ",FLD(.03)
 W !," PATIENT ORIENTED: ",FLD(.04)
 W !,"    PATIENT FIELD: ",FLD(.05)
 W !,"            SHARE: ",FLD(.06)
 W !,"             FORM: ",FLD(.07),!
 W !," PATIENT LOOKUP CODE: ",FLD(1),!
 W !,"           PUSH CODE: ",FLD(2),!
 W !,"       PRE PUSH CODE: ",FLD(3),!
 W !,"      POST PUSH CODE: ",FLD(4)
 W !,$$REPEAT^XLFSTR("=",79),!
 Q
 ;
RECORD(MSG,SCR) ; Ask File/IEN combo
 N DIR,X,Y,DIRUT,FILE
 S:$G(MSG)'="" DIR("A")=MSG
 S:$G(SCR)'="" DIR("S")=SCR
 S DIR("?")="Select an existing CONTROL or create/select with a file/field combination."
 S DIR("??")="^D R^DSIO61"
 S DIR(0)="PO^1:AEQF" D ^DIR Q:Y<1!($D(DIRUT)) ""
 S FILE=+Y K DIR,X,Y
 S DIR(0)="PO^"_FILE_":AEQF" D ^DIR Q:Y<1!($D(DIRUT)) ""
 Q +Y_";"_$TR(^DIC(FILE,0,"GL"),U)
 ;
R ; Record Help
 N CT,LIST,I,FLG,DIR,DA,X,Y
 S CT="" F  S CT=$O(^DSIO(19641.4,"B",CT)) Q:CT=""  S LIST(CT)=""
 I $D(LIST) S CT="" F I=1:1 S CT=$O(LIST(CT)) Q:CT=""  D  Q:$D(FLG)
 . I '(I#20),'$$GOON^VALM1 S FLG=1 Q
 . W !,"  ",CT
 W ! S DIR(0)="PO^19641.4:AEQF" D ^DIR
 I $G(Y) S RECORD=$P(Y,U,2) G S1
 Q
 ;
FIELDS(MSG,VAL,FLE) ; Allow the selection of the fields of a file
 N FIELD,FLD,FDD,I,FLG,DIR,X,Y,DIRUT
 Q:'$G(FLE) $G(VAL)
 S FIELD="" F  S FIELD=$O(^DD(FLE,"B",FIELD)) Q:FIELD=""  D
 . S FLD=$O(^DD(FLE,"B",FIELD,"")) I FLD=$G(VAL) S FLG=1
 . S FDD(FLD)=FIELD
 K:'$D(FLG) VAL
 K FLG
F1 ; Continue
 S:$G(MSG)'="" DIR("A")=MSG S:'$D(DIR("A")) DIR("A")="Select FIELD"
 S DIR("?")="Select a FIELD number from the list."
 S DIR("??")="^D F2^DSIO61"
 S DIR(0)="F^1:100" S:$G(VAL)'="" DIR("B")=VAL D ^DIR Q:$D(DIRUT) ""
 I Y=""!(Y[U) W "??" G F1
 I Y'="",'$$F3 W "??" G F1
 Q $S(Y'="":Y,1:$G(VAL))
F2 ; Continue
 K FLG S FLD=0 F I=1:1 S FLD=$O(FDD(FLD)) Q:'FLD  D  Q:$D(FLG)
 . W !,"  ",FLD,?15,FDD(FLD)
 . I '(I#20),'$$GOON^VALM1 S FLG=1
 W ! G F1
 Q
F3() ; Continue
 Q:$D(FDD(Y)) 1
 N CT,FLG
 S CT=0 F  S CT=$O(FDD(CT)) Q:'CT  D  Q:$D(FLG)
 . I FDD(CT)=Y S Y=CT,FLG=1
 Q $S($D(FLG):1,1:0)
 ;
FLDV(VAL,FLE) ; FIELDS of FILE Validation
 N FIELD,FLD,FDD,FLG
 Q:'$G(FLE) ""
 S FIELD="" F  S FIELD=$O(^DD(FLE,"B",FIELD)) Q:FIELD=""  D
 . S FLD=$O(^DD(FLE,"B",FIELD,"")) I FLD=$G(VAL) S FLG=1
 . S FDD(FLD)=FIELD
 S VAL=$S('$D(FLG):"",1:$G(VAL)) I VAL="" W "??"
 Q VAL
 ;
FLDH(FLE) ; FIELDS of FILE Help
 N FIELD,FLD,FDD,I,FLG Q:'$G(FLE)
 S FIELD="" F  S FIELD=$O(^DD(FLE,"B",FIELD)) Q:FIELD=""  D
 . S FLD=$O(^DD(FLE,"B",FIELD,"")),FDD(FLD)=FIELD
 S FLD=0 F I=1:1 S FLD=$O(FDD(FLD)) Q:'FLD  D  Q:$D(FLG)
 . W !,"  ",FLD,?15,FDD(FLD)
 . I '(I#20),'$$GOON^VALM1 S FLG=1
 W !
 Q
 ;
LV(VAL) ; LINK Validation
 I $G(VAL)?.N1";".A1"(".N1"," Q VAL
 I $G(VAL)?.N1";".A1"(".N Q VAL
 W "??" S VAL=$$RECORD^DSIO61("Select LINK File")
 Q $G(VAL)
 ;
LH(IEN) ; LINK Help
 N VAL
 S VAL=$$RECORD^DSIO61("Select LINK File")
 I $G(IEN),VAL'="" S (DE(2),$P(^DSIO(19641.401,IEN,0),U,5))=VAL
 Q
