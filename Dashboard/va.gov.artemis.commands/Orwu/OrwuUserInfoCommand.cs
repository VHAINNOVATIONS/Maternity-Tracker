// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

//using VA.Gov.Artemis.Vista.Broker;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Vista.Utility; 

namespace VA.Gov.Artemis.Commands.Orwu
{
    public class OrwuUserInfoCommand: CommandBase
    {
        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public OrwuUserInfoCommand(IRpcBroker newBroker):
            base(newBroker) 
        {
            this.Context = "DSIO GUI CONTEXT";
        }

        public override string RpcName{get{return "ORWU USERINFO";}}

        public override string Version{get{return "0";}}

        public OrwuUserInfo UserInfo { get; set; }

        protected override void ProcessResponse()
        {
            this.Response.Status = RpcResponseStatus.Fail; 

            if (this.Response.Lines != null)
                if (this.Response.Lines.Length > 0)
                {

                    string[] pieces = Util.Split(this.Response.Lines[0], "^");

                    this.UserInfo = new OrwuUserInfo(pieces); 

                    //string piece8 = Util.Piece(this.Response.Lines[0], "^", 8);

                    //int timeOut;
                    //if (int.TryParse(piece8, out timeOut))
                    //{
                    //    this.TimeoutSeconds = timeOut;
                    //    this.Response.Status = RpcResponseStatus.Success; 
                    //}

                    this.Response.Status = RpcResponseStatus.Success; 
                }
        }
    }
}
