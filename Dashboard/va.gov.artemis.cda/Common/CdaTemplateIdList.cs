using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.CDA.Common
{
    /// <summary>
    /// A list of template Id's for any CDA section/node
    /// </summary>
    public class CdaTemplateIdList
    {
        // *** Internal copy of the list ***
        private List<string> idList; 

        // *** Constructor with array of template id's ***
        public CdaTemplateIdList(params string[] list)
        {
            this.idList = new List<string>();

            this.idList.AddRange(list); 
        }

        // *** Constructor with array of pocd II objects ***
        public CdaTemplateIdList(II[] ids)
        {
            this.idList = new List<string>();

            if (ids != null)
                foreach (II id in ids)
                    if (!string.IsNullOrWhiteSpace(id.root))
                        this.idList.Add(id.root); 
        }

        // *** Method to add id's after creation ***
        public void AddId(string id)
        {
            this.idList.Add(id); 
        }

        // *** Method to convert to CDA object array ***
        public II[] ToPocd()
        {
            List<II> returnList = new List<II>();

            foreach (string item in this.idList)
            {
                II tempII = new II() { root = item };
                returnList.Add(tempII);
            }

            return returnList.ToArray();
        }

        /// <summary>
        /// Returns a count of the number of template id's present in the list
        /// </summary>
        public int Count
        {
            get
            {
                return this.idList.Count;
            }
        }


    }
}
