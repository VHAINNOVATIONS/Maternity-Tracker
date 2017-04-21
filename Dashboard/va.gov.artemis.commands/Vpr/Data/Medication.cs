// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.Commands.Vpr.Data
{
    [Serializable]
    public class Medication : ClinicalItem
    {
        // TODO: From docs...

        // list dose
        // IMO
        // medID
        // parent
        
        // TODO: Determine if there's a difference between inpatient, outpatient, non-va, fluid

        [XmlElement("currentProvider")]
        public CodeElement CurrentProvider { get; set; }

        [XmlElement("daysSupply")]
        public ValueElement DaysSupply { get; set; }

        [XmlElement("expires")]
        public VprDateTime Expires { get; set; }

        [XmlArray("fills")]
        [XmlArrayItem("fill")]
        public List<Fill> Fills { get; set; }

        [XmlElement("fillCost")]
        public ValueElement FillCost { get; set; }

        [XmlElement("fillsAllowed")]
        public ValueElement FillsAllowed { get; set; }

        [XmlElement("fillsRemaining")]
        public ValueElement FillsRemaining { get; set; }

        [XmlElement("form")]
        public ValueElement Form { get; set; }

        [XmlElement("lastFilled")]
        public VprDateTime LastFilled { get; set; }

        [XmlElement("orderID")]
        public ValueElement OrderId { get; set; }

        [XmlElement("ordered")]
        public VprDateTime Ordered { get; set; }

        [XmlElement("orderingProvider")]
        public CodeElement OrderingProvider { get; set; }

        [XmlElement("pharmacist")]
        public CodeElement Pharmacist { get; set; }

        [XmlElement("prescription")]
        public ValueElement Prescription { get; set; }

        [XmlArray("products")]
        [XmlArrayItem("product")]
        public List<Product> Products { get; set; }

        [XmlElement("quantity")]
        public ValueElement Quantity { get; set; }

        [XmlElement("routing")]
        public ValueElement Routing { get; set; }

        [XmlElement("sig")]
        public PreserveSpaceElement Sig { get; set; }

        [XmlElement("start")]
        public VprDateTime Start { get; set; }

        [XmlElement("status")]
        public ValueElement Status { get; set; }

        [XmlElement("stop")]
        public VprDateTime Stop { get; set; }

        [XmlElement("type")]
        public ValueElement MedicationType { get; set; }

        [XmlElement("vaStatus")]
        public ValueElement VaStatus { get; set; }

        [XmlElement("vaType")]
        public ValueElement VaType { get; set; }

    }
}
