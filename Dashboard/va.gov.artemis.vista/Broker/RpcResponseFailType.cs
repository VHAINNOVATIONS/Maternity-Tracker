﻿// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Broker
{
    public enum RpcResponseFailType { None, Unspecified, InvalidMessage, U411, Retries, UnexpectedResultFormat, UnexpectedResultEmpty, NotConnected, InvalidContext, SocketError }
}
