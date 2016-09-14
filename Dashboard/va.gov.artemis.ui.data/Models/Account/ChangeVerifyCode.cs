using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace VA.Gov.Artemis.UI.Data.Models.Account
{
    public class ChangeVerifyCode
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Original Verify Code")]
        public string OriginalVerifyCode { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "New Verify Code")]
        public string NewVerifyCode { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Confirm Verify Code")]
        public string ConfirmVerifyCode { get; set; }

        public string Message { get; set; }

        // *** Keep this around if still logging in ***        
        public string RequestedUrl { get; set; }
    }
}