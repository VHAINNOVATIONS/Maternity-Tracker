Routine DSIO99 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO99^INT^64180,41249^Sep 19, 2016@11:27
DSIO99 ;DSS/TFF - DSIO IMPORT/EXPORT TIU TITLES;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$MIXED^TIULS
 ;
 ; CLINICAL DOCUMENTS (CL)
 ;  +PROGRESS NOTES (CL)
 ;   +MATERNITY TRACKER (DC) - OR OTHER DOCUMENT CLASS
 ;    TITLE <- SELECT AT THIS LEVEL
 ;
UPDATE ; Start Auto Configuration
 N PATH,LOC,I,STR,TITLE,CAT,FILE,IEN,DIK
 W !!,"*******************************************************************************"
 W !,"Set the path where the TIU TITLE import files are located.",!
 S PATH=$$PATH($$DEFDIR^%ZISH)
 W !!,"*******************************************************************************",!!
 S LOC=$$FIND1^DIC(44,,"X","MATERNITY TRACKER") S:'LOC LOC=+$$ADD44
 F I=1:1 S STR=$P($T(TITLE+I),";;",2) Q:STR=""  D
 . S TITLE=$$TRIM^XLFSTR($P(STR,U))
 . S CAT=$$TRIM^XLFSTR($P(STR,U,2))
 . S FILE=$$TRIM^XLFSTR($P(STR,U,3))
 . S IEN=$$IMPORT(TITLE,PATH,FILE) Q:'IEN
 . D:LOC>0 CONFIG(IEN,CAT,LOC)
 S DIK="^DSIO(19641.4," D IXALL2^DIK   ; REINDEX KILL
 S DIK="^DSIO(19641.4," D IXALL^DIK    ; REINDEX SET
 Q
 ;
ADD44() ; Select a HOSIPITAL LOCATION for MATERNITY TRACKER
 N DIR,X,Y,DIRUT
 W !,"Choose your Maternity Tracker hospital location. All TIU notes created via the"
 W !,"dashboard will use this hospital location.",!
 S DIR(0)="P^44:AEQ"
 D ^DIR Q:$D(DIRUT) 0
 Q +$G(Y)
 ;
TITLE ; DSIO TIU TITLES
 ;;DASHBOARD CDA INCOMING                     ^E ^DSIO_TIU_TITLE_01.TXT
 ;;MCC DASHBOARD NOTE                         ^E ^DSIO_TIU_TITLE_02.TXT
 ;;MCC PROVIDER CONTACT                       ^T ^DSIO_TIU_TITLE_03.TXT
 ;;MD POSTPARTUM FOLLOWUP VISIT               ^E ^DSIO_TIU_TITLE_04.TXT
 ;;NURSE POSTPARTUM - DELIVERY                ^E ^DSIO_TIU_TITLE_05.TXT
 ;;NURSE POSTPARTUM - MATERNAL                ^E ^DSIO_TIU_TITLE_06.TXT
 ;;NURSE POSTPARTUM NOTE                      ^E ^DSIO_TIU_TITLE_07.TXT
 ;;OB FOLLOWUP NOTE                           ^E ^DSIO_TIU_TITLE_08.TXT
 ;;OB H&P CONSULT                             ^E ^DSIO_TIU_TITLE_09.TXT
 ;;OB H&P INITIAL                             ^E ^DSIO_TIU_TITLE_10.TXT
 ;;OB HISTORY NOTE                            ^E ^DSIO_TIU_TITLE_11.TXT
 ;;PHONE CALL #1 (FIRST CONTACT)              ^T ^DSIO_TIU_TITLE_12.TXT
 ;;PHONE CALL #2 (12 WEEKS)                   ^T ^DSIO_TIU_TITLE_13.TXT
 ;;PHONE CALL #3 (20 WEEKS)                   ^T ^DSIO_TIU_TITLE_14.TXT
 ;;PHONE CALL #4 (28 WEEKS)                   ^T ^DSIO_TIU_TITLE_15.TXT
 ;;PHONE CALL #5 (36 WEEKS)                   ^T ^DSIO_TIU_TITLE_16.TXT
 ;;PHONE CALL #6A (41 WEEKS NOT DELIVERED)    ^T ^DSIO_TIU_TITLE_17.TXT
 ;;PHONE CALL #6B (41 WEEKS DELIVERED) TOPICS ^T ^DSIO_TIU_TITLE_18.TXT
 ;;PHONE CALL #7 (6 WEEKS POSTPARTUM) TOPICS  ^T ^DSIO_TIU_TITLE_19.TXT
 ;;PHONE CALL - ADDITIONAL                    ^T ^DSIO_TIU_TITLE_20.TXT
 ;;
 Q
 ;
IMPORT(TITLE,PATH,FILE) ; Import XML TIU TITLE TRANSPORT
 N IEN,POP,RI,LN,TST,TYP,SUB,FLGB,FLGS,BLD,BSUB,IPT,CL,DCL
 S IEN=$O(^TIU(8925.1,"B",TITLE,"")) Q:IEN IEN
 Q:$G(PATH)="" ""  D OPEN^%ZISH("DSIO",PATH,FILE,"R")
 I POP W !,"*** Failed to open file - "_FILE,! Q ""
 D USE^%ZISUTL("DSIO")
 F RI=1:1 R LN:DTIME Q:$$STATUS^%ZISH  D
 . D DOTS(,"DSIO")
 . I "^<TIU_TITLE>^<TIU_DOCUMENT_CLASS>^<TIU_CLASS>^"[(U_LN_U) D  Q
 . . S TYP=$TR(LN,"<>") K SUB,FLGB,FLGS,BSUB
 . I "^</TIU_TITLE>^</TIU_DOCUMENT_CLASS>^</TIU_CLASS>^"[(U_LN_U) D  Q
 . . D SBLD
 . D PARSE
 D CLOSE^%ZISH("DSIO")
 Q $O(^TIU(8925.1,"B",TITLE,""))
 ;
SBLD ; Continue
 N TYPE,OWNER,VAR,I,NAME,STAT,OUSER
 Q:TYP="TIU_CLASS"&(+$G(CL)>0)
 Q:TYP="TIU_DOCUMENT_CLASS"&(+$G(DCL)>0)
 S TYPE=$S(TYP="TIU_DOCUMENT_CLASS":"DC",TYP="TIU_TITLE":"DOC",1:"") Q:TYPE=""
 S OWNER=$S(TYP="TIU_DOCUMENT_CLASS":+$G(CL),TYP="TIU_TITLE":+$G(DCL),1:"") Q:OWNER=""
 I OWNER=0&(TYP'="TIU_CLASS") D
 . S VAR=$S(TYP="TIU_DOCUMENT_CLASS":"CL",TYP="TIU_TITLE":"DCL")
 . S $P(@VAR,U)=$$FIND1^DIC(8925.1,,"X",$P(@VAR,U,2))
 I $D(BLD) F I=1:1:$L(BLD,",") I $P(BLD,",",I)[")=" D
 . I $P($P(BLD,",",I),")=")=.01 S NAME=$TR($P($P(BLD,",",I),")=",2),"""","")
 . I $P($P(BLD,",",I),")=")=.07 S STAT=$TR($P($P(BLD,",",I),")=",2),"""","")
 . I $P($P(BLD,",",I),")=")=.06 S OUSER=$TR($P($P(BLD,",",I),")=",2),"""","")
 D BUILD(NAME,TYPE,STAT,OUSER,OWNER)
 Q
 ;
BUILD(NAME,TYPE,STAT,OUSER,OWNER) ; Build TIU Entity and add to Owner
 ;
 ; INTERNAL
 ; TYPE : DOC (TITLE), DC (DOCUMENT CLASS) (ALL OTHERS REJECTED)
 ;
 N IPT,IEN,IENS
 Q:"^DOC^DC^"'[(U_$G(TYPE)_U)!($G(NAME)="")
 ; *** ADD TITLE (CREATE ENTRY), DO EXTERNAL VALIDATION
 S IPT(8925.1,"?+1,",.01)=NAME
 S IPT(8925.1,"?+1,",.06)=$G(OUSER,"CLINICAL COORDINATOR")
 D UPDATE^DIE("E","IPT","IEN") K IPT Q:'$G(IEN(1))
 I TYP="TIU_CLASS"&(+$G(CL)<1) S $P(CL,U)=IEN(1)
 I TYP="TIU_DOCUMENT_CLASS"&(+$G(DCL)<1) S $P(DCL,U)=IEN(1)
 S IPT(8925.1,IEN(1)_",",.03)=NAME                    ; .03 = PRINT NAME
 S IPT(8925.1,IEN(1)_",",.04)=TYPE
 S IPT(8925.1,IEN(1)_",",.07)=$$FIND1^DIC(8925.6,,"X","INACTIVE")
 D UPDATE^DIE(,"IPT") K IPT
 ; ADD ENTRY TO OWNER MULTIPLE
 S IPT(8925.14,"?+1,"_OWNER_",",.01)=IEN(1)
 S IPT(8925.14,"?+1,"_OWNER_",",4)=$$MIXED^TIULS(NAME)
 D UPDATE^DIE(,"IPT","IENS") K IPT
 S STAT=$$FIND1^DIC(8925.6,,"X",STAT)
 I STAT S IPT(8925.1,IEN(1)_",",.07)=STAT D UPDATE^DIE(,"IPT")
 Q
 ;
PARSE ; Continue
 Q:'$D(TYP)
 N FLD I LN["</"&(LN["NUMBER='") D
 . S FLD=$P($P(LN,"NUMBER=",2),"'",2)
 . I $D(SUB),$$VFIELD^DILFD($P(SUB,U),FLD) D  S FLGS=1 Q
 . . S BSUB=$S('$D(FLGS):"S ",1:$G(BSUB)_",")_"IPT("_$P(SUB,U)_","_"""?+1,"""_"_IEN_"","""_","_FLD_")="""_$P($P(LN,">",2),"<")_""""
 . Q:'$$VFIELD^DILFD(8925.1,FLD)
 . I TYP="TIU_CLASS"&(FLD=.01)&('$D(CL)) D
 . . S CL=$$FIND1^DIC(8925.1,,"X",$P($P(LN,">",2),"<"))_U_$P($P(LN,">",2),"<")
 . I TYP="TIU_DOCUMENT_CLASS"&(FLD=.01)&('$D(DCL)) D
 . . S DCL=$$FIND1^DIC(8925.1,,"X",$P($P(LN,">",2),"<"))_U_$P($P(LN,">",2),"<")
 . Q:TYP="TIU_CLASS"
 . Q:TYP="TIU_DOCUMENT_CLASS"&(+$G(DCL)>0)
 . I TYP="TIU_TITLE"&(FLD=.01) S TITLE=$P($P(LN,">",2),"<")
 . S BLD=$S('$D(FLGB):"S ",1:$G(BLD)_",")_"IPT(8925.1,IEN_"","""_","_FLD_")="""_$P($P(LN,">",2),"<")_""""
 . S FLGB=1
 I LN["SUB-FILE='" S SUB=$P($P(LN,"SUB-FILE=",2),"'",2)_U_$P($P(LN,"=",2),"'",2) Q
 I $D(SUB) I LN="</"_$P(SUB,U,2)_">" K SUB
 Q
 ;
CONFIG(IEN,CAT,LOC) ; Add/Edit DSIO TITLE CONFIGURATION (19641.5)
 N DIC,DIE,DA,X,Y,DIRUT
 S (DIC,DIE)="^DSIO(19641.5,",DIC(0)="XL",X="`"_IEN D ^DIC Q:+Y<1
 S DA=IEN,DR=".02////"_LOC_";.03////"_CAT D ^DIE
 Q
 ;
 ; -------------------------------- UTILITIES ---------------------------------
 ;
PATH(PATH) ; Default Path
 N DIR,X,Y,DIRUT
 S:$G(PATH)="" PATH=$S($$OS^%ZOSV["NT":"C:\HFS\",$$OS^%ZOSV["UNIX":"/hfs/")
 S DIR(0)="F^1:255",DIR("A")="Enter directory name or path",DIR("B")=PATH
 D ^DIR Q:$D(DIRUT) ""
 Q Y
 ;
DOTS(MSG,TAG) ; Write Dots to the Screen
 N WR D SWITCH("|TNT|") S WR="W "_$S($D(MSG):"!,MSG,!",1:""".""")
 X WR D SWITCH($G(TAG,"PARSE"))
 Q
 ;
SWITCH(TAG,FLG) ; Switch the Device and Return the Current
 N IEN,NEW
 I '$G(FLG),TAG["|TNT|" S NEW=$P(IO("HOME"),U,2) D HOME^%ZIS Q
 K IEN S IEN=$O(^TMP("XUDEVICE",$J,"B",TAG,"")) Q:IEN=""
 S IO=$G(^TMP("XUDEVICE",$J,IEN,"IO")) D USE^%ZISUTL(TAG)
 Q
 ;
 ; ---------------------------------- EXPORT ----------------------------------
 ;
EXPORT ; Collect TITLES and create XML EXPORT
 ;
 ; BLD(85,69,3)=""
 ; TITLE, DOCUMENT CLASS, CLASS
 ;
 N TL,FLG,DC,CL,ERR,BLD,PATH,FILE,POP,CT
 F  Q:'$$GET
 Q:'$D(BLD)
 S PATH=$$PATH($$DEFDIR^%ZISH)
 S CT=$NA(BLD) F  S CT=$Q(@CT) Q:CT=""  D
 . S FILE="DSIO_TIU_TITLE_"_$TR($$GET1^DIQ(8925.1,$QS(CT,1)_",",.01)," ","_")_".TXT"
 . D OPEN^%ZISH("TIU",PATH,FILE,"W") Q:POP
 . U IO
 . ; *** CLASS
 . W "<TIU_CLASS>",!
 . D GETFLDS(8925.1,$QS(CT,3),"LP",$O(^TIU(8925.1,$QS(CT,3),10,"B",$QS(CT,2),"")))
 . W "</TIU_CLASS>",!
 . ; *** DOCUMENT CLASS
  .W "<TIU_DOCUMENT_CLASS>",!
 . D GETFLDS(8925.1,$QS(CT,2),"L",$O(^TIU(8925.1,$QS(CT,2),10,"B",$QS(CT,1),"")))
 . W "</TIU_DOCUMENT_CLASS>",!
 . ; *** TITLE
 . W "<TIU_TITLE>",!
 . D GETFLDS(8925.1,$QS(CT,1))
 . W "</TIU_TITLE>",!
 . D CLOSE^%ZISH("TIU")
 Q
 ;
GET() ; Get Titles
 N DIC,DA,X,Y W !
 S:$D(TL) DIC("A")="ANOTHER: "
 S DIC("S")="I $P(^(0),U,4)=""DOC"""   ; *** ONLY TITLES
 S DIC="^TIU(8925.1,",DIC(0)="AEOQ" D ^DIC
 I +Y>0 D DCLGET(+Y) Q 1
 Q 0
 ;
GETFLDS(FLE,IEN,TYP,CHILD) ; Get fields and values
 N OUT,ERR,CT,FLG,SFLE,FLD
 D GETS^DIQ(FLE,IEN_",","**","E","OUT","ERR") Q:'$D(OUT)
 S CT=$NA(OUT) F  S CT=$Q(@CT) Q:CT=""  D
 . I $G(TYP)["L",$QS(CT,1)=8925.14,$P($QS(CT,2),",")'=CHILD Q
 . I $G(TYP)["P",$QS(CT,1)'=FLE Q
 . I $G(TYP)["P",$QS(CT,1)=FLE,$QS(CT,3)'=.01 Q
 . I $QS(CT,1)'=FLE,$D(FLG) D
 . . ;*** Different sub file or different sub file entry
 . . I $QS(CT,1)'=$P(FLG,U)!($QS(CT,2)'=$P(FLG,U,2)) K FLG D  Q
 . . . W "</"_$TR($O(^DD(SFLE,0,"NM",""))," ","_")_">",!
 . I $QS(CT,1)'=FLE,'$D(FLG) D
 . . S SFLE=$QS(CT,1),FLG=$QS(CT,1)_U_$QS(CT,2)_U_$QS(CT,3)
 . . W "<"_$TR($O(^DD(SFLE,0,"NM",""))," ","_")_" NAME='"
 . . W $O(^DD(SFLE,0,"NM",""))_"' SUB-FILE='"_SFLE_"'>",!
 . S FLD=$$GET1^DID($QS(CT,1),$QS(CT,3),,"LABEL") I @CT'="" D
 . . Q:$$GET1^DID($QS(CT,1),FLD,,"TYPE")="COMPUTED"
 . . W "<"_$TR(FLD," ","_")_" NAME='"_FLD_"' NUMBER='"_$QS(CT,3)_"'>",@CT
 . . W "</"_$TR(FLD," ","_")_">",!
 I $D(FLG) W "</"_$TR($O(^DD(SFLE,0,"NM",""))," ","_")_">",!
 Q
 ;
SETUP(VAR) ; Set up the DC and CL directory to find owners
 N LIST,CT,SUB,EX
 D LIST^DIC(8925.1,,"@","P",,,,,"I $P(^(0),U,4)="""_VAR_"""",,"LIST","ERR")
 K LIST("DILIST",0) Q:'$D(LIST)
 S CT=$NA(LIST) F  S CT=$Q(@CT) Q:CT=""  D
 . K SUB D LIST^DIC(8925.14,","_@CT_",","@;.01I","P",,,,,,,"SUB","ERR")
 . K SUB("DILIST",0) I $D(SUB) S EX="M "_VAR_"(@CT)=SUB" X EX
 Q
 ;
DCLGET(IEN) ; Get document class(DC) of title(TL) or class(CL) of DC
 I '$D(FLG) N I F I="DC","CL" D SETUP(I) S FLG=1
 N DCT,CCT,DCIEN,CLIEN
 S DCT=$NA(DC) F  S DCT=$Q(@DCT) Q:DCT=""  D
 . I $P(@DCT,U,2)=IEN S DCIEN=$QS(DCT,1) D
 . . S CCT=$NA(CL) F  S CCT=$Q(@CCT) Q:CCT=""  D
 . . . I $P(@CCT,U,2)=DCIEN S BLD(IEN,DCIEN,$QS(CCT,1))=""
 Q
