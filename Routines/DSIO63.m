Routine DSIO63 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO63^INT^64180,40973^Sep 19, 2016@11:22
DSIO63 ;DSS/TFF - DSIO DDCS CONFIGURE AND REPORT;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 ; 19641.42   (DSIO DDCS FORM CONFIGURATION) - THE FORM TO BE RENDERED
 ; 19641.425  (DSIO DDCS CONTROLS)           - FORM CONTROLS
 ; 19641.4258 (DSIO DDCS CONTROL PROPERTIES) - FORM CONTROL PROPERTIES
 ; 19641.401  (DSIO DDCS REPORT ITEMS)       - PUSH ACTION FOR FORM CONTROLS
 ; 19641.492  (DSIO DDCS ACTION)             - EXTENDED ACTIONS FOR FORMS
 ; 19641.122  (DSIO DDCS OBSERVATION CONFIG) - ALLOWS OBSERVATIONS FOR ELEMENTS CREATED DURING PUSH
 ;
SET ; Editor for 19641.42
 N DIC,X,Y,DIRUT,IEN,DA,DR,DIE
 W !!,"This information is collected and passed to a caller of the DDCS CONFIGURATION",!
 W "RPC which is used to build the DDCS form.",!
 S DIC("A")="Select the NAME of the INTERFACE: "
 S DIC(0)="AEQL",DIC=19641.42 D ^DIC Q:Y<1!($D(DIRUT))
 ; *** Set Form properties but we only want one instance of the multiple
 S IEN=+Y D S1($P(Y,U,2),IEN)
 ; *** Edit Entry
 W !!,"ACTION is a special action applied to the whole interface.",!
 W "Add each letter of each action you will to apply to your interface.",!
 W " A = DO NOT RESTORE",!
 W " B = DO NOT SAVE",!
 W " C = DO NOT PUSH",!
 W " D = SUBMIT NOW (PUSH on SAVE rather than waiting for the trigger)",!
 S DA=IEN,DIE="^DSIO(19641.42,",DR=".02" D ^DIE
 I $$GET1^DIQ(19641.42,IEN_",",.06)'["A" S DR=.06 D ^DIE
 ; *** SHARED, PUSH (AS A WHOLE), FILENAME
 W ! S DR=".03;.04;.05" D ^DIE
 ; *** MULTI-INTERFACE
 W !,"When set to Multi-Interface pages will be treated as interfaces (single paged)."
 W !,"The hiding of these pages will be controlled by the RPC: DSIO DDCS BUILD FORM"
 W !,"All pages not included in the array that are part of this record will be hidden.",!
 S DR=.07 D ^DIE
 W !!,"A DDCS can have up to 30 pages which will appear as tabs within the",!
 W "GUI form. You can press '+' to add the next page or a number to jump.",!
 W "You will not be allowed to create a higher numbered page until you create",!
 W "the lower ordered page."
 F  W ! Q:'$$S0
 Q
 ;
S0() ; Pages
 N DIR,DIRUT,DA,X,Y,PAGE,DIC,DIE,DR
 S DIR("A")="Enter a number (1-30)"
 S DIR("?")="Enter a number between 1-30 or '+'."
 S DIR(0)="F^1:2^K:'$$PAGE^DSIO63 X" D ^DIR Q:$D(DIRUT) 0
 S PAGE=Y S:PAGE="+" PAGE=$O(^DSIO(19641.42,IEN,1,""),-1)+1
 S DA=PAGE,DA(1)=IEN,(DIC,DIE)="^DSIO(19641.42,"_DA(1)_",1,"
 S DIC(0)="XL",X=PAGE D ^DIC
 ; *** Naming the Page and adding controls
 S DR=".02;.03" D ^DIE
 W !!,"If this is set to TRUE then this page will be populated with the Vitals "
 W "component and nothing more. Vitals will pull the current information for "
 W "the patient. You will only be able to configure the listing of contraception.",!
 S DR=".04" D ^DIE
 I $$GET1^DIQ(19641.421,PAGE_","_IEN_",",.04,"I") D VITALS(IEN,PAGE) Q 1
 F  Q:'$$CONTROL(IEN,PAGE)
 Q 1
 ;
VITALS(FORM,PAGE) ; Allow only the Contraception list to be set
 N FDA,CIEN,DA,DIE,DR
 S FDA(19641.4211,"?+1,"_PAGE_","_FORM_",",.01)="EDTCONTRACEPTIONTYPE"
 D UPDATE^DIE(,"FDA","CIEN")
 I '$G(CIEN(1)) W "*** Failed to create CONTROL.",! Q
 S DA(2)=FORM,DA(1)=PAGE,DA=CIEN(1)
 S DIE="^DSIO(19641.42,"_DA(2)_",1,"_DA(1)_",1,",DR=2 D ^DIE
 Q
 ;
S1(NAM,FORM) ; Property Multiple
 N DIR,PROP,IEN,X,Y,DIRUT
 W !!,"The following properties will be applied to the form.",!
 S DIR(0)="F^1:245"
 S PROP="" F  S PROP=$O(^DSIO(19641.42,FORM,2,"B",PROP)) Q:PROP=""  D
 . S IEN=$O(^DSIO(19641.42,FORM,2,"B",PROP,""))
 . S DIR("A")=PROP,DIR("B")=$G(^DSIO(19641.42,FORM,2,IEN,1)) D ^DIR
 . Q:$D(DIRUT)
 . S FDA(19641.422,IEN_","_FORM_",",.01)=PROP
 . S FDA(19641.422,IEN_","_FORM_",",1)=Y
 . D UPDATE^DIE(,"FDA") K FDA
 F  Q:'$$S2(FORM)
 Q
 ;
S2(FORM) ; Set new PROPERTIES
 N DIR,X,Y,DIRUT,PROP,FDA
 S DIR(0)="F^1:245"
 S DIR("A")="Set new PROPERTY" D ^DIR Q:$D(DIRUT) 0
 S PROP=Y
 K X,Y S DIR("A")="Set '"_PROP_"' VALUE" D ^DIR Q:$D(DIRUT) 0
 S FDA(19641.422,"?+1,"_FORM_",",.01)=PROP
 S FDA(19641.422,"?+1,"_FORM_",",1)=Y
 D UPDATE^DIE(,"FDA") K FDA
 Q 1
 ;
PAGE() ; Did the user indicate a correct page
 I X<1!(X>30)&(X'="+") Q 0
 N CT,FLG
 I X>1 F CT=1:1:(X-1) I '$D(^DSIO(19641.42,IEN,1,CT)) S FLG=1 Q
 Q:$D(FLG) 0
 I X="+",($O(^DSIO(19641.42,IEN,1,""),-1)+1)>30 Q 0
 Q 1
 ;
CONTROL(FORM,PAGE) ; Add a Control to a Page
 N DA,DIC,X,Y,DIRUT,CONTROL,CIEN,DIE,DR,OB
 S DA(2)=FORM,DA(1)=PAGE
 S DIC("W")="W ?40,$P(^(0),U,4)"
 S DIC="^DSIO(19641.42,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="AEQL"
 W ! D ^DIC Q:+Y<1!($D(DIRUT)) 0
 S CONTROL=$P(Y,U,2),CIEN=+Y W !!," CONTROL: ",CONTROL,!
 ; *** Allow CONTROL to be renamed or deleted
 K X,Y S DA(2)=FORM,DA(1)=PAGE,DA=CIEN
 S DIE="^DSIO(19641.42,"_DA(2)_",1,"_DA(1)_",1,",DR=".01" D ^DIE Q:'$D(DA)!($D(DIRUT)) 1
 S DR=".02;.03;.04" D ^DIE Q:$D(DIRUT) 1
 ; *** CONFIGURATION
 W !!,"A CONTROL can be configured with free text values (these entries must start"
 W " with a caret as the first piece of each free text value is the index). Other "
 W "options include a listing of dialogs (or a single dialog for a button). When "
 W "using this type be sure to define the Dialog Return which is a control that "
 W "the calling program will use to return the dialog's responses. The third option "
 W "would be to run a routine. The routine must set @RET@(#) with text as it would "
 W "have been in the word processing field (so each line must start with a caret)."
 W !!,"Only one form can be used so the order of priority is:"
 W !,"  1. RUN ROUTINE"
 W !,"  2. DIALOGS"
 W !,"  3. WORD PROCESSING",!
 K X,Y S DR="4;3;2" D ^DIE Q:$D(DIRUT) 1
 W !!,"CONTROL REPORT ITEM **These values will override the GUI defaults**",!
 K X,Y S DR=9 D ^DIE Q:$D(DIRUT) 1
 ; *** OBSERVATION
 W !!,"Should this CONTROL create an observation on PUSH? If so, then you will be",!
 W "asked to complete the configuration here or identify an existing one in order ",!
 W "to link it.",!
 S OB=$$SET^DSIO67(CIEN,PAGE,FORM) I OB K X,Y S DR=".05////"_OB D ^DIE
 Q 1
 ;
 ; -------------------------------- EXTERNAL ----------------------------------
 ;
CONFIG(RET,INFACE,OBJECT,SIEN,CITEM) ; RPC: DSIO DDCS BUILD FORM
 ;
 ; INPUT PARAMETERS:
 ; -----------------
 ; INFACE = ARRAY of...
 ;           IEN;DSIO(19641.42, (or NAME)
 ;           or IEN;DSIO(19641.49,
 ;           *Dialogs must exist as a single entry
 ;
 ; OBJECT = OBJECT of CONTROL
 ;          Example: 500000042;PXRMD(801.41,
 ;                   Which is the Reminder Dialog of IEN 500000042
 ;         = O=### (ORDER IEN)
 ;         = N=### ( NOTE IEN)
 ;
 ;   SIEN = Destination IEN - Record of Control
 ;
 ;  CITEM = If set then run the interface's configuration routine
 ;
 ; RETURN:
 ;   INTERFACE:  I^PROPERTY|VALUE
 ;        PAGE:  P^NUMBER^CAPTION^HIDE
 ;     CONTROL: CC^COLLECTION_NAME|VALUE
 ;     CONTROL: CV^NAME^(D,F)^(INDEX^VALUE)
 ;
 ; -----------------------------------
 D:'$D(CITEM) TRIG^DSIO6  ; *** PUSH |
 ; -----------------------------------
 S RET=$NA(^TMP($J,"DSIO63")) Q:$$CONT  K @RET S @RET@(0)=""
 N CONTROL,DFN,I,CT,TMP,IEN,FLG,IGRP,DFLG
 S CONTROL=$$OBJECT^DSIO65($G(OBJECT)),DFN=$$DFN^DSIO6(CONTROL,$G(SIEN))
 S I=0,CT="" F  S CT=$O(INFACE(CT)) Q:CT=""  S I=I+1 D
 . S TMP=$$INFACE^DSIO65(INFACE(CT))
 . I TMP[";DSIO(19641.42," D  Q
 . . I $D(IEN),+TMP'=IEN S FLG=1 Q
 . . S IEN=+TMP I $O(^DSIO(19641.42,"P",INFACE(CT),"")) S IGRP(INFACE(CT))=""
 . I TMP[";DSIO(19641.49," S DFLG=TMP
 ; *** A Dialog must be presented by itself
 I $D(DFLG) Q:I>1  D  D CONT Q
 . I $D(CITEM) D DCITEM^DSIO66(+DFLG,$G(OBJECT),$G(SIEN)) Q
 . D DIALOG^DSIO66(+DFLG,$G(OBJECT),$G(SIEN))
 I $G(IEN) D
 . I $D(CITEM) D CITEM(IEN,$G(OBJECT),$G(SIEN)) Q
 . D CG(IEN,$P($G(^DSIO(19641.42,IEN,0)),U,7),.IGRP)
 D CONT
 Q
 ;
CONT() ; Continue Cummulative Return
 N CONT,STRT,END,I,CT,FLG
 S CONT=$NA(^TMP($J,"DSIO63 CONT")) K @CONT
 S STRT=$G(@RET@("##CONT##")),END=$G(@RET@("##CONT##"))+500
 S CT=RET F I=1:1 S CT=$Q(@CT) Q:CT=""  Q:$QS(CT,1)'=$J!($QS(CT,2)'="DSIO63")  D  Q:$D(FLG)
 . Q:I<STRT
 . S @CONT@(I)=@CT
 . I I=END S @CONT@(0)="##CONT##",FLG=1
 I $D(FLG) S @RET@("##CONT##")=$G(@RET@("##CONT##"))+501,RET=CONT Q 1
 K @RET I '$D(@CONT) Q 0
 S RET=CONT
 Q 1
 ;
CITEM(IEN,OBJECT,SIEN) ; Return data for the configuration collection
 ;
 ; *This will happen after all the interface's controls are populated
 ;  with configuration and/or restored data.
 ;
 Q:$P($G(^DSIO(19641.42,+$G(IEN),3)),U,3)=""
 N TMP,ROU,DDCSCT
 S TMP=^DSIO(19641.42,+IEN,3),ROU=$TR($P(TMP,U,3),"|",U)
 I $L($T(@ROU)) D
 . S @RET@(0)=$P(TMP,U)_":"_$$D^DSIO66($P(TMP,U,2)),DDCSCT=1 D @ROU
 D:$G(SIEN) RESTF^DSIO64(.RET,1,,,"##TCONFIGCOLLECTION##",OBJECT,IEN_";DSIO(19641.42,",SIEN,1)
 Q
 ;
CG(IEN,TYP,PAGES) ; Continue with 19641.42
 N CT,SI,SN,SINFACE,PG,NAM,HIDE,CON,CIEN
 ; *** INTERFACE: I^PROPERTY|VALUE
 S @RET@(0)="I" D
 . S CT=0 F  S CT=$O(^DSIO(19641.42,IEN,2,CT)) Q:'CT  D
 . . S @RET@(0)=@RET@(0)_U_$G(^DSIO(19641.42,IEN,2,CT,0))_"|"_$G(^DSIO(19641.42,IEN,2,CT,1))
 ; *** DATA SHUFFLE
 S SI=$P($G(^DSIO(19641.42,IEN,0)),U,6) I SI D
 . S SN=SI_";DSIO(19641.42,"
 . S DFN=$$DFN^DSIO6($$OBJECT^DSIO65($G(OBJECT)),$G(SIEN))
 . I DFN,$O(^DSIO(19641.4941,DFN,1,"S",SN,"")) S SINFACE=SN
 S PG=0 F  S PG=$O(^DSIO(19641.42,IEN,1,PG)) Q:'PG  D
 . ; *** PAGE: P^NUMBER^CAPTION^HIDE
 . S NAM=$P($G(^DSIO(19641.42,IEN,1,PG,0)),U,2),HIDE=$$HIDE
 . S @RET@(PG)="P^"_PG_U_NAM_U_HIDE Q:HIDE
 . S CON="" F  S CON=$O(^DSIO(19641.42,IEN,1,PG,1,"B",CON)) Q:CON=""  D
 . . S CIEN=$O(^DSIO(19641.42,IEN,1,PG,1,"B",CON,""))
 . . D CC(CIEN,PG,IEN,CON),CV(CIEN,PG,IEN,CON,$G(SIEN))
 K:$D(SINFACE) ^DSIO(19641.4941,DFN,1,"S",SINFACE)
 Q
 ;
HIDE() ; Page Hide (TabVisible)
 I TYP,NAM'="",'$D(PAGES(NAM)) Q "TRUE"
 I TYP Q "FALSE"
 Q $S($P($G(^DSIO(19641.42,IEN,1,PG,0)),U,3):"TRUE",1:"FALSE")
 ;
CC(IEN,PG,FORM,CON) ; CONTROL Collection
 ; *** CONTROL: CC^NAME^COLLECTION_NAME|VALUE
 N STR,CT,PRP,VAL
 S STR="",CT=0 F  S CT=$O(^DSIO(19641.42,FORM,1,IEN,9,CT)) Q:'CT  D
 . K PRP,VAL
 . S PRP=$G(^DSIO(19641.42,FORM,1,IEN,9,CT,0))
 . S VAL=$G(^DSIO(19641.42,FORM,1,IEN,9,CT,1))
 . S:VAL'="" STR=STR_PRP_"|"_VAL_U
 S @RET@(PG,IEN,"CC")="CC^"_CON_U_STR
 Q
 ;
CV(DDCSCI,DDCSPG,FORM,DDCSCON,SIEN) ; CONTROL Configuration Value
 N DDCSCT,FLG,IENS,LOG,LN S DDCSCT=1
 ; *** RUN ROUTINE
 ;     Needs to build either of the two formats
 ;     S @RET@(PG,IEN,CT)="CV^"_CON_U_(D,F)_U
 I $G(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,4))'="" S FLG=1 D
 . X ^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,4)
 ; *** DIALOGS
 ;     CV^NAME^D^IEN|NAME|CLASS
 I '$D(FLG),$P($G(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,3,0)),U,4)>0 S FLG=2 D
 . S IENS=0 F  S IENS=$O(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,3,IENS)) Q:'IENS  D
 . . S LOG=^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,3,IENS,0)
 . . S @RET@(DDCSPG,DDCSCI,DDCSCT)="CV^"_DDCSCON_"^D^"_LOG_"|"_$P($G(^DSIO(19641.49,LOG,0)),U)_"|"_$P($G(^DSIO(19641.49,LOG,0)),U,3)
 . . S DDCSCT=DDCSCT+1
 ; *** FREE TEXT
 ;     CV^NAME^F^(INDEX^VALUE)
 I '$D(FLG),$P($G(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,2,0)),U,4)>0 D
 . S IENS=0 F  S IENS=$O(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,2,IENS)) Q:'IENS  D
 . . S LN=^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,2,IENS,0)
 . . I LN'[U!(($P(LN,U)'?.N)&($P(LN,U)'["TRUE")) I $D(@RET@(DDCSCT-1)) D  Q
 . . . S @RET@(DDCSCT-1)=@RET@(DDCSCT-1)_LN
 . . S @RET@(DDCSPG,DDCSCI,DDCSCT)="CV^"_DDCSCON_"^F^"_LN,DDCSCT=DDCSCT+1
 ; *** RESTORE
 Q:$P($G(^DSIO(19641.42,FORM,0)),U,2)["A"                    ; DO NOT RESTORE (FORM)
 Q:$$UP^XLFSTR($$RITEM(FORM,IEN,"DONOTRESTORE"))="TRUE"      ; DO NOT RESTORE (CONTROL)
 ;     DATA SHUFFLE
 I $G(SI) Q:'$$DSCON(SI,DDCSCON)
 D:$G(SIEN)&($G(FLG)'=2) RESTF^DSIO64(.RET,1,DDCSCI,DDCSPG,DDCSCON,OBJECT,FORM_";DSIO(19641.42,",SIEN)
 Q
 ;
RITEM(FORM,CON,PROP) ; Get the Report Item Value for a Control
 N IEN
 S PROP=$$UP^XLFSTR($G(PROP)) Q:PROP="" -1
 S IEN=$O(^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,9,"B",PROP,"")) Q:'IEN -1
 Q ^DSIO(19641.42,FORM,1,DDCSPG,1,DDCSCI,9,IEN,1)
 ;
DSCON(IEN,CON) ; Determine if a "restore as" form should use a control
 I '$D(^DSIO(19641.42,IEN,1,"CONTROL",CON)) Q 0
 N PG S PG=$O(^DSIO(19641.42,IEN,1,"CONTROL",CON,""))
 Q $S($P($G(^DSIO(19641.42,IEN,1,PG,0)),U,3):0,1:1)
