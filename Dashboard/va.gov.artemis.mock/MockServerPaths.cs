using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Controllers;

namespace VA.Gov.Artemis.Mock
{
    public class MockServerPaths: IServerPaths
    {
        private string rootPath { get; set; }

        public MockServerPaths(string mockRootPath)
        {
            this.rootPath = mockRootPath; 
        }

        public string MapPath(string path)
        {
            if (path.StartsWith("/"))
                path = path.Remove(0,1);

            path = path.Replace("/", "\\");

            return System.IO.Path.Combine(rootPath, path);
        }
    }
}
