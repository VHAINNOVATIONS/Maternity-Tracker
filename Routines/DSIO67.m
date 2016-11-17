Routine DSIO67 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO67^INT^64180,41062^Sep 19, 2016@11:24
DSIO67 ;DSS/TFF - DSIO DDCS ELEMENT OBSERVATIONS;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
 ; ELEMENT LEVEL --------------------------------------------------------------
 ;
OBF(FORM,CON,EIEN) ; Create the Observation for a Control for an Interface/Form - INTERFACE
 N PG,IEN,OBS,VAL
 S PG=$O(^DSIO(19641.42,FORM,1,"CONTROL",CON,"")) Q:'PG
 S IEN=$O(^DSIO(19641.42,FORM,1,"CONTROL",CON,PG,""))
 S OBS=$P($G(^DSIO(19641.42,FORM,1,PG,1,IEN,0)),U,5) Q:'OBS
 S $P(VAL,U,3)=$$VALUE(EIEN)
 D OBG(OBS)
 Q
 ;
OBD(FORM,CON,EIEN) ; Create the Observation for a Control for an Interface/Form - DIALOG
 N IEN,OBS,VAL
 S IEN=$O(^DSIO(19641.49,FORM,1,"B",CON,"")) Q:'IEN
 S OBS=$P($G(^DSIO(19641.49,FORM,1,IEN,0)),U,5) Q:'OBS
 S $P(VAL,U,3)=$$VALUE(EIEN)
 D OBG(OBS)
 Q
 ;
 ; INTERFACE LEVEL ------------------------------------------------------------
 ;
OBI ; Create the Observation for a Control for an Interface/Form
 S DDCSEN="" F  S DDCSEN=$O(^DSIO(19641.41,DATA,1,FIEN,1,"C",DDCSEN)) Q:DDCSEN=""  D
 . S EIEN=$O(^DSIO(19641.41,DATA,1,FIEN,1,"C",DDCSEN,""))
 . S DDCSE=+$G(^DSIO(19641.41,DATA,1,FIEN,1,EIEN,0))
 . I DDCSFRM[";DSIO(19641.42," D
 . . D OBF(+DDCSFRM,DDCSEN,DDCSE)
 . I DDCSFRM[";DSIO(19641.49," D
 . . D OBD(+DDCSFRM,DDCSEN,DDCSE)
 Q
 ;
VALUE(IEN) ; Return element value as a string
 N OUT,CT,STR
 D GETS^DSIO62(.OUT,IEN) Q:'$D(OUT) ""
 S CT=0 F  S CT=$O(OUT(CT)) Q:'CT  S STR=$S($D(STR):STR_" ",1:"")_$P(OUT(CT),U,2,999)
 Q $E($G(STR),1,200)
 ;
 ; COMMON ---------------------------------------------------------------------
 ;
OBG(IEN) ; Get Observation Configuration and create
 ;
 ;    OBJ = OBJECTS OF OBSERVATION (ARRAY)
 ;          PG = CURRENT PREGNANCY ($$PG^DSIO4(DFN))
 ;    REL = RELATIONSHIP
 ;    CAT = CATEGORY
 ;   CODE = SYS NAME^SYS VALUE^CODE^DISPLAY NAME
 ;    VAL = TYPE^UNIT^VALUE
 ;  VALCD = SYS NAME^SYS VALUE^CODE^DISPLAY NAME
 ;    NEG = NEGATION (T/F)
 ;   BOOL = BOOLEAN VALUE (T/F)
 ;   QUAL = QUALIFIERS (ARRAY OF QUALIFIER^VALUE)
 ;    NAR = NARRATIVE (ARRAY OF TEXT)
 ;  LIMIT = CREATE ONLY IF (the boolean value matches)
 ;  **SYS = $S(SYS="LNC":"LOINC",SYS="SCT":"SNOMED-CT",1:SYS)
 ;
 N OUT,REF,LN,CAT,REL,NEG,BOOL,NAR,CT,OBJ,CODE,VALCD,QUAL,OB,FLG
 I DDCSFLE=8925 S REF(1)="TIU."_+DDCSR                ; OBJECTS OF REFERENCE
 D GETS^DIQ(19641.122,IEN_",","**","I","OUT") Q:'$D(OUT)
 S LN=$NA(OUT) F  S LN=$Q(@LN) Q:LN=""  D  Q:$D(FLG)
 . I $QS(LN,1)=19641.122 D  Q
 . . I $QS(LN,3)=.03 S CAT=@LN Q                      ; CATEGORY
 . . I $QS(LN,3)=.04 S REL=@LN Q                      ; RELATIONSHIP
 . . I $QS(LN,3)=4.1 S $P(VAL,U)=@LN Q                ; VALUE TYPE
 . . I $QS(LN,3)=4.3 S $P(VAL,U,2)=@LN Q              ; VALUE UNIT
 . . I $QS(LN,3)=4.4 S NEG=@LN Q                      ; NEGATION
 . . I $QS(LN,3)=4.5 I @LN S BOOL=1,$P(VAL,U,3)=$$BOOL($P(VAL,U,3)) Q  ; BOOLEAN VALUE
 . . I $QS(LN,3)=4.6 I @LN D  Q
 . . . S CT=0 F  S CT=$O(^DSIO(19641.45,+$G(DDCSE),1,CT)) Q:'CT  D
 . . . . S NAR(CT)=$P($G(^DSIO(19641.45,DDCSE,1,CT,0)),U,2,999)
 . . I $QS(LN,3)=4.7 I @LN'="",'$$LIMIT($D(BOOL),@LN,$P(VAL,U,3)) S FLG=1 Q
 . I $QS(LN,1)=19641.1221 D  Q                        ; OBJECTS OF OBSERVATION
 . . I @LN="PG" S OBJ(1)="PG."_$$PG^DSIO4($G(DFN))      ; CURRENT PREGNANCY FLAG
 . I $QS(LN,1)=19641.1223,$QS(LN,3)=.01 D  Q
 . . I @LN="C" D  Q                                   ; CODE
 . . . S CODE=$$ND(3)_U_$$ND(4)_U_$$ND(1)_U_$$ND(2)
 . . I @LN="V" D                                      ; VALUE CODE
 . . . S VALCD=$$ND(3)_U_$$ND(4)_U_$$ND(1)_U_$$ND(2)
 . I $QS(LN,1)=19641.1225 D                           ; QUALIFIERS
 . . I $QS(LN,3)=.01 S $P(QUAL(+$QS(LN,2)),U)=@LN Q     ; QUALIFIER
 . . I $QS(LN,3)=.02 S $P(QUAL(+$QS(LN,2)),U,2)=@LN     ; VALUE
 D:'$D(FLG) OBS^DSIO10(.OB,,$G(DFN),,.OBJ,.REF,$G(REL),$G(CAT),$G(CODE),$S('$D(NAR):$G(VAL),1:""),$G(VALCD),$G(NEG),.QUAL,.NAR,1)
 Q
 ;
BOOL(VAL) ; Set value based on Boolean type and check type control
 Q:$G(DDCSEN)=""!($G(DDCSFRM)="") "False"
 I $$CHECK^DSIO62(DDCSFRM,DDCSEN) Q $S($$TGET1^DSIO62(DDCSEN):"True",1:"False")
 Q $S(VAL'="":"True",1:"False")
 ;
LIMIT(BOOL,FLD,VAL) ; The CREATE ONLY IF field is set...
 ;                    - If we are working with boolean values and the value matches
 ;                      this field's value - so create only if the value is True
 ;                      or create only if the value is False
 ;                    - If we are not working with boolean values but the type of
 ;                      control is a boolean type (checkbox) then we do like the
 ;                      above condition
 N OUT,VCHK
 I BOOL D
 . I FLD=1,VAL="True" S OUT=1
 . I FLD=0,VAL="False" S OUT=1
 I 'BOOL,$$CHECK^DSIO62(DDCSFRM,DDCSEN) D
 . S VCK=$$TGET1^DSIO62(DDCSEN)
 . I FLD=1,VCK S OUT=$S(VAL'="":1,1:0)
 . I FLD=0,'VCK S OUT=$S(VAL="":1,1:0)
 Q +$G(OUT)
 ;
ND(Q) ; Return node value for CODES
 Q OUT($QS(LN,1),$QS(LN,2),Q,"I")
 ;
 ; CONFIGURATION --------------------------------------------------------------
 ;
SET(CIEN,PAGE,FORM) ; DSIO63 configuration entry point
 N DIC,X,Y,DIRUT,IEN,DA,DR,DIE,DIR,FDA
 S DIC="^DSIO(19641.122,",DIC(0)="AEQL"
 S DIC("A")="Select the NAME of the OBSERVATION: "
 S DIC("B")=$P($G(^DSIO(19641.42,FORM,1,PAGE,1,CIEN,0)),U,5)
 D ^DIC Q:Y<1!($D(DIRUT)) ""
 S IEN=+Y,DA=IEN,DIE="^DSIO(19641.122,",DR=".03;.04;4.1;4.3;4.4;5;6" D ^DIE
 W !,"Will this observation be for the current pregnancy? "
 W "If so, then this data must be PUSHed before the pregnancy is closed out.",!!
 K X,Y S DIR("A")="Link to CURRENT PREGNANCY",DIR(0)="Y",DIR("B")="YES" D ^DIR I Y D
 . S FDA(19641.1221,"?+1,"_IEN_",",.01)="PG" D UPDATE^DIE(,"FDA") K FDA
 W !!,"Identify the CODE.",! D CODE("C")
 W !!,"Identify the VALUE CODE.",! D CODE("V")
 Q IEN
 ;
CODE(TYP) ; Build the code array
 N IENS,DIE,DIC,DA,DR,X,Y
 S IENS=$O(^DSIO(19641.122,IEN,3,"B",TYP,"")),DA(1)=IEN
 I IENS S DA=IENS,DIE="^DSIO(19641.122,"_DA(1)_",3,",DR="1;2;3;4" D ^DIE Q
 S X=TYP,DIC="^DSIO(19641.122,"_DA(1)_",3,",DIC(0)="AEQL"
 S DIC("DR")="1;2;3;4" D FILE^DICN
 Q
