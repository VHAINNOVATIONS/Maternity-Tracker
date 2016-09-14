using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using VA.Gov.Artemis.Vista.Utility;

namespace VA.Gov.Artemis.UI.Data.Models.Text4Baby
{
    //    <request>
    //  <action>enrollParticipantInText4baby</action>
    //  <participanttype></participanttype>
    //  <firstname></firstname>
    //  <emailaddress></emailaddress>
    //  <duedateknown></duedateknown>
    //  <menstrualperioddate></menstrualperioddate>
    //  <pregnancyduedate></pregnancyduedate>
    //  <babydateofbirth></babydateofbirth>
    //  <duedateorbabydateofbirth></duedateorbabydateofbirth>
    //  <mobilenumber></mobilenumber>
    //  <zipcode></zipcode>
    //  <participantcode></participantcode>
    //  <referringurl></referringurl>
    //  <sourceofenrollment></sourceofenrollment>
    //  <password></password>
    //</request>

    public class Text4BabyEnrollment
    {
        public string Action { get; set; }

        [Display(Name="Participant Type")]
        public Text4BabyParticipantType ParticipantType { get; set; }

        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Display(Name = "Email Address")]
        public string EmailAddress { get; set; }

        [Display(Name = "Due Date Is Known")]
        public bool DueDateKnown { get; set; }
                
        public DateTime MenstrualPeriodDate { get; set; }

        [Display(Name = "Last Menstrual Period")]
        public string MenstrualPeriodDateText
        {
            get
            {
                return (this.MenstrualPeriodDate == DateTime.MinValue) ? "" : this.MenstrualPeriodDate.ToString(VistaDates.UserDateFormat);
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.MenstrualPeriodDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }

        public DateTime PregnancyDueDate { get; set; }

        [Display(Name = "Estimated Due Date")]
        public string DueDateText {
            get
            {
                return (this.PregnancyDueDate == DateTime.MinValue) ? "" : this.PregnancyDueDate.ToString(VistaDates.UserDateFormat);
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.PregnancyDueDate = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }
        
        public DateTime BabyDateOfBirth { get; set; }

        [Display(Name = "Baby Date of Birth")]
        public string BabyDobText
        {
            get
            {
                return (this.BabyDateOfBirth == DateTime.MinValue) ? "" : this.BabyDateOfBirth.ToString(VistaDates.UserDateFormat);
            }
            set
            {
                string temp = VistaDates.StandardizeDateFormat(value);

                if (!string.IsNullOrWhiteSpace(temp))
                    this.BabyDateOfBirth = VistaDates.ParseDateString(temp, VistaDates.VistADateOnlyFormat);
            }
        }

        [Display(Name = "Due Date or Baby Date of Birth")]
        public DateTime DueDateOrBabyDateOfBirth { get; set; }

        [Display(Name = "Mobile Number")]
        public string MobileNumber { get; set; }

        [Display(Name = "Zip Code")]
        public string ZipCode { get; set; }

        [Display(Name = "Participant Code")]
        public string ParticipantCode { get; set; }
        
        public string ReferringUrl { get; set; }
        public string Password { get; set; }

        public string[] Text4BabyParticipantTypeDescriptions = { "Unknown", "Pregnant", "New Mom", "Dad or Parent", "Relative / Friend", "Healthcare Provider or Other Observer" };

        public Text4BabyEnrollment()
        {
            this.Action = "enrollParticipantInText4baby"; 
        }

        public string ToRequestXml()
        {
            StringBuilder sb = new StringBuilder();

            XmlWriterSettings settings = new XmlWriterSettings() { Indent = true, OmitXmlDeclaration = true };

            using (XmlWriter writer = XmlTextWriter.Create(sb, settings))
            {
                writer.WriteStartElement("request");

                writer.WriteElementString("action", this.Action);
                writer.WriteElementString("participanttype", ((int)this.ParticipantType).ToString());
                writer.WriteElementString("firstname", this.FirstName);
                writer.WriteElementString("emailaddress", this.EmailAddress);
                writer.WriteElementString("duedateknown", (this.DueDateKnown) ? "1" : "2");
                writer.WriteElementString("menstrualperioddate", (this.MenstrualPeriodDate != DateTime.MinValue) ? this.MenstrualPeriodDate.ToString("MM/dd/yyyy") : "");
                writer.WriteElementString("pregnancyduedate", (this.PregnancyDueDate != DateTime.MinValue) ? this.PregnancyDueDate.ToString("MM/dd/yyyy") : "");
                writer.WriteElementString("babydateofbirth", (this.BabyDateOfBirth != DateTime.MinValue) ? this.BabyDateOfBirth.ToString("MM/dd/yyyy") : "");
                writer.WriteElementString("duedateorbabydateofbirth", (this.DueDateOrBabyDateOfBirth != DateTime.MinValue) ? this.DueDateOrBabyDateOfBirth.ToString("MM/dd/yyyy") : "");
                writer.WriteElementString("mobilenumber", this.MobileNumber);
                writer.WriteElementString("zipcode", this.ZipCode);
                writer.WriteElementString("participantcode", this.ParticipantCode);
                writer.WriteElementString("referringurl", this.ReferringUrl);
                writer.WriteElementString("password", this.Password); 

                writer.WriteEndElement();
            }
            return sb.ToString();
        }
    }

    public enum Text4BabyParticipantType { Unknown, Pregnant, NewMom, DadOrParent, RelativeFriend, ProviderObserver }

 

    
}
