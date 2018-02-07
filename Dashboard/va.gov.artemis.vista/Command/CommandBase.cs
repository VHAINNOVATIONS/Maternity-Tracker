// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using VA.Gov.Artemis.Core;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Vista.Commands
{
    public abstract class CommandBase
    {
        protected const string Caret = "^"; 

        protected IRpcBroker broker { get; set; }
        protected object[] CommandArgs { get; set; }
        protected string Context { get; set; }

        // *** Indicates that command data is sensitive and should not be logged ***
        protected virtual bool Sensitive { get { return false; } }

        public RpcResponse Response { get; set; }

        public abstract string RpcName { get; }
        public abstract string Version { get; }        

        public CommandBase(IRpcBroker newBroker)
        {
            this.broker = newBroker;

            this.Context = string.Empty; 
        }

        public virtual RpcResponse Execute()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(string.Format("Calling RPC, {0}, with Arguments:", this.RpcName));
            
            if (this.CommandArgs != null)
            {            
                int count = 1;
                foreach (var arg in this.CommandArgs)
                    if (arg != null)
                        if (arg is string[])
                        {
                            string[] stringArgs = arg as string[];
                            int subCount = 0;
                            if (stringArgs.Length == 0)
                                sb.AppendLine(string.Format("{0}:", count));
                            else
                            {
                                foreach (string subArg in stringArgs)
                                {
                                    if (string.IsNullOrWhiteSpace(subArg))
                                        sb.AppendLine(string.Format("{0}[{1}]: {2}", count, subCount++, ""));
                                    else
                                    {
                                        string noCommas = subArg.ToString();
                                        sb.AppendLine(string.Format("{0}[{1}]: {2}", count, subCount++, noCommas));
                                    }
                                }
                            }
                            count++;
                        }
                        else
                        {
                            string noCommas = arg.ToString();
                            sb.AppendLine(string.Format("{0}: {1}", count++, noCommas));
                        }
                    else
                        sb.AppendLine(string.Format("{0}: {1}", count++, "")); 
            }
            else
                sb.AppendLine("None");

            TraceLogger.Log(sb.ToString());

            this.Response = this.broker.CallRpc(this.Context, this.RpcName, this.Version, this.CommandArgs);

            // TODO: Remove this tracing...?
            TraceLogger.Log(string.Format("Result from '{0}':\n\r{1}", this.RpcName, this.Response.Data)); 
     
            if (this.Response.Status != RpcResponseStatus.Fail)
                this.ProcessResponse();

            LogIt(); 

            return this.Response;
        }

        private string StripCommas(string orig)
        {
            string returnVal = "";

            foreach (char c in orig)
                if (c.ToString() != ",")
                    returnVal += c; 

            return returnVal;
        }

        protected abstract void ProcessResponse();

        public string GetXmlDescription()
        {
            StringBuilder sb = new StringBuilder();
            
            XmlWriterSettings settings = new XmlWriterSettings() { Indent = true, OmitXmlDeclaration=true };

            using (XmlWriter writer = XmlTextWriter.Create(sb, settings))
            {
                writer.WriteStartElement("CommandBase");

                writer.WriteElementString("RpcName", this.RpcName);
                writer.WriteElementString("Version", this.Version);
                //if (this.request != null)
                //{
                    writer.WriteStartElement("Request");

                    writer.WriteElementString("Context", this.Context);

                    if (this.CommandArgs == null)
                        writer.WriteElementString("Args", "");
                    else if (this.CommandArgs.Length == 0)
                        writer.WriteElementString("Args", "");
                    else
                    {
                        writer.WriteStartElement("Args");
                        for (int i = 0; i < this.CommandArgs.Length; i++)
                        {
                            string elName = string.Format("Args{0}", i);

                            writer.WriteElementString(elName, this.CommandArgs[i].ToString());
                        }
                        writer.WriteEndElement();
                    }
                //}

                writer.WriteEndElement();

                writer.WriteEndElement();
            }
            return sb.ToString();
        }

        private bool ProcessAnyResponse(bool isQuery)
        {
            bool returnVal = false;

            // *** This routine does preliminary response processing ***

            // *** Checks for 
            // ***          1. No data
            // ***          2. chr 24 as first character of first line (Mumps error) 
            // ***          3. 0 as first character of first line 
            // ***          4. -1 or 0 as first piece of first line
            // ***
            // *** Everything else is ok 

            if (string.IsNullOrWhiteSpace(this.Response.Data))
            {
                this.Response.Status = RpcResponseStatus.Fail;
                this.Response.InformationalMessage = "No return value";
            }
            else
            {
                string piece1 = Util.Piece(this.Response.Lines[0], Caret, 1);
                string piece2 = Util.Piece(this.Response.Lines[0], Caret, 2);

                char[] chars = piece1.ToCharArray();

                if ((int)chars[0] == 24)
                {
                    this.Response.Status = RpcResponseStatus.Fail;
                    this.Response.InformationalMessage = "An internal error has occurred";
                    ErrorLogger.Log(string.Format("M Error Calling RPC '{0}': {1}", this.RpcName, this.Response.Data)); 
                }
                else
                {
                    switch (piece1)
                    {
                        case "-1":
                            this.Response.Status = RpcResponseStatus.Fail;
                            this.Response.InformationalMessage = piece2;
                            break;
                        case "0":
                            if (isQuery)
                            {
                                this.Response.Status = RpcResponseStatus.Success;
                                this.Response.InformationalMessage = piece2;

                                //It's been noticed that the returned response for Clinical Reminders, even though it 
                                //contains data, has its the first line stating otherwise: "0^Entry not found.", 
                                //meaning that actually there is no data in the response. For this particular error 
                                //case, in order to adjust around the misleading response, when we actually do have data,
                                //we are removing the first line of the response: "0^Entry not found."
                                //In order to correct the response in the back-end, the FMTOUT() routine of 
                                //PXRMFMTO.int file should be modified, by overwriting line 0 of the output, otherwise
                                //it remains unchanged "0^Entry not found.", as stated in MTD12.int, DETAIL() routine.                                
                                if (this.Response.Lines.Length > 1)
                                {
                                    this.Response.InformationalMessage = "Data found.";
                                    var breakPoint = "\r\n";
                                    int index = this.Response.Data.IndexOf(breakPoint) + breakPoint.Length;
                                    this.Response.Data = this.Response.Data.Substring(index);
                                    returnVal = true;
                                }
                            }
                            else
                            {
                                this.Response.Status = RpcResponseStatus.Fail;
                                this.Response.InformationalMessage = piece2;
                            }
                            break;
                        case "reject":
                            this.Response.Status = RpcResponseStatus.Fail;
                            this.Response.InformationalMessage = "An internal error has occurred communicating with VistA (reject)";
                            break; 
                        default:
                            returnVal = true;
                            break;
                    }
                }
            }

            return returnVal;
        }

        protected bool ProcessSaveResponse()
        {
            return ProcessAnyResponse(false);
        }

        protected bool ProcessQueryResponse()
        {
            return ProcessAnyResponse(true);
        }

        private void LogIt()
        {
            object[] logArgs = (this.Sensitive) ? null : this.CommandArgs;

            if (this.Response != null) 
                VistaLogger.Log(this.RpcName, this.Response.ExecutionTime, this.Response.Size, logArgs, this.Response.Status.ToString());
            else 
                VistaLogger.Log(this.RpcName, "-1", -1, logArgs, RpcResponseStatus.Unknown.ToString());
        }

    }
}
