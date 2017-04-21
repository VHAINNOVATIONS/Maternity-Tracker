// Originally submitted to OSEHRA 2/21/2017 by DSS, Inc. 
// Authored by DSS, Inc. 2014-2017

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.CDA.Common;

namespace VA.Gov.Artemis.CDA.ValueSets
{
    public class AntepartumEducationValueSet: ValueSet
    {
        public AntepartumEducationValueSet()
        {
            this.ValueSetName = "Antepartum Education Value Set";
            this.Id = "1.3.6.1.4.1.19376.1.5.3.1.1.16.5.8";

            InitializeCodes(); 
        }

        private void InitializeCodes()
        {

            // *** First Trimester ***
            this.Items.Add(new ValueSetItem("440047008", CodingSystem.SnomedCT, "Risk factors identified by prenatal history", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("17629007", CodingSystem.SnomedCT, "Anticipated course of prenatal care", "General"));
            this.Items.Add(new ValueSetItem("171054004", CodingSystem.SnomedCT, "Special Diet", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("171054004", CodingSystem.SnomedCT, "Nutrition and weight gain counseling", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("439733009", CodingSystem.SnomedCT, "Toxoplasmosis precautions (cats/raw meat)", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("162169002", CodingSystem.SnomedCT, "Sexual Activity", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("171056002", CodingSystem.SnomedCT, "Exercise", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("171044003", CodingSystem.SnomedCT, "Vaccine Education", "Testing & Immunizations"));
            this.Items.Add(new ValueSetItem("171055003", CodingSystem.SnomedCT, "Smoking/Tobacco Counseling", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("385872009", CodingSystem.SnomedCT, "Environmental/Work Hazards", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("439816006", CodingSystem.SnomedCT, "Travel", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("171057006", CodingSystem.SnomedCT, "Alcohol", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("425014005", CodingSystem.SnomedCT, "Illicit/Recreational Drugs", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("171058001", CodingSystem.SnomedCT, "Use of Any Medications", "Medications"));
            this.Items.Add(new ValueSetItem("440227005", CodingSystem.SnomedCT, "Indications for Ultrasound", "Testing & Immunizations"));
            this.Items.Add(new ValueSetItem("413457006", CodingSystem.SnomedCT, "Domestic Violence", "Health & Wellness"));
            this.Items.Add(new ValueSetItem("440638004", CodingSystem.SnomedCT, "Seatbelt Use", "Health & Wellness"));
            //this.Items.Add(new ValueSetItem("66961001", CodingSystem.SnomedCT, "Childbirth Classes/Hospital Facilities", "First Trimester"));

            // *** Second Trimester ***
            this.Items.Add(new ValueSetItem("66961001", CodingSystem.SnomedCT, "Childbirth Classes/Hospital Facilities", "Delivery Planning"));
            this.Items.Add(new ValueSetItem("440669000", CodingSystem.SnomedCT, "Signs and symptoms of preterm labor", "2nd & 3rd Trimester Pregnancy Planning"));
            this.Items.Add(new ValueSetItem("410299006", CodingSystem.SnomedCT, "Abnormal Lab Values", "Testing & Immunizations"));
            this.Items.Add(new ValueSetItem("xx-edu-fluvaccine", CodingSystem.None, "Influenza Vaccine", "Testing & Immunizations"));
            this.Items.Add(new ValueSetItem("439908001", CodingSystem.SnomedCT, "Selecting a newborn care provider", "Newborn Considerations"));
            this.Items.Add(new ValueSetItem("54070000", CodingSystem.SnomedCT, "Postpartum family planning", "Contraception"));
            this.Items.Add(new ValueSetItem("243064009", CodingSystem.SnomedCT, "Tubal Sterilization", "Contraception"));

            // *** Third Trimester ***
            this.Items.Add(new ValueSetItem("243062008", CodingSystem.SnomedCT, "Anesthesia/Analgesia Plans", "Delivery Planning"));
            this.Items.Add(new ValueSetItem("310585007", CodingSystem.SnomedCT, "Intended Facility for Delivery Plan", "Delivery Planning"));
            this.Items.Add(new ValueSetItem("440309009", CodingSystem.SnomedCT, "Fetal Movement Monitoring", "2nd & 3rd Trimester Pregnancy Planning"));
            this.Items.Add(new ValueSetItem("440671000", CodingSystem.SnomedCT, "Labor Signs", "2nd & 3rd Trimester Pregnancy Planning"));
            this.Items.Add(new ValueSetItem("440073003", CodingSystem.SnomedCT, "VBAC Counseling", "Delivery Planning"));
            this.Items.Add(new ValueSetItem("xx-edu-sspreclampsia", CodingSystem.SnomedCT, "Signs & Symptoms of Pregnancy-Induced Hypertension", "2nd & 3rd Trimester Pregnancy Planning"));
            this.Items.Add(new ValueSetItem("xx-edu-postterm", CodingSystem.SnomedCT, "Postterm Counseling", "2nd & 3rd Trimester Pregnancy Planning"));
            this.Items.Add(new ValueSetItem("184002001", CodingSystem.SnomedCT, "Circumcision", "Newborn Considerations"));
            this.Items.Add(new ValueSetItem("169644004", CodingSystem.SnomedCT, "Bottle Feeding", "Newborn Considerations"));
            this.Items.Add(new ValueSetItem("16943005", CodingSystem.SnomedCT, "Breast Feeding", "Newborn Considerations"));
            this.Items.Add(new ValueSetItem("439366005", CodingSystem.SnomedCT, "Postpartum Depression", "Postpartum Planning"));
            this.Items.Add(new ValueSetItem("75461000", CodingSystem.SnomedCT, "Newborn Education (Newborn Screening, Jaundice, SIDS, Car Seat", "Postpartum Planning"));
            this.Items.Add(new ValueSetItem("40791000", CodingSystem.SnomedCT, "Family Medical leave or Disability Forms", "Postpartum Planning"));
            this.Items.Add(new ValueSetItem("408835000", CodingSystem.SnomedCT, "Tubal Sterilization Consent Signed", "Contraception"));

            // *** Items added for Dr. Rose ***
            this.Items.Add(new ValueSetItem("Test36Wks", CodingSystem.Other, "Testing and exams 36 weeks and beyond", "Testing & Immunizations"));
            this.Items.Add(new ValueSetItem("TelNumbers", CodingSystem.Other, "Important Telephone Numbers", "General"));


        }
    }
}
