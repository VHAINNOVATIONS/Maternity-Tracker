using VA.Gov.Artemis.Vista.Broker;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Data.Brokers.Common
{
    public abstract class RepositoryBase
    {
        protected IRpcBroker broker { get; set; }

        public string ContentPath { get; set; }

        public RepositoryBase(IRpcBroker rpcBroker)
        {
            this.broker = rpcBroker; 
        }
    }
}