// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.Commands.Dsio.Observation;
using VA.Gov.Artemis.UI.Data.Models.Observations;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Outcomes
{
    public abstract class ObservationConstructable
    {
        public ObservationConstructable()
        {

        }

        public ObservationConstructable(List<Observation> list)
        {
            this.Construct(list);
        }

        protected abstract void Construct(List<Observation> list);

        public abstract List<Observation> GetObservations(string patientDfn, string pregnancyIen, string babyIen);
        
        public abstract string ObservationCategory { get; }

        public object PopulateProperties(object obj, List<Observation> list)
        {
            Type t = obj.GetType();

            Dictionary<string, PropertyInfo> propLookup = this.GetPropertyLookup(obj); 

            foreach (var prop in t.GetProperties()) 

            foreach (Observation obs in list)
            {
                PropertyInfo pi = t.GetProperty(obs.Code);

                if (pi == null)
                    pi = propLookup[obs.Code];

                if (pi != null)
                {
                    if (pi.PropertyType == typeof(int))
                    {
                        int intVal;
                        if (int.TryParse(obs.Value, out intVal))
                            pi.SetValue(obj, intVal);
                    }
                    else if (pi.PropertyType == typeof(string))
                    {
                        Attribute attr = pi.GetCustomAttribute(typeof(IsNarrative));

                        if (attr == null)
                            pi.SetValue(obj, obs.Value);
                        else
                            pi.SetValue(obj, obs.Narrative); 
                    }
                    else if (pi.PropertyType == typeof(bool))
                    {
                        bool boolVal;
                        if (bool.TryParse(obs.Value, out boolVal))
                            pi.SetValue(obj, boolVal);
                    }
                    else if (pi.PropertyType.IsEnum)
                    {
                        if (Enum.IsDefined(pi.PropertyType, obs.Value))
                        {
                            var enumVal = Enum.Parse(pi.PropertyType, obs.Value);
                            pi.SetValue(obj, enumVal);
                        }
                    }
                    else if (pi.PropertyType == typeof(decimal))
                    {
                        decimal decVal;
                        if (decimal.TryParse(obs.Value, out decVal))
                            pi.SetValue(obj, decVal);
                    }
                    else if (pi.PropertyType == typeof(DateTime))
                        pi.SetValue(obj, obs.Value);

                }
            }

            return obj;
        }

        protected List<Observation> GetObservations(object obj, string patientDfn, string pregnancyIen, string babyIen)
        {
            List<Observation> returnList = new List<Observation>();

            PropertyInfo[] props = obj.GetType().GetProperties();

            foreach (PropertyInfo pi in props)
            {
                bool skip = false;

                foreach (var attr in pi.CustomAttributes)
                    if (attr.AttributeType == typeof(SkipObservationAttribute))
                        skip = true;

                if (!pi.CanWrite)
                    skip = true; 

                if (!skip)
                {
                    object orig = pi.GetValue(obj);

                    var tempVal = pi.GetValue(obj);

                    if (tempVal != null)
                    {
                        Observation obs = GetObservationPrototype(obj, patientDfn, pregnancyIen, babyIen);

                        Attribute attr = pi.GetCustomAttribute(typeof(CdaCodingInfo));

                        if (attr == null)
                            obs.Code = pi.Name;
                        else
                        {
                            CdaCodingInfo codingAttr = attr as CdaCodingInfo;
                            obs.Code = codingAttr.Code;
                            obs.CodeSystem = codingAttr.CodeSystem;
                            obs.Description = codingAttr.DisplayName; 
                        }

                        attr = pi.GetCustomAttribute(typeof(IsNarrative));

                        if (attr == null)
                            obs.Value = tempVal.ToString();
                        else
                            obs.Narrative = tempVal.ToString(); 
                        
                        returnList.Add(obs);
                    }
                }
            }

            return returnList;
        }

        private Observation GetObservationPrototype(object obj, string patientDfn, string pregnancyIen, string babyIen)
        {
            Observation returnVal = new Observation();

            returnVal.PatientDfn = patientDfn;
            returnVal.PregnancyIen = pregnancyIen;
            returnVal.BabyIen = babyIen;
            //returnVal.Category = obj.GetType().Name;
            returnVal.Category = this.ObservationCategory;
            returnVal.EntryDate = DateTime.Now; //.ToString(VistaDates.VistADateFormatFour);
            returnVal.CodeSystem = CDA.Common.CodingSystem.None; // DsioObservation.OtherCodeSystem;

            return returnVal;
        }

        private Dictionary<string, PropertyInfo> GetPropertyLookup(object o)
        {
            Type t = o.GetType();

            Dictionary<string, PropertyInfo> props = new Dictionary<string, PropertyInfo>();

            foreach (PropertyInfo pi in t.GetProperties())
            {
                bool skip = false;

                foreach (var attr in pi.CustomAttributes)
                    if (attr.AttributeType == typeof(SkipObservationAttribute))
                        skip = true;

                if (!pi.CanWrite)
                    skip = true;

                if (!skip)
                {
                    Attribute attr = pi.GetCustomAttribute(typeof(CdaCodingInfo));

                    if (attr == null)
                        props.Add(pi.Name, pi);
                    else
                    {
                        CdaCodingInfo codingAttr = attr as CdaCodingInfo;

                        props.Add(codingAttr.Code, pi); 
                    }                        
                }
            }

            return props; 
        }
    }
}
