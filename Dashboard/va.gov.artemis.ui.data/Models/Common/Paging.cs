using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.UI.Data.Models.Common
{
    public class Paging
    {
        private int MaxPages = 20; 

        public int ItemsPerPage { get; set; }
        public int CurrentPage { get; set; }
        public int TotalItems { get; set; }

        //public string ControllerName { get; set; }
        //public string ActionName { get; set; }

        public string BaseUrl { get; set; }

        public void SetPagingData(int itemsPerPage, int currentPage, int totalItems)
        {
            this.ItemsPerPage = itemsPerPage;
            this.CurrentPage = currentPage;
            this.TotalItems = totalItems;
        }

        public int TotalPages
        {
            get
            {
                int returnVal = -1;

                if (ItemsPerPage > 0)
                {
                    returnVal = TotalItems / ItemsPerPage;
                    if (TotalItems % ItemsPerPage > 0)
                        returnVal += 1;
                }

                return returnVal;
            }
        }

        public int NextPage
        {
            get
            {
                return this.CurrentPage + 1;
            }
        }

        public int PreviousPage
        {
            get
            {
                return (this.CurrentPage > 1) ? this.CurrentPage - 1 : 1;
            }
        }

        public int FirstPageToShow
        {
            get
            {
                int returnVal = 1;

                if (TotalPages > MaxPages)
                {
                    if (this.CurrentPage <= this.MaxPages / 2)
                        returnVal = 1;
                    else if (this.CurrentPage + this.MaxPages / 2 > this.TotalPages)
                        returnVal = this.TotalPages - this.MaxPages;
                    else
                        returnVal = this.CurrentPage - this.MaxPages / 2 + 1;
                }

                return returnVal;
            }
        }

        public int LastPageToShow
        {
            get
            {
                int returnVal = this.FirstPageToShow + MaxPages;

                if (returnVal > this.TotalPages)
                    returnVal = this.TotalPages; 

                return returnVal;
            }
        }


    }
}
