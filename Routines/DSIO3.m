Routine DSIO3 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO3^INT^64180,40843^Sep 19, 2016@11:20
DSIO3 ;DSS/TFF - DSIO TIU SUPPORT;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$CLASS^TIUCP
 ; $$ISA^TIULX
 ; CANDO^TIUSRVA
 ; NEEDJUST^TIUSRVA
 ; WHATACT^TIUSRVA
 ; BLRSHELL^TIUSRVD
 ; DELETE^TIUSRVP
 ; LOCK^TIUSRVP
 ; MAKE^TIUSRVP
 ; MAKEADD^TIUSRVP
 ; SIGN^TIUSRVP
 ; UNLOCK^TIUSRVP
 ; UPDATE^TIUSRVP
 ; SAVED^TIUSRVP1
 ; SETTEXT^TIUSRVPT
 ; GET4EDIT^TIUSRVR
 ; $$SETGDATA^TIUSRVR1
 ; LOADTOP^TIUSRVR1
 ; TGET^TIUSRVR1
 ; INQUIRE^TIUSRVR2
 ;
 Q
 ;
CREATE(RET,DFN,TITLE,NOTE,DATA,SUBJ,PREG) ; RPC: DSIO CREATE A NOTE
 ;
 ; Visit information will come out of a configuration file
 ;
 ; ADDITIONAL PARAMETER TO SAVE DISCREET INFORMATION
 ; ARRAY(#)=(S,M,WP)^CONTROL^LABEL 1^INDEX(OPTIONAL ONLY FOR M)^VALUE
 ;
 ;  TIUX(.02)=PATIENT                       -UPDATE,ADDENDA
 ; TIUX(1202)=AUTHOR/DICTATOR
 ; TIUX(1205)=HOSPITAL LOCATION
 ; TIUX(1208)=EXPECTED COSIGNER
 ; TIUX(1301)=REFERENCE DATE/DT OF ENTRY    -UPDATE,ADDENDA
 ; TIUX(1302)=ENTERED BY                    -UPDATE,ADDENDA
 ; TIUX(1405)=PKGREF
 ; TIUX(1701)=SUBJECT
 ; TIUX(2101)=IDPARENT
 ;
 ; ORDER:
 ; CREATE - BOILER - LOCK - UPDATE - SET - UNLOCK
 ;
 N TIEN,VSTR,DTIUX,IEN,TMP,BLR S RET=-1
 ; *** Requirements
 I '$$TM^%ZTLOAD S RET="-1^TASKMAN must be running." Q
 I '$$CHECK^DSIO2($G(DFN)) S RET="-1^Patient entry not found." Q
 S TIEN=$$TITLE($G(TITLE)) I 'TIEN S RET="-1^Title not found." Q
 S VSTR=$$VISIT(TIEN)
 I 'VSTR S RET="-1^DSIO TITLE CONFIGURATION not setup for this TITLE." Q
 S DTIUX(1202)=DUZ                  ; AUTHOR/DICTATOR
 S DTIUX(1205)=$P(VSTR,";")         ; HOSPITAL LOCATION
 S DTIUX(1301)=$P(VSTR,";",2)       ; REFERENCE DATE
 S DTIUX(1701)=$G(SUBJ)             ; SUBJECT
 ; MAKE^TIUSRVP(.IEN,DFN,TITLE,VDT,VLOC,VSIT,TIUX,VSTR,SUPPRESS,NOASF)
 D MAKE^TIUSRVP(.IEN,DFN,TIEN,,,,.DTIUX,VSTR,1)
 I 'IEN S RET="-1^"_$P(IEN,U,2) Q
 D BLRSHELL^TIUSRVD(.TMP,TIEN,DFN,VSTR) I $D(TMP),$D(@TMP) M BLR("TEXT")=@TMP
 D UPDATE1
 Q
 ;
VISIT(TIEN) ; Get visit information from a TITLE
 ;
 ; [VDT]   = Date(/Time) of Visit
 ; [VLOC]  = Visit Location (HOSPITAL LOCATION)
 ; [VSIT]  = Visit file ien (#9000010)
 ; [VSTR]  = Visit string (i.e., VLOC;VDT;VTYPE)
 ;
 ; VTYPE = Service Category (SET OF CODES - 9000010(VISIT FILE) - .07)
 ;
 N VLOC,VTYPE
 S VLOC=$$GET1^DIQ(19641.5,TIEN_",",.02,"I") Q:'VLOC 0
 S VTYPE=$$GET1^DIQ(19641.5,TIEN_",",.03,"I") Q:$L(VTYPE)'=1 0
 Q VLOC_";"_$$NOW^XLFDT_";"_VTYPE
 ;
SET(RET,IEN,NOTE,DATA,SUBJ,PREG) ; RPC: DSIO UPDATE A NOTE
 ; 
 ; REQUIRED INPUT:
 ; ---------------
 ; IEN,NOTE
 ;
 ; THIS RETURN ALSO APPLIES TO CREATE AND ADDENDUM
 ; -----------------------------------------------
 ; If successful:
 ;   <IEN in TIU DOCUMENT FILE>^<LAST_PAGE_RECEIVED>^<TOTAL_PAGES_EXPECTED>
 ; 
 ; If unsuccessful:
 ;   0^0^0^Explanatory text
 ;
 N DFN,DTIUX S RET="0^Not found."
 I '$$TM^%ZTLOAD S RET="-1^TASKMAN must be running." Q
 Q:'$$AUTH(IEN,"EDIT RECORD")
 S DFN=$$GET1^DIQ(8925,$G(IEN),.02,"I") Q:'DFN
 S DTIUX(1301)=$$NOW^XLFDT
UPDATE1 ; Continue for Create, Set, and Addendum
 N PFLG,TASK,NOTIN,CT,I,X N:'$D(DTIUX) DTIUX
 S DTIUX(1202)=DUZ                  ; AUTHOR/DICTATOR
 S:$G(SUBJ)'="" DTIUX(1701)=SUBJ    ; SUBJECT
 ; *** If LCK is TRUE then FAILED to lock
 S RET=$$LCK(IEN) I RET S $P(RET,U)=-1 Q
 D UPDATE^TIUSRVP(.RET,IEN,.DTIUX,0)
 I RET<1 S $P(RET,U)=-1 D UNLCK(IEN) Q
 ; *** DDCS
 I $D(DATA) D
 . ; STORED(RET,OBJECT,DIEN,INFACE,IDATA,ACT)
 . N TASK D STORED^DSIO6(.TASK,$$TITLE(IEN)_";TIU(8925.1,",IEN,"OTHER",.DATA)
 I $D(BLR) M NOTIN=BLR S CT=$O(NOTIN("TEXT",""),-1)+1
 S:'$D(CT) CT=1 S X="" F I=CT:1 S X=$O(NOTE(X)) Q:X=""  S NOTIN("TEXT",I,0)=NOTE(X)
 ; <# of Current Page>^<Total # of Pages>
 S NOTIN("HDR")="1^1"
 D SETTEXT^TIUSRVPT(.RET,IEN,.NOTIN),UNLCK(IEN)
 I RET<1 S RET="-1^"_$P(RET,U,4) Q
 I $G(PREG),'$$SPG(DFN,IEN,PREG) S RET=+RET_"^Unable to associate pregnancy."
 Q
 ;
SPG(DFN,TIEN,PREG) ; Associate TIU note to a Pregnancy
 Q:'$G(PREG) 0
 Q:'$D(^DSIO(19641.13,PREG)) 0
 Q:$$GET1^DIQ(19641.13,PREG_",",.03,"I")'=DFN 0
 N DLAYGO,DIC,DA,X,Y,FDA,ERR
 S DLAYGO=19641.83
 S DIC="^DSIO(19641.83,",DIC(0)="XL",X="`"_DFN D ^DIC Q:+Y<1 0
 S FDA(19641.831,"?+1,"_DFN_",",.01)=TIEN
 S FDA(19641.831,"?+1,"_DFN_",",.02)=PREG
 D UPDATE^DIE(,"FDA",,"ERR") Q:$D(ERR) 0
 Q 1
 ;
ADDEN(RET,IEN,NOTE,DATA,SUBJ) ; RPC: DSIO MAKE ADDENDUM
 N DTIUX S RET="-1^Not authorized to make addenda."
 Q:'$$AUTH(IEN,"MAKE ADDENDUM")
 S DTIUX(1202)=DUZ                  ; AUTHOR/DICTATOR
 S DTIUX(1301)=$$NOW^XLFDT          ; REFERENCE DATE
 S:$G(SUBJ)'="" DTIUX(1701)=SUBJ    ; SUBJECT
 D MAKEADD^TIUSRVP(.RET,IEN,.DTIUX) I RET<1 S $P(RET,U)="-1" Q
 S IEN=RET D UPDATE1
 Q
 ;
 ; -------------------------------- VIEW TEXT ---------------------------------
 ;
GET(RET,IEN,TYP) ; RPC: DSIO GET RECORD TEXT
 ;
 ; - TYP 
 ;   = NULL - Whole note with addenda - FOR VIEW
 ;   = H    - ONLY the HEADER         - FOR VIEW
 ;   = B    - ONLY the BODY           - FOR EDIT
 ; 
 N FLD,OUT,I,LN,FLG,TIUARR,DATA,NCLSS,REC
 S RET=$NA(^TMP("TIUVIEW",$J)) K @RET S @RET@(0)="0^Nothing found." Q:'$G(IEN)
 I $G(TYP)="B" D  Q
 . S FLD=".01;.06;.07;1204;1205;1208;1301;1405;1701;2101;70201;70202"
 . D GET4EDIT^TIUSRVR(.OUT,IEN,FLD)
 . I $G(@OUT@(0))["~" S $P(@RET@(0),U,2)=$$TRIM^XLFSTR($P(@OUT@(0),"~",2),"L") Q
 . S I=0,LN=$NA(@OUT) F  S LN=$Q(@LN) Q:LN=""  Q:$QS(LN,1)'="TIUEDIT"!($QS(LN,2)'=$J)  D
 . . I @LN="$TXT" S FLG=1 Q
 . . Q:'$D(FLG)
 . . S @RET@(I)=@LN,I=I+1
 Q:'$$AUTH(IEN,"VIEW")
 I $G(TYP)="H" D  Q
 . S TIUARR=RET,DATA=$$SETGDATA^TIUSRVR1(IEN)
 . ; Set a flag to indicate whether or not a Title is a memer of the
 . ; Clinical Procedures Class (1=Yes and 0=No)
 . S NCLSS=+$$ISA^TIULX(+$G(^TIU(8925,IEN,0)),+$$CLASS^TIUCP)
 . ; Call INQUIRE to get record
 . D INQUIRE^TIUSRVR2(IEN,.REC,NCLSS)
 . D LOADTOP^TIUSRVR1(.REC,IEN,0,DATA,NCLSS)
 . K:$O(@RET@(""),-1) @RET@(0)
 D TGET^TIUSRVR1(.RET,IEN)
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
DELETE(RET,IEN,JUST) ; RPC: DSIO DELETE A NOTE
 S RET="-1^Not authorized to delete."
 Q:'$$AUTH(IEN,"DELETE RECORD")
 D NEEDJUST^TIUSRVA(.RET,IEN) I RET D  Q
 . S:$G(JUST)="" RET="-1^Justification for deletion is required."
 ; *** If LCK is TRUE then FAILED to lock
 S RET=$$LCK(IEN) I RET S $P(RET,U)=-1 Q
 D DELETE^TIUSRVP(.RET,IEN,$G(JUST))
 I RET<1 S RET=1
 E  S $P(RET,U)=-1
 ; *** UNLOCK is always TRUE
 D UNLCK(IEN)
 Q
 ;
SIGN(RET,IEN,SIG) ; RPC: DSIO SIGN A NOTE
 ;
 ; $$ENCRYP^XUSRB1 - DEBUG
 ;
 N ACT
 D SAVED^TIUSRVP1(.RET,IEN) I RET<1 S $P(RET,U)=-1 Q
 ; *** If LCK is TRUE then FAILED to lock
 S RET=$$LCK(IEN) I RET S $P(RET,U)=-1 Q
 D WHATACT^TIUSRVA(.ACT,IEN)
 I '$$AUTH(IEN,ACT) S RET="-1^Not authorized to sign." Q
 D SIGN^TIUSRVP(.RET,IEN,SIG)
 I RET<1 S RET=1
 E  S $P(RET,U)=-1
 ; *** UNLOCK is always TRUE
 D UNLCK(IEN)
 Q
 ;
 ; ------------------------------ TIU LIST ------------------------------------
 ;
LIST(RET,IEN,DFN,TITLES,FDT,TDT,DIRECT,PREG,SORT) ; RPC: DSIO GET TIU NOTES
 ;
 ;     IEN: NOTE IEN
 ;     DFN: PATIENT IEN
 ;  TITLES: ARRY OF TITLES TITLE(#)=TITLE
 ;     FDT: FROM DATE
 ;     TDT: TO DATE
 ;  DIRECT: DIRECTION OF SORT (1,-1) (defaults to 1)
 ;    PREG: IEN OF PREGNANCY HISTORY FILE (19641.13)
 ;    SORT: PAGE#,CT
 ;
 ; C    REGULAR
 ;           Field:  PATIENT  (8925,.02)
 ;     Description:  This REGULAR FileMan type cross-reference is used for
 ;                   look-up by patient.  
 ;                   1)= S ^TIU(8925,"C",$E(X,1,30),DA)=""
 ;                   2)= K ^TIU(8925,"C",$E(X,1,30),DA)
 ;
 ; **if NOTE IEN is not associated with PREG - DON'T INCLUDE
 ;
 ; RETURN: GLOBAL ARRAY
 ; ====================
 ;  IEN^TITLE(.01)^SUBJECT(1701)^STATUS(.05)^REFERENCE DATE(1301)^DUZ(1202I)^
 ;  AUTHOR/DICTATOR(1202E)^PARENT(.06)^ADDENDA("DAD" X-REF)(| DELIMITED)^PREG
 ;
 N CT,TL,RCT,TS,DATE,STRT,END D SORT($G(SORT))
 S RET=$NA(^TMP($J,"DSIO LIST")) K @RET S @RET@(0)="0^Nothing found."
 I $G(IEN) Q:'$D(^TIU(8925,IEN))  S @RET@(1)=$$L1(IEN),@RET@(0)=1 Q
 ; *** Requirements
 I '$G(DFN) S @RET@(0)="-1^Patient not provided." Q
 S CT=$NA(TITLES) F  S CT=$Q(@CT) Q:CT=""  S:@CT'="" TL($$UP^XLFSTR(@CT))=""
 I '$D(TL) S @RET@(0)="-1^Titles required." Q 
 I $G(PREG),'$D(^DSIO(19641.13,PREG)) S @RET@(0)="-1^Pregnacy not found." Q
 I $G(FDT)'="" D  Q:$P(@RET@(0),U)=-1
 . S FDT=$$DT^DSIO2(FDT)
 . I FDT="" S @RET@(0)="-1^Invalid from date time format."
 I $G(TDT)'="" D  Q:$P(@RET@(0),U)=-1
 . S TDT=$$DT^DSIO2(TDT)
 . I TDT="" S @RET@(0)="-1^Invalid to date time format."
 ; *** Search Start
 S (RCT,TS)=0,IEN="",DIRECT=+$G(DIRECT),DIRECT=$S(DIRECT=-1:-1,1:1)
 F  S IEN=$O(^TIU(8925,"C",DFN,IEN),DIRECT) Q:IEN=""  D
 . S DATE=$$GET1^DIQ(8925,IEN_",",1201,"I")
 . I $G(FDT)'="" Q:DATE=""!(DATE<FDT)
 . I $G(TDT)'="" Q:DATE=""!(DATE>TDT)
 . Q:'$D(TL($$UP^XLFSTR($$GET1^DIQ(8925,IEN_",",.01))))
 . Q:'$$STATUS(IEN)
 . I $G(PREG),'$$PG(IEN,PREG) Q
 . S TS=TS+1 I STRT'="",TS'>STRT Q
 . S RCT=RCT+1 I END'="",RCT>END Q
 . S @RET@(RCT)=$$L1(IEN)
 S:$G(TS) @RET@(0)=TS
 Q
 ;
L1(IEN) ; Continue
 N OUT,LINE,FLD,STR
 D GETS^DIQ(8925,IEN_",",".01;.05;.06;1202;1301;1701;","IE","OUT")
 S LINE=$NA(OUT) F  S LINE=$Q(@LINE) Q:LINE=""  S FLD($QS(LINE,3),$QS(LINE,4))=@LINE
 S STR=IEN_U
 S STR=STR_FLD(.01,"E")_U                       ; TITLE
 S STR=STR_FLD(1701,"E")_U                      ; SUBJECT
 S STR=STR_FLD(.05,"E")_U                       ; STATUS
 S STR=STR_$$FMTE^XLFDT(FLD(1301,"I"),"5Z")_U   ; REFERENCE DATE
 S STR=STR_FLD(1202,"I")_U                      ; DUZ
 S STR=STR_FLD(1202,"E")_U                      ; AUTHOR/DICTATOR
 S STR=STR_FLD(.06,"E")_U                       ; PARENT
 S STR=STR_$$DAD(IEN)_U                         ; ADDENDUM
 S STR=STR_$$PREG(IEN)                          ; PREGNANCY IEN
 Q STR
 ;
DAD(IEN) ; Create Addendum List
 N CT,RT
 S CT=0 F  S CT=$O(^TIU(8925,"DAD",IEN,CT)) Q:'CT  S RT=$G(RT)_$S($D(RT):"|",1:"")_CT
 Q $G(RT)
 ;
PG(IEN,PREG) ; Is the Note and PREGNACY associated?
 Q:'$G(IEN) 0
 I $$PREG(IEN)'=$G(PREG) Q 0
 Q 1
 ;
PREG(IEN) ; Get associated PREGNANCY
 Q:'$G(IEN) ""
 I '$G(DFN) N DFN S DFN=$$GET1^DIQ(8925,IEN_",",.02,"I") Q:'DFN ""
 N IENS
 S IENS=$O(^DSIO(19641.83,"N",IEN,DFN,"")) Q:'IENS ""
 Q $$GET1^DIQ(19641.831,IENS_","_DFN_",",.02,"I")
 ;
STATUS(IEN) ; Check the status of the note, can this user view it
 Q:'$$AUTH(IEN,"VIEW") 0
 Q 1
 ;
 ; ---------------------------------- COMMON ----------------------------------
 ;
SORT(SORT) ; Set Start and End
 D S^DSIO2(SORT)
 Q
 ;
TITLE(TITLE) ; Find Title IEN from TITLE as Alpha or 8925 IEN
 S TITLE=$$UP^XLFSTR($G(TITLE)) Q:TITLE="" ""
 Q:TITLE?.N $$GET1^DIQ(8925,TITLE_",",.01,"I")
 Q $O(^TIU(8925.1,"B",TITLE,""))
 ;
AUTH(IEN,ACT) ; TIU Authorization
 N RET
 D CANDO^TIUSRVA(.RET,IEN,ACT)
 Q +$G(RET)
 ;
LCK(IEN) ; TIU Lock Record
 ;
 ; 0 if the LOCK was GRANTED
 ; 1^<Explanatory Message> if LOCK was DENIED
 ;
 D LOCK^TIUSRVP(.OUT,IEN)
 Q $G(OUT)
 ;
UNLCK(IEN) ; TIU Unlock Record
 N OUT D UNLOCK^TIUSRVP(.OUT,IEN)
 Q
