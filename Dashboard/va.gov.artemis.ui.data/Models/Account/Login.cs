//using VA.Gov.Artemis.Commands.Xus;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using VA.Gov.Artemis.Commands.Xus;

namespace VA.Gov.Artemis.UI.Data.Models.Account
{
    public class Login
    {
        // *** From XUS INTRO MSG ***
        public string IntroMessage { get; set; }

        // *** From XUS SIGNON SETUP ***
        public string Server { get; set; }
        public string Volume { get; set; }
        public string UCI { get; set; }
        public string Port { get; set; }
        
        [Required]
        [Display(Name = "Access Code")]
        public string AccessCode { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Verify Code")]
        public string VerifyCode { get; set; }

        [Display(Name = "Change Verify Code")]
        public bool ChangeVerifyCode { get; set; }

        // *** From XUS AV CODE ***
        public string LoginMessage { get; set; }

        public string RequestedUrl { get; set; }

        public void SetSignonSetup(XusSignonSetup signonSetup)
        {
            this.Server = signonSetup.ServerName;
            this.Volume = signonSetup.Volume;
            this.UCI = signonSetup.UCI;
            this.Port = signonSetup.Port; 
        }

        // *** After logging in, this is the displayed user name ***
        public string UserName { get; set; }

    }
}