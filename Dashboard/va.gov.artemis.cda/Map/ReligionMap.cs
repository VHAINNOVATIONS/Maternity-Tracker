using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Map
{
    public class ReligionMap
    {
        // Vista...
                                                                               
        //Global ^DIC(13,0)
        //^DIC(13,0)="RELIGION^13I^153^84"

        //Global ^DIC(13,,0)
        //^DIC(13,1,0)="JUDAISM^^^1"
        //^DIC(13,2,0)="EASTERN ORTHODOX^^^2"
        //^DIC(13,3,0)="BAPTIST^^^3"
        //^DIC(13,4,0)="METHODIST^^^4"
        //^DIC(13,5,0)="LUTHERAN^^^5"
        //^DIC(13,6,0)="PRESBYTERIAN^^^6"
        //^DIC(13,7,0)="UNITED CHURCH OF CHRIST^^^7"
        //^DIC(13,8,0)="EPISCOPALIAN^^^8"
        //^DIC(13,9,0)="ADVENTIST^^^9"
        //^DIC(13,10,0)="ASSEMBLY OF GOD^^^10"
        //^DIC(13,11,0)="BRETHREN^^^11"
        //^DIC(13,12,0)="CHRISTIAN SCIENTIST^^^12"
        //^DIC(13,13,0)="CHURCH OF CHRIST^^^13"
        //^DIC(13,14,0)="CHURCH OF GOD^^^14"
        //^DIC(13,15,0)="DISCIPLES OF CHRIST^^^15"
        //^DIC(13,16,0)="EVANGELICAL COVENANT^^^16"
        //^DIC(13,17,0)="FRIENDS^^^17"
        //^DIC(13,18,0)="JEHOVAH'S WITNESSES^^^18"
        //^DIC(13,19,0)="LATTER DAY SAINTS^LDS^^19"
        //^DIC(13,20,0)="ISLAM^^^20"
        //^DIC(13,21,0)="NAZARENE^^^21"
        //^DIC(13,22,0)="OTHER^^^22"
        //^DIC(13,23,0)="PENTECOSTAL^^^23"
        //(M)ore, (L)ine, (S)croll, (Q)uit? M => S                                                                                ^DIC(13,24,0)="PROTESTANT^^^24"
        //^DIC(13,25,0)="PROTESTANT, NO DENOMINATION^^^25"
        //^DIC(13,26,0)="REFORMED^^^26"
        //^DIC(13,27,0)="SALVATION ARMY^^^27"
        //^DIC(13,28,0)="UNITARIAN-UNIVERSALISM^^^28"
        //^DIC(13,29,0)="UNKNOWN/NO PREFERENCE^^^29"
        //^DIC(13,99,0)="ROMAN CATHOLIC CHURCH^^^0"
        //^DIC(13,100,0)="NATIVE AMERICAN^^^30"
        //^DIC(13,101,0)="ZEN BUDDHISM^^^31"
        //^DIC(13,102,0)="AFRICAN RELIGIONS^^^32"
        //^DIC(13,103,0)="AFRO-CARIBBEAN RELIGIONS^^^33"
        //^DIC(13,104,0)="AGNOSTICISM^^^34"
        //^DIC(13,105,0)="ANGLICAN^^^35"
        //^DIC(13,106,0)="ANIMISM^^^36"
        //^DIC(13,107,0)="ATHEISM^^^37"
        //^DIC(13,108,0)="BABI & BAHA'I FAITHS^^^38"
        //^DIC(13,109,0)="BON^^^39"
        //^DIC(13,110,0)="CAO DAI^^^40"
        //^DIC(13,111,0)="CELTICISM^^^41"
        //^DIC(13,112,0)="CHRISTIAN (NON-SPECIFIC)^^^42"
        //^DIC(13,113,0)="CONFUCIANISM^^^43"
        //^DIC(13,114,0)="CONGREGATIONAL^^^44"
        //^DIC(13,115,0)="CYBERCULTURE RELIGIONS^^^45"
        //^DIC(13,116,0)="DIVINATION^^^46"
        //^DIC(13,117,0)="FOURTH WAY^^^47"
        //^DIC(13,118,0)="FREE DAISM^^^48"
        //^DIC(13,119,0)="FULL GOSPEL^^^49"
        //^DIC(13,120,0)="GNOSIS^^^50"
        //^DIC(13,121,0)="HINDUISM^^^51"
        //^DIC(13,122,0)="HUMANISM^^^52"
        //^DIC(13,123,0)="INDEPENDENT^^^53"
        //^DIC(13,124,0)="JAINISM^^^54"
        //^DIC(13,125,0)="MAHAYANA^^^55"
        //^DIC(13,126,0)="MEDITATION^^^56"
        //^DIC(13,127,0)="MESSIANIC JUDAISM^^^57"
        //^DIC(13,128,0)="MITRAISM^^^58"
        //^DIC(13,129,0)="NEW AGE^^^59"
        //^DIC(13,130,0)="NON-ROMAN CATHOLIC^^^60"
        //^DIC(13,131,0)="OCCULT^^^61"
        //^DIC(13,132,0)="ORTHODOX^^^62"
        //^DIC(13,133,0)="PAGANISM^^^63"
        //^DIC(13,134,0)="PROCESS, THE^^^64"
        //^DIC(13,135,0)="REFORMED/PRESBYTERIAN^^^65"
        //^DIC(13,136,0)="SATANISM^^^66"
        //^DIC(13,137,0)="SCIENTOLOGY^^^67"
        //^DIC(13,138,0)="SHAMANISM^^^68"
        //^DIC(13,139,0)="SHIITE (ISLAM)^^^69"
        //^DIC(13,140,0)="SHINTO^^^70"
        //^DIC(13,141,0)="SIKISM^^^71"
        //^DIC(13,142,0)="SPIRITUALISM^^^72"
        //^DIC(13,143,0)="SUNNI (ISLAM)^^^73"
        //^DIC(13,144,0)="TAOISM^^^74"
        //^DIC(13,145,0)="THERAVADA^^^75"
        //^DIC(13,146,0)="UNIVERSAL LIFE CHURCH^^^76"
        //^DIC(13,147,0)="VAJRAYANA (TIBETAN)^^^77"
        //^DIC(13,148,0)="VEDA^^^78"
        //^DIC(13,149,0)="VOODOO^^^79"
        //^DIC(13,150,0)="WICCA^^^80"
        //^DIC(13,151,0)="YAOHUSHUA^^^81"
        //^DIC(13,152,0)="ZOROASTRIANISM^^^82"
        //^DIC(13,153,0)="ASKED BUT DECLINED TO ANSWER^^^83"

        // HL7...
        //1  L:  (1001)  19186 1001 Adventist  
        //1  L:  (1002)  19187 1002 African Religions  
        //1  L:  (1003)  19188 1003 Afro-Caribbean Religions  
        //1  L:  (1004)  19189 1004 Agnosticism  
        //1  L:  (1005)  19190 1005 Anglican  
        //1  L:  (1006)  19191 1006 Animism  
        //1  L:  (1007)  19192 1007 Atheism  
        //1  L:  (1008)  19193 1008 Babi & Baha'I faiths  
        //1  L:  (1009)  19194 1009 Baptist  
        //1  L:  (1010)  19195 1010 Bon  
        //1  L:  (1011)  19196 1011 Cao Dai  
        //1  L:  (1012)  19197 1012 Celticism  
        //1  L:  (1013)  19198 1013 Christian (non-Catholic, non-specific)  
        //1  L:  (1014)  19199 1014 Confucianism  
        //1  L:  (1015)  19200 1015 Cyberculture Religions  
        //1  L:  (1016)  19201 1016 Divination  
        //1  L:  (1017)  19202 1017 Fourth Way  
        //1  L:  (1018)  19203 1018 Free Daism  
        //1  L:  (1019)  19204 1019 Gnosis  
        //1  L:  (1020)  19205 1020 Hinduism  
        //1  L:  (1021)  19206 1021 Humanism  
        //1  L:  (1022)  19207 1022 Independent  
        //1  L:  (1023)  19208 1023 Islam  
        //1  L:  (1024)  19209 1024 Jainism  
        //1  L:  (1025)  19210 1025 Jehovah's Witnesses  
        //1  L:  (1026)  19211 1026 Judaism  
        //1  L:  (1027)  19212 1027 Latter Day Saints  
        //1  L:  (1028)  19213 1028 Lutheran  
        //1  L:  (1029)  19214 1029 Mahayana  
        //1  L:  (1030)  19215 1030 Meditation  
        //1  L:  (1031)  19216 1031 Messianic Judaism  
        //1  L:  (1032)  19217 1032 Mitraism  
        //1  L:  (1033)  19218 1033 New Age  
        //1  L:  (1034)  19219 1034 non-Roman Catholic  
        //1  L:  (1035)  19220 1035 Occult  
        //1  L:  (1036)  19221 1036 Orthodox  
        //1  L:  (1037)  19222 1037 Paganism  
        //1  L:  (1038)  19223 1038 Pentecostal  
        //1  L:  (1039)  19224 1039 Process, The  
        //1  L:  (1040)  19225 1040 Reformed/Presbyterian  
        //1  L:  (1041)  19226 1041 Roman Catholic Church  
        //1  L:  (1042)  19227 1042 Satanism  
        //1  L:  (1043)  19228 1043 Scientology  
        //1  L:  (1044)  19229 1044 Shamanism  
        //1  L:  (1045)  19230 1045 Shiite (Islam)  
        //1  L:  (1046)  19231 1046 Shinto  
        //1  L:  (1047)  19232 1047 Sikism  
        //1  L:  (1048)  19233 1048 Spiritualism  
        //1  L:  (1049)  19234 1049 Sunni (Islam)  
        //1  L:  (1050)  19235 1050 Taoism  
        //1  L:  (1051)  19236 1051 Theravada  
        //1  L:  (1052)  19237 1052 Unitarian-Universalism  
        //1  L:  (1053)  19238 1053 Universal Life Church  
        //1  L:  (1054)  19239 1054 Vajrayana (Tibetan)  
        //1  L:  (1055)  19240 1055 Veda  
        //1  L:  (1056)  19241 1056 Voodoo  
        //1  L:  (1057)  19242 1057 Wicca  
        //1  L:  (1058)  19243 1058 Yaohushua  
        //1  L:  (1059)  19244 1059 Zen Buddhism  
        //1  L:  (1060)  19245 1060 Zoroastrianism 

    }
}
