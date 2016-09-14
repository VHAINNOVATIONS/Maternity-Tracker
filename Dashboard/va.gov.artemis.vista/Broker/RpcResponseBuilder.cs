//using VA.Gov.Artemis.Vista.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Broker
{
    internal class RpcResponseBuilder
    {
        private const string repeatedIncompleteReads = "U411";
        private const string endOfData = "\x4";

        // *** Storage of the security segment ***
        private string securitySegment;

        // *** Storage of the application segment ***
        private string applicationSegment;

        private RpcResponse response { get; set; }

        public RpcResponseBuilder()
        {
            this.response = new RpcResponse(); 
        }

        public RpcResponse ToResponse()
        {
            return this.response; 
        }

        public bool SetSecuritySegment(byte[] bytes)
        {
            // *** Sets the security segment as bytes ***

            // *** Returns true if any bytes set ***

            bool returnVal = false;

            if (bytes != null)
                if (bytes.Length > 0)
                {
                    this.securitySegment = Encoding.ASCII.GetString(bytes);
                    returnVal = true;
                }

            return returnVal;
        }

        public bool SetApplicationSegment(byte[] bytes)
        {
            // *** Sets the application segment as bytes ***

            // *** Returns true if any bytes set ***

            bool returnVal = false;

            if (bytes != null)
                if (bytes.Length > 0)
                {
                    this.applicationSegment = Encoding.ASCII.GetString(bytes);

                    if (this.applicationSegment == repeatedIncompleteReads)
                    {
                        this.response.InformationalMessage = "Application segment is U411: Repeated incomplete reads on server";
                        this.response.Status = RpcResponseStatus.Fail;
                        this.response.FailType = RpcResponseFailType.U411;
                    }

                    returnVal = true;
                }

            return returnVal;
        }

        public bool AppendData(byte[] bytes)
        {
            // *** Appends the bytes to existing ***

            // *** Returns true if END IS REACHED ***

            bool returnVal = false;

            // *** Check if we have something to work with ***
            if (bytes != null)
                if (bytes.Length > 0)
                {
                    // *** Append ASCII encoded bytes to existing ***
                    this.response.Data += Encoding.ASCII.GetString(bytes);

                    // *** Check if we are done ***
                    if (this.response.Data.EndsWith(endOfData))
                    {
                        returnVal = true;

                        // *** Set status to true if not already set elsewhere ***
                        if (this.response.Status == RpcResponseStatus.Unknown)
                            this.response.Status = RpcResponseStatus.Success;

                        // *** Trim end of data ***
                        this.response.Data = this.response.Data.TrimEnd(endOfData.ToCharArray());
                    }
                }

            return returnVal;
        }

        public void SetInformationalMessage(string message)
        {
            this.response.InformationalMessage = message;
        }

        public void SetFailType(RpcResponseFailType failType)
        {
            this.response.FailType = failType;
            if (failType != RpcResponseFailType.None)
                this.response.Status = RpcResponseStatus.Fail;
        }
    }
}
