using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    public class CdaReferenceRange
    {
        public string Low { get; set; }
        public string High { get; set; }
        public string Units { get; set; }

        
        //<referenceRange typeCode="REFV">
            //<observationRange classCode="OBS" moodCode="EVN.CRT">
                //<interpretationCode code="N"/>
                //<value xsi:type="IVL_PQ">
                    //<low value="4.50" unit="10*6/mm3"/>
                    //<high value="6.00" unit="10*6/mm3"/>
                //</value>
                //<lab:precondition typeCode="PRCN">
                    //<lab:criterion classCode="COND">
                        //<lab:code code="SEX"/>
                        //<lab:value xsi:type="CD" code="M" codeSystem="2.16.840.1.113883.5.1"/>
                    //</lab:criterion>
                //</lab:precondition>
            //</observationRange>
        //</referenceRange>

        public POCD_MT000040ReferenceRange ToPocd()
        {
            POCD_MT000040ReferenceRange returnVal = new POCD_MT000040ReferenceRange();

            // *** Create the observation range ***
            returnVal.observationRange = new POCD_MT000040ObservationRange()
            {
                classCode = "OBS",
                moodCode = "EVN.CRT"
            };

            // *** Create interpretation code ***
            returnVal.observationRange.interpretationCode = new CE() { code = "N" };

            // *** Create working lists ***
            List<PQ> itemsList = new List<PQ>();
            List<ItemsChoiceType> itemNameList = new List<ItemsChoiceType>(); 
            
            // *** Create a value for the range ***
            IVL_PQ val = new IVL_PQ();

            // *** Add low and high values *** 
            IVXB_PQ pq = new IVXB_PQ() { value = this.Low, unit = this.Units };
            itemsList.Add(pq);
            itemNameList.Add(ItemsChoiceType.low);

            pq = new IVXB_PQ() { value = this.High, unit = this.Units };
            itemsList.Add(pq);
            itemNameList.Add(ItemsChoiceType.high);

            val.Items = itemsList.ToArray();
            val.ItemsElementName = itemNameList.ToArray();

            returnVal.observationRange.value = val; 

            return returnVal; 
        }

    }
}
