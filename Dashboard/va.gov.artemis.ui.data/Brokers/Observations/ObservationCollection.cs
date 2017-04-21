// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;

namespace VA.Gov.Artemis.UI.Data.Brokers.Observations
{
    public abstract class ObservationCollection
    {
        public Dictionary<string , Observation> Observations {get; set; }

        public abstract string Category { get; }

        public ObservationCollection()
        {
            this.Observations = new Dictionary<string, Observation>(); 
        }

        public void SetValue(string code, string value)
        {
            if (this.Observations.ContainsKey(code))
                this.Observations[code].Value = value;
        }

        public string GetValue(string code)
        {
            string returnVal = "";

            if (this.Observations.ContainsKey(code))
                returnVal = this.Observations[code].Value;

            return returnVal;
        }

        protected void AddLoincObservation(string code, string description)
        {
            Observation tempObservation = new Observation()
            {
                Category = Category,
                CodeSystem =  CDA.Common.CodingSystem.Loinc,
                Code = code,
                Description = description
            };

            this.Observations.Add(code, tempObservation);
        }
    }

    
}
