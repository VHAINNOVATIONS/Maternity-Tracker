using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Dsio
{
    public interface IPagedDataProcessor
    {
        int TotalResults { get; set; }

        void ProcessPage();

        void ProcessLine(string line);
    }
}
