using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using VA.Gov.Artemis.UI.Data.Models.Pregnancy;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using System.Collections.Generic;
using VA.Gov.Artemis.UI.Data.Brokers.Observations;
using VA.Gov.Artemis.CDA.Common;
using VA.Gov.Artemis.UI.Data.Models.Outcomes;
using VA.Gov.Artemis.UI.Data.Models.Observations;

namespace VA.Gov.Artemis.UI.Tests
{
    [TestClass]
    public class TestObservationsRepository
    {
        [TestMethod]
        public void TestObservationFactory()
        {
            SpontaneousAbortionOutcome outcome = new SpontaneousAbortionOutcome();

            outcome.GestationalAgeWeeks = "32";
            outcome.GestationalAgeDays = "2";
            outcome.Trimester = 1;
            outcome.WithoutSurgery = true;
            outcome.DilationCurettage = false;
            outcome.VacuumAspiration = true;
            outcome.MedicationsNeeded = "Tylenol, Aleve";
            outcome.IncompetentCervix = false;

            List<Observation> list = outcome.GetObservations("28", "4", "");

            Assert.IsNotNull(list);

            SpontaneousAbortionOutcome outcome2 = new SpontaneousAbortionOutcome(list);

            Assert.AreEqual(outcome.MedicationsNeeded, outcome2.MedicationsNeeded);

            BabyDetails bd = new BabyDetails()
            {
                FirstName = "Joe",
                Gender = Hl7Gender.Male,
                BirthWeight = "3000",
                OneMinuteApgar = "3",
                FiveMinuteApgar = "2",
                Complications = "Some Complications Text Here",
                AdmittedToIcu = true
            };

            list = bd.GetObservations("28", "4", "");

            Assert.IsNotNull(list);

            BabyDetails bd2 = new BabyDetails(list);

            Assert.AreEqual(bd.Gender, bd2.Gender);

            DeliveryDetails dd = new DeliveryDetails();
            dd.Babies = new List<BabyDetails>();
            dd.NormalSpontaneousVaginalDelivery = true;
            dd.OtherDeliveryDetails = "Something";

            list = dd.GetObservations("28", "4", "");
            
            Assert.IsNotNull(list);

            DeliveryDetails dd2 = new DeliveryDetails(list);

            Assert.AreEqual(dd.OtherDeliveryDetails, dd2.OtherDeliveryDetails); 
        }
    }
}
