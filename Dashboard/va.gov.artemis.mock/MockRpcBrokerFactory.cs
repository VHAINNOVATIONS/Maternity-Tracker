using VA.Gov.Artemis.Commands.Orwu;
using VA.Gov.Artemis.Commands.Dsio;
using VA.Gov.Artemis.Vista.Broker;
using VA.Gov.Artemis.Vista.Commands;
using VA.Gov.Artemis.Vista.Commands.Orwu;
using VA.Gov.Artemis.Commands.Xus;
using VA.Gov.Artemis.Commands.Vpr;
using VA.Gov.Artemis.Commands.Dsio.Notes;
using VA.Gov.Artemis.Commands.Dsio.PatientSearch;

namespace VA.Gov.Artemis.UI.Mock
{
    public static class MockRpcBrokerFactory
    {
        #region "Brokers for Controller Tests"

        public static IRpcBroker GetLoginSuccessBroker() 
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            AddSuccessfulSignonSetupResponse(broker);

            AddSuccessfulIntroMsgResponse(broker); 

            return broker; 
        }

        public static IRpcBroker GetDisconnectedBroker()
        {
            return new MockRpcBroker() { PresetConnected = false };
        }

        public static IRpcBroker GetLoginPostBroker(bool successful)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (successful)
            {
                AddSuccessfulAVCodeResponse(broker);

                AddSuccessfulGetUserInfoResponse(broker);

                AddSuccessfulOrwuUserInfoResponse(broker);
            }
            else
                AddFailedAvCodeResponse(broker); 

            return broker; 
        }

        public static IRpcBroker GetChangeVerifyCodePostBroker(bool successfulCvc, bool successfulUserInfo = true)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (successfulCvc)
            {
                AddSuccessfulChangeVerifyCodeResponse(broker);

                if (successfulUserInfo)
                    AddSuccessfulGetUserInfoResponse(broker);
                else
                    AddFailedGetUserInfoResponse(broker);

                AddSuccessfulOrwuUserInfoResponse(broker);
            }
            else
                AddFailedChangeVerifyCodeResponse(broker);

            return broker; 
        }

        //public static IRpcBroker GetCdaIndexSuccessBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddSuccessfulOrwptSelectResponse(broker); 

        //    // *** Successful exchange history ***
        //    // TODO...

        //    return broker; 
        //}

        //public static IRpcBroker GetCdaIndexFailBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddFailedOrwptSelectResponse(broker); 

        //    // *** Failed exchange history ***
        //    // TODO...

        //    return broker;
        //}

        //public static IRpcBroker GetCdaGenerateSuccessBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddSuccessfulOrwptSelectResponse(broker);

        //    // *** Successful document ***
        //    // TODO...

        //    return broker;
        //}

        //public static IRpcBroker GetCdaGenerateFailBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddFailedOrwptSelectResponse(broker);

        //    // *** Failed document ***
        //    // TODO...

        //    return broker;
        //}

        //public static IRpcBroker GetCdaOptionsSuccessBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddSuccessfulOrwptSelectResponse(broker);

        //    // *** Successful options ***
        //    // TODO...

        //    return broker;
        //}

        //public static IRpcBroker GetCdaOptionsFailBroker()
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    AddFailedOrwptSelectResponse(broker);

        //    // *** Successful options ***
        //    // TODO...

        //    return broker;
        //}
        #endregion 

        #region "Brokers for Command Tests"

        public static IRpcBroker GetOrwuUserInfoBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (success)
                AddSuccessfulOrwuUserInfoResponse(broker);
            else 
                AddFailedOrwuUserInfoResponse(broker); 

            return broker; 
        }

        public static IRpcBroker GetVprGetPatientDataBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            // TODO: Add command response...
            if (success)
                AddSuccessfulVprGetPatientDataResponse(broker);
            else
                AddFailedVprGetPatientDataResponse(broker);

            return broker;
        }

        public static IRpcBroker GetXusSignonSetupBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (success)
                AddSuccessfulSignonSetupResponse(broker);
            else
                AddFailedSignonSetupResponse(broker);

            return broker; 
        }

        public static IRpcBroker GetXusIntroMsgBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (success)
                AddSuccessfulIntroMsgResponse(broker);
            else
                AddFailedIntroMsgResponse(broker);

            return broker;
        }

        public static IRpcBroker GetXusAvCodeBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (success)
                AddSuccessfulAVCodeResponse(broker);
            else
                AddFailedAvCodeResponse(broker);

            return broker;
        }

        public static IRpcBroker GetXusChangeVerifyCodeBroker(bool successfulCvc)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (successfulCvc)
                AddSuccessfulChangeVerifyCodeResponse(broker);
            else
                AddFailedChangeVerifyCodeResponse(broker);

            return broker;
        }

        public static IRpcBroker GetXusDivisionGetBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };
            
            if (success)
                AddSuccessfulDivisionGetResponse(broker);
            else
                AddFailedDivisionGetResponse(broker);

            return broker; 
        }

        public static IRpcBroker GetXusDivisionSetBroker(bool successfulSelect)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (successfulSelect)
            {
                broker.PresetContextResponse = new RpcResponse();
                broker.PresetContextResponse.Status = RpcResponseStatus.Success; 
                AddSuccessfulDivisionSetResponse(broker);
            }
            else
                AddFailedDivisionSetResponse(broker);

            return broker;
        }

        public static IRpcBroker GetXusGetUserInfoBroker(bool success)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            if (success)
                AddSuccessfulGetUserInfoResponse(broker);
            else
                AddFailedGetUserInfoResponse(broker);

            return broker;
        }

        //public static IRpcBroker GetXwbGetBrokerInfoBroker(bool success)
        //{
        //    MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

        //    if (success)
        //        AddSuccessfulXwbGetBrokerInfoResponse(broker);
        //    else
        //        AddFailedXwbGetBrokerInfoResponse(broker);

        //    return broker;
        //}

        public static IRpcBroker GetOrwuHasKeyBroker(bool hasKey)
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            string data = (hasKey) ? "1" : "0";

            OrwuHasKeyCommand command = new OrwuHasKeyCommand(broker); 

            command.AddCommandArguments("DSIO ADMIN"); 

            AddResponse(broker, data, command);


            return broker; 
        }

        public static IRpcBroker GetDsioFemalePatientSearchBroker()
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            string partialMatch = "711^CPRSPATIENT,EIGHT F^0008^02/01/1955^YES^VCM-IN^VCM-IN-18^NO^0\r\n2^CPRSPATIENT,FOURTEEN^0005^07/08/1954^YES^^^NO^0\r\n100039^CPRSPATIENT,TWENTY-ONE T^1719^07/17/1982^YES^^^YES^0\r\n100017^CPRSPATIENT,TWO F^0002^09/03/1952^YES^VCM-IN^VCM-IN-12^YES^0\r\n2^CPRSPATIENT,FOURTEEN^0005^07/08/1954^YES^^^NO^0\r\n";

            //AddResponse(broker, partialMatch, new DsioPatientSearchCommand(broker));
            //AddResponse(broker, partialMatch, new DsioFemalePatientSearchCommand(broker));
            AddResponse(broker, partialMatch, new DsioPatientListCommand(broker)); 


            return broker; 
        }

        public static IRpcBroker GetCreateANoteBroker()
        {
            MockRpcBroker broker = new MockRpcBroker() { PresetConnected = true };

            AddResponse(broker, "4907^1^1", new DsioCreateANoteCommand(broker));

            return broker;
        }

        #endregion 


        //private static void AddSuccessfulXwbGetBrokerInfoResponse(MockRpcBroker broker)
        //{
        //    AddResponse(broker, "36000\r\n", new XwbGetBrokerInfoCommand(broker));
        //}

        //private static void AddFailedXwbGetBrokerInfoResponse(MockRpcBroker broker)
        //{
        //    AddResponse(broker, "", new XwbGetBrokerInfoCommand(broker));
        //}

        //private static void AddSuccessfulOrwptSelectResponse(MockRpcBroker broker)
        //{
        //    // *** Successful patient select ***
        //    AddResponse(broker, "DSSPTFPATIENT,THREE^F^2450203^666668999^^^^^0^^0^0^^5000000211^69^0", new OrwptSelectCommand(broker));
        //}

        //private static void AddFailedOrwptSelectResponse(MockRpcBroker broker)
        //{
        //    // *** Successful patient select ***
        //    AddResponse(broker, "", new OrwptSelectCommand(broker));
        //}

        private static void AddSuccessfulSignonSetupResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "WIN-123456788901\r\nROU\r\nVAH\r\n//./nul:4772\r\n5\r\n0\r\nABC.DE-FGHIJK.LMN.OP.QRS\r\n0\r\n", new XusSignonSetupCommand(broker));
        }

        private static void AddFailedSignonSetupResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "", new XusSignonSetupCommand(broker));
        }

        private static void AddSuccessfulIntroMsgResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "Some login message", new XusIntroMsgCommand(broker), true);
        }

        private static void AddFailedIntroMsgResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "", new XusIntroMsgCommand(broker), true);
        }

        private static void AddSuccessfulAVCodeResponse(MockRpcBroker broker) 
        {
            AddResponse(broker, "10000000034\r\n0\r\n0\r\n\r\n0\r\n0\r\n\r\nGood morning ROISTAFF,CHIEF O\r\n     You last signed on yesterday at 15:07\r\nYou have 170 new messages. (170 in the 'IN' basket)\r\n\r\nEnter '^NML' to read your new messages.\r\n", 
                new XusAvCodeCommand(broker));
        }

        private static void AddFailedAvCodeResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "0\r\n0\r\n0\r\nNot a valid ACCESS CODE/VERIFY CODE pair.\r\n0\r\n0\r\n", new XusAvCodeCommand(broker));
        }

        private static void AddSuccessfulGetUserInfoResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "10000000034\r\nROISTAFF,CHIEF O\r\nChief O Roistaff\r\n500^VAMC KDFJKDF^999\r\nCOMPUTER SPECIALIST\r\nINFORMATION SYSTEMS CENTER\r\n\r\n99999\r\n\r\n", new XusGetUserInfoCommand(broker));
        }

        private static void AddFailedGetUserInfoResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "0\r\nunk\r\nunk\r\nunk\r\nunk\r\nunk\r\nunk\r\n", new XusGetUserInfoCommand(broker));
        }

        private static void AddSuccessfulOrwuUserInfoResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "10000000034^ROISTAFF,CHIEF O^3^0^0^0^0^88888^45^1^1^5^ABC.DE-FGHIJK.LMN.OP.QRS^1043^180^1^^^0^0^^1^0^500^^0", new OrwuUserInfoCommand(broker));
        }

        private static void AddFailedOrwuUserInfoResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "", new OrwuUserInfoCommand(broker));
        }

        private static void AddResponse(MockRpcBroker broker, string responseData, CommandBase command, bool forceSuccess = false)
        {
            RpcResponse response = new RpcResponse()
            {
                Data = responseData
            };

            if (forceSuccess)
                response.Status = RpcResponseStatus.Success;

            string rpcName = command.RpcName;

            broker.PresetBrokerResponses.Add(rpcName, response);
        }

        private static void AddSuccessfulChangeVerifyCodeResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "0", new XusCvcCommand(broker));
        }

        private static void AddFailedChangeVerifyCodeResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "1\r\nTest Error Message\r\n", new XusCvcCommand(broker));
        }

        private static void AddSuccessfulDivisionGetResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "2\r\n678^TUCSON, AZ^678\r\n17034^LKJLKJJJ WARD^500A5\r\n", new XusDivisionGetCommand(broker));
        }

        private static void AddFailedDivisionGetResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "", new XusDivisionGetCommand(broker));
        }

        private static void AddSuccessfulDivisionSetResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "1", new XusDivisionSetCommand(broker, "1"));
        }

        private static void AddFailedDivisionSetResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "0", new XusDivisionSetCommand(broker, "1"));
        }

        private static void AddSuccessfulVprGetPatientDataResponse(MockRpcBroker broker)
        {
            string data = @"<results version='1.0' timeZone='-0500' >\r\n<demographics total='1' >\r\n<patient>\r\n<address streetLine1='145 LINBROOK RD' city='LONGLY' stateProvince='NEW HAMPSHIRE' postalCode='12345' />\r\n<bid value='B8967' />\r\n<dob value='2250204' />\r\n<facilities>\r\n<facility code='500' name='VAMC ALBANY' />\r\n</facilities>\r\n<familyName value='BLSE' />\r\n<fullName value='BLSE,WLSDHYS' />\r\n<gender value='M' />\r\n<givenNames value='WLSDHYS' />\r\n<icn value='5000000046' />\r\n<id value='229' />\r\n<lrdfn value='177' />\r\n<maritalStatus value='D' />\r\n<religion value='4' />\r\n<sc value='1' />\r\n<scPercent value='10' />\r\n<sensitive value='1' />\r\n<ssn value='101028967' />\r\n<telecomList>\r\n<telecom usageType='H' value='(000)020-1326' />\r\n</telecomList>\r\n<veteran value='1' />\r\n</patient>\r\n</demographics>\r\n<reactions total='1' >\r\n<allergy>\r\n<assessment value='not done' />\r\n</allergy>\r\n</reactions>\r\n<problems total='3' >\r\n<problem>\r\n<acuity code='C' name='CHRONIC' />\r\n<entered value='2941207' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<icd value='414.00' />\r\n<id value='9' />\r\n<location value='GENERAL MEDICINE' />\r\n<name value='Coronary Artery Disorder' />\r\n<onset value='2941107' />\r\n<provider code='11278' name='MXYUXH,KHJBN' />\r\n<removed value='0' />\r\n<sc value='1' />\r\n<status code='A' name='ACTIVE' />\r\n<unverified value='0' />\r\n<updated value='2941207' />\r\n</problem>\r\n<problem>\r\n<acuity code='A' name='ACUTE' />\r\n<entered value='2941207' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<icd value='784.0' />\r\n<id value='10' />\r\n<location value='GENERAL MEDICINE' />\r\n<name value='Headache' />\r\n<onset value='2940908' />\r\n<provider code='11278' name='MXYUXH,KHJBN' />\r\n<removed value='0' />\r\n<sc value='0' />\r\n<status code='A' name='ACTIVE' />\r\n<unverified value='0' />\r\n<updated value='2941207' />\r\n</problem>\r\n<problem>\r\n<acuity code='C' name='CHRONIC' />\r\n<entered value='2941207' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<icd value='799.9' />\r\n<id value='11' />\r\n<location value='GENERAL MEDICINE' />\r\n<name value='Blood Pressure, High' />\r\n<onset value='2940809' />\r\n<provider code='11278' name='MXYUXH,KHJBN' />\r\n<removed value='0' />\r\n<status code='A' name='ACTIVE' />\r\n<unverified value='0' />\r\n<updated value='2941207' />\r\n</problem>\r\n</problems>\r\n<vitals total='2' >\r\n<vital>\r\n<entered value='2990226.092239' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<location code='121' name='MIKE&apos;S IP SUBSPECIALTY' />\r\n<measurements>\r\n<measurement id='299' name='PULSE' value='66' high='120' low='60' >\r\n<qualifiers>\r\n<qualifier name='RADIAL' />\r\n</qualifiers>\r\n</measurement>\r\n<measurement id='300' name='RESPIRATION' value='44' high='30' low='8' >\r\n<qualifiers>\r\n<qualifier name='SPONTANEOUS' />\r\n</qualifiers>\r\n</measurement>\r\n<measurement id='298' name='TEMPERATURE' value='98' units='F' metricValue='36.7' metricUnits='C' high='102' low='95' >\r\n<qualifiers>\r\n<qualifier name='ORAL' />\r\n</qualifiers>\r\n</measurement>\r\n</measurements>\r\n<taken value='2990226.0922' />\r\n</vital>\r\n<vital>\r\n<entered value='3001027.0908' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<location code='155' name='3 MIKE' />\r\n<measurements>\r\n<measurement id='687' name='BLOOD PRESSURE' value='110/90' high='210/110' low='100/60' />\r\n</measurements>\r\n<taken value='2950418.084609' />\r\n</vital>\r\n</vitals>\r\n<labs total='31' >\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 123' />\r\n<id value='CH;6999070.889696;2' />\r\n<interpretation value='H*' />\r\n<localName value='GLUCOSE' />\r\n<loinc value='15074-8' />\r\n<low value='60 ' />\r\n<result value='500' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='GLUCOSE' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n<vuid value='4656673' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 24' />\r\n<id value='CH;6999070.889696;3' />\r\n<interpretation value='H' />\r\n<localName value='BUN' />\r\n<low value='11 ' />\r\n<result value='25' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='UREA NITROGEN' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 1.4' />\r\n<id value='CH;6999070.889696;4' />\r\n<interpretation value='H' />\r\n<localName value='CREAT' />\r\n<low value='.9 ' />\r\n<result value='2.1' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CREATININE' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 145' />\r\n<id value='CH;6999070.889696;5' />\r\n<interpretation value='L' />\r\n<localName value='NA' />\r\n<low value='135 ' />\r\n<result value='125' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='SODIUM' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 5.3' />\r\n<id value='CH;6999070.889696;6' />\r\n<interpretation value='L' />\r\n<localName value='K' />\r\n<low value='3.8 ' />\r\n<result value='3.1' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='POTASSIUM' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 108' />\r\n<id value='CH;6999070.889696;7' />\r\n<interpretation value='H' />\r\n<localName value='CL' />\r\n<low value='100 ' />\r\n<result value='110' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CHLORIDE' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 31 (24' />\r\n<id value='CH;6999070.889696;8' />\r\n<localName value='CO2' />\r\n<low value='23 ' />\r\n<result value='29' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CO2' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 288' />\r\n<id value='CH;6999070.889696;12' />\r\n<interpretation value='L' />\r\n<localName value='CHOL' />\r\n<low value='135 ' />\r\n<result value='120' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CHOLESTEROL' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 2.6' />\r\n<id value='CH;6999070.889696;29' />\r\n<interpretation value='H' />\r\n<localName value='MG' />\r\n<low value='2 ' />\r\n<result value='10.1' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='MAGNESIUM' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 165' />\r\n<id value='CH;6999070.889696;47' />\r\n<localName value='TRIGLYC' />\r\n<low value='36 ' />\r\n<result value='50' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='TRIGLYCERIDE' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 72' />\r\n<id value='CH;6999070.889696;80' />\r\n<interpretation value='H' />\r\n<localName value='HDL' />\r\n<low value='32 ' />\r\n<result value='80' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='HDL' />\r\n<type value='CH' />\r\n<units value='MG/DL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<id value='CH;6999070.889696;291' />\r\n<localName value='LDL CHO' />\r\n<result value='12' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='LDL CHOLESTEROL' />\r\n<type value='CH' />\r\n<units value='MG/DL' />\r\n</lab>\r\n<lab>\r\n<collected value='3000928.110304' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 0928 10' />\r\n<high value=' 22' />\r\n<id value='CH;6999070.889696;790' />\r\n<localName value='ANI GAP' />\r\n<low value='10 ' />\r\n<result value='-14' />\r\n<resulted value='3001030.104108' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='ANION GAP' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 123' />\r\n<id value='CH;7028780.9063;2' />\r\n<localName value='GLUCOSE' />\r\n<low value='60 ' />\r\n<result value='122' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='GLUCOSE' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 24' />\r\n<id value='CH;7028780.9063;3' />\r\n<localName value='BUN' />\r\n<low value='11 ' />\r\n<result value='22' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='UREA NITROGEN' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 1.4' />\r\n<id value='CH;7028780.9063;4' />\r\n<localName value='CREAT' />\r\n<low value='.9 ' />\r\n<result value='1.2' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CREATININE' />\r\n<type value='CH' />\r\n<units value='mg/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 145' />\r\n<id value='CH;7028780.9063;5' />\r\n<localName value='NA' />\r\n<low value='135 ' />\r\n<result value='144' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='SODIUM' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 5.3' />\r\n<id value='CH;7028780.9063;6' />\r\n<localName value='K' />\r\n<low value='3.8 ' />\r\n<result value='4.5' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='POTASSIUM' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 108' />\r\n<id value='CH;7028780.9063;7' />\r\n<interpretation value='H' />\r\n<localName value='CL' />\r\n<low value='100 ' />\r\n<result value='120' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CHLORIDE' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 31 (24' />\r\n<id value='CH;7028780.9063;8' />\r\n<localName value='CO2' />\r\n<low value='23 ' />\r\n<result value='23' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='CO2' />\r\n<type value='CH' />\r\n<units value='meq/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2971218.0937' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='CH 1218 27' />\r\n<high value=' 25' />\r\n<id value='CH;7028780.9063;40' />\r\n<localName value='AMY-S' />\r\n<low value='12 ' />\r\n<result value='42' />\r\n<resulted value='2980925.124301' />\r\n<specimen code='0X500' name='SERUM' />\r\n<status value='completed' />\r\n<test value='AMYLASE' />\r\n<type value='CH' />\r\n<units value='IU/L' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 8.3' />\r\n<id value='CH;7029081.89;384' />\r\n<interpretation value='H' />\r\n<localName value='WBC' />\r\n<low value='3.5 ' />\r\n<result value='13.2' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='WBC' />\r\n<type value='CH' />\r\n<units value='k/cmm' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 6.1' />\r\n<id value='CH;7029081.89;385' />\r\n<interpretation value='L' />\r\n<localName value='RBC' />\r\n<low value='4.7 ' />\r\n<result value='3.33' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='RBC' />\r\n<type value='CH' />\r\n<units value='M/cmm' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 18' />\r\n<id value='CH;7029081.89;386' />\r\n<localName value='HGB' />\r\n<low value='14 ' />\r\n<result value='14.4' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='HGB' />\r\n<type value='CH' />\r\n<units value='g/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 52' />\r\n<id value='CH;7029081.89;387' />\r\n<localName value='HCT' />\r\n<low value='42 ' />\r\n<result value='45' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='HCT' />\r\n<type value='CH' />\r\n<units value='% ' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 94' />\r\n<id value='CH;7029081.89;388' />\r\n<interpretation value='H' />\r\n<localName value='MCV' />\r\n<low value='80 ' />\r\n<result value='99.1' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='MCV' />\r\n<type value='CH' />\r\n<units value='cmu' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 35' />\r\n<id value='CH;7029081.89;389' />\r\n<localName value='MCH' />\r\n<low value='27 ' />\r\n<result value='33.2' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='MCH' />\r\n<type value='CH' />\r\n<units value='uug' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 36' />\r\n<id value='CH;7029081.89;390' />\r\n<interpretation value='L' />\r\n<localName value='MCHC' />\r\n<low value='33 ' />\r\n<result value='32.1' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='MCHC' />\r\n<type value='CH' />\r\n<units value='gm/dL' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 14' />\r\n<id value='CH;7029081.89;391' />\r\n<localName value='RDW' />\r\n<low value='11 ' />\r\n<result value='13.1' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='RDW' />\r\n<type value='CH' />\r\n<units value='% ' />\r\n</lab>\r\n<lab>\r\n<collected value='2970917.11' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0917 4' />\r\n<high value=' 420' />\r\n<id value='CH;7029081.89;392' />\r\n<localName value='PLT' />\r\n<low value='140 ' />\r\n<result value='223.0' />\r\n<resulted value='2971017.120159' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='PLATELET COUNT' />\r\n<type value='CH' />\r\n<units value='K/cmm' />\r\n</lab>\r\n<lab>\r\n<collected value='2970520.141507' />\r\n<comment xml:space='preserve'>TESTING THE EPI PATCH MALARIA SMEAR reported incorrectly as POSITIVE FOR MALARIA </comment>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<groupName value='HE 0520 1' />\r\n<id value='CH;7029478.858493;488' />\r\n<localName value='MALARIA' />\r\n<result value='POSITIVE' />\r\n<resulted value='2970521.081628' />\r\n<sample value='BLOOD  ' />\r\n<specimen code='0X000' name='BLOOD' />\r\n<status value='completed' />\r\n<test value='MALARIA SMEAR' />\r\n<type value='CH' />\r\n</lab>\r\n</labs>\r\n<meds total='7' >\r\n<med>\r\n<currentProvider code='11578' name='KURTEHU,KHQHUAN' />\r\n<daysSupply value='30' />\r\n<expires value='3000227' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<fillCost value='192' />\r\n<fillsAllowed value='1' />\r\n<fillsRemaining value='1' />\r\n<form value='SOLN,OPH' />\r\n<id value='401758R;O' />\r\n<lastFilled value='2990513' />\r\n<location code='121' name='MIKE&apos;S IP SUBSPECIALTY' />\r\n<name value='ACETYLCHOLINE CHLORIDE SOLN,OPH' />\r\n<orderID value='9527' />\r\n<ordered value='2990513.13034' />\r\n<orderingProvider code='11578' name='KURTEHU,KHQHUAN' />\r\n<pharmacist code='923' name='RNZLYXPTBD,QLAHYSDYH G' />\r\n<prescription value='300399' />\r\n<products>\r\n<product code='749' name='ACETYLCHOLINE CHL INTRAOCULAR' role='D' >\r\n<class code='OP102' name='MIOTICS,TOPICAL OPHTHALMIC' vuid='4021771' />\r\n<vaGeneric code='2217' name='ACETYLCHOLINE CHLORIDE' vuid='4019546' />\r\n<vaProduct code='8788' name='ACETYLCHOLINE CL 1% SOLN,OPH' vuid='4009245' />\r\n</product>\r\n</products>\r\n<quantity value='20' />\r\n<routing value='W' />\r\n<sig xml:space='preserve'>INSTILL 1 DROP(S) OD THREE TIMES A DAY </sig>\r\n<start value='2990226' />\r\n<status value='historical' />\r\n<stop value='3000227' />\r\n<type value='Prescription' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='O' />\r\n</med>\r\n<med>\r\n<currentProvider code='11531' name='TRMPHYSICIAN,ONE' />\r\n<daysSupply value='30' />\r\n<expires value='3000902' />\r\n<facility code='474' name='TROY' />\r\n<fills>\r\n<fill fillDate='2990922' fillRouting='M' fillQuantity='90' fillDaysSupply='30' />\r\n</fills>\r\n<fillCost value='19.8' />\r\n<fillsAllowed value='5' />\r\n<fillsRemaining value='4' />\r\n<form value='TAB' />\r\n<id value='401945R;O' />\r\n<lastFilled value='2990922' />\r\n<location code='230' name='FUNNY' />\r\n<name value='CAPTOPRIL TAB' />\r\n<orderID value='10552' />\r\n<ordered value='2990921.140925' />\r\n<orderingProvider code='11531' name='TRMPHYSICIAN,ONE' />\r\n<pharmacist code='11817' name='LHTDHRU,TEDUAHN' />\r\n<prescription value='100001936' />\r\n<products>\r\n<product code='2977' name='CAPTOPRIL 25MG TABS' role='D' >\r\n<class code='CV800' name='ACE INHIBITORS' vuid='4021577' />\r\n<vaGeneric code='107' name='CAPTOPRIL' vuid='4017614' />\r\n<vaProduct code='1133' name='CAPTOPRIL 25MG TAB' vuid='4001735' />\r\n</product>\r\n</products>\r\n<quantity value='90' />\r\n<routing value='W' />\r\n<sig xml:space='preserve'>T1 PO TID</sig>\r\n<start value='2990902' />\r\n<status value='historical' />\r\n<stop value='3000902' />\r\n<type value='Prescription' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='O' />\r\n</med>\r\n<med>\r\n<currentProvider code='11531' name='TRMPHYSICIAN,ONE' />\r\n<daysSupply value='7' />\r\n<expires value='3000907' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<fills>\r\n<fill fillDate='2990921' fillRouting='W' fillQuantity='21' fillDaysSupply='7' />\r\n</fills>\r\n<fillCost value='.168' />\r\n<fillsAllowed value='5' />\r\n<fillsRemaining value='4' />\r\n<form value='TAB' />\r\n<id value='401946R;O' />\r\n<lastFilled value='2990921' />\r\n<name value='PSEUDOEPHEDRINE/TRIPROLIDINE TAB' />\r\n<orderID value='10553' />\r\n<ordered value='2990921.142001' />\r\n<orderingProvider code='11531' name='TRMPHYSICIAN,ONE' />\r\n<pharmacist code='11817' name='LHTDHRU,TEDUAHN' />\r\n<prescription value='100001937' />\r\n<products>\r\n<product code='1667' name='TRIPROLIDINE &amp; PSEUDOEPHEDRINE' role='D' >\r\n<class code='RE501' name='ANTIHISTAMINE/DECONGESTANT' vuid='4021781' />\r\n<vaGeneric code='855' name='PSEUDOEPHEDRINE/TRIPROLIDINE' vuid='4022414' />\r\n<vaProduct code='4612' name='PSEUDOEPHEDRINE HCL 60MG/TRIPROLIDINE HCL 2.5MG TAB' vuid='4005159' />\r\n</product>\r\n</products>\r\n<quantity value='21' />\r\n<routing value='W' />\r\n<sig xml:space='preserve'>T 1 Q8H</sig>\r\n<start value='2990907' />\r\n<status value='historical' />\r\n<stop value='3000907' />\r\n<type value='Prescription' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='O' />\r\n</med>\r\n<med>\r\n<doses>\r\n<dose dose='325mg' route='PO' schedule='Q4H PRN' />\r\n</doses>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<form value='TAB' />\r\n<id value='1U;I' />\r\n<location code='155' name='3 MIKE' />\r\n<name value='ACETAMINOPHEN TAB ' />\r\n<orderID value='17260' />\r\n<orderingProvider code='11830' name='PLTSHUYXJB,CXN L MD' />\r\n<products>\r\n<product code='5591' name='ACETAMINOPHEN 325MG TABLET' role='D' >\r\n<class code='CN103' name='NON-OPIOID ANALGESICS' vuid='4021582' />\r\n<vaGeneric code='1338' name='ACETAMINOPHEN' vuid='4017513' />\r\n<vaProduct code='6642' name='ACETAMINOPHEN 325MG TAB' vuid='4007158' />\r\n</product>\r\n</products>\r\n<sig xml:space='preserve'>Give: 325mg PO Q4H PRN</sig>\r\n<start value='3010403.1651' />\r\n<status value='historical' />\r\n<stop value='3010404.24' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='I' />\r\n</med>\r\n<med>\r\n<doses>\r\n<dose dose='100mg' route='PO' schedule='BID' />\r\n</doses>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<form value='TAB' />\r\n<id value='2U;I' />\r\n<location code='155' name='3 MIKE' />\r\n<name value='LEVODOPA TAB ' />\r\n<orderID value='17261' />\r\n<orderingProvider code='11830' name='PLTSHUYXJB,CXN L MD' />\r\n<products>\r\n<product code='4579' name='LEVODOPA 100MG TAB' role='D' >\r\n<class code='CN500' name='ANTIPARKINSON AGENTS' vuid='4021593' />\r\n<vaGeneric />\r\n<vaProduct />\r\n</product>\r\n</products>\r\n<sig xml:space='preserve'>Give: 100mg PO BID</sig>\r\n<start value='3010403.1651' />\r\n<status value='historical' />\r\n<stop value='3010404.24' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='I' />\r\n</med>\r\n<med>\r\n<doses>\r\n<dose dose='.1mg' route='PO' schedule='QD' />\r\n</doses>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<form value='TAB' />\r\n<id value='3U;I' />\r\n<location code='155' name='3 MIKE' />\r\n<name value='LEVOTHYROXINE TAB ' />\r\n<orderID value='17259' />\r\n<orderingProvider code='11830' name='PLTSHUYXJB,CXN L MD' />\r\n<products>\r\n<product code='986' name='LEVOTHYROXINE 0.1MG TAB' role='D' >\r\n<class code='HS851' name='THYROID SUPPLEMENTS' vuid='4021638' />\r\n<vaGeneric code='192' name='LEVOTHYROXINE' vuid='4022126' />\r\n<vaProduct code='1736' name='LEVOTHYROXINE NA 0.1MG TAB' vuid='4002321' />\r\n</product>\r\n</products>\r\n<sig xml:space='preserve'>Give: .1mg PO QD</sig>\r\n<start value='3010403.1651' />\r\n<status value='historical' />\r\n<stop value='3010417.1651' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='I' />\r\n</med>\r\n<med>\r\n<doses>\r\n<dose route='IV' />\r\n</doses>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='1V;I' />\r\n<location code='121' name='MIKE&apos;S IP SUBSPECIALTY' />\r\n<name value='FUROSEMIDE INJ,SOLN' />\r\n<orderID value='13800' />\r\n<orderingProvider code='11597' name='KUHRM,TEHUD K' />\r\n<products>\r\n<product code='17' name='FUROSEMIDE' role='A' concentration='10 MG' >\r\n<class code='CV702' name='LOOP DIURETICS' vuid='4021574' />\r\n<vaGeneric code='197' name='FUROSEMIDE' vuid='4017830' />\r\n<vaProduct code='1786' name='FUROSEMIDE 10MG/ML INJ' vuid='4002371' />\r\n</product>\r\n<product code='1' name='5% DEXTROSE' role='B' concentration='1000 ML' >\r\n<class code='TN101' name='IV SOLUTIONS WITHOUT ELECTROLYTES' vuid='4021702' />\r\n<vaGeneric code='535' name='DEXTROSE' vuid='4017760' />\r\n<vaProduct code='3643' name='DEXTROSE 5% INJ' vuid='4004204' />\r\n</product>\r\n</products>\r\n<rate value='100 ml/hr' />\r\n<start value='3000714.15' />\r\n<status value='historical' />\r\n<stop value='3000717.2359' />\r\n<vaStatus value='EXPIRED' />\r\n<vaType value='V' />\r\n</med>\r\n</meds>\r\n<immunizations total='1' >\r\n<immunization>\r\n<administered value='3001016.1416' />\r\n<contraindicated value='0' />\r\n<cpt code='90690' name='TYPHOID VACCINE ORAL' />\r\n<encounter value='2496' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='61' />\r\n<location value='3 MIKE' />\r\n<name value='INFLUENZA' />\r\n<provider code='10958' name='BHATJEPDYIHU,ZDJELHA' />\r\n<reaction value='NONE' />\r\n<series value='BOOSTER' />\r\n</immunization>\r\n</immunizations>\r\n<visits total='6' >\r\n<visit>\r\n<dateTime value='3001027.0906' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='2535' />\r\n<location value='3 MIKE' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='10958' name='BHATJEPDYIHU,ZDJELHA' role='P' primary='1' />\r\n</providers>\r\n<reason code='V81.1' name='SCREENING FOR HYPERTENSION' narrative='SCREENING FOR HYPERTENSION' />\r\n<serviceCategory code='I' name='IN HOSPITAL' />\r\n<type name='IN HOSPITAL' />\r\n<visitString value='155;3001027.0906;I' />\r\n</visit>\r\n<visit>\r\n<dateTime value='3001016.1416' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='2496' />\r\n<location value='3 MIKE' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='10958' name='BHATJEPDYIHU,ZDJELHA' role='P' primary='1' />\r\n</providers>\r\n<serviceCategory code='I' name='IN HOSPITAL' />\r\n<type name='IN HOSPITAL' />\r\n<visitString value='155;3001016.1416;I' />\r\n</visit>\r\n<visit>\r\n<arrivalDateTime value='2950418.084609' />\r\n<dateTime value='2950418.084609' />\r\n<facility code='474' name='TROY' />\r\n<id value='1466' />\r\n<location value='7B' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='11265' name='PUXQDIHU,SHTS' role='P' primary='1' />\r\n<provider code='11265' name='PUXQDIHU,SHTS' role='A' />\r\n</providers>\r\n<reason code='398.99' name='OTHER RHEUMATIC HEART DISEASES' narrative='LSKFDJKJF' />\r\n<service value='MEDICINE' />\r\n<serviceCategory code='H' name='HOSPITALIZATION' />\r\n<specialty value='GENERAL MEDICINE' />\r\n<type name='HOSPITALIZATION' />\r\n<visitString value='81;2950418.084609;H' />\r\n</visit>\r\n<visit>\r\n<arrivalDateTime value='2950418.084609' />\r\n<dateTime value='2950418.084609' />\r\n<documents>\r\n<document id='1746' localTitle='Discharge Summary' />\r\n<document id='1987' localTitle='MIRACLES HAPPEN' />\r\n<document id='2026' localTitle='REMINDER RESOLUTIONS' />\r\n<document id='2684' localTitle='MISC JMS TITLE' />\r\n</documents>\r\n<facility code='474' name='TROY' />\r\n<id value='2353' />\r\n<location value='7B' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='11265' name='PUXQDIHU,SHTS' role='P' primary='1' />\r\n<provider code='11265' name='PUXQDIHU,SHTS' role='A' />\r\n</providers>\r\n<reason code='398.99' name='OTHER RHEUMATIC HEART DISEASES' narrative='LSKFDJKJF' />\r\n<service value='MEDICINE' />\r\n<serviceCategory code='H' name='HOSPITALIZATION' />\r\n<specialty value='GENERAL MEDICINE' />\r\n<type name='HOSPITALIZATION' />\r\n<visitString value='81;2950418.084609;H' />\r\n</visit>\r\n<visit>\r\n<arrivalDateTime value='2940929.08' />\r\n<dateTime value='2940929.08' />\r\n<departureDateTime value='2941202.143951' />\r\n<documents>\r\n<document id='353' localTitle='Discharge Summary' />\r\n</documents>\r\n<facility code='474' name='TROY' />\r\n<id value='1029' />\r\n<location value='ICU/CCU' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='1926' name='BLDAALUFHXY,SHUHTL' role='P' primary='1' />\r\n</providers>\r\n<reason narrative='SECOND ADMISSION' />\r\n<roomBed value='1-1' />\r\n<service value='PSYCHIATRY' />\r\n<serviceCategory code='H' name='HOSPITALIZATION' />\r\n<specialty value='ACUTE PSYCHIATRY(&lt;45 DAYS)' />\r\n<type name='HOSPITALIZATION' />\r\n<visitString value='8;2940929.08;H' />\r\n</visit>\r\n<visit>\r\n<arrivalDateTime value='2940928.110803' />\r\n<dateTime value='2940928.110803' />\r\n<departureDateTime value='2940928.112001' />\r\n<documents>\r\n<document id='336' localTitle='Discharge Summary' />\r\n</documents>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='1013' />\r\n<location value='7A GEN MED' />\r\n<patientClass value='IMP' />\r\n<providers>\r\n<provider code='11531' name='TRMPHYSICIAN,ONE' role='P' primary='1' />\r\n</providers>\r\n<reason narrative='TEST PT' />\r\n<service value='MEDICINE' />\r\n<serviceCategory code='H' name='HOSPITALIZATION' />\r\n<specialty value='GENERAL MEDICINE' />\r\n<type name='HOSPITALIZATION' />\r\n<visitString value='158;2940928.110803;H' />\r\n</visit>\r\n</visits>\r\n<appointments total='0' >\r\n</appointments>\r\n<documents total='7' >\r\n<document>\r\n<clinicians>\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='A' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='S' dateTime='3010419.151157' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n</clinicians>\r\n<documentClass value='JEANIE&apos;S TITLES' />\r\n<encounter value='2353' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='2684' />\r\n<localTitle value='MISC JMS TITLE' />\r\n<referenceDateTime value='3010419.1109' />\r\n<status value='completed' />\r\n<type value='PN' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='A' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='S' dateTime='3001027.090905' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n</clinicians>\r\n<documentClass value='BELSCHY&apos;S TITLES' />\r\n<encounter value='2353' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='2026' />\r\n<localTitle value='REMINDER RESOLUTIONS' />\r\n<referenceDateTime value='3001027.0906' />\r\n<status value='completed' />\r\n<type value='PN' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='A' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='S' dateTime='3010103.084752' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n</clinicians>\r\n<documentClass value='SADNEWS TITLES' />\r\n<encounter value='2353' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='1987' />\r\n<localTitle value='MIRACLES HAPPEN' />\r\n<referenceDateTime value='3001016.1355' />\r\n<status value='completed' />\r\n<type value='PN' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='11278' name='MXYUXH,KHJBN' role='A' />\r\n<clinician code='11278' name='MXYUXH,KHJBN' role='S' dateTime='2950807.1506' signature='KECKY ZONROE MD,DDS,DDA,' />\r\n</clinicians>\r\n<documentClass value='HISTORICAL TITLES' />\r\n<encounter value='595' />\r\n<facility code='474' name='TROY' />\r\n<id value='157' />\r\n<localTitle value='General Note' />\r\n<referenceDateTime value='2950807.1506' />\r\n<status value='completed' />\r\n<type value='PN' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='A' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='S' dateTime='3000822.103505' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n</clinicians>\r\n<documentClass value='DISCHARGE SUMMARIES' />\r\n<encounter value='2353' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='1746' />\r\n<localTitle value='Discharge Summary' />\r\n<referenceDateTime value='3000822.1015' />\r\n<status value='completed' />\r\n<type value='DS' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='813' name='BLKJXJB,ADTL' role='A' />\r\n</clinicians>\r\n<documentClass value='DISCHARGE SUMMARIES' />\r\n<encounter value='1029' />\r\n<facility code='474' name='TROY' />\r\n<id value='353' />\r\n<localTitle value='Discharge Summary' />\r\n<referenceDateTime value='2941202.143951' />\r\n<status value='purged' />\r\n<type value='DS' />\r\n</document>\r\n<document>\r\n<clinicians>\r\n<clinician code='755' name='OJXYYHAA,SXZ' role='A' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='S' dateTime='2940928' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n<clinician code='10958' name='BHATJEPDYIHU,ZDJELHA' role='C' dateTime='2940928' signature='ZICHAEL KELSCHWINDER Michael J. Belschwinder' />\r\n</clinicians>\r\n<documentClass value='DISCHARGE SUMMARIES' />\r\n<encounter value='1013' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='336' />\r\n<localTitle value='Discharge Summary' />\r\n<referenceDateTime value='2940928.112001' />\r\n<status value='completed' />\r\n<type value='DS' />\r\n</document>\r\n</documents>\r\n<procedures total='6' >\r\n<procedure>\r\n<case value='49' />\r\n<category value='RA' />\r\n<dateTime value='2940831.1558' />\r\n<documents>\r\n<document id='7059168.8441-1' localTitle='HIP 2 OR MORE VIEWS' status='Verified' />\r\n</documents>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059168.8441-1' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='40' name='RADIOLOGY MAIN FLOOR' />\r\n<name value='HIP 2 OR MORE VIEWS' />\r\n<provider code='755' name='OJXYYHAA,SXZ' />\r\n<status value='COMPLETE' />\r\n<type code='73510' name='RADIOLOGIC EXAMINATION, HIP, UNILATERAL; COMPLETE, MINIMUM OF 2 VIEWS' />\r\n</procedure>\r\n<procedure>\r\n<case value='50' />\r\n<category value='RA' />\r\n<dateTime value='2940831.1558' />\r\n<documents>\r\n<document id='7059168.8441-2' localTitle='ECHOGRAM ABDOMEN LTD' status='Verified' />\r\n</documents>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059168.8441-2' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='40' name='RADIOLOGY MAIN FLOOR' />\r\n<name value='ECHOGRAM ABDOMEN LTD' />\r\n<provider code='755' name='OJXYYHAA,SXZ' />\r\n<status value='COMPLETE' />\r\n<type code='76705' name='ULTRASOUND, ABDOMINAL, B-SCAN AND/OR REAL TIME WITH IMAGE DOCUMENTATION; LIMITED (EG, SINGLE ORGAN, QUADRANT, FOLLOW-UP)' />\r\n</procedure>\r\n<procedure>\r\n<case value='47' />\r\n<category value='RA' />\r\n<dateTime value='2940831.1552' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059168.8447-1' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='40' name='RADIOLOGY MAIN FLOOR' />\r\n<name value='ABDOMEN 2 VIEWS [01]' />\r\n<status value='COMPLETE' />\r\n<type code='74010' name='RADIOLOGIC EXAMINATION, ABDOMEN; ANTEROPOSTERIOR AND ADDITIONAL OBLIQUE AND CONE VIEWS' />\r\n</procedure>\r\n<procedure>\r\n<case value='91' />\r\n<category value='RA' />\r\n<dateTime value='2940617.161' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059382.8389-1' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='40' name='RADIOLOGY MAIN FLOOR' />\r\n<name value='KNEE 2 VIEWS' />\r\n<status value='COMPLETE' />\r\n<type code='73560' name='RADIOLOGIC EXAMINATION, KNEE; 1 OR 2 VIEWS' />\r\n</procedure>\r\n<procedure>\r\n<case value='71' />\r\n<category value='RA' />\r\n<dateTime value='2940503.1059' />\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059496.894-1' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='40' name='RADIOLOGY MAIN FLOOR' />\r\n<name value='ARTHROGRAM ANKLE S&amp;I' />\r\n<status value='COMPLETE' />\r\n<type code='73615' name='RADIOLOGIC EXAMINATION, ANKLE, ARTHROGRAPHY, RADIOLOGICAL SUPERVISION AND INTERPRETATION' />\r\n</procedure>\r\n<procedure>\r\n<case value='8' />\r\n<category value='RA' />\r\n<dateTime value='2940503.103' />\r\n<documents>\r\n<document id='7059496.8969-1' localTitle='ANKLE 2 VIEWS' status='Verified' />\r\n</documents>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<hasImages value='0' />\r\n<id value='7059496.8969-1' />\r\n<imagingType code='RAD' name='GENERAL RADIOLOGY' />\r\n<location code='59' name='MAIN FLOOR' />\r\n<name value='ANKLE 2 VIEWS' />\r\n<provider code='755' name='OJXYYHAA,SXZ' />\r\n<status value='COMPLETE' />\r\n<type code='73600' name='RADIOLOGIC EXAMINATION, ANKLE; 2 VIEWS' />\r\n</procedure>\r\n</procedures>\r\n<consults total='1' >\r\n<consult>\r\n<facility code='500' name='VAMC ALBANY' />\r\n<id value='113' />\r\n<name value='CARDIOLOGY Cons' />\r\n<orderID value='6669.1' />\r\n<procedure value='Consult' />\r\n<requested value='2970515' />\r\n<service value='CARDIOLOGY' />\r\n<status value='PENDING' />\r\n<type value='C' />\r\n</consult>\r\n</consults>\r\n<flags total='0' >\r\n</flags>\r\n<healthFactors total='0' >\r\n</healthFactors>\r\n</results>\r\n";

            AddResponse(broker, data, new VprGetPatientDataCommand(broker));
        }

        private static void AddFailedVprGetPatientDataResponse(MockRpcBroker broker)
        {
            AddResponse(broker, "", new VprGetPatientDataCommand(broker));
        }

    }
}
