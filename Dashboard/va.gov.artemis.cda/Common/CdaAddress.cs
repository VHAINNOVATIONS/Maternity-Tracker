// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// This class represents a basic CDA address.  It can be converted to the raw AD object found in the CDA schema. 
    /// </summary>
    public class CdaAddress
    {
        /// <summary>
        /// The top line of the street address
        /// </summary>
        public string StreetAddress1 { get; set; }

        /// <summary>
        /// The second line of the street address
        /// </summary>
        public string StreetAddress2 { get; set; }

        /// <summary>
        /// The city 
        /// </summary>
        public string City { get; set; }

        /// <summary>
        /// The US state
        /// </summary>
        public string State { get; set; }

        /// <summary>
        /// The zip or postal code 
        /// </summary>
        public string ZipCode { get; set; }

        /// <summary>
        /// The country.  Defaults to "US".
        /// </summary>
        public string Country { get; set; }

        /// <summary>
        /// The address use defined in HL7 value set 2.16.840.1.113883.1.11.10637
        /// </summary>
        public Hl7AddressUse Use { get; set; }

        // *** String representation of the address use ***
        //public enum Hl7AddressUse { Unknown, BadAddress, Direct, Home, PrimaryHome, VacationHome, PhysicalVisit, Postal, Public, Temporary, WorkPlace }
        private string[] codes = new string[] { "", "BAD", "DIR", "H", "HP", "HV", "PHYS", "PST", "PUB", "TMP", "WP" };

        /// <summary>
        /// Default parameterless constructor
        /// </summary>
        public CdaAddress() 
        {
            this.Country = "US";
        }

        /// <summary>
        /// Instantiates based on raw AD object from CDA schema
        /// </summary>
        /// <param name="sourceAD">Raw AD (address) object from CDA schema</param>
        public CdaAddress(AD sourceAD)
        {
            // *** Sets properties based on source AD ***

            // *** Use ***
            if (sourceAD.use != null) 
                if (sourceAD.use.Length > 0) 
                    if (!string.IsNullOrWhiteSpace(sourceAD.use[0]))
                    {
                        int idx = Array.IndexOf(this.codes, sourceAD.use[0]);
                        this.Use = (Hl7AddressUse)idx;
                    }

            // *** Address ***
            int adrIdx = 0; 
            if (sourceAD.Items != null) 
                if (sourceAD.Items.Length > 0)
                    foreach (ADXP item in sourceAD.Items)
                    {
                        if (item.Text != null)
                        {
                            if (item is adxpstreetAddressLine)
                            {
                                if (adrIdx == 0)
                                    this.StreetAddress1 = item.Text[0];
                                else
                                    this.StreetAddress2 = item.Text[0];
                            }
                            else if (item is adxpcity)
                                this.City = item.Text[0];
                            else if (item is adxpstate)
                                this.State = item.Text[0];
                            else if (item is adxppostalCode)
                                this.ZipCode = item.Text[0];
                            else if (item is adxpcountry)
                                this.Country = item.Text[0];
                        }
                    }
        }
        
        /// <summary>
        /// Converts instance to a raw AD CDA address 
        /// </summary>
        /// <returns>Raw AD</returns>
        public AD ToAD()
        {
            AD returnVal = new AD();

            // *** Create a working list ***
            List<ADXP> addressItemList = new List<ADXP>();

            // *** Check for emptiness, add if not ***
            if (!string.IsNullOrWhiteSpace(this.StreetAddress1))
                addressItemList.Add(new adxpstreetAddressLine() { Text = new string[] { this.StreetAddress1 } });

            // *** Check for emptiness, add if not ***
            if (!string.IsNullOrWhiteSpace(this.StreetAddress2)) 
                addressItemList.Add(new adxpstreetAddressLine() { Text = new string[] { this.StreetAddress2 } });

            // *** Check for emptiness, add if not ***
            if (!string.IsNullOrWhiteSpace(this.City))
                addressItemList.Add(new adxpcity() { Text = new string[] { this.City } });

            // *** Check for emptiness, add if not ***
            if (!string.IsNullOrWhiteSpace(this.State)) 
                addressItemList.Add(new adxpstate() { Text = new string[] { this.State } });

            // *** Check for emptiness, add if not ***
            if (!string.IsNullOrWhiteSpace(this.ZipCode)) 
                addressItemList.Add(new adxppostalCode() { Text = new string[] { this.ZipCode } });

            if (addressItemList.Count == 0)
                returnVal.nullFlavor = "UNK";
            else
            {
                // *** Check for emptiness, add if not ***
                if (!string.IsNullOrWhiteSpace(this.Country))
                    addressItemList.Add(new adxpcountry() { Text = new string[] { this.Country } });

                // *** Populate Use ***
                if (!string.IsNullOrWhiteSpace(this.ADUse))
                    returnVal.use = new string[] { this.ADUse };

                // *** Populate items value ***
                returnVal.Items = addressItemList.ToArray();
            }

            return returnVal;
        }

        private string ADUse
        {
            get
            {
                return codes[(int)this.Use];
            }
        }

    }
}
