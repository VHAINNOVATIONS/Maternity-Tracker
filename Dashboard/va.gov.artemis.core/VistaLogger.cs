// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NLog; 

namespace VA.Gov.Artemis.Core
{
    public static class VistaLogger
    {
        // *** NLog logger object ***
        private static Logger logger = LogManager.GetLogger("dashboard-vista"); 

        /// <summary>
        /// Logs calls to VistA
        /// </summary>
        /// <param name="op">Operation or RPC Name</param>
        /// <param name="elapsed">Time Elapsed in seconds</param>
        /// <param name="returnSize">Size of the Data Returned</param>
        /// <param name="commandArgs">The Command Args Passed In</param>
        public static void Log(string op, string elapsed, int returnSize, object[] commandArgs, string result)
        {
            // *** Format of the operation ***
            string opFormat = "{0}({1})"; 
            
            string args = ""; 

            // *** Check if there are ags to work with ***
            if (commandArgs != null)            
            {
                // *** Keep track of outer loop first ***
                bool outFirst = true;

                // *** Go through each arg ***
                foreach (var arg in commandArgs)
                {
                    // *** Add vertical bar separator if not first item ***
                    if (outFirst)
                        outFirst = false;
                    else
                        args += "|"; 

                    // *** Special handling for string array ***
                    if (arg is string[])
                    {
                        // *** Delimit string array items by caret ***
                        string[] argArray = arg as string[];
                        bool inFirst = true;
                        foreach (var subArg in argArray)
                        {
                            if (inFirst)
                                inFirst = false;
                            else
                                args += "^"; 

                            args += string.Format("{0}", subArg);
                        }
                    }
                    else if (arg != null)
                        args += arg.ToString();
                }
            }

            // *** Get final string for args ***
            string opArgs = string.Format(opFormat, op, args); 

            // *** Create message ***
            string msg = string.Format("{0},{1},{2},{3},{4},{5}", DateTime.Now.ToShortDateString(), DateTime.Now.ToString("HH:mm:ss"), opArgs, result, elapsed, returnSize); 

            // *** Log it ***
            logger.Info(msg); 
        }

    }
}
