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
    /// The name of a person for CDA data 
    /// </summary>
    public class CdaName 
    {
        public string NullFlavor { get; set; }

        /// <summary>
        /// What type of name it is or what it's used for
        /// </summary>
        public Hl7NameUse Use { get; set; }  

        /// <summary>
        /// The person's first or given name 
        /// </summary>
        public string First { get; set; } // Required

        /// <summary>
        /// The person's middle name
        /// </summary>
        public string MiddleInitial { get; set; }

        /// <summary>
        /// The person's last or family name 
        /// </summary>
        public string Last { get; set; } // Required

        /// <summary>
        /// The person's name prefix (e.g. Dr.)
        /// </summary>
        public string Prefix { get; set; }

        /// <summary>
        /// Any suffix which comes after the end of the name such as credentials
        /// </summary>
        public string Suffix { get; set; }

        public CdaName()
        {
            this.Use = Hl7NameUse.Legal; 
        }

        /// <summary>
        /// Converts this simple object to a raw PN from the CDA schema
        /// </summary>
        /// <returns></returns>
        public PN ToPN()
        {
            PN pn = new PN();

            if (string.IsNullOrWhiteSpace(this.NullFlavor))
            {
                // *** Use a list ***
                List<ENXP> namelist = new List<ENXP>();

                // *** Check all values and create corresponding object, add to  list ***

                if (!string.IsNullOrWhiteSpace(this.First))
                    namelist.Add(new engiven() { Text = new string[] { this.First } });

                if (!string.IsNullOrWhiteSpace(this.MiddleInitial))
                    namelist.Add(new engiven() { Text = new string[] { this.MiddleInitial } });

                if (!string.IsNullOrWhiteSpace(this.Last))
                    namelist.Add(new enfamily() { Text = new string[] { this.Last } });

                if (!string.IsNullOrWhiteSpace(this.Prefix))
                    namelist.Add(new enprefix() { Text = new string[] { this.Prefix } });

                if (!string.IsNullOrWhiteSpace(this.Suffix))
                    namelist.Add(new ensuffix() { Text = new string[] { this.Suffix } });

                // *** Add as array ***
                pn.Items = namelist.ToArray();

                // *** Set the use code ***
                pn.use = new string[] { this.UseCode };
            }
            else
                pn.nullFlavor = this.NullFlavor; 

            return pn; 
        }

        private string UseCode
        {
            get
            {
                string returnVal = "";

                //Unknown, ArtistStage, Alphabetic, Assigned, License,
                //IndigeneousTribal, Ideographic, Legal, Pseudonym, Phonetic, Religious, Soundex,
                //Search, Syllabic, Academic, Adopted, Birth, CallMe, Initial, Nobility, Professional,
                //Spouse, Title, Voorvoegsel

                string[] codes = new string[] {"", "A", "ABC", "ASGN", "C", "I",
                        "IDE", "L", "P", "PHON", "R", "SNDX", "SRCH", "SYL", 
                    "AC", "AD", "BR", "CL", "IN", "NB", "PR", "SP", "TITLE", "VV"};

                returnVal = codes[(int)this.Use]; 

                return returnVal;
            }
        }

        /// <summary>
        /// Retrieves the name if last, first mi format 
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return string.Format("{0}, {1} {2}", this.Last, this.First, this.MiddleInitial);
        }

    }
}
