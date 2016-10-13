Routine DSIO4 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO4^INT^64203,38327^Oct 12, 2016@10:38
DSIO4 ;DSS/TFF - DSIO PREGNANCY X-REF AND FILE SUPPORT;08/26/2016 16:00
 ;;2.0;DSIO 2.0;**1**;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
 ; ------------------------------- UTILITIES ----------------------------------
 ;
PG(DFN) ; Get Current Pregnancy
 N DATE,IEN,FLG Q:'$G(DFN) ""
 S DATE="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE),-1) Q:DATE=""  D  Q:$D(FLG)
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN),-1) Q:IEN=""  D  Q:$D(FLG)
 . . I $P($G(^DSIO(19641.13,IEN,0)),U,4)="C" S FLG=IEN
 Q $G(FLG)
 ;
PSTAT(DFN) ; CURRENTLY PREGNANT
 I $$PG(DFN) Q "YES"
 Q "NO"
 ;
PGL(DFN) ; Get last PREGNANCY HISTORY record
 N DATE
 S DATE=$O(^DSIO(19641.13,"P",DFN,""),-1) Q:DATE="" ""
 Q $O(^DSIO(19641.13,"P",DFN,DATE,""),-1)
 ;
PGE(DFN) ; Get last PREGNANCY HISTORY record with an end
 N DATE,IEN,FLG
 S DATE="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE),-1) Q:DATE=""  D  Q:$D(FLG)
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN),-1) Q:IEN=""  D  Q:$D(FLG)
 . . I $P($G(^DSIO(19641.13,IEN,0)),U,7)'="" S FLG=IEN
 Q $G(FLG)
 ;
PGEL(DFN) ; Get last PREGNANCY HISTORY record with a live birth
 ; ***PREGNANCY MUST HAVE AN OBSERVATION USING LOINC 75092-7
 ;
 N DATE,IEN,OBS,FLG
 S DATE="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE),-1) Q:DATE=""  D  Q:$D(FLG)
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN),-1) Q:IEN=""  D  Q:$D(FLG)
 . . Q:$P($G(^DSIO(19641.13,IEN,0)),U,7)=""
 . . S OBS="" F  S OBS=$O(^DSIO(19641.12,"OBJ",IEN_";DSIO(19641.13,",OBS),-1) Q:OBS=""  D  Q:$D(FLG)
 . . . Q:$$GETCODE^DSIO10(OBS,"C",1)'="75092-7"
 . . . Q:$$GETCODE^DSIO10(OBS,"C",3)'="LOINC"
 . . . S FLG=IEN
 Q $G(FLG)
 ;
GA(DFN,PREG,FLG) ; Return Gestational Age of Pregnancy
 ;
 ; If FLG then return in number of days
 ;
 I '$G(PREG) S PREG=$$PG($G(DFN)) Q:'PREG ""
 N AGE S AGE=$$G1($TR($$UP^XLFSTR($$GET1^DIQ(19641.13,PREG_",",3.1))," "))
 Q $S($G(FLG):AGE,1:$$G2(AGE))
 ; *** Need to record How it was calucated in the DSIO EDD HISTORY file
 ;N EDC,EDD,END,DAYS,DATE
 ;S EDC=$$GET1^DIQ(19641.13,PREG_",",.02,"I")
 ;S EDD=$$GET1^DIQ(19641.03,$$GET1^DIQ(19641.13,PREG_",",.06,"I")_",",.01,"I")
 ;S END=$$GET1^DIQ(19641.13,PREG_",",.07,"I"),DAYS=""
 ;; *** Pregnancy has ENDed
 ;I EDC,END S DAYS=$$FMDIFF^XLFDT(END,EDC) Q $S($G(FLG):DAYS,1:$$G2(DAYS))
 ;Q:END!('EDD) $S($G(FLG):AGE,1:$$G2(AGE))
 ; *** Pregnancy is ongoing
 ;I EDC S DAYS=$$FMDIFF^XLFDT(DT,EDC) Q $S($G(FLG):DAYS,1:$$G2(DAYS))
 ; *** no END, no EDD, no EDC
 ;Q $S($G(FLG):AGE,1:$$G2(AGE))
 ;
G1(AGE) ; Convert #W#D to Numeric
 Q:AGE?.N1"W".N1"D" +AGE*7+$P($P(AGE,"D"),"W",2)
 Q:AGE?.N1"W" +AGE*7
 Q:AGE?.N1"D" +AGE
 Q:AGE?.N +AGE
 Q 0
 ;
G2(DAYS) ; Convert # to #W#D
 Q ((DAYS/7)\1)_"W"_(DAYS-(((DAYS/7)\1)*7))_"D"
 ;
GP(DFN) ; Return GravidaParaSummary
 Q:'$G(DFN) "G? P????"
 Q "G"_$$TOTAL(DFN)_" P"_$$FULLT(DFN)_$$PRETM(DFN)_$$ABORT(DFN)_$$LIVIG(DFN)
 ;
TOTAL(DFN) ; Return TOTAL PREGNANCIES
 N DATE,IEN,FLG Q:'$G(DFN) "?"
 S (FLG,DATE)="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN)) Q:IEN=""  D
 . . S FLG=FLG+1
 Q $S($G(FLG):FLG,1:"?")
 ;
ABORT(DFN,RET) ; Return Abortions, Terminations, and Ectopics
 N DATE,IEN,TYP,FLG Q:'$G(DFN) "?"
 S (FLG,DATE)="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S IEN="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN)) Q:IEN=""  D
 . . S TYP=$$OT^DSIO03($P($G(^DSIO(19641.13,IEN,3)),U,6))
 . . Q:TYP'="SpontaneousAbortion"&(TYP'="PregnancyTermination")&(TYP'="Ectopic")
 . . I $G(RET)="S" S:TYP="SpontaneousAbortion" FLG=FLG+1 Q
 . . I $G(RET)="T" S:TYP="PregnancyTermination" FLG=FLG+1 Q
 . . I $G(RET)="E" S:TYP="Ectopic" FLG=FLG+1 Q
 . . S FLG=FLG+1
 Q $S($G(FLG):FLG,$D(RET):0,1:"?")
 ;
STILL(DFN) ; Return STILLBIRTHS
 N DATE,IEN,BABY,OUT,FLG Q:'$G(DFN) "?"
 S (FLG,DATE)="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S IEN=0 F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN)) Q:'IEN  D
 . . Q:$$GET1^DIQ(19641.13,IEN_",",999.1)="NONE"
 . . S OUT=$S($$OT^DSIO03($P($G(^DSIO(19641.13,IEN,3)),U,6))="StillBirth":1,1:0)
 . . S BABY=0 F  S BABY=$O(^DSIO(19641.13,IEN,2,"B",BABY)) Q:'BABY  D
 . . . I OUT S FLG=FLG+1 Q
 . . . I $P($G(^DSIO(19641.112,BABY,0)),U,7) S FLG=FLG+1 Q
 . . . I $P($G(^DSIO(19641.112,BABY,0)),U,11)="D",+$$GA(DFN,IEN,1)>140 S FLG=FLG+1
 Q $S($G(FLG):FLG,1:"?")
 ;
PRETM(DFN) ; Return PRETERM (including stillborn)
 N DATE,IEN,GA,IFLG,BABY,FLG Q:'$G(DFN) "?"
 S (FLG,DATE)="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S (IFLG,IEN)="" F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN)) Q:IEN=""  D
 . . Q:$$GET1^DIQ(19641.13,IEN_",",999.1)="NONE"
 . . Q:$P($G(^DSIO(19641.13,IEN,3)),U,5)=0
 . . S GA=+$$GA(DFN,IEN,1) I GA,GA<259 S IFLG=1
 . . I $$OT^DSIO03($P($G(^DSIO(19641.13,IEN,3)),U,6))="PretermDelivery" S IFLG=1
 . . Q:'IFLG
 . . S BABY=0 F  S BABY=$O(^DSIO(19641.13,IEN,2,"B",BABY)) Q:'BABY  D
 . . . Q:$P($G(^DSIO(19641.112,BABY,0)),U,11)="D"
 . . . S FLG=FLG+1
 Q $S($G(FLG):FLG,1:"?")
 ;
LIVIG(DFN) ; Return LIVING
 N DATE,IEN,BABY,FLG Q:'$G(DFN) "?"
 S (FLG,DATE)="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S IEN=0 F  S IEN=$O(^DSIO(19641.13,"P",DFN,DATE,IEN)) Q:'IEN  D
 . . Q:$$GET1^DIQ(19641.13,IEN_",",999.1)="NONE"
 . . S BABY=0 F  S BABY=$O(^DSIO(19641.13,IEN,2,"B",BABY)) Q:'BABY  D
 . . . Q:$P($G(^DSIO(19641.112,BABY,0)),U,7)
 . . . Q:$P($G(^DSIO(19641.112,BABY,0)),U,11)="D"
 . . . S FLG=FLG+1
 Q $S($G(FLG):FLG,1:"?")
 ;
FULLT(DFN) ; Return TERM BIRTHS (including stillborn)
 N OUT
 S OUT=$$LIVIG(DFN)-$$PRETM(DFN)
 Q $S(OUT<0:"?",1:OUT)
 ;
EDDC(DFN) ; Get EDD for computed fields
 N PG,EDD
 S PG=$$PG^DSIO4(DFN) Q:'PG ""
 S EDD=$P(^DSIO(19641.13,PG,0),U,6) Q:'EDD ""
 Q $$FMTE^XLFDT($P(^DSIO(19641.03,EDD,0),U),"5Z")
 ;
LACT(DFN) ; CURRENTLY LACTATING
 N DATE,IEN
 S DATE=$O(^DSIO(19641,DFN,3,"B",""),-1) Q:DATE="" "NO"
 S IEN=$O(^DSIO(19641,DFN,3,"B",DATE,""),-1)
 Q $S($P(^DSIO(19641,DFN,3,IEN,0),U,2)="":"YES",1:"NO")
 ;
LACE(DFN) ; CURRENTLY LACTATING record
 N DATE
 S DATE=$O(^DSIO(19641,DFN,3,"B",""),-1) Q:DATE="" ""
 Q $O(^DSIO(19641,DFN,3,"B",DATE,""),-1)
 ;
TRACK(DFN,FL) ; Get TRACKING STATUS of a patient
 Q:'$G(DFN) 0
 N TR S TR=$O(^DSIO(19641.2,"S",DFN,""))
 Q:$D(FL) $S(TR="T":1,TR="F":2,1:0)
 Q $S(TR="T":"YES",TR="F":"FLAGGED",1:"NO")
 ;
HR(IEN) ; Return High Risk text
 Q:'$G(IEN) ""
 Q:'$P($G(^DSIO(19641.13,IEN,5,0)),U,4) ""
 N CT,STR
 S CT=0 F  S CT=$O(^DSIO(19641.13,IEN,5,CT)) Q:'CT  D
 . S STR=$S($D(STR):STR_" ",1:"")_^DSIO(19641.13,IEN,5,CT,0)
 Q $G(STR)
 ;
 ;=============================================================================
 ;                         X - R E F  S U P P O R T
 ;=============================================================================
 ; *** Syncs DSIO with WV and vice versa; however, DSIO cannot create X-REFs
 ;     for WV; therefore, at the time of this release WV will not update DSIO
 ;     and the updates for WV from TDrugs had not been released so there are
 ;     some updates here to files that do not yet exist.
 ;
 ; DSIO PREGNANCY HISTORY
 ;   - If "C" all other entries will be "HISTORICAL"; there can only be one "C"
 ;   - If there is a pregnancy with a future EDD and no pregnancy end then that
 ;     must be the current pregnancy and it will prevent a new "CURRENT"
 ;     pregnancy from being created
 ;   - If EDD is in the future and the entry is "CURRENT" then WV PATIENT .13 is
 ;     changed to "YES" and .14 is set with the EDD value
 ;   - If pregnancy end (future dates not allowed) and there isn't a pregnancy
 ;     history entry then the status is changed to "H" and WV PATIENT .13 is set
 ;     to "NO" and .14 is deleted
 ;
CURRENT(IEN) ; Should this record be CURRENT?
 ;
 ; Is there an entry with a future EDD and no pregnancy end?
 ; INPUT TRANSFORM for .04 STATUS
 ;
 N DFN,DATE,CT,FLG S FLG=1
 S DFN=$$GET1^DIQ(19641.13,IEN_",",.03,"I") Q:'DFN
 S DATE="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S CT=$O(^DSIO(19641.13,"P",DFN,DATE,""))
 . I $$GET1^DIQ(19641.03,CT_",",.06,"I")>=DT&($$GET1^DIQ(19641.03,CT_",",.07,"I")="") S FLG=0
 Q FLG
 ;
HIS(DFN,IEN) ; Kill HISTORICAL EDD X-REF
 ; *** NEW 'ASTATUS'
 ;
 I $D(^DSIO(19641.13,"EDD",DFN,+$O(^DSIO(19641.13,"EDD",DFN,"")),IEN)) D
 . K ^DSIO(19641.13,"EDD",DFN)
 Q
 ;
STATUS(DFN,IEN) ; Update PREGNANCY HISTORY statuses to "H" if current is "C"
 ; *** NEW 'ASTATUS'
 ;
 Q:$$GET1^DIQ(19641.13,$G(IEN)_",",.04,"I")'="C"
 N DATE,CT,DLAYGO,FDA,WVIEN
 S DATE="" F  S DATE=$O(^DSIO(19641.13,"P",DFN,DATE)) Q:DATE=""  D
 . S CT=$O(^DSIO(19641.13,"P",DFN,DATE,"")) Q:CT=IEN
 . S DLAYGO=19641.13
 . S FDA(19641.13,CT_",",.04)="H" D UPDATE^DIE(,"FDA") K FDA
 . D HIS(DFN,CT)
 . ;S WVIEN=$$GET1^DIQ(19641.13,CT_",",99.1,"I") Q:'WVIEN
 . ;S DLAYGO=790
 . ;S FDA(790.16,WVIEN_","_DFN_",",2)=0 D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
EDD(EDD,IEN) ; Update WV,DSIO PATIENT files when EDD is future
 ;
 ; New 'EDD' (Not on HISTORICAL entries)
 ; Create an "EDD" X-REF - Only one per patient
 ;
 I '$G(DFN) S DFN=$$GET1^DIQ(19641.13,IEN_",",.03,"I") Q:'DFN
 K ^DSIO(19641.13,"EDD",DFN)
 S:EDD'="@" ^DSIO(19641.13,"EDD",DFN,EDD,DA)="",EDD=$$GET1^DIQ(19641.03,EDD_",",.01,"I")
 Q:$D(DSIOSILENT)  N DSIOSILENT S DSIOSILENT=1
 Q:$$GET1^DIQ(19641.13,IEN_",",.04,"I")="H"
 ;N WVIEN,DLAYGO,FDA
 ;S WVIEN=$$GET1^DIQ(19641.13,IEN_",",99.1,"I")
 ;S DLAYGO=790
 ;S FDA(790.16,WVIEN_","_DFN_",",2)=1
 ;S FDA(790.16,WVIEN_","_DFN_",",3)=EDD
 ;D UPDATE^DIE(,"FDA") K FDA
 D STATUS(DFN,IEN)
 Q
 ;
DELV(DATE,DFN,IEN) ; Update WV,DSIO PATIENT files when PREGNANCY END is set
 Q:$D(DSIOSILENT)  N DSIOSILENT S DSIOSILENT=1
 Q:+$G(DATE)=0!($$GET1^DIQ(19641.13,IEN_",",.04,"I")="H")
 I DATE'>$$NOW^XLFDT D
 . N DLAYGO,FDA,WVIEN
 . S DLAYGO=19641.13,FDA(19641.13,IEN_",",.04)="H" D UPDATE^DIE(,"FDA") K FDA
 . K ^DSIO(19641.13,"EDD",DFN)
 . ;S DLAYGO=790,WVIEN=$$GET1^DIQ(19641.13,IEN_",",99.1,"I")
 . ;S FDA(790.16,WVIEN_","_DFN_",",2)=0
 . ;S FDA(790.16,WVIEN_","_DFN_",",3)=""
 . ;S FDA(790.16,WVIEN_","_DFN_",",4)=DATE
 . ;D UPDATE^DIE(,"FDA") K FDA D PTRK(DFN,0)
 Q
 ;
 ; -------------------------- WV PATIENT - (NEW) ------------------------------
 ;
WV(DFN,WVIEN) ; WOMEN'S HEALTH entry point
 ; *** REQUIRES WV X-REFS
 ;
 ; Update the current pregnancy with the new EDD from the WV PREGNANCY LOG
 ; or if there is no "CURRENT" pregnancy then create a new one
 ;
 ; Pregnancy log is triggered on field and this new style is set
 ; to trigger on record and the creation of the log
 ;
 Q:'$G(DFN)!('$G(WVIEN))
 N DLAYGO,CIEN,PREG,EDD,END,RET,FDA
 S DLAYGO=19641.13,CIEN=$$PG(DFN)
 S PREG=$$GET1^DIQ(790.16,WVIEN_","_DFN_",",2,"I")
 S EDD=$$GET1^DIQ(790.16,WVIEN_","_DFN_",",3,"I")
 S END=$$GET1^DIQ(790.16,WVIEN_","_DFN_",",4,"I") K:'END END
 I PREG=1,'CIEN D PREG^DSIO15(.RET,,DFN,"^^"_EDD,"C"),PTRK(DFN,PREG)
 E  I PREG=1,CIEN,EDD'="" D PREG^DSIO15(.RET,CIEN,DFN,"^^"_EDD,,,,,,,,,1)
 E  I 'PREG,CIEN D PREG^DSIO15(.RET,CIEN,DFN,U_$G(END,DT)_U,"H",,,,,,,,1),PTRK(DFN,PREG)
 I $G(RET) K FDA S FDA(19641.13,RET_",",99.1)=WVIEN D UPDATE^DIE(,"FDA")
 Q
 ;
PTRK(DFN,PREG) ; Track Pregnancy
 N RES,RET
 S RES="WV PATIENT FILE(790) PREGNANCY STATUS = "_$S(PREG:"YES",1:"NO")
 D REC^DSIO1(.RET,DFN,2,RES,,"TRIGGER")
 Q
 ;
 ; -------- WV PATIENT to DSIO MENSTRUAL HISTORY and DSIO PATIENT -------------
 ;
MH(DFN,WVIEN) ; Update DSIO with LMP
 ; *** REQUIRES WV X-REFS
 ;
 ; Starting Location = 790.15,2
 ; DSIO MENSTRUAL HISTORY (Link back at field 99.1)
 ; DSIO PATIENT : 1.2
 ;
 Q:$D(DSIOSILENT)!('$G(DFN))!('$G(WVIEN))
 N DSIOSILENT,DLAYGO,DATE,FDA,IEN
 S DSIOSILENT=1,DLAYGO=19641.01
 S DATE=$$GET1^DIQ(790.15,WVIEN_","_DFN_",",2,"I") Q:'DATE
 Q:$D(^DSIO(19641.01,"C",DFN,DATE))
 S FDA(19641.01,"+1,",.01)=DATE
 S FDA(19641.01,"+1,",.02)=DFN
 D UPDATE^DIE("U","FDA","IEN") K FDA S DLAYGO=19641
 I $D(IEN(1)) S FDA(19641,DFN_",",1.2)=IEN(1) D FILE^DIE(,"FDA")
 Q
 ;
MH1(DFN,DATE) ; From DSIO PATIENT to WV PATIENT
 Q:$D(DSIOSILENT)!('$G(DFN))!('$G(DATE))
 N DSIOSILENT,DLAYGO,FDA,WVIEN
 S DSIOSILENT=1,DLAYGO=790
 S FDA(790.15,"?+1,"_DFN_",",.01)=$$NOW^XLFDT
 S FDA(790.15,"?+1,"_DFN_",",2)=$$GET1^DIQ(19641.01,DATE_",",.01,"I")
 S FDA(790.15,"?+1,"_DFN_",",3)=DUZ
 D UPDATE^DIE(,"FDA","WVIEN") K FDA Q:'$G(WVIEN(1))
 S DLAYGO=19641.01
 S FDA(19641.01,DATE_",",99.1)=WVIEN(1) D UPDATE^DIE(,"FDA") K FDA
 Q
