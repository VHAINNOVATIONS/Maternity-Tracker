Routine DSIO7 saved using VFDXTRS routine on Oct 13, 2016 17:20
DSIO7^INT^64180,41180^Sep 19, 2016@11:26
DSIO7 ;DSS/TFF - DSIO VPR FOR IHE;08/26/2016 16:00
 ;;2.0;DSIO 2.0;;Aug 26, 2016;Build 1
 ;
 ; External References      DBIA#
 ; -------------------      -----
 ; $$GETDFN^MPIF001
 ; TFL^VAFCTFU1
 ; $$SITE^VASITE
 ; $$ALL^VPRD
 ; $$ESC^VPRD
 ; $$RTN^VPRD
 ; ADD^VPRD
 ; ERR^VPRD
 ; $$FORMAT^VPRDPT
 ; ADD^VPRDPT
 ; ADDR^VPRDPT
 ; ALIAS^VPRDPT
 ; ATC^VPRDPT
 ; DEM^VPRDPT
 ; PHONE^VPRDPT
 ; PRF^VPRDPT
 ; SUPP^VPRDPT
 ; SVC^VPRDPT
 ; $$IEN^XUAF4
 ;
 Q
 ;
GET(VPR,DFN,TYPE,START,STOP,MAX,ID,FILTER) ; RPC: DSIO VPR GET PATIENT DATA
 N ICN,VPRI,VPRTOTL,VPRTEXT
 S VPR=$NA(^TMP("VPR",$J)) K @VPR
 S VPRTEXT=+$G(FILTER("text")) ;include report/document text?
 ;
 ; parse & validate input parameters
 S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN),ID=$G(ID)
 I DFN<1,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 S TYPE=$$LOW^XLFSTR($G(TYPE)) I TYPE="" D
 .S TYPE=$$ALL^VPRD_";author;participant"
 I TYPE'="new",DFN<1!'$D(^DPT(DFN)) D ERR^VPRD(1,DFN) G GTQ
 S:'$G(START) START=1410102 S:'$G(STOP) STOP=4141015 S:'$G(MAX) MAX=9999
 I START,STOP,STOP<START N X S X=START,START=STOP,STOP=X  ;switch
 I STOP,$L(STOP,".")<2 S STOP=STOP_".24"
 I ID="",$D(FILTER("id")) S ID=FILTER("id")
 ;
 ; extract data
 N VPRTYPE,VPRP,VPRHDR,VPRTAG,VPRTN
 S VPRTYPE=TYPE D ADD^VPRD("<results version='1.1' timeZone='"_$$TZ^XLFDT_"' >")
 F VPRP=1:1:$L(VPRTYPE,";") S VPRTAG=$P(VPRTYPE,";",VPRP) I $L(VPRTAG) D
 . S VPRTN=$$RTN(.VPRTAG) Q:'$L($T(@VPRTN))
 . D ADD^VPRD("<"_VPRTAG) S VPRHDR=VPRI,VPRTOTL=0
 . D @(VPRTN_"(DFN,START,STOP,MAX,ID)")
 . S @VPR@(VPRHDR)=@VPR@(VPRHDR)_" total='"_+$G(VPRTOTL)_"' >" D ADD^VPRD("</"_VPRTAG_">")
 D ADD^VPRD("</results>")
GTQ ; end
 Q
 ;
RTN(X) ; -- Return name of VPRDxxxx routine for clinical domain X
 ;  X is also enforced as expected group tag name, if passed by ref
 N Y S Y="VPRD",X=$G(X) I X="" Q Y
 I X["patient" S Y="EN^DSIO7",X="demographics"
 E  I X["demograph" S Y="EN^DSIO7",X="demographics"
 E  I X["author" S Y="AUT^DSIO7",X="author"
 E  I X["participant" S Y="PAR^DSIO7",X="participant"
 E  S Y="EN^"_$$RTN^VPRD(X)
 Q Y
 ;
 ;=============================================================================
 ;                            PATIENT/DEMOGRAPHICS
 ;=============================================================================
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find current patient demographics
 ; [BEG,END,MAX,ID not currently used]
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 N PAT,SYS S SYS=$$SITE^VASITE
 D DEM^VPRDPT,SVC^VPRDPT,PRF^VPRDPT,ATC^VPRDPT,SUPP^VPRDPT
 D ALIAS^VPRDPT,FAC,GAR,BIR
 I $D(PAT)>9 D XMLPD(.PAT)
 Q
 ;
FAC ;-treating facilities [see FACLIST^ORWCIRN]
 N IFN S DFN=+$G(DFN) Q:DFN<1
 N VPRY,HOME,LAST,I,X,IEN
 I $L($T(TFL^VAFCTFU1)) D TFL^VAFCTFU1(.VPRY,DFN)
 S HOME=+$P($G(^DPT(DFN,"MPI")),U,3) ;home facility
 I $P($G(VPRY(1)),U)<0 D  Q  ;not setup
 . S X=$O(^AUPNVSIT("AA",DFN,0)),LAST=$S(X:9999999-$P(X,"."),1:"")
 . S X=$$SITE^VASITE
 . S PAT("facility",+X)=$P(X,U,3)_U_$P(X,U,2)_U_LAST_U_$$GET1^DIQ(4,+X_",",60)_U_$$GET1^DIQ(4,+X_",",41.99)
 . ;street1^st2^city^state^zip
 . S $P(PAT("facility",+X),U,6)=$$GET1^DIQ(4,+X_",",1.01)
 . S $P(PAT("facility",+X),U,7)=$$GET1^DIQ(4,+X_",",1.02)
 . S $P(PAT("facility",+X),U,8)=$$GET1^DIQ(4,+X_",",1.03)
 . S $P(PAT("facility",+X),U,9)=$$GET1^DIQ(4,+X_",",.02)
 . S $P(PAT("facility",+X),U,10)=$$GET1^DIQ(4,+X_",",1.04)
 S I=0 F  S I=$O(VPRY(I)) Q:I<1  D
 . S X=VPRY(I) Q:$P(X,U)=""  ;unknown
 . S IEN=+$$IEN^XUAF4($P(X,U))
 . I +X=776!(+X=200) S $P(X,U,2)="DEPT. OF DEFENSE"
 . S PAT("facility",IEN)=$P(X,U,1,3) ;stn# ^ name ^ last date ^ VistA domain ^ npi
 . S $P(PAT("facility",IEN),U,4)=$$GET1^DIQ(4,IEN_",",60)_U_$$GET1^DIQ(4,IEN_",",41.99)
 . ;street1^st2^city^state^zip
 . S $P(PAT("facility",IEN),U,6)=$$GET1^DIQ(4,IEN_",",1.01)
 . S $P(PAT("facility",IEN),U,7)=$$GET1^DIQ(4,IEN_",",1.02)
 . S $P(PAT("facility",IEN),U,8)=$$GET1^DIQ(4,IEN_",",1.03)
 . S $P(PAT("facility",IEN),U,9)=$$GET1^DIQ(4,IEN_",",.02)
 . S $P(PAT("facility",IEN),U,10)=$$GET1^DIQ(4,IEN_",",1.04)
 . I IEN=HOME S $P(PAT("facility",IEN),U,11)=1
 Q
 ;
GAR ;-guardian
 S PAT("guardian")=$$GET1^DIQ(2,DFN_",",.2912)_U_$$GET1^DIQ(2,DFN_",",.2922) ;va^civil
 Q
 ;
BIR ;-birthplace
 S PAT("birthplace")=$$GET1^DIQ(2,DFN_",",.092)_U_$$GET1^DIQ(2,DFN_",",.093) ;city^state
 Q
 ;
XMLPD(ITEM) ; -- Return patient data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD^VPRDPT("<patient>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ITEM(ATT)) Q:ATT=""  D  D:$L(Y) ADD^VPRDPT(Y)
 . I ATT="exposures" D:X["1"  S Y="" Q
 .. S I=0,Y="<exposures>" D ADD^VPRDPT(Y)
 .. F ID="AO","IR","PG","HNC","MST","CV" S I=I+1 I $P(X,U,I) S Y="<exposure value='"_ID_"' />" D ADD^VPRDPT(Y)
 .. D ADD^VPRDPT("</exposures>")
 . I $L($O(ITEM(ATT,""))) D  Q  ;multiples
 .. S ID=$S($E(ATT,$L(ATT))="s":ATT_"es",$E(ATT,$L(ATT))="y":$E(ATT,1,$L(ATT)-1)_"ies",1:ATT_"s")
 .. D ADD^VPRDPT("<"_ID_">")
 .. S I="" F  S I=$O(ITEM(ATT,I)) Q:I=""  D  D:$L(Y) ADD^VPRDPT(Y)
 ... S X=ITEM(ATT,I),Y="<"_ATT_" "
 ... I ATT="support" D  S Y="" Q
 .... S Y=Y_"contactType='"_I_"' name='"_$$ESC^VPRD($P(X,U))_$S($L($P(X,U,2)):"' relationship='"_$$ESC^VPRD($P(X,U,2)),1:"")_"' >" D ADD^VPRDPT(Y)
 .... S X=$G(ITEM(ATT,I,"address")) I $L(X) D ADDR^VPRDPT(X)
 .... S X=$G(ITEM(ATT,I,"telecom")) I $L(X) D PHONE^VPRDPT(X)
 .... D ADD^VPRDPT("</support>")
 ... I ATT="alias" S Y=Y_"fullName='"_$$ESC^VPRD(X)_$S(X[",":"' familyName='"_$$ESC^VPRD($P(X,","))_"' givenNames='"_$$ESC^VPRD($P(X,",",2,99)),1:"")_"' />" Q
 ... I ATT="flag" S Y=Y_"name='"_$$ESC^VPRD($P(X,U))_"' text='"_$$ESC^VPRD($P(X,U,2))_"' />" Q
 ... I ATT="facility" D ADDFAC(X) S Y="" Q
 ... I ATT="disability" S Y=Y_"vaCode='"_I_"' printName='"_$$ESC^VPRD($P(X,U))_$S($P(X,U,3):"' sc='"_$P(X,U,3)_"' scPercent='"_$P(X,U,2),1:"")_"' />" Q
 ... S Y=Y_"value='"_$$ESC^VPRD(ITEM(ATT,I))_"' />"
 .. D ADD^VPRDPT("</"_ID_">") S Y=""
 . S X=$G(ITEM(ATT)),Y="" Q:'$L(X)
 . I ATT="address" D ADDR^VPRDPT(X) S Y="" Q
 . I ATT="telecom" D PHONE^VPRDPT(X) S Y="" Q
 . I ATT="guardian" D ADDG(X) S Y="" Q
 . I ATT="birthplace" D ADDB(X) S Y="" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD^VPRDPT("</patient>")
 Q
 ;
ADDFAC(X) ;
 N IEN,I S IEN=+$P(X,U)
 S Y=Y_"code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"'"
 S Y=Y_$S($P(X,U,3):" latestDate='"_$P($P(X,U,3),".")_"'",1:"")
 S Y=Y_$S($L($P(X,U,4))>0:" domain='"_$P(X,U,4)_"'",1:"")
 S Y=Y_$S($L($P(X,U,5))>0:" npi='"_$P(X,U,5)_"'",1:"")
 S Y=Y_$S($P(X,U,11):" homeSite='1'",1:"")_" >"
 D ADD^VPRDPT(Y)
 S Y="<address "
 S Y=Y_$S($L($P(X,U,6))>0:" streetLine1='"_$P(X,U,6)_"'",1:"")
 S Y=Y_$S($L($P(X,U,7))>0:" streetLine2='"_$P(X,U,7)_"'",1:"")
 S Y=Y_$S($L($P(X,U,8))>0:" city='"_$P(X,U,8)_"'",1:"")
 S Y=Y_$S($L($P(X,U,9))>0:" stateProvince='"_$P(X,U,9)_"'",1:"")
 S Y=Y_$S($L($P(X,U,10))>0:" postalCode='"_$P(X,U,10)_"'",1:"")
 S Y=Y_" />" D ADD^VPRDPT(Y)
 D ADD^VPRDPT("</facility>")
 Q
 ;
ADDG(X) ; -- XML guardian node from X=va^civil
 N I,Y Q:$L(X)'>5  ;no data
 S Y="<guardian"
 I $L($P(X,U)) S Y=Y_" va='"_$$ESC^VPRD($P(X,U))_"'"
 I $L($P(X,U,2)) S Y=Y_" civil='"_$P(X,U,2)_"'"
 S Y=Y_" />" D ADD^VPRDPT(Y)
 Q
 ;
ADDB(X) ; -- XML birthplace node from X=city^state
 N I,Y Q:$L(X)'>5  ;no data
 S Y="<birthplace"
 I $L($P(X,U)) S Y=Y_" city='"_$$ESC^VPRD($P(X,U))_"'"
 I $L($P(X,U,2)) S Y=Y_" state='"_$P(X,U,2)_"'"
 S Y=Y_" />" D ADD^VPRDPT(Y)
 Q
 ;
 ;=============================================================================
 ;                                    AUTHOR
 ;=============================================================================
 ;
AUT(DFN,BEG,END,MAX,ID) ; -- find current user information (Author)
 ; [BEG,END,MAX,ID not currently used]
 ;
 ; IF PRIMARY PROVIDER OF THE PATIENT USE THE FOLLOWING
 ;S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 ;S IEN=$$GET1^DIQ(2,+DFN_",",.104,"I") Q:+IEN<1
 ;
 N PAT S PAT("name")=$$GET1^DIQ(200,DUZ_",",.01)
 S PAT("type")=$$GET1^DIQ(200,DUZ_",",53.6)
 S PAT("class")=$$GET1^DIQ(200,DUZ_",",53.5)
 ; npi^npi entry status
 S PAT("npi")=$$GET1^DIQ(200,DUZ_",",41.99)_U_$$GET1^DIQ(200,DUZ_",",41.98)
 D ATCS(200,DUZ),FAC,XMLA(.PAT)
 Q
 ;
XMLA(ITEM) ; -- Return current user information as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD^VPRDPT("<current_user>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ITEM(ATT)) Q:ATT=""  D  D:$L(Y) ADD^VPRDPT(Y)
 .I $L($O(ITEM(ATT,""))) D  Q  ;multiples
 ..S ID=$S($E(ATT,$L(ATT))="s":ATT_"es",$E(ATT,$L(ATT))="y":$E(ATT,1,$L(ATT)-1)_"ies",1:ATT_"s")
 ..D ADD^VPRDPT("<"_ID_">")
 ..S I="" F  S I=$O(ITEM(ATT,I)) Q:I=""  D  D:$L(Y) ADD^VPRDPT(Y)
 ...S X=ITEM(ATT,I),Y="<"_ATT_" "
 ...I ATT="facility" D ADDFAC(X) S Y="" Q
 ...S Y=Y_"value='"_$$ESC^VPRD(ITEM(ATT,I))_"' />"
 ..D ADD^VPRDPT("</"_ID_">") S Y=""
 .S X=$G(ITEM(ATT)),Y="" Q:'$L(X)
 .I ATT="npi" S Y="<"_ATT_" value='"_$P(X,U)_"' status='"_$$ESC^VPRD($P(X,U,2))_"' />" Q
 .I ATT="address" D ADDR^VPRDPT(X) S Y="" Q
 .I ATT="telecom" D PHONE^VPRDPT(X) S Y="" Q
 .I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 .S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD^VPRDPT("</current_user>")
 Q
 ;
 ;=============================================================================
 ;                                  PARTICIPANT
 ;=============================================================================
 ;
PAR(DFN,BEG,END,MAX,ID) ; -- find patient family information (Participant)
 ; [BEG,END,MAX,ID not currently used]
 S DFN=+$G(DFN) Q:DFN<1  ;invalid patient
 N PAT,OUT,ERR,I,RT,FLE,FOF,FOFIEN
 D LIST^DIC(408.12,,"@;.01;.02;.03","P",,,,,"I $P(^(0),U)=DFN",,"OUT","ERR")
 I $D(OUT) S I=$NA(OUT) F  S I=$Q(@I) Q:I=""  D
 .Q:$QS(I,2)<1
 .;name^relationship
 .Q:$P(@I,U,3)="SELF"
 .S PAT("family_member",$QS(I,2))=$P(@I,U,4)_U_$P(@I,U,3)
 .; POINTER TO (2) OR (408.13)
 .S RT=$$GET1^DIQ(408.12,+@I_",",.03,"I")
 .S FLE=$S(RT["DPT,":2,1:$TR($P($P(RT,U,";",2),"(",2),",",""))
 .D ATCS(FLE,+RT)
 ;
 ; *** GET ONLY CURRENT FOF
 D PREGG^DSIO15(.OUT,"C",DFN) I $G(@OUT@(0)) D
 . S FOF=$P($P($G(@OUT@(1)),U,7),"|"),FOFIEN=$P($P($G(@OUT@(1)),U,7),"|",2)
 . I FOFIEN="" S PAT("father_of_fetus",0)=FOF Q
 . S PAT("father_of_fetus",FOFIEN)=FOF
 . K @OUT,OUT D PERSON^DSIO9(.OUT,DFN,FOFIEN) Q:$G(OUT(0))<1
 . Q:FOF='$P($G(OUT(1)),U,2)
 . S PAT("father_of_fetus",FOFIEN,"address")=$P(OUT(1),U,6,11)
 . S PAT("father_of_fetus",FOFIEN,"telecom")=$P(OUT(1),U,12,14)
 D XMLP(.PAT)
 Q
 ;
ATCS(FLE,IEN) ;-address & telecom
 ;street1^st2^st3^city^state^zip
 ;home^cell^work phones
 N FLD I FLE=2!(FLE=200) D  Q
 .S PAT("address")=$$GET1^DIQ(FLE,IEN_",",.111)
 .F FLD=.112,.113,.114,.115,.116 D
 ..S PAT("address")=PAT("address")_U_$$GET1^DIQ(FLE,IEN_",",FLD)
 .S PAT("telecom")=$$FORMAT^VPRDPT($$GET1^DIQ(FLE,IEN_",",.131))
 .F FLD=$S(FLE=2:.134,1:.133),.132 D
 ..S PAT("telecom")=PAT("telecom")_U_$$FORMAT^VPRDPT($$GET1^DIQ(FLE,IEN_",",FLD))
 I FLE=408.13 D
 .S PAT("address")=$$GET1^DIQ(FLE,IEN_",",1.2)
 .F FLD=1.3,1.4,1.5,1.6,1.7 D
 ..S PAT("address")=PAT("address")_U_$$GET1^DIQ(FLE,IEN_",",FLD)
 .S PAT("telecom")=$$FORMAT^VPRDPT($$GET1^DIQ(FLE,IEN_",",1.8))
 Q
 ;
XMLP(ITEM) ; -- Return patient family information data as XML in @VPR@(n)
 ; as <element code='123' displayName='ABC' />
 N ATT,X,Y,I,ID
 D ADD^VPRDPT("<patient_family>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(ITEM(ATT)) Q:ATT=""  D  D:$L(Y) ADD^VPRDPT(Y)
 .I $L($O(ITEM(ATT,""))) D  Q  ;multiples
 ..S ID=$S($E(ATT,$L(ATT))="s":ATT_"es",$E(ATT,$L(ATT))="y":$E(ATT,1,$L(ATT)-1)_"ies",1:ATT_"s")
 ..D ADD^VPRDPT("<"_ID_">")
 ..S I="" F  S I=$O(ITEM(ATT,I)) Q:I=""  D  D:$L(Y) ADD^VPRDPT(Y)
 ...S X=ITEM(ATT,I),Y="<"_ATT_" "
 ...I ATT="family_member" D  S Y="" Q
 ....S Y=Y_"name='"_$$ESC^VPRD($P(X,U))_$S($L($P(X,U,2)):"' relationship='"_$$ESC^VPRD($P(X,U,2)),1:"")_"' >" D ADD^VPRDPT(Y)
 ....S X=$G(ITEM(ATT,I,"address")) I $L(X) D ADDR^VPRDPT(X)
 ....S X=$G(ITEM(ATT,I,"telecom")) I $L(X) D PHONE^VPRDPT(X)
 ....D ADD^VPRDPT("</family_member>")
 ...I ATT="father_of_fetus" D  S Y="" Q
 ....S Y=Y_"name='"_$$ESC^VPRD($P(X,U))_"' >" D ADD^VPRDPT(Y)
 ....S X=$G(ITEM(ATT,I,"address")) I $L(X) D ADDR^VPRDPT(X)
 ....S X=$G(ITEM(ATT,I,"telecom")) I $L(X) D PHONE^VPRDPT(X)
 ....D ADD^VPRDPT("</father_of_fetus>")
 ...S Y=Y_"value='"_$$ESC^VPRD(ITEM(ATT,I))_"' />"
 ..D ADD^VPRDPT("</"_ID_">") S Y=""
 .S X=$G(ITEM(ATT)),Y="" Q:'$L(X)
 .I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 .S Y="<"_ATT_" code='"_$P(X,U)_"' name='"_$$ESC^VPRD($P(X,U,2))_"' />"
 D ADD^VPRDPT("</patient_family>")
 Q
