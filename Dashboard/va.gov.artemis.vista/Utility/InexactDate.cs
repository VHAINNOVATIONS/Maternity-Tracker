using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Utility
{
    public class InexactDate
    {
        public DateTime Approximation { get; private set; }

        public int Year { get; set; }
        public int Month { get; set; }
        public int Day { get; set; }

        public InexactDate(int year, int month, int day)
        {
            // *** Pass year month date into constructor ***

            this.Year = -1;
            this.Month = -1;
            this.Day = -1;

            int approximateMonth;
            int approximateDay;

            // *** Check if year is ok ***
            if ((year > 0) && (year < 3000))
            {
                this.Year = year;

                // *** Check if month is ok ***
                if ((month > 0) && (month <= 12))
                {
                    this.Month = month;

                    // *** Check if day is ok ***
                    if ((day > 0) && (day <= DateTime.DaysInMonth(year, month)))
                        this.Day = day;
                }

                // *** Set approximate values if necessary ***

                approximateMonth = (this.Month == -1) ? 6 : this.Month;

                approximateDay = (this.Day == -1) ? 15 : this.Day; 

                this.Approximation = new DateTime(year, approximateMonth, approximateDay);

            }

        }

        public override string ToString()
        {
            string returnVal = "";

            string format = "";

            // *** Have to have at least a year ***
            if (this.Year != -1)
            {
                // *** Base formatting on what's available ***
                if ((this.Day == -1) && (this.Month == -1))
                    format = "yyyy";
                else if (this.Day == -1)
                    format = "MMM yyyy";
                else
                    format = "MM/dd/yyyy";
            }

            // *** If we have any format and any date make a string to return ***
            if (!string.IsNullOrWhiteSpace(format))
                if (this.Approximation != DateTime.MinValue)
                    returnVal = this.Approximation.ToString(format);

            return returnVal;
        }

    }
}
