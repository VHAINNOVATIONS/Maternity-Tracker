Routine DSIO02 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO02^INT^64180,40412^Sep 19, 2016@11:13
DSIO02 ;DSS/TFF - DSIO FORM CONFIGURATION;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
SUM ; Get Summary for Overview
 ; *19641.42 : OB H&P CONSULT, OB H&P INITIAL, OB FOLLOWUP NOTE : LBSUMMARY
 ;
 ; Summary statement sample: 29 yo G4P3003 at 35 5/7 weeks here for a return OB visit.
 ;  So, include: patient age, GA value, weeks and days (as fraction) of fetus age (35 5/7)
 ;
 N STR,PREG
 S STR=$$GET(2,.01)_" is a "_$$GET(2,.033)_"yr old "_$$GET(2,.02)_" patient with a "_$$GET(19641,.04)
 S PREG=$$PG^DSIO4(DFN) S:'PREG STR=STR_" and is not currently pregnant"
 S:PREG STR=STR_" and is at "_$$GA
 S @RET@(DDCSCT)="CV^"_DDCSCON_"^F^^"_STR
 Q
 ;
GET(FLE,FLD) ; GET1^DIQ for 2 and 19641 only
 N ANS
 S ANS=$$GET1^DIQ(FLE,DFN_",",FLD) Q:ANS'="" ANS
 Q "<NO DATA>"
 ;
GA() ; Get Patient's GA
 N GA S GA=$$GA^DSIO4(DFN,PREG)
 Q $S(GA'="":GA,1:"<NO DATA>")
 ;
 ; ----------------------------------------------------------------------------
 ;
PREG ; Get list of Historical Pregnancies
 ; *19641.49 : PREGNANCY HISTORY
 ;
 ;  L^IEN^DATE RECORDED^EDC^DFN|PATIENT^STATUS^FOF|(IEN OR IDENTIFIER)^
 ;    EDD^END^OB IEN|OB^FACILITY IEN|FACILITY^
 ;    UPDATED BY IEN|UPDATED BY^GESTATIONAL AGE AT DELIVERY^LENGTH OF LABOR^
 ;    TYPE OF DELIVERY^EPIDERAL/SPINAL^PRETERM DELIVERY^BIRTH TYPE^IEN;BABY#|IEN;BABY#^
 ;    OUTCOME^HIGH RISK FLAG(0,1)^DAYS IN HOSPITAL
 ;  C^IEN^COMMENT           (Delivery Notes)
 ;  B^IEN|BABY|#^COMMENT    (Baby Notes)
 ;
 N OUT,CT,LN,I,STR,BABY,CTC
 D PREGG^DSIO15(.OUT,$G(PG),DFN) Q:'$G(@OUT@(0))
 S CT=0 F  S CT=$O(@OUT@(CT)) Q:'CT  S LN=@OUT@(CT) D
 . I $P(LN,U)="L" D
 . . I $P(LN,U,19)'="" D  S $P(LN,U,19)=STR                                         ; BABIES
 . . . S STR=$P(LN,U,19) F I=1:1:$L(STR,"|") S $P(STR,"|",I)=$$PB(+$P(STR,"|",I))
 . . S $P(LN,U,13)=$$GA^DSIO4(,$P(LN,U,2))                                          ; GESTATIONAL AGE
 . . S $P(LN,U,17)=$S($P(LN,U,17)="YES":1,1:0)                                      ; PRETERM
 . . S $P(LN,U,20)=$$OTV^DSIO03($P(LN,U,20))                                        ; OUTCOME
 . S @RET@(DDCSCT)=LN,DDCSCT=DDCSCT+1
 . I $O(@OUT@(CT,"")) D
 . . S CTC=0 F  S CTC=$O(@OUT@(CT,CTC)) Q:'CTC  D                                   ; COMMENTS
 . . . I $P(@OUT@(CT,CTC),U)="C",$P(@OUT@(CT,CTC),U,2)=$P(LN,U,2) D
 . . . . S @RET@(DDCSCT)=@OUT@(CT,CTC),DDCSCT=DDCSCT+1
 . I $D(BABY(+$P(LN,U,2))) D PBC(+$P(LN,U,2))
 K @OUT
 Q
 ;
PB(IEN) ; IEN;NUMBER;NAME;GENDER;BIRTH WEIGHT;STILLBORN;APGAR1;APGAR2;STATUS;NICU
 N STR,OUT Q:'$G(IEN) ""
 S BABY(+$P(LN,U,2),IEN)=""
 S STR=$G(^DSIO(19641.112,IEN,0))
 Q $TR(IEN_";"_$P(STR,U)_";"_$P(STR,U,4,9)_";"_$P(STR,U,11,12),U,";")
 ;
PBC(IEN) ; B^IEN|BABY|#^COMMENT
 N CT,BLN,NUM
 S CT=0 F  S CT=$O(BABY(IEN,CT)) Q:'CT  D
 . S BLN=0 F  S BLN=$O(^DSIO(19641.112,CT,1,BLN)) Q:'BLN  D
 . . S NUM=$P(^DSIO(19641.112,CT,0),U)
 . . S @RET@(DDCSCT)="B^"_IEN_"|"_CT_"|"_NUM_U_^DSIO(19641.112,CT,1,BLN,0)
 . . S DDCSCT=DDCSCT+1
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
DELV ; Current Pregnancy
 ; *19641.42 : NURSE POSTPARTUM-DELIVERY
 ;
 N PG S PG=$$PG^DSIO4(DFN) Q:'PG
 D PREG
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
PERSON ; Get list of people associated with the patient
 ; *19641.49 : FAMILY HISTORY : LVPERSONLIST
 ;
 ;  IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^STATE^
 ;  ZIP^PHONE HOME^PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^DFN
 ;
 N OUT,CT,LN
 S @RET@(DDCSCT)="CV^"_DDCSCON_"^F^H^IEN^NAME^SEX^DOB^EDUCATION^STREET1^STREET2^STREET3^CITY^"
 S @RET@(DDCSCT)=@RET@(DDCSCT)_"STATE^ZIP^PHONE HOME^PHONE WORK^PHONE CELL^PHONE FAX^PATIENT^"
 S @RET@(DDCSCT)=@RET@(DDCSCT)_"DFN^RELATIONSHIP^STATUS^DIAGNOSIS|^COMMENTS"
 D PERSON^DSIO9(.OUT,DFN,,1) Q:'$G(OUT(0))
 S DDCSCT=DDCSCT+1,CT=0 F  S CT=$O(OUT(CT)) Q:'CT  S LN=OUT(CT) D
 . S @RET@(DDCSCT)="CV^"_DDCSCON_"^F^^"_LN
 . S $P(@RET@(DDCSCT),U,14)=$$GET1^DIQ(19641.11,+LN_",",1.5)
 . S $P(@RET@(DDCSCT),U,25)=$$GET1^DIQ(19641.11,+LN_",",4)
 . S DDCSCT=DDCSCT+1
 Q
