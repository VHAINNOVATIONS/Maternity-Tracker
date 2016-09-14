using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// An effective time object for CDA
    /// </summary>
    public class CdaEffectiveTime
    {
        // *** Basic Values ***
        public DateTime Low { get; set; }
        public DateTime High { get; set; }
        public DateTime Value { get; set; }

        /// <summary>
        /// Returns a CDA low/high date 
        /// </summary>
        /// <returns>IVL_TS based on low/high</returns>
        public IVL_TS ToIvlTs()
        {
            // *** Converts to raw effective time ***

            IVL_TS returnVal = new IVL_TS();

            // *** Create working lists ***
            List<QTY> itemsList = new List<QTY>();
            List<ItemsChoiceType2> itemNameList = new List<ItemsChoiceType2>(); 

            // *** If we have a value for low, add entry to lists ***
            if (this.Low != DateTime.MinValue)
            {
                IVXB_TS lowTs = new IVXB_TS() { value = this.Low.ToString(RawCdaDocument.CdaDateFormat) };
                itemsList.Add(lowTs);
                itemNameList.Add(ItemsChoiceType2.low);
            }
            else
            {
                IVXB_TS low = new IVXB_TS() { nullFlavor = "UNK" };
                itemsList.Add(low);
                itemNameList.Add(ItemsChoiceType2.low);
            }

            // *** If we have a value for high, add entry to lists ***
            if (this.High != DateTime.MinValue)
            {
                IVXB_TS highTs = new IVXB_TS() { value = this.High.ToString(RawCdaDocument.CdaDateFormat) };
                itemsList.Add(highTs);
                itemNameList.Add(ItemsChoiceType2.high);
            }
            //else
            //{
            //    IVXB_TS high = new IVXB_TS() { nullFlavor = "UNK" };
            //    itemsList.Add(high);
            //    itemNameList.Add(ItemsChoiceType2.high);
            //}

            // *** Add value as "center" ***
            if (this.Value != DateTime.MinValue)
            {
                IVXB_TS valTs = new IVXB_TS() { value = this.Value.ToString(RawCdaDocument.CdaDateFormat) };
                itemsList.Add(valTs);
                itemNameList.Add(ItemsChoiceType2.high);
            }
        
            // *** ADD arrays to return ***

            returnVal.Items = itemsList.ToArray();

            returnVal.ItemsElementName = itemNameList.ToArray();

            return returnVal; 
        }

        /// <summary>
        /// Creates a time object 
        /// </summary>
        /// <returns>A TS object with value populated</returns>
        public TS ToTS()
        {
            TS returnVal = new TS();

            if (this.Value == DateTime.MinValue)
                returnVal.nullFlavor = "UNK"; 
            else 
                returnVal.value = this.Value.ToString(RawCdaDocument.CdaDateFormat);

            return returnVal; 
        }

        internal static CdaEffectiveTime FromPocd(IVL_TS iVL_TS)
        {
            CdaEffectiveTime returnVal = new CdaEffectiveTime();

            if (iVL_TS.Items != null)
                for (int i = 0; i < iVL_TS.Items.Length; i++)
                    if (iVL_TS.ItemsElementName.Length > i)
                        if (iVL_TS.Items[i] is TS)
                        {
                            DateTime dt = GetDateTime((TS)iVL_TS.Items[i]);

                            if (dt != DateTime.MinValue)
                            {
                                switch (iVL_TS.ItemsElementName[i])
                                {
                                    case ItemsChoiceType2.low:
                                        returnVal.Low = dt;
                                        break;
                                    case ItemsChoiceType2.high:
                                        returnVal.High = dt;
                                        break;
                                    case ItemsChoiceType2.center:
                                        returnVal.Value = dt;
                                        break;
                                }
                            }
                        }

            return returnVal; 
        }

        private static DateTime GetDateTime(TS ts)
        {
            DateTime dt = DateTime.MinValue;
         
            if (ts != null)
            {
                CultureInfo enUs = new CultureInfo("en-US");
                DateTime.TryParseExact(ts.value, RawCdaDocument.CdaDateFormat, enUs, DateTimeStyles.None, out dt); 
            }

            return dt; 
        }
    }
}
