Routine DSIO2 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO2^INT^64180,40712^Sep 19, 2016@11:18
DSIO2 ;DSS/TFF - DSIO X-REFERENCES AND UTILITIES;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
 ; --------------------------------- CODING -----------------------------------
 ;
ICODE(SYS,CD) ; Transform and lookup code (internal)
 Q:CD="@" CD
 N IEN,CODE,CK
 I SYS="LNC" D
 . S IEN=+CD,CK=$P(CD,"-",2)
 . I $$FIND1^DIC(95.3,,"A",IEN)&($$GET1^DIQ(95.3,IEN_",",15)=CK) D
 . . S CODE=IEN_";LAB(95.3,"
 I SYS="SCT" D
 . S IEN=$$FIND1^DIC(757.02,,"O",CD,"CODE") Q:'IEN
 . I $$GET1^DIQ(757.02,IEN_",",1)=CD D
 . . S CODE=IEN_";LEX(757.02,"
 Q $G(CODE)
 ;
DCODE(Y) ; Display Code
 N FLE S FLE=$TR($P(Y,"(",2),",","")
 I $P(Y,";",2)="LAB(95.3," S Y=$$GET1^DIQ(FLE,+Y_",",.01)
 E  I $P(Y,";",2)="LEX(757.02," S Y=$$GET1^DIQ(FLE,+Y_",",1)
 Q Y
 ;
SCODE(VP,IEN,FLE) ; Set the Code Type
 N TYP,IPT
 S TYP=$S($P(VP,";",2)="LAB(95.3,":"LNC",$P(VP,";",2)="LEX(757.02,":"SCT",1:"OTHER")
 S IPT(FLE,IEN_",",$S(FLE=19641.123:.03,FLE=19641.12:.07,1:""))=TYP
 D UPDATE^DIE(,"IPT")
 Q
 ;
LCODE(CODE,TYP,SOR) ; Log codes that are not found in DSIO CODES (19641.99)
 ; *** USED BY DSIO OBSERVATION
 N IPT,REASON,DLAYGO
 S DLAYGO=19641.99
 S IPT(19641.99,"+1,",.01)=$$NOW^XLFDT
 S IPT(19641.99,"+1,",.02)=CODE
 S IPT(19641.99,"+1,",.03)=TYP
 S IPT(19641.99,"+1,",.04)=DUZ
 S IPT(19641.99,"+1,",.05)=SOR
 S REASON=$S(TYP'="LNC"&(TYP'="SCT"):"Type is not LOINC or SNOMED CT.",1:"Unable to find code as "_TYP_".")
 S IPT(19641.99,"+1,",.06)=REASON
 D UPDATE^DIE(,"IPT")
 Q
 ;
 ; --------------------------------- UTILITIES --------------------------------
 ;
WITHIN(SUB,WOLE,DL) ; Is a string within another
 ; WOLE IS DELIMITED BY CARET
 N CT,FLG S:'$D(DL) DL=U
 F CT=1:1:$L(WOLE,DL) I $P(WOLE,DL,CT)=SUB S FLG=1
 Q +$G(FLG)
 ;
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
 ;
AB(LIST) ; Change null to @ for null means delete
 ;
 ; This API turns non-existing or existing but equal to null variables
 ; into the @. Originally, most DSIO RPCS were set up to ignore null
 ; and use @ as the user's confirmation that they wish to delete data
 ; before using FileMan API's.
 ;
 ; The implementation of this API means that before calling any DSIO
 ; add or update action all values expressing the current state of the
 ; record must be passed - thus a get function may need to be called first
 ; Some methods will include the AB input variable and if set to 1 will
 ; bypass the use of this method.
 ;
 ; THE MCCDASHBOARD expects that by sending a null the user wishes to
 ; delete that associated data element.
 ;
 ; Array inputs are expected to be IDENTIFIER^VALUE PAIRS
 ; EXAMPLE: ARRAY(<SUBSCRIPT>)="ZIP<^ - THE LAST PIECE IS THE VALUE>66666"
 ;
 N I,VAR,CT
 F I=1:1:$L(LIST,",") S VAR=$P(LIST,",",I) D
 . I '$D(@VAR) S @VAR="@"
 . E  I $D(@VAR)=10 S CT=$NA(@VAR) F  S CT=$Q(@CT) Q:CT=""  D
 . . I $P(@CT,U,$L(@CT,U))="" S $P(@CT,U,$L(@CT,U))="@"
 . E  I $D(@VAR)=1&(@VAR="") S @VAR="@"
 Q
 ;
STORE ; Save FileMan variables for restoration
 M:$D(DO) VFDDO=DO
 M:$D(DI) VFDDI=DI
 M:$D(DQ) VFDDQ=DQ
 M:$D(DC) VFDDC=DC
 M:$D(DM) VFDDM=DM
 M:$D(DK) VFDDK=DK
 M:$D(DP) VFDDP=DP
 M:$D(DL) VFDDL=DL
 M:$D(DV) VFDDV=DV
 M:$D(DIU) VFDDIU=DIU
 Q
 ;
GETVAR ; Restore FileMan variables
 M:$D(VFDDO) DO=VFDDO
 M:$D(VFDDI) DI=VFDDI
 M:$D(VFDDQ) DQ=VFDDQ
 M:$D(VFDDC) DC=VFDDC
 M:$D(VFDDM) DM=VFDDM
 M:$D(VFDDK) DK=VFDDK
 M:$D(VFDDP) DP=VFDDP
 M:$D(VFDDL) DL=VFDDL
 M:$D(VFDDV) DV=VFDDV
 M:$D(VFDDIU) DIU=VFDDIU
 Q
 ;
CHECK(DFN) ; Check for patient in DSIO PATIENT
 N VFDDO,VFDDI,VFDDQ,VFDDC,VFDDM,VFDDK,VFDDP,VFDDL,VFDDV,VFDDIU
 D STORE
 N DIC,DA,X,Y,DLAYGO S DLAYGO=19641
 S DIC="^DSIO(19641,",DIC(0)="XL",X="`"_DFN D ^DIC I +Y<1 D GETVAR Q 0
 ; *** ADD PATIENT TO WV PATIENT (790)
 N DIC,DA,X,Y,DLAYGO S DLAYGO=790
 S DIC="^WV(790,",DIC(0)="XL",X="`"_DFN D ^DIC I +Y<1 D GETVAR Q 0
 D GETVAR
 Q 1
 ;
NAME(NAM) ; Transform NAME,NAME to title case thats Name,Name
 I NAM["," S NAM=$$TITLE^XLFSTR($P(NAM,","))_","_$$TITLE^XLFSTR($P(NAM,",",2))
 E  S NAM=$$TITLE^XLFSTR(NAM)
 Q NAM
 ;
VALID(FLE,FLD,IENS,VAL) ; Check if a value is valid
 N VALID,ERR
 D VAL^DIE($G(FLE),$G(IENS),$G(FLD),,$G(VAL),.VALID,,"ERR")
 I VALID["^"!($D(ERR)) Q 0
 Q 1
 ;
DT(X) ; Validate and attempt to return a valid date
 N %DT S %DT="ST" D ^%DT
 I +Y<1 S X=$$DT1(X) S:+X'=-1 Y=X I +X<1 S X=$P(X,U,2) S %DT="STX" D ^%DT
 Q $S(Y'<1:Y,1:"")
 ;
DT1(VAL) ; Translate external date time to FM date time
 ;
 ; Converts these 9/23/2004 10:53:25 AM
 ;                09/03/2014 21:00:00
 ;                2009-10-22 05:00:00.0
 ;                10-22-2009 05:00:00.0
 ;                OCT 12,(, )2012 12:10 AM
 ;                OCT 12,(, )2012 13:00
 ;                July 26, 2014 @ 10
 ;                02-OCT-2014 13.29.28
 ;
 ; The FM call below does not work with the time portions
 ; of the above format
 ; ------------------------------------------------------
 ; D DT^DILF("E","DEC 12,2014",.RESULT)
 ; RESULT=3141212
 ; RESULT(0)="DEC 12, 2014"
 ;
 Q:VAL="" ""
 I $$FMTH^XLFDT(VAL)'=-1 Q VAL
 N DATE,FLG,TIME S DATE=-1,FLG=0
 I $P(VAL," ",2)?.2N.1":".2N.1":".2N S FLG=1
 I $P(VAL," ",2)?.2N.1":".2N.1":".2N.1" ".2A S FLG=1
 I $P(VAL," ",2)?.2N.1":".2N.1":".2N.1".".2N S FLG=1
 I VAL?3A1" "1.2N1","4N.1" ".2N.1":".2N.1":".2N.1" ".2A S FLG=2
 I VAL?3A1" "1.2N1","1" "4N.1" ".2N.1":".2N.1":".2N.1" ".2A S FLG=3
 I VAL?1.A1" "1.2N1","1" "4N.1" ".1"@".1" ".2N.1":".2N S FLG=4
 I VAL?2N1"-"3A1"-"4N.1" ".2N.1".".2N.1".".2N S FLG=5
 I FLG=0 D DT^DILF("E",VAL,.DATE)
 I FLG=1 D DT^DILF("E",$P(VAL," "),.DATE) S TIME=$$DT2($P(VAL," ",2,99))
 I FLG=2 D DT^DILF("E",$P(VAL," ",1,2),.DATE) S TIME=$$DT2($P(VAL," ",3,99))
 I FLG=3 D DT^DILF("E",$P(VAL," ",1,3),.DATE) S TIME=$$DT2($P(VAL," ",4,99))
 I FLG=4 D DT^DILF("E",$$TRIM^XLFSTR($P(VAL,"@")),.DATE) D
 . S TIME=$$DT2($$TRIM^XLFSTR($P(VAL,"@",2)))
 I FLG=5 D DT^DILF("E",$P(VAL," "),.DATE) S TIME=$$DT2($TR($P(VAL," ",2,99),".",":"))
 I DATE=-1 Q -1_U_VAL
 Q DATE_$S($G(TIME)'="":"."_TIME,1:"")
 ;
DT2(TM) ; Convert Time
 N SEC,MIN,HR S TM=$$TRIM^XLFSTR($$UP^XLFSTR(TM))
 I TM'[":",TM?.N D  Q $G(TM)
 . F I=$L(TM):-1:1 Q:$E(TM,I)'=0  I $E(TM,I)=0 S TM=$E(TM,1,I-1)
 Q:TM'[":" ""
 S SEC=$S(TM[" ":$P($P(TM,":",3)," "),TM[".":$P($P(TM,":",3),"."),1:$P(TM,":",3))
 S SEC=$$DT3(SEC) S:$L(SEC)=1 SEC=0_SEC
 S MIN=$P($P(TM,":",2)," "),MIN=$$DT3(MIN) S:$L(MIN)=1 MIN=0_MIN
 S HR=$P($P(TM,":")," "),HR=$$DT3(HR) S:$L(HR)=1 HR=0_HR
 I HR=12&((TM["AM")!($E(TM,$L(TM)-1,$L(TM))="AM")) S HR="00"
 I HR<12&((TM["PM")!($E(TM,$L(TM)-1,$L(TM))="PM")) S HR=HR+12
 S TM=HR_MIN_SEC
 F I=$L(TM):-1:1 Q:$E(TM,I)'=0  I $E(TM,I)=0 S TM=$E(TM,1,I-1)
 Q $S($G(TM)'="":TM,1:"")
 ;
DT3(SEG) ; Only Numbers
 Q $$TRIM^XLFSTR($TR($$UP^XLFSTR(SEG),"ABCDEFGHIJKLMNOPQRSTUVWXYZ",""))
 ;
M(VAL) ; Minus One
 I VAL?.N S VAL=VAL-1 Q VAL
 I VAL?.A Q $$ALPHA(VAL)
 Q VAL
 ;
ALPHA(AL) ; Return the Prior Alpha
 N VAL,I,X
 S VAL="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 F I=1:1:26 I $E(VAL,I)=AL S X=I-1 Q
 Q $E(VAL,$G(X))
 ;
KEY(VAL,KEY) ; Value to Key
 I KEY="" Q 0
 I $E(VAL,1,$L(KEY))'=KEY Q 1
 Q 0
 ;
PAR ; Check Parameters
 D:$$GET^XPAR("SYS","DSIO EVAL LABS NOW") TASK("LAB^DSIO5")
 D:$$GET^XPAR("SYS","DSIO EVAL PROBLEMS NOW") TASK("PROBLEM^DSIO5")
 D:$$GET^XPAR("SYS","DSIO EVAL CONSULTS NOW") TASK("CONSULT^DSIO5")
 Q
 ;
TASK(ZTRTN) ; TaskMan
 N ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S ZTDESC="DSIO (MATERNITY TRACKER) Trigger on "_$P(ZTRTN,U)
 S ZTDTH=$$FMTH^XLFDT($$NOW^XLFDT),ZTIO="NULL",ZTPRI=10
 D ^%ZTLOAD
 Q
 ;
 ; --------------------------------- SORTING ----------------------------------
 ;
FN(P,C) ; Get the next record by dashboard page and count forward
 Q:P<2 0
 Q C*(P-1)
 ;
S(SORT) ; Set Start and End
 ;S STRT="",END="",SORT=$G(SORT),SORT=$G(SORT,"1,500")
 ;S:'(SORT?.N1",".N) SORT="1,500" S:$P(SORT,",",2)>500 SORT=$P(SORT,",")_",500"
 S STRT="",END="",SORT=$G(SORT)
 S STRT=$$FN($P(SORT,","),$P(SORT,",",2)),END=$P(SORT,",",2)
 Q
