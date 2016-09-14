using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using VA.Gov.Artemis.Vista.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Commands;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusDivisionGetCommand: CommandBase 
    {
        public List<XusDivision> Divisions { get; set; }

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public XusDivisionGetCommand(IRpcBroker newBroker) :
            base(newBroker) { }

        public override string RpcName { get { return "XUS DIVISION GET";}}

        public override string Version { get { return "0"; } }

        protected override void ProcessResponse()
        {
            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "Nothing returned";
            }
            else
            {
                string[] lines = this.Response.Lines;

                if (lines[0] == "0") // *** Indicates no division, will use default ***
                    this.Response.Status = RpcResponseStatus.Success;
                else
                {
                    this.Divisions = new List<XusDivision>();
                    for (int i = 1; i < lines.Length; i++)
                    {
                        if (lines[i] != String.Empty)
                        {
                            XusDivision tempDivision = new XusDivision();

                            tempDivision.ID = Util.Piece(lines[i], "^", 1);
                            tempDivision.Name = Util.Piece(lines[i], "^", 2);
                            tempDivision.StationNumber = Util.Piece(lines[i], "^", 3);
                            if (Util.Piece(lines[i], "^", 4) == "1")
                                tempDivision.IsDefault = true;

                            this.Divisions.Add(tempDivision);
                        }
                    }
                    this.Response.Status = RpcResponseStatus.Success;
                }
            }

        }
    }
}
