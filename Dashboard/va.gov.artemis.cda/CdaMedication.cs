using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA
{
    public class CdaMedication
    {
        public string Id { get; set; }
        public CdaEffectiveTime EffectiveTime {get; set;}
        public string Description { get; set; }
        public CdaCode ProductCode { get; set; }

        public string ReferenceId
        {
            get
            {
                return string.Format("med-{0}", this.Id);
            }
        }

        public POCD_MT000040SubstanceAdministration ToPocd()
        {
            POCD_MT000040SubstanceAdministration returnVal = new POCD_MT000040SubstanceAdministration();

            returnVal.classCode = "SBADM";
            returnVal.moodCode = x_DocumentSubstanceMood.EVN;

            returnVal.templateId = new II[]
            { 
                new II { root = "2.16.840.1.113883.10.20.1.24" }, 
                new II { root = "1.3.6.1.4.1.19376.1.5.3.1.4.7" }, 
                new II { root = "1.3.6.1.4.1.19376.1.5.3.1.4.7.1" }
            };

            returnVal.id = new II[] {new II { root = this.Id }};

            returnVal.statusCode = new CS { code = "completed" };

            returnVal.effectiveTime = new IVL_TS[1];

            returnVal.effectiveTime[0] = this.EffectiveTime.ToIvlTs();

            returnVal.consumable = new POCD_MT000040Consumable();

            returnVal.consumable.manufacturedProduct = new POCD_MT000040ManufacturedProduct();
                        
            returnVal.consumable.manufacturedProduct.templateId = new II[] 
            {
                new II { root = "1.3.6.1.4.1.19376.1.5.3.1.4.7.2" }, 
                new II { root = "2.16.840.1.113883.10.20.1.53" }
            };

            POCD_MT000040Material material = new POCD_MT000040Material(); 

            material.name = new EN() { Text = new string[] { this.Description } } ;

            if (this.ProductCode != null)
                material.code = this.ProductCode.ToCE();
            else
                material.code = new CE() { nullFlavor = "UNK", originalText = new ED() { reference = new TEL() { value = "N/A" } } };
                        
            returnVal.consumable.manufacturedProduct.Item = material;
                        
            return returnVal; 
        }
    }
}
