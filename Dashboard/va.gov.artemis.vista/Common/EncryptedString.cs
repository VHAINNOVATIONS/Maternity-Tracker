// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VA.Gov.Artemis.Vista.Common
{
    [Serializable]
    public sealed class EncryptedString
    {
        private string s;

        public EncryptedString()
            : this(String.Empty)
        {
        }

        public EncryptedString(string s)
        {
            this.s = s;
        }

        public override string ToString()
        {
            return s;
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            return s == obj.ToString();
        }

        public override int GetHashCode()
        {
            return s.GetHashCode();
        }
        /*
        public static implicit operator EncryptedString(string s)
        {
            return new EncryptedString(s);
        }
        */

        public static implicit operator string(EncryptedString es)
        {
            if (es == null) return null;
            return es.ToString();
        }

    }
}
