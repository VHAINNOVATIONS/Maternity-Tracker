// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Commands.Xus
{
    public class XusUserInfo
    {
        public string DUZ {get;set;}
        public string Name {get;set;}
        public string StandardName {get;set;}
        public XusDivision Division {get;set;}
        public string Title {get;set;}
        public string Language {get;set;}

        // TODO: What is this?
        public string DTime {get;set;}
        public string Vpid {get;set;}
        public string ServiceSection {get;set;}

        public string UserClass {get;set;}
        public string DefaultLocation {get;set;}
    }
}
