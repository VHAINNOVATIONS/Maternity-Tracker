using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using System.Collections.Generic;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Commands.Dsio.Pregnancy;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.Commands.Tests.Real
{
    [TestClass]
    public abstract class TestCommandsBase
    {
        protected IRpcBroker Broker { get; set; }

        protected RpcBroker GetConnectedBroker()
        {
            RpcBroker returnVal = new RpcBroker(TestConfiguration.ValidServerName, TestConfiguration.ValidPort);

            if (!returnVal.Connect())
                Assert.Fail("Could not connect broker");

            return returnVal;
        }

        // *** Executes a queue of commands and returns last response ***
        protected RpcResponse ExecuteCommandQueue(Queue<CommandBase> commands)
        {
            RpcResponse returnVal = null;

            bool ok = true;
            CommandBase command = null;

            while ((commands.Count > 0) && ok)
            {
                command = commands.Dequeue();

                returnVal = command.Execute();

                ok = returnVal.Status == RpcResponseStatus.Success;
            }

            if (commands.Count > 0)
                Assert.Fail(string.Format("Did not complete command queue: Command {0} failed", command.GetType().ToString()));

            return returnVal;
        }

        protected void SignonToBroker(IRpcBroker broker, int avCodeIndex)
        {
            XusSignonSetupCommand signonSetupCommand = new XusSignonSetupCommand(broker);

            RpcResponse response = signonSetupCommand.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            XusAvCodeCommand avCodeCommand = new XusAvCodeCommand(broker);
            
            avCodeCommand.AddCommandArguments(TestConfiguration.ValidAccessCodes[avCodeIndex], TestConfiguration.ValidVerifyCodes[avCodeIndex]);

            response = avCodeCommand.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

        }

        protected DsioPregnancy GetAnyPregnancy(IRpcBroker broker, string patientDfn)
        {
            DsioPregnancy returnVal = null;

            DsioGetPregDetailsCommand command = new DsioGetPregDetailsCommand(broker);

            command.AddCommandArguments(patientDfn, "");

            RpcResponse response = command.Execute();
                        
            if (response.Status == RpcResponseStatus.Success)            
                if (command.PregnancyList != null)
                    if (command.PregnancyList.Count > 0)
                        returnVal = command.PregnancyList[0];

            return returnVal; 
        }

        public DsioPregnancy AddCurrentPregnancy(IRpcBroker broker, string patientDfn)
        {
            DsioSavePregDetailsCommand command = new DsioSavePregDetailsCommand(broker);

            DsioPregnancy newPreg = new DsioPregnancy()
            {
                EDD = DateTime.Now.AddMonths(6).ToString(VistaDates.VistADateOnlyFormat),
                RecordType = "CURRENT",
                PatientDfn = patientDfn
            };

            command.AddCommandArguments(newPreg, false);

            RpcResponse response = command.Execute();

            Assert.AreEqual(RpcResponseStatus.Success, response.Status);

            newPreg.Ien = command.Ien; 

            return newPreg; 
        }


        public DsioPregnancy GetOrCreatePregnancy(IRpcBroker broker, string patientDfn)
        {
            DsioPregnancy returnVal = this.GetAnyPregnancy(broker, patientDfn);

            if (returnVal == null)
                returnVal = this.AddCurrentPregnancy(broker, patientDfn); 

            return returnVal; 
        }
    }
}
