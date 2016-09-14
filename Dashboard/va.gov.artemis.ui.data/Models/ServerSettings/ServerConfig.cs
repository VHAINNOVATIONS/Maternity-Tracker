using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Data.Models.ServerSettings
{
    public class ServerConfig
    {
        [Display(Name = "Server Name")]
        [Required]
        public string ServerName { get; set; }

        [Display(Name = "Listener Port")]
        [Required]
        public int ListenerPort { get; set; }

        public bool Valid
        {
            get
            {
                bool returnVal = false;

                if (!string.IsNullOrWhiteSpace (this.ServerName))
                    if (this.ListenerPort > 0)
                        returnVal = true; 

                return returnVal;
            }
        }
    }
}