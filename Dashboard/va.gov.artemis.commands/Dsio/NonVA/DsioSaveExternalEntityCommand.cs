// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.NonVA
{
    public class DsioSaveExternalEntityCommand: DsioCommand 
    {
        public string Ien { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioSaveExternalEntityCommand(IRpcBroker newBroker): base(newBroker)
        {

        }

        public override string RpcName
        {
            get { return "DSIO SAVE EXTERNAL ENTITY"; }
        }

        public void AddCommandArguments(DsioNonVAItem item)
        {

            // Input Parameter are now IEN, NAME, TYP, ACT, PCON, ADDR, and PHONE where ADDR and PHONE 
            //are lists used like DSIO SAVE PERSON with the exception of FAX as the fourth entry for PHONE.

//IEN,NAME,TYP,ACT,PCON,ADDR,PHONE
//;  ADDR = ARRAY OF LABELS: 1,2,3,CITY,STATE,ZIP
//; PHONE = ARRAY OF LABLES: H,MC,WP


            List<string> telParamList = new List<string>(); 

            if (item.TelephoneList != null)
                foreach (DsioTelephone tel in item.TelephoneList)
                    telParamList.Add(tel.ToParam());

            this.CommandArgs = new object[]{
                item.Ien, 
                item.EntityName, 
                item.EntityType, 
                item.Inactive, 
                item.PrimaryContact, 
                item.Address.ToParameter(), 
                telParamList.ToArray()
            };

            //List<string> argList = new List<string>();

            //if (string.IsNullOrWhiteSpace(item.OriginalEntityName))
            //    argList.Add(string.Format("NAME^{0}^{1}", item.EntityName, ""));
            //else if (item.OriginalEntityName != item.EntityName)
            //    argList.Add(string.Format("NAME^{0}^{1}", item.OriginalEntityName, item.EntityName));
            //else
            //    argList.Add(string.Format("NAME^{0}^{1}", item.OriginalEntityName, ""));

            //argList.Add(string.Format("TYPE^{0}", item.EntityType));
            //argList.Add(string.Format("INACTIVE^{0}", item.Inactive));
            //argList.Add(string.Format("PRIMARY CONTACT^{0}", item.PrimaryContact)); 
            //argList.Add(string.Format("STREET ADDRESS 1^{0}", item.AddressLine1));
            //argList.Add(string.Format("STREET ADDRESS 2^{0}", item.AddressLine2));
            //argList.Add(string.Format("CITY^{0}", item.City));
            //argList.Add(string.Format("STATE^{0}", item.State));
            //argList.Add(string.Format("ZIP CODE^{0}", item.Zip));
            //argList.Add(string.Format("PHONE NUMBER (OFFICE)^{0}", item.PhoneNumber));
            //argList.Add(string.Format("FAX NUMBER^{0}", item.FaxNumber));

            //string[] arg = argList.ToArray(); 
                
            //this.CommandArgs = new object[] { arg}; 
        }

        protected override void ProcessResponse()
        {
            //if (!string.IsNullOrWhiteSpace(this.Response.Data))
            //{
            //    string result = Util.Piece(this.Response.Lines[0], Caret, 1);

            //    if (result == "1")
            //        this.Response.Status = RpcResponseStatus.Success;
            //    else
            //    {
            //        this.Response.InformationalMessage = Util.Piece(this.Response.Lines[0], Caret, 2);
            //        this.Response.Status = RpcResponseStatus.Fail;
            //    }
            //}            

            if (this.ProcessSaveResponse())
                this.Ien = Util.Piece(this.Response.Lines[0], Caret, 1); 
        }
    }
}
