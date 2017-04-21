// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusGetUserInfoCommand: CommandBase 
    {
        public XusUserInfo UserInfo { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusGetUserInfoCommand(IRpcBroker newBroker):
            base(newBroker) {}

        public override string RpcName { get { return "XUS GET USER INFO";}}

        public override string Version { get { return "0";}}

        protected override void ProcessResponse()
        {
            string[] lines = this.Response.Lines;

            if (this.Response.Data == "reject")
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "reject";
            }
            else
            {
                this.UserInfo = new XusUserInfo
                {
                    DUZ = lines[0],
                    Name = lines[1],
                    StandardName = lines[2],
                    Division = new XusDivision
                    {
                        ID = Util.Piece(lines[3], "^", 1),
                        Name = Util.Piece(lines[3], "^", 2),
                        StationNumber = Util.Piece(lines[3], "^", 3)
                    },
                    Title = lines[4],
                    ServiceSection = lines[5]
                };

                if (lines.Length > 6)
                    this.UserInfo.Language = lines[6];

                if (lines.Length > 7)
                    this.UserInfo.DTime = lines[7];

                if (lines.Length > 8)
                    this.UserInfo.Vpid = lines[8];

                if (this.UserInfo.DUZ == "0")
                    this.Response.Status = RpcResponseStatus.Fail;
                else
                    this.Response.Status = RpcResponseStatus.Success;
            }

        }
    }
}
