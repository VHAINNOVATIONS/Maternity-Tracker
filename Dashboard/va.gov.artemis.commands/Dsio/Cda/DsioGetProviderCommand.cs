// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Cda
{
    /// <summary>
    /// A VistA Command which can be used to retrieve provider details
    /// </summary>
    public class DsioGetProviderCommand: DsioCommand
    {
        /// <summary>
        /// The list of providers returned by the RPC 
        /// </summary>
        public List<DsioProvider> ProviderList { get; set; }

        /// <summary>
        /// Creates a new command object
        /// </summary>
        /// <param name="newBroker">A real or mock broker which implemens IRpcBroker</param>
        public DsioGetProviderCommand (IRpcBroker newBroker): base(newBroker){}

        /// <summary>
        /// The name of the RPC
        /// </summary>
        public override string RpcName
        {
            get { return "WEBM GET PROVIDER"; }
        }

        /// <summary>
        /// The command arguments passed into the RPC
        /// </summary>
        /// <param name="providerIds">A list of provider id's</param>
        public void AddCommandArguments(string[] providerIds)
        {
            this.CommandArgs = new object[] { providerIds };
        }

        protected override void ProcessResponse()
        {
            // *** Process the return data ***

            // *** Use the default processor first ***
            if (this.ProcessQueryResponse())
            {
                // *** If ok, create the return list ***
                this.ProviderList = new List<DsioProvider>();

                // *** Get the data as array of lines ***
                string[] lines = this.Response.Lines;

                // *** Loop through the lines ***
                foreach (string line in lines)
                {
                    // *** Create a provider ***
                    DsioProvider prov = new DsioProvider();

                    // *** Get data from pieces ***
                    prov.Ien = Util.Piece(line, Caret, 1);
                    prov.Name = Util.Piece(line, Caret, 2);

                    // *** Address ***
                    DsioAddress addr = this.GetSixPieceAddress(line, 3);

                    if (addr != null)
                        prov.Address = addr;

                    // *** Telephone ***
                    string tel = Util.Piece(line, Caret, 9);
                    if (!string.IsNullOrWhiteSpace(tel))
                        prov.TelephoneList.Add(new DsioTelephone() { Usage = DsioTelephone.WorkPhoneUsage, Number = tel });

                    prov.Title = Util.Piece(line, Caret, 10);
                    prov.Service = Util.Piece(line, Caret, 11);
                    prov.Npi = Util.Piece(line, Caret, 12);

                    this.ProviderList.Add(prov);

                }

                //10958^BHATJEPDYIHU,ZDJELHA^1K Shird Tt.^Appt. 123^MN TS. LIIUHTT #3^troy^NEW YORK^00001^^2:COMPUTER SPECIALIST^1043:INFORMATION SYSTEMS CENTER^

                this.Response.Status = RpcResponseStatus.Success;
            }

        }
    }
}
