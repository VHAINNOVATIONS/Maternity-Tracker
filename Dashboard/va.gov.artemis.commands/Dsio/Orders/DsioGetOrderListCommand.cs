using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Dsio.Orders
{
    /// <summary>
    /// A command to retrieve a list of orders from VistA
    /// </summary>
    public class DsioGetOrderListCommand: DsioPagableCommand
    {
        /// <summary>
        /// The list of orders received by a call to the RPC
        /// </summary>
        public List<DsioOrder> Orders { get; set; }

        // *** Temporary working order ***
        private DsioOrder workingOrder; 

        /// <summary>
        /// Creates the command
        /// </summary>
        /// <param name="newBroker">An object which allows communication with VistA and implements IRpcBroker</param>
        public DsioGetOrderListCommand(IRpcBroker newBroker)
            : base(newBroker) {}

        public void AddCommandArguments(string patientDfn, int page, int itemsPerPage)
        {
            // TODO: Implement order filtering & selection...

            this.CommandArgs = new object[] { 
                patientDfn,
                "", 
                "", 
                "", 
                "", 
                string.Format("{0},{1}", page, itemsPerPage)
             };
        }

        public void AddCommandArguments(string patientDfn)
        {
            this.CommandArgs = new object[] { patientDfn, "", "", "", "", "" };
        }

        public override string RpcName
        {
            get { return "DSIO GET ORDER LIST"; }
        }

        //protected override void ProcessResponse()
        //{
        //    //8
        //    //~18928;1^23^3050223.1732^^^23^^^^5^^^0^^^^^^CLINIC (45):223^^0^0^0^0
        //    //tDOXORUBICIN INJ,SOLN  TEST ORDER
        //    //~18588;1^18^3011025.1304^^^18^^^^6^^^0^^^^^^7B:81^^0^0^0^0
        //    //tREGULAR
        //    //~18578;1^43^3011024.1523^^^43^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tBONE MARROW BIOPSY HEMATOLOGY NEW NAME Proc Bedside
        //    //~18569;1^42^3011024.0833^^^42^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tMAMMARY DUCTOGRAM BILAT CP
        //    //~18342;1^11^3010918.1048^^^11^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tSHERI'S NEW SERVICE Cons Bedside
        //    //~18340;1^6^3010918.0931^^^6^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tALBUMIN BLOOD   SERUM WC LB #2796
        //    //~18331;1^11^3010917.1113^^^11^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tSHERI'S NEW SERVICE Cons Bedside
        //    //~18322;1^11^3010917.0948^^^11^^^^5^^^0^^^^^^7B:81^^0^0^0^0
        //    //tSHERI'S NEW SERVICE Cons Bedside

        //    // ;             1        2       3             4          5            6      7    8      9      10        11            12       13        14 
        //    // ;RET=~IFN^Grp^ActTm^StrtTm^StopTm^Sts^Sig^Nrs^Clk^PrvID^PrvNam^ActDA^Flag^DCType
        //    //      15          16   17    18
        //    //^ChrtRev^DEA#^^Schedule
        //    //;RET=tOrder Text (repeating as necessary)

        //    // *** Generic processing ***
        //    if (ProcessAnyResponse())
        //    {
        //        // *** Set flag to get first item as total items ***
        //        bool first = true; 

        //        // *** Get data as array of lines ***
        //        string[] lines = this.Response.Lines;

        //        DsioOrder workingOrder = null; 

        //        // *** Process the lines ***
        //        foreach (string line in lines)
        //        {
        //            if (first)
        //            {

        //                first = false;
        //            }
        //            else
        //            {
        //                string firstChar = line.Substring(0, 1);

        //                if (firstChar == "~")
        //                {
        //                    if (workingOrder != null)
        //                        AddDsioOrderToList(workingOrder);

        //                    workingOrder = new DsioOrder();

        //                    workingOrder.Ifn = Util.Piece(line.Substring(1), Caret, 1);
        //                    workingOrder.Grp = Util.Piece(line, Caret, 2);
        //                    workingOrder.ActTm = Util.Piece(line, Caret, 3);
        //                    workingOrder.StrtTm = Util.Piece(line, Caret, 4);
        //                    workingOrder.StopTm = Util.Piece(line, Caret, 5);
        //                    workingOrder.Sts = Util.Piece(line, Caret, 6);
        //                    workingOrder.Sig = Util.Piece(line, Caret, 7);
        //                    workingOrder.Nrs = Util.Piece(line, Caret, 8);
        //                    workingOrder.Clk = Util.Piece(line, Caret, 9);
        //                    workingOrder.PrvId = Util.Piece(line, Caret, 10);
        //                    workingOrder.PrvNam = Util.Piece(line, Caret, 11);
        //                    workingOrder.ActDA = Util.Piece(line, Caret, 12);
        //                    workingOrder.Flag = Util.Piece(line, Caret, 13);
        //                    workingOrder.DCType = Util.Piece(line, Caret, 14);
        //                    workingOrder.ChrtRev = Util.Piece(line, Caret, 15);
        //                    workingOrder.DEA = Util.Piece(line, Caret, 16);
        //                    workingOrder.Schedule = Util.Piece(line, Caret, 18);
        //                    workingOrder.Location = Util.Piece(line, Caret, 19);

        //                }
        //                else if (firstChar == "t")
        //                    workingOrder.OrderText += line.Substring(1) + Environment.NewLine;

        //            }
        //        }

        //        this.Response.Status = RpcResponseStatus.Success;
        //    }
        //}

        private void AddDsioOrderToList(DsioOrder order)
        {
            if (this.Orders == null)
                this.Orders = new List<DsioOrder>();

            this.Orders.Add(order); 
        }


        protected override void ProcessLine(string line)
        {
            string firstChar = line.Substring(0, 1);

            if (firstChar == "~")
            {
                if (workingOrder != null)
                    AddDsioOrderToList(workingOrder);

                workingOrder = new DsioOrder();

                workingOrder.Ifn = Util.Piece(line.Substring(1), Caret, 1);
                workingOrder.Grp = Util.Piece(line, Caret, 2);
                workingOrder.ActTm = Util.Piece(line, Caret, 3);
                workingOrder.StrtTm = Util.Piece(line, Caret, 4);
                workingOrder.StopTm = Util.Piece(line, Caret, 5);
                workingOrder.Sts = Util.Piece(line, Caret, 6);
                workingOrder.Sig = Util.Piece(line, Caret, 7);
                workingOrder.Nrs = Util.Piece(line, Caret, 8);
                workingOrder.Clk = Util.Piece(line, Caret, 9);
                workingOrder.PrvId = Util.Piece(line, Caret, 10);
                workingOrder.PrvNam = Util.Piece(line, Caret, 11);
                workingOrder.ActDA = Util.Piece(line, Caret, 12);
                workingOrder.Flag = Util.Piece(line, Caret, 13);
                workingOrder.DCType = Util.Piece(line, Caret, 14);
                workingOrder.ChrtRev = Util.Piece(line, Caret, 15);
                workingOrder.DEA = Util.Piece(line, Caret, 16);
                workingOrder.Schedule = Util.Piece(line, Caret, 18);
                workingOrder.Location = Util.Piece(line, Caret, 19);

            }
            else if (firstChar == "t")
                workingOrder.OrderText += Util.Piece(line.Substring(1), Caret, 1) + Environment.NewLine;
        }

        protected override void ProcessEndData()
        {
            if (workingOrder != null)
                AddDsioOrderToList(workingOrder);
        }

    }
}
