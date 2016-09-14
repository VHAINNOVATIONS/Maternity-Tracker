using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Commands.Orwu
{
    public class OrwuUserInfo
    {
        public string DUZ { get; set; }
        public string UserName { get; set; }
        public string UsrCls { get; set; }
        public string CanSign { get; set; }
        public string IsProvider { get; set; }
        public string OrderRole { get; set; }
        public string NoOrder { get; set; }
        public int Timeout { get; set; } // *** Seconds ***
        public string Countdown { get; set; }
        public string EnableVerify { get; set; }
        public string NotifyApps { get; set; }
        public string MsgHang { get; set; }
        public string Domain { get; set; }
        public string Service { get; set; }
        public string AutoSave { get; set; }
        public string InitTab { get; set; }
        public string LastTab { get; set; }
        public string WebAccess { get; set; }
        public string AllowHold { get; set; }
        public string IsRpl { get; set; }
        public string RplList { get; set; }
        public string CorTabls { get; set; }
        public string RptTab { get; set; }
        public string StaNum { get; set; }
        public string GecStatus { get; set; }
        public string ProdAcct { get; set; }

        public OrwuUserInfo() {}

        public OrwuUserInfo(string[] pieces) 
        { 
            DUZ = pieces[0];
            UserName = pieces[1];
            UsrCls = pieces[2];
            CanSign = pieces[3];
            IsProvider = pieces[4];
            OrderRole = pieces[5];
            NoOrder = pieces[6];

            int timeOut;
            if (int.TryParse(pieces[7], out timeOut))
            {
                Timeout = timeOut;
            }

            Countdown = pieces[8];
            EnableVerify = pieces[9];
            NotifyApps = pieces[10];
            MsgHang = pieces[11];
            Domain = pieces[12];
            Service = pieces[13];
            AutoSave = pieces[14];
            InitTab = pieces[15];
            LastTab = pieces[16];
            WebAccess = pieces[17];
            AllowHold = pieces[18];
            IsRpl = pieces[19];
            RplList = pieces[20];
            CorTabls = pieces[21];
            RptTab = pieces[22];
            StaNum = pieces[23];
            GecStatus = pieces[24];
            ProdAcct = pieces[25];
        }
    }
}
