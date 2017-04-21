// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.Vista.Broker;
using System.Collections.Generic;
using VA.Gov.Artemis.UI.Mock;
using VA.Gov.Artemis.UI.Data.Brokers;
using VA.Gov.Artemis.UI.Data.Brokers.Patient;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestPatientRepository
    {
        [TestMethod]
        public void TestPatientRepositorySearch()
        {
            IRpcBroker broker = MockRpcBrokerFactory.GetDsioFemalePatientSearchBroker();

            PatientRepository repository = new PatientRepository(broker);

            PatientSearchResult result = repository.Search("C", 1, 10);

            Assert.IsTrue(result.Success);
        }
    }
}
