Routine DSIO66 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO66^INT^64180,41051^Sep 19, 2016@11:24
DSIO66 ;DSS/TFF - DSIO DDCS DIALOG SUPPORT;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
LOOK(RET,CLASS,IEN) ; RPC: DSIO DDCS DIALOG LOOKUP
 I $G(IEN) D  Q
 . S RET=$P($G(^DSIO(19641.49,IEN,0)),U,3)
 S RET=$$FIND1^DIC(19641.49,,"X",$G(CLASS),"C")
 Q
 ;
DCITEM(IEN,OBJECT,SIEN) ; Return data for the DIALOG configuration collection
 ;
 ; *This will happen after DIALOG where all the interface's controls are populated
 ;  with configuration and/or restored data.
 ;
 ; Input variables - Same as DIALOG
 ;
 Q:$P($G(^DSIO(19641.49,+$G(IEN),2)),U,3)=""
 N TMP,ROU,DDCSCT
 S TMP=^DSIO(19641.49,IEN,2),ROU=$TR($P(TMP,U,3),"|",U)
 I $L($T(@ROU)) D
 . S @RET@(0)=$P(TMP,U)_":"_$$D($P(TMP,U,2)),DDCSCT=1 D @ROU
 D:$G(SIEN) RESTD^DSIO64(.RET,1,"##TCONFIGCOLLECTION##",OBJECT,IEN_";DSIO(19641.49,",SIEN,1)
 Q
 ;
D(C) ; Return the Delimiter from code
 Q:C="M" ","
 Q:C="H" "-"
 Q:C="P" "|"
 Q:C="S" ";"
 Q U
 ;
DIALOG(IEN,OBJECT,SIEN) ; Part of Configuration (CONFIG^DSIO63)
 ; *RUN ROUTINE VARIABLES:
 ;   ***DDCSCT,DDCSCON
 ;
 ;    IEN = IEN of 19641.49
 ;
 ; OBJECT = OBJECT of CONTROL
 ;          Example: 500000042;PXRMD(801.41,
 ;                   Which is the Reminder Dialog of IEN 500000042
 ;         = O=### (ORDER IEN)
 ;         = N=### ( NOTE IEN)
 ;
 ;   SIEN = Destination IEN - Record of Control
 ;
 ; RETURN:
 ;     CONTROL: CV^NAME^F^(INDEXED^VALUE)
 ;
 N DDCSCT,DDCSCON
 S DDCSCT=0,DDCSCON="" F  S DDCSCON=$O(^DSIO(19641.49,IEN,1,"B",DDCSCON)) Q:DDCSCON=""  D
 . D DCV(IEN,$O(^DSIO(19641.49,IEN,1,"B",DDCSCON,"")),$G(SIEN))
 Q
 ;
DCV(FORM,IEN,SIEN) ; CONTROL Configuration Value for Dialogs
 N STRT,FLG,IENS,LN S STRT=DDCSCT
 ; *** RUN ROUTINE
 ;     CV^NAME^F^(INDEX^VALUE)
 I $G(^DSIO(19641.49,FORM,1,IEN,4))'="" S FLG=1 D
 . X ^DSIO(19641.49,FORM,1,IEN,4)
 ; *** FREE TEXT
 ;     CV^NAME^F^(INDEX^VALUE)
 I '$D(FLG),$P($G(^DSIO(19641.49,FORM,1,IEN,2,0)),U,4)>0 D
 . S IENS=0 F  S IENS=$O(^DSIO(19641.49,FORM,1,IEN,2,IENS)) Q:'IENS  D
 . . S LN=^DSIO(19641.49,FORM,1,IEN,2,IENS,0)
 . . I LN'[U!(($P(LN,U)'?.N)&($P(LN,U)'["TRUE")) I $D(@RET@(DDCSCT-1)) D  Q
 . . . S @RET@(DDCSCT-1)=@RET@(DDCSCT-1)_LN
 . . S @RET@(DDCSCT)="CV^"_DDCSCON_"^F^"_LN,DDCSCT=DDCSCT+1
 ; *** RESTORE
 ;     A = DO NOT RESTORE
 Q:$P($G(^DSIO(19641.49,FORM,0)),U,5)["A"
 Q:$$UP^XLFSTR($$RITEM(FORM,IEN,"DONOTRESTORE"))="TRUE"
 D:$G(SIEN) RESTD^DSIO64(.RET,STRT,DDCSCON,OBJECT,FORM_";DSIO(19641.49,",SIEN)
 Q
 ;
OWNER(OBJECT) ; Get Owner IEN from OBJECT
 N CONTROL
 S CONTROL=$$OBJECT^DSIO65($G(OBJECT))
 Q $P($G(^DSIO(19641.4,CONTROL,0)),U,7)
 ;
REPORT(FORM,CON) ; Get the Report Item for a Control for an Interface/Form
 N IEN
 S IEN=$O(^DSIO(19641.49,FORM,1,"B",CON,"")) Q:'IEN ""
 Q $P($G(^DSIO(19641.49,FORM,1,IEN,0)),U,3)
 ;
RITEM(FORM,CON,PROP) ; Get the Report Item Value for a Control
 N IEN
 S PROP=$$UP^XLFSTR($G(PROP)) Q:PROP="" -1
 S IEN=$O(^DSIO(19641.49,FORM,1,CON,9,"B",PROP,"")) Q:'IEN -1
 Q ^DSIO(19641.49,FORM,1,CON,9,IEN,1)
 ;
IMPORT(RET,UNIT,CLASS,CON) ; RPC: DSIO DDCS DIALOG IMPORT
 ;
 ;  UNIT: Delphi Filename (.pas)
 ; CLASS: Custom Form class the inherits from TDDCSDialogs
 ;
 ; CON(TROLS):
 ;   (H) - CONTROL       ^ CONTROL_NAME ^ CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION
 ;   (C) - CONFIGURATION ^ CONTROL_NAME ^ VALUE
 ;   (R) - REPORT ITEM   ^ CONTROL_NAME ^ NAME ^ VALUE
 ;
 S RET=0 Q:$G(UNIT)=""!($G(CLASS)="")
 N IPT,IEN,SAVE,CT,CTRN,CTRI,DIK,DA
 S UNIT=$$UP^XLFSTR(UNIT),CLASS=$$UP^XLFSTR(CLASS)
 I '$O(^DSIO(19641.49,"D",UNIT,CLASS,"")) D
 . S IPT(19641.49,"?+1,",.01)="<"_$E(UNIT,5,$L(UNIT))_">"       ; DISPLAY NAME
 . S IPT(19641.49,"?+1,",.02)=UNIT                              ; UNIT
 . S IPT(19641.49,"?+1,",.03)=CLASS                             ; CLASS
 . D UPDATE^DIE(,"IPT") K IPT
 ; Since dialogs can be reused with different display names we need to
 ;  find all dialogs of this UNIT/CLASS and add their controls
 S RET=1 Q:'$D(CON)
 S IEN=0 F  S IEN=$O(^DSIO(19641.49,"D",UNIT,CLASS,IEN)) Q:'IEN  D
 . K SAVE
 . S CT="" F  S CT=$O(CON(CT)) Q:CT=""  D
 . . S CTRN=$$UP^XLFSTR($P(CON(CT),U,2)) S:CTRN'="" SAVE(CTRN)=""
 . . S CTRI=$$CTRI(IEN,CTRN)
 . . I $P(CON(CT),U)="H" S CTRI=$$HCTR(IEN,CTRI,CTRN,$P(CON(CT),U,3,6))
 . . Q:'CTRI
 . . I $P(CON(CT),U)="C" D CCTR(IEN,CTRI,$P(CON(CT),U,3)) Q
 . . I $P(CON(CT),U)="R" D RCTR(IEN,CTRI,$P(CON(CT),U,3),$P(CON(CT),U,4))
 . ; *** Delete controls no longer used
 . Q:'$D(SAVE)
 . S DIK="^DSIO(19641.49,"_IEN_",1,",DA(1)=IEN
 . S CTRN="" F  S CTRN=$O(^DSIO(19641.49,IEN,1,"B",CTRN)) Q:CTRN=""  D
 . . Q:$D(SAVE(CTRN))
 . . S DA=$O(^DSIO(19641.49,IEN,1,"B",CTRN,"")) D ^DIK
 Q
 ;
CTRI(IEN,NAM) ; Return Dialog Control IEN
 Q:NAM="" 0
 N CTRI S CTRI=$O(^DSIO(19641.49,IEN,1,"B",NAM,"")) Q:CTRI CTRI
 Q $$HCTR(IEN,CTRI,NAM)
 ;
HCTR(IEN,CTRI,NAM,PROP) ; Add/Update Control
 ;
 ; PROP = CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION
 ;
 N IPT,OUT
 I 'CTRI D
 . S IPT(19641.491,"?+1,"_IEN_",",.01)=NAM
 . D UPDATE^DIE(,"IPT","OUT") K IPT S CTRI=$G(OUT(1))
 Q:'CTRI CTRI
 S IPT(19641.491,CTRI_","_IEN_",",.02)=$P($G(PROP),U)     ; CLASS       (P)
 ;S IPT(19641.491,CTRI_","_IEN_",",.03)=$P($G(PROP),U,2)  ; PUSH        (P)
 S IPT(19641.491,CTRI_","_IEN_",",.04)=$P($G(PROP),U,3)   ; ID
 ;S IPT(19641.491,CTRI_","_IEN_",",.05)=$P($G(PROP),U,4)  ; OBSERVATION (P)
 D UPDATE^DIE("E","IPT")
 Q CTRI
 ;
CCTR(IEN,CTRI,VAL) ; CONFIGURATION (WP)
 K ^TMP($J,"DSIO66-CCTR")
 S ^TMP($J,"DSIO66-CCTR",1)=U_VAL
 D WP^DIE(19641.491,CTRI_","_IEN_",",2,"A","^TMP($J,""DSIO66-CCTR"")")
 K ^TMP($J,"DSIO66-CCTR")
 Q
 ;
RCTR(IEN,CTRI,NAM,VAL) ; REPORT ITEM
 N IPT
 S IPT(19641.4919,"?+1,"_CTRI_","_IEN_",",.01)=NAM
 S IPT(19641.4919,"?+1,"_CTRI_","_IEN_",",1)=VAL
 D UPDATE^DIE(,"IPT")
 Q
