using System;
using System.Collections.Generic;

namespace VA.Gov.Artemis.Vista.Utility
{
    internal class Mult
    {
        private List<KeyValuePair<string, string>> multiple = new List<KeyValuePair<string, string>>();

        public string this[string key]
        {
            get
            {
                int idx = Position(key);
                if (idx < 0)
                {
                    return String.Empty;
                }
                return multiple[idx].Value;
            }
            set
            {
                int idx = Position(key);
                if (idx > -1)
                {
                    multiple.RemoveAt(idx);
                }
                multiple.Add(new KeyValuePair<string, string>(key, value));
            }
        }

        public int Count
        {
            get { return multiple.Count; }
        }

        public string Subscript(int position)
        {
            if (position > -1 && position < Count)
            {
                return multiple[position].Key;
            }
            return String.Empty;
        }

        public int Position(string subscript)
        {
            int i = 0;
            while (i < Count)
            {
                if (String.Equals(multiple[i].Key, subscript, StringComparison.InvariantCultureIgnoreCase))
                {
                    return i;
                }
                i++;
            }
            return -1;
        }

        public string First
        {
            get
            {
                if (Count > 0) return multiple[0].Key;
                return String.Empty;
            }
        }

        public string Last
        {
            get
            {
                if (Count > 0) return multiple[Count - 1].Key;
                return String.Empty;
            }
        }

        public string Order(string start, int direction)
        {
            if (start == String.Empty)
            {
                if (direction > 0) return First;
                return Last;
            }
            int idx = Position(start);
            if (idx > -1)
            {
                if ((idx < Count - 1) && (direction > 0))
                {
                    return multiple[idx + 1].Key;
                }
                if ((idx > 0) && (direction < 0))
                {
                    return multiple[idx - 1].Key;
                }
            }
            return String.Empty;
        }

        public string Value(string key)
        {
            int idx = Position(key);
            if (idx > -1) return multiple[idx].Value;
            return String.Empty;
        }

        public string ValueAt(int position)
        {
            if (position > -1 && position < Count)
            {
                return multiple[position].Value;
            }
            return String.Empty;
        }

        public void Assign(Mult source)
        {
            multiple.Clear();
            multiple.AddRange(source.multiple);
        }
    }
}