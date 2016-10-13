Routine DSIO64 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO64^INT^64180,40983^Sep 19, 2016@11:23
DSIO64 ;DSS/TFF - DSIO DDCS DATA RETURN;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ;
 ;
 Q
 ;
ELE(RET,OBJECT,INFACE,SIEN,ELE) ; RPC: DSIO DDCS GET CONTROL VALUE
 ;
 ; INPUT PARAMETERS:
 ; -----------------
 ;  OBJECT = OBJECT of CONTROL
 ;           Example: 500000042;PXRMD(801.41,
 ;                    Which is the Reminder Dialog of IEN 500000042
 ;         = O=### (ORDER IEN)
 ;         = N=### ( NOTE IEN)
 ;
 ; INFACE = IEN;DSIO(19641.42, (or NAME) 
 ;          or IEN;DSIO(19641.49,
 ;
 ;    SIEN = Destination IEN - Record of Control
 ;
 ;     ELE = Full Name of ELEMENT
 ;
 ; RETURN: 0^MESSAGE
 ;         Example:
 ;           RET(#)="101;VFD(21661,^MO_CLINICALCOMMENTS^03          ^       ^THESE ARE VALUES."
 ;           RET(#)=INTERFACE      ^ CONTROL NAME      ^ CONTROL ID ^ INDEX ^ VALUE
 ;
 S RET(0)="0^Nothing found."
 N NUM,CONTROL,DFLE,DFN,SHARE,DATA S NUM=1
 Q:$G(OBJECT)=""  S:OBJECT["=" SIEN=$P(OBJECT,"=",2)
 S CONTROL=$$OBJECT^DSIO65(OBJECT) Q:'CONTROL
 I $G(SIEN) D
 . S DFLE=$$GET1^DIQ(19641.4,CONTROL_",",.03,"I") Q:'DFLE
 . S DFN=$$DFN^DSIO6(CONTROL,SIEN)
 I $G(INFACE)'="" D  K:$G(RET(1))'="" RET(0) Q
 . S INFACE=$$INFACE^DSIO65($G(INFACE)),SHARE=$$SHARE(CONTROL,INFACE)
 . D D1
 Q:'$G(SIEN)&('$G(DFLE))
 S DATA=$O(^DSIO(19641.41,"B",SIEN_";"_$TR(^DIC(DFLE,0,"GL"),U),"")) Q:'DATA
 S INFACE="" F  S INFACE=$O(^DSIO(19641.41,DATA,1,"B",INFACE)) Q:INFACE=""  D
 . S SHARE=$$SHARE(CONTROL,INFACE)
 . D D1
 K:$G(RET(1))'="" RET(0)
 Q
 ;
D1 ; Continue
 N IEN
 I $G(SHARE),$G(DFN) D  Q
 . S IEN=$O(^DSIO(19641.4941,DFN,1,"B",INFACE,"")) Q:'IEN
 . I $G(ELE)'="" D D2(19641.4941) Q
 . S ELE="" F  S ELE=$O(^DSIO(19641.4941,DFN,1,IEN,1,"C",ELE)) Q:ELE=""  D
 . . D D2(19641.4941)
 Q:'$G(SIEN)&('$G(DFLE))
 S:'$D(DATA) DATA=$O(^DSIO(19641.41,"B",SIEN_";"_$TR(^DIC(DFLE,0,"GL"),U),"")) Q:'DATA
 S IEN=$O(^DSIO(19641.41,DATA,1,"B",INFACE,"")) Q:'IEN
 I $G(ELE)'="" D D2(19641.41) Q
 S ELE="" F  S ELE=$O(^DSIO(19641.41,DATA,1,IEN,1,"C",ELE)) Q:ELE=""  D
 . D D2(19641.41)
 Q
 ;
D2(FLE) ; Continue
 N IENS,IELE
 I FLE=19641.41 D
 . S IENS=$O(^DSIO(19641.41,DATA,1,IEN,1,"C",ELE,"")) Q:'IENS
 . S IELE=^DSIO(19641.41,DATA,1,IEN,1,IENS,0)
 I FLE=19641.4941 Q:'$G(DFN)  D
 . S IENS=$O(^DSIO(19641.4941,DFN,1,IEN,1,"C",ELE,"")) Q:'IENS
 . S IELE=^DSIO(19641.4941,DFN,1,IEN,1,IENS,0)
 Q:'$G(IELE)
 D VAL(IELE,INFACE_U_ELE_U_$$ID(ELE,INFACE))
 Q
 ;
VAL(IEN,ID) ; Get Value
 ;
 ; There's an extra caret in the value wp for the storage of the index value
 ;
 N CT S CT=0 F  S CT=$O(^DSIO(19641.45,IEN,1,CT)) Q:'CT  D
 . S RET(NUM)=ID_U_^DSIO(19641.45,IEN,1,CT,0),NUM=NUM+1
 Q
 ;
SHARE(CONTROL,INFACE) ; Determine if the INTERFACE/FORM should be SHARED
 N SHARE
 S SHARE=$$GET1^DIQ(19641.4,$G(CONTROL)_",",.06,"I")
 ; *** LIMITED or not set - Allow the INTERFACE/FORM decide
 I $G(INFACE)'=""&(SHARE=2!(SHARE="")) Q $$SE
 Q $S(SHARE:1,1:0)
 ;
SE() ; Continue
 Q:$G(INFACE)[";DSIO(19641.49," $S($$GET1^DIQ(19641.49,+INFACE_",",.04,"I"):1,1:0)
 Q $S($$GET1^DIQ(19641.42,+INFACE_",",.03,"I"):1,1:0)
 ;
ID(CONTROL,INFACE) ; Get assigned ID
 N IEN,PG,IENS
 Q:$G(CONTROL)=""!($G(INFACE)="") ""
 S IEN=$O(^DSIO(19641.42,"B",INFACE,"")) S:'IEN IEN=$O(^DSIO(19641.42,"P",INFACE,"")) Q:'IEN ""
 S PG=$O(^DSIO(19641.42,IEN,1,"CONTROL",CONTROL,"")) Q:'PG ""
 S IENS=$O(^DSIO(19641.42,IEN,1,"CONTROL",CONTROL,PG,""))
 Q $P(^DSIO(19641.42,IEN,1,PG,1,IENS,0),U,4)
 ;
IMPORT(RET,INFACE,CON) ; RPC: DSIO DDCS IMPORT FORM
 ;
 ; INFACE = IEN;DSIO(19641.42, (or NAME)
 ;          or IEN;DSIO(19641.49,
 ;
 ; CON(TROLS):
 ;   (H) - CONTROL       ^ PAGE# ^ CONTROL_NAME ^ CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION
 ;   (C) - CONFIGURATION ^ PAGE# ^ CONTROL_NAME ^ VALUE
 ;   (R) - REPORT ITEM   ^ PAGE# ^ CONTROL_NAME ^ NAME | VALUE
 ;
 N IEN,CT,CTRN,SAVE,IPT,PG,CTRI,DIK,DA S RET=0
 S INFACE=$$INFACE^DSIO65($G(INFACE)) Q:INFACE'[";DSIO(19641.42,"
 S IEN=+INFACE,CT=$NA(CON) F  S CT=$Q(@CT) Q:CT=""  D
 . Q:'$P(@CT,U,2)
 . S CTRN=$$UP^XLFSTR($P(@CT,U,3)) S:CTRN'="" SAVE(CTRN)=""
 . S IPT(19641.421,"?+1,"_IEN_",",.01)=+$P(@CT,U,2)
 . K PG D UPDATE^DIE("E","IPT","PG") K IPT Q:'$G(PG(1))
 . S IPT(19641.4211,"?+1,"_PG(1)_","_IEN_",",.01)=CTRN
 . K CTRI D UPDATE^DIE("E","IPT","CTRI") K IPT Q:'$G(CTRI(1))
 . I $P(@CT,U)="H" D  Q
 . . S IPT(19641.4211,CTRI(1)_","_PG(1)_","_IEN_",",.02)=$P(@CT,U,4)
 . . D UPDATE^DIE("E","IPT") K IPT
 . I $P(@CT,U)="C" D CCTR(IEN,PG(1),CTRI(1),$P(@CT,U,4)) Q
 . I $P(@CT,U)="R" D RCTR(IEN,PG(1),CTRI(1),$P(@CT,U,4,999))
 ; *** Delete controls no longer used
 S RET=1 Q:'$D(SAVE)
 K PG S PG=0 F  S PG=$O(^DSIO(19641.42,IEN,1,PG)) Q:'PG  D
 . S DIK="^DSIO(19641.42,"_IEN_",1,"_PG_",1,",DA(1)=PG,DA(2)=IEN
 . S CTRN="" F  S CTRN=$O(^DSIO(19641.42,IEN,1,PG,1,"B",CTRN)) Q:CTRN=""  D
 . . Q:$D(SAVE(CTRN))
 . . S DA=$O(^DSIO(19641.42,IEN,1,PG,1,"B",CTRN,"")) D ^DIK
 Q
 ;
CCTR(IEN,PG,CTRI,VAL) ; CONFIGURATION (WP)
 K ^TMP($J,"DSIO64-CCTR")
 S ^TMP($J,"DSIO64-CCTR",1)=U_VAL
 D WP^DIE(19641.4211,CTRI_","_PG_","_IEN_",",2,"A","^TMP($J,""DSIO64-CCTR"")")
 K ^TMP($J,"DSIO64-CCTR")
 Q
 ;
RCTR(IEN,PG,CTRI,ITEM) ; REPORT ITEM
 N PC,STR,IPT
 F PC=1:1:$L(ITEM,U) D
 . S STR=$P(ITEM,U,PC) Q:$P(STR,"|")=""!($P(STR,"|",2)="")
 . S IPT(19641.42119,"?+1,"_CTRI_","_PG_","_IEN_",",.01)=$P(STR,"|")
 . S IPT(19641.42119,"?+1,"_CTRI_","_PG_","_IEN_",",1)=$P(STR,"|",2)
 . D UPDATE^DIE(,"IPT") K IPT
 Q
 ;
 ; ----------------------------------------------------------------------------
 ;
 ;   STRT = The node of the return array that the control data begins
 ;
 ;    CON = The name of the CONTROL ELEMENT
 ;
 ; OBJECT = OBJECT of CONTROL
 ;          Example: 500000042;PXRMD(801.41,
 ;                   Which is the Reminder Dialog of IEN 500000042
 ;         = O=### (ORDER IEN)
 ;         = N=### ( NOTE IEN)
 ;
 ; INFACE = IEN;DSIO(19641.42, (or NAME)
 ;          or IEN;DSIO(19641.49,
 ;
 ;   SIEN = Destination IEN - Record of Control
 ;
 ; RETURN
 ;     CONTROL: CV^NAME^F^(INDEXED^VALUE)
 ;
RESTF(RET,STRT,IEN,PG,CON,OBJECT,INFACE,SIEN,CITEM) ; Restore Saved Data (FORMS)
 N OUT,VAL,I,CT
 ; RET(#)=INTERFACE ^ CONTROL NAME ^ CONTROL ID ^ INDEX ^ VALUE
 D ELE(.OUT,OBJECT,$S($D(SINFACE):SINFACE,1:INFACE),SIEN,CON) Q:$D(OUT(0))
 S VAL=$S($O(OUT(""),-1)=1:$P(OUT(1),U,4,999),1:"")
 I $$LIST^DSIO62(INFACE,CON) D  Q
 . F I=STRT:1:$O(@RET@(""),-1) D
 . . I $P(@RET@(I),U,5,999)=$P(VAL,U,2,999) S $P(@RET@(I),U,4)="TRUE"
 F I=STRT:1:$O(@RET@(PG,IEN,0),-1) K @RET@(PG,IEN,I)
 S DDCSCT=STRT,CT="" F  S CT=$O(OUT(CT)) Q:CT=""  D
 . I $G(CITEM) S @RET@(DDCSCT)=$P(OUT(CT),U,4,999),DDCSCT=DDCSCT+1 Q
 . S @RET@(PG,IEN,"CV",DDCSCT)="CV^"_CON_"^F^"_$P(OUT(CT),U,4,999),DDCSCT=DDCSCT+1
 Q
 ;
RESTD(RET,STRT,CON,OBJECT,INFACE,SIEN,CITEM) ; Restore Saved Data (DIALOGS)
 N OUT,VAL,I,CT
 ; RET(#)=INTERFACE ^ CONTROL NAME ^ CONTROL ID ^ INDEX ^ VALUE
 D ELE(.OUT,OBJECT,INFACE,SIEN,CON) Q:$D(OUT(0))
 S VAL=$S($O(OUT(""),-1)=1:$P(OUT(1),U,4,999),1:"")
 I $$LIST^DSIO62(INFACE,CON) D  Q
 . F I=STRT:1:$O(@RET@(""),-1) D
 . . I $P(@RET@(I),U,5,999)=$P(VAL,U,2,999) S $P(@RET@(I),U,4)="TRUE"
 F I=STRT:1:$O(@RET@(""),-1) K @RET@(I)
 S DDCSCT=STRT,CT="" F  S CT=$O(OUT(CT)) Q:CT=""  D
 . I $G(CITEM) S @RET@(DDCSCT)=$P(OUT(CT),U,4,999),DDCSCT=DDCSCT+1 Q
 . S @RET@(DDCSCT)="CV^"_CON_"^F^"_$P(OUT(CT),U,4,999),DDCSCT=DDCSCT+1
 Q
