// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Commands.Dsio.Base;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio
{
    public abstract class DsioCommand: CommandBase
    {
        public DsioCommand(IRpcBroker newBroker): base(newBroker)
        {
            this.Context = "MTD GUI CONTEXT";
        }

        public override string Version
        {
            get { return "0"; }
        }

        protected DsioAddress GetSixPieceAddress(string line, int startingIndex)
        {
            DsioAddress returnAddress = new DsioAddress();

            returnAddress.StreetLine1 = Util.Piece(line, Caret, startingIndex);
            returnAddress.StreetLine2 = Util.Piece(line, Caret, startingIndex + 1);
            returnAddress.StreetLine3 = Util.Piece(line, Caret, startingIndex + 2);
            returnAddress.City = Util.Piece(line, Caret, startingIndex + 3);
            returnAddress.State = Util.Piece(line, Caret, startingIndex + 4);
            returnAddress.ZipCode = Util.Piece(line, Caret, startingIndex + 5);

            return returnAddress;
        }


    }
}
