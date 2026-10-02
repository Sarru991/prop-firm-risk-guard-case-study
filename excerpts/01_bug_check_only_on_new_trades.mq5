// EXCERPT 1: THE BUG (simplified)
// The daily-loss check lived inside the lot-sizing function,
// so it only ran when the EA was about to open a NEW trade.
double CalcLotSize(double riskPct, double stopPoints)
{
   if(IsDailyLossHalted())          // <- only reached when a new trade is attempted
      return 0.0;
   double riskMoney = AccountInfoDouble(ACCOUNT_EQUITY) * riskPct / 100.0;
   return NormalizeLots(riskMoney / (stopPoints * PointValue()));
}
// Between 06:06 and 08:36 no new trade was attempted,
// so open positions kept losing and nothing checked the limit.
