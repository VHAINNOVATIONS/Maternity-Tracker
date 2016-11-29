using System;
using System.Text;
using VA.Gov.Artemis.Vista.Common;

namespace VA.Gov.Artemis.Vista.Utility
{
    public partial class VistAHash
    {
        private static Random rnd = new Random();
        private static int maxKeys = 20;

        private static string[] cipherPad = new string[] {"Insert VistA cipher here" }; 

        public static EncryptedString Encrypt(string normaltext)
        {
            int assoc = rnd.Next(maxKeys);
            int ident = rnd.Next(maxKeys);
            while (ident == assoc)
            {
                ident = rnd.Next(maxKeys);
            }
            return new EncryptedString(String.Empty + (char)(assoc+32) + Translate(normaltext, cipherPad[assoc], cipherPad[ident]) + (char)(ident+32));
        }

        public static string Decrypt(EncryptedString encryptedtext)
        {
            string s = encryptedtext;
            int ident = (byte)s[0] - 32;
            int assoc = (byte)s[s.Length-1] - 32;
            return Translate(s.Substring(1,s.Length-2), cipherPad[assoc], cipherPad[ident]);
        }

        private static string Translate(string s, string ident, string assoc)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.Length; i++)
            {
                char c = s[i];
                int p = ident.IndexOf(c);
                if (p > -1)
                {
                    sb.Append(assoc[p]);
                }
                else
                {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }
    }
}