using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Vista.Broker
{
    public sealed class RpcResponse
    {
        public RpcResponseStatus Status { get; set; }
        public RpcResponseFailType FailType { get; set; }

        public string Data { get; set; }

        public string[] Lines { get { return Util.Split(this.Data); } }

        public string InformationalMessage { get; set; }

        // *** Information about the execution ***
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }

        public RpcResponse()
        {
            this.Data = "";
            this.InformationalMessage = ""; 
            this.Status = RpcResponseStatus.Unknown;
            this.FailType = RpcResponseFailType.None; 
        }

        public RpcResponse(RpcResponseFailType failType, string failMessage)
        {
            this.Data = "";
            this.Status = RpcResponseStatus.Fail;
            this.FailType = failType;
            this.InformationalMessage = failMessage; 
        }

        public string GetXmlDescription()
        {
            StringBuilder sb = new StringBuilder();

            XmlWriterSettings settings = new XmlWriterSettings() { Indent = true, OmitXmlDeclaration = true };

            using (XmlWriter writer = XmlTextWriter.Create(sb, settings))
            {
                writer.WriteStartElement("Response");

                writer.WriteElementString("Status", this.Status.ToString());
                writer.WriteElementString("FailType", this.FailType.ToString());
                writer.WriteElementString("InformationalMessage", this.InformationalMessage.ToString()); 

                if (this.Data == null)
                    writer.WriteElementString("Data", "");
                else 
                {
                    writer.WriteStartElement("Data");

                    string[] lines = this.Lines; 

                    for (int i = 0; i < lines.Length; i++)
                    {
                        string elName = string.Format("Line{0}", i);

                        writer.WriteElementString(elName, lines[i].ToString());
                    }

                    writer.WriteEndElement();
                }

                writer.WriteEndElement();
            }
            return sb.ToString();
        }

        /// <summary>
        /// A timespan object representing the time it took to 
        /// execute the command including sending and
        /// receiving bytes from the socket. 
        /// </summary>        
        public string ExecutionTime
        {
            get
            {
                string returnVal = ""; 

                TimeSpan timeSpan = new TimeSpan(0);

                if (this.StartTime != DateTime.MinValue)
                    if (this.EndTime != DateTime.MinValue)
                    {
                        timeSpan = this.EndTime - this.StartTime;

                        returnVal = timeSpan.TotalSeconds.ToString("######0.###");
                    }

                return returnVal;
            }
        }

        /// <summary>
        /// The size of the response in bytes. 
        /// </summary>
        public int Size
        {
            get
            {
                int returnVal = 0;

                if (!string.IsNullOrWhiteSpace(this.Data))
                    returnVal = this.Data.Length;

                return returnVal;
            }
        }

    }
}
