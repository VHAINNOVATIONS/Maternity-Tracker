using VA.Gov.Artemis.Vista.Common;
using VA.Gov.Artemis.Vista.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Broker
{
    internal class RpcParameter
    {
        public RpcParameterType ParameterType { get; set; }
        public string Value { get; set; }
        public Mult Mult { get; set; }

        private const string MultValue = ".X"; 

        public RpcParameter(object arg)
        {            
            if (arg == null)
            {
                this.ParameterType = RpcParameterType.Literal;
                this.Value = string.Empty;
            }
            else if ((arg is string) || (arg is EncryptedString) || (arg is char))
            {
                this.ParameterType = RpcParameterType.Literal;
                this.Value = arg.ToString();
            }
            else if (arg is Mult)
            {
                this.ParameterType = RpcParameterType.List;
                this.Value = MultValue;
                this.Mult = (Mult)arg; 
            }
            else if (arg is string[])
            {
                string[] arr = arg as string[];
                Mult m = new Mult();
                for (int i = 0; i < arr.Length; i++)
                {
                    m[(i + 1).ToString()] = arr[i];
                }
                this.ParameterType = RpcParameterType.List;
                this.Value = MultValue;
                this.Mult = m;
            }
            else
            {
                throw new ArgumentException("Invalid RPC Parameter Type: " + arg.GetType().Name); 
            }

        }

    }
}
