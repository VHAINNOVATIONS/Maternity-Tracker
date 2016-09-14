using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Broker
{
    public enum RpcResponseFailType { None, Unspecified, InvalidMessage, U411, Retries, UnexpectedResultFormat, UnexpectedResultEmpty, NotConnected, InvalidContext, SocketError }
}
