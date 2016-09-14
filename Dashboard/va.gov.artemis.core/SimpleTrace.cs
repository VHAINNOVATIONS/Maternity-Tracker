//using System;
//using System.Collections.Generic;
//using System.Diagnostics;
//using System.Linq;
//using System.Reflection;
//using System.Text;
//using System.Threading.Tasks;

//namespace VA.Gov.Artemis.Core
//{
//    /// <summary>
//    /// A simple one-line per entry log for development and tracing purposes
//    /// </summary>
//    public static class SimpleTrace
//    {
//        // *** The trace switch can be configured in a config file ***
//        private static TraceSwitch simpleTraceSwitch = new TraceSwitch("simpleTraceSwitch", "");

//        private const string lineFormat = "{0} {1} {2} {3} {4}: {5}";

//        public static void TraceError(string message)
//        {
//            if (simpleTraceSwitch.Level >= TraceLevel.Error)
//            {
//                string formattedMessage = GetMessage(TraceLevel.Error, message);

//                Trace.WriteLine(formattedMessage);
//            }
//        }

//        public static void TraceError(string message, Exception exception)
//        {
//            if (simpleTraceSwitch.Level >= TraceLevel.Error)
//            {
//                string formattedMessage = GetMessage(TraceLevel.Error, message);

//                Trace.WriteLine(formattedMessage);
//                Trace.WriteLine(exception.ToString());
//            }
//        }

//        public static void TraceWarning(string message)
//        {
//            if (simpleTraceSwitch.Level >= TraceLevel.Warning)
//            {
//                string formattedMessage = GetMessage(TraceLevel.Warning, message);

//                Trace.WriteLine(formattedMessage);
//            }
//        }

//        public static void TraceInformation(string message)
//        {
//            if (simpleTraceSwitch.Level >= TraceLevel.Info)
//            {
//                string formattedMessage = GetMessage(TraceLevel.Info, message);

//                Trace.WriteLine(formattedMessage);
//            }
//        }

//        private static string GetMessage(TraceLevel level, string originalMessage)
//        {
//            string levelDescription = level.ToString();

//            return string.Format(lineFormat, MessageDate, MessageTime, levelDescription, Version, Server, originalMessage);
//        }

//        private static string MessageDate
//        {
//            get
//            {
//                return DateTime.Now.ToShortDateString();
//            }
//        }

//        private static string MessageTime
//        {
//            get
//            {
//                return DateTime.Now.ToString("HH:mm:ss.ff");
//            }
//        }

//        private static string Version
//        {
//            get
//            {
//                return Assembly.GetExecutingAssembly().GetName().Version.ToString();
//            }
//        }

//        private static string Server
//        {
//            get
//            {
//                return Environment.MachineName;
//            }
//        }

//    }
//}
