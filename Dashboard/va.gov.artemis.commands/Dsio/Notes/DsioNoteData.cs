// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio.Notes
{
    /// <summary>
    /// Class to hold discrete data for a note 
    /// </summary>
    /// 
    public class DsioNoteData: Dictionary<string, string>
    {
        /// <summary>
        /// Creates object from plain Dictionary<string, string> object
        /// </summary>
        /// <param name="original">The Dictionary<string, string> which the DsioNoteData will be based on</param>
        /// <returns>A new DsioNoteData</returns>
        public static DsioNoteData FromDictionary(Dictionary<string, string> original)
        {
            // *** Create from plain dictionary ***

            DsioNoteData returnData = new DsioNoteData();

            if (original != null)
                if (original.Count > 0)
                    foreach (string key in original.Keys)
                        if (key.Length > 30)
                            throw new ArgumentException(); 
                        else 
                            returnData.Add(key, original[key]);

            return returnData; 
        }

        /// <summary>
        /// Gets the parameter as expected by MTD RPC's
        /// </summary>
        /// <returns>A string array which can be passed to VistA RPC's</returns>
        public string[] ToParameter()
        {
            List<string> returnList = new List<string>(); 

            // Format is Type^ID^Field^Value
            // Type: S = Single, M = Multiple, WP = Word Processing
            // ID: Needed as consolidating ID for multiples

            //(S,M,WP)^CONTROL^LABEL 1^SOME VALUE^INDEX^NOTE TEXT

            //(S,M,WP)^CONTROL^LABEL 1^INDEX(OPTIONAL ONLY FOR M)^VALUE

            // S^COVERAGE_1^COVERAGE_1^^False

            //foreach (string key in this.Keys)
            //    returnList.Add(string.Format("{0}^{1}^{2}^{3}^{4}", "S", key.ToUpper(), key.ToUpper(),"", this[key]));

            // *** Changes for DSIO_DDCS_2_T1.KID
            //CONTROL^(INDEXED^VALUE)

            foreach (string key in this.Keys)
                returnList.Add(string.Format("{0}^^{1}", key.ToUpper(), this[key]));

            return returnList.ToArray(); 
        }
    }
}
