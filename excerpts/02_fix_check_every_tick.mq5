// EXCERPT 2: FIX 1 - limits are checked on EVERY tick, independent of entries
void OnTick()
{
   if(DailyLossReached() || MaxDrawdownReached())
   {
      CloseAllPositions();           // flatten immediately
      g_tradingLocked = true;        // block new entries until the firm's reset time
      return;
   }
   if(g_tradingLocked) return;
   ManageEntries();                  // strategy logic runs only when risk is OK
}

// Equity-based (open trades count), with a safety buffer below the firm's limit
bool DailyLossReached()
{
   double loss = g_dayStartBalance - AccountInfoDouble(ACCOUNT_EQUITY);
   return loss >= g_dayStartBalance * InpDailyLimitPct / 100.0 * InpBufferFactor; // e.g. 5% * 0.9
}
