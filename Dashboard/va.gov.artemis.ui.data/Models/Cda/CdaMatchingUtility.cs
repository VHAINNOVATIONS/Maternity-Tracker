using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VA.Gov.Artemis.UI.Data.Models.Common;

namespace VA.Gov.Artemis.UI.Data.Models.Cda
{
    public static class CdaMatchingUtility
    {
        public static MatchType GetMatchType(BasePatient pat1, BasePatient pat2)
        {
            MatchType returnVal = MatchType.None;

            if (LastNameMatch(pat1, pat2) == MatchResult.Match)
            {
                returnVal = MatchType.Partial;
                if (FirstNameMatch(pat1, pat2) == MatchResult.Match)
                    if (SSNMatch(pat1, pat2) == MatchResult.Match)
                        if (DOBMatch(pat1, pat2) == MatchResult.Match)
                            returnVal = MatchType.Exact;
            }

            return returnVal;
        }

        private static MatchResult LastNameMatch(BasePatient pat1, BasePatient pat2)
        {
            MatchResult returnResult = MatchResult.Unknown;

            if (pat1 != null)
                if (pat2 != null)
                    if (!string.IsNullOrWhiteSpace(pat1.LastName))
                        if (!string.IsNullOrWhiteSpace(pat2.LastName))
                            if (pat1.LastName.ToUpper().Trim() == pat2.LastName.ToUpper().Trim())
                                returnResult = MatchResult.Match;
                            else
                                returnResult = MatchResult.NotMatch;

            return returnResult;
        }

        private static MatchResult FirstNameMatch(BasePatient pat1, BasePatient pat2)
        {
            MatchResult returnResult = MatchResult.Unknown;

            if (pat1 != null)
                if (pat2 != null)
                    if (!string.IsNullOrWhiteSpace(pat1.FirstName))
                        if (!string.IsNullOrWhiteSpace(pat2.FirstName))
                            if (pat1.FirstName.ToUpper().Trim() == pat2.FirstName.ToUpper().Trim())
                                returnResult = MatchResult.Match;
                            else
                                returnResult = MatchResult.NotMatch;

            return returnResult;
        }

        private static MatchResult SSNMatch(BasePatient pat1, BasePatient pat2)
        {
            MatchResult returnResult = MatchResult.Unknown;

            if (pat1 != null)
                if (pat2 != null)
                    if (!string.IsNullOrWhiteSpace(pat1.FullSSN))
                        if (!string.IsNullOrWhiteSpace(pat2.FullSSN))
                            if (pat1.FullSSN.ToUpper().Trim() == pat2.FullSSN.ToUpper().Trim())
                                returnResult = MatchResult.Match;
                            else
                                returnResult = MatchResult.NotMatch;

            return returnResult;
        }

        private static MatchResult DOBMatch(BasePatient pat1, BasePatient pat2)
        {
            MatchResult returnResult = MatchResult.Unknown;

            if (pat1 != null)
                if (pat2 != null)
                    if (pat1.DateOfBirth != DateTime.MinValue)
                        if (pat2.DateOfBirth != DateTime.MinValue)
                            if (pat1.DateOfBirth.Date == pat2.DateOfBirth.Date)
                                returnResult = MatchResult.Match;
                            else
                                returnResult = MatchResult.NotMatch;

            return returnResult;
        }

    }
}
