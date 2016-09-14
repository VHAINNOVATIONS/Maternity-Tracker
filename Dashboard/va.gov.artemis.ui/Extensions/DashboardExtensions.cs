using System;
using System.Linq;
using System.Web.Mvc;

namespace VA.Gov.Artemis.UI.Extensions
{
    public static class DashboardExtensions
    {
        public static SelectList ToSelectList<TEnum>(this TEnum enumObj)
            where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            var values = from TEnum e in Enum.GetValues(typeof(TEnum))
                         select new { Id = e, Name = e.ToString() };

            return new SelectList(values, "Id", "Name", enumObj);
        }

    }
}