// EXCERPT 3: FIX 2 + FIX 3
// Fix 2: this firm measures max drawdown from the STARTING balance (static),
// not from the equity peak (trailing). The reference must match the rules.
bool MaxDrawdownReached()
{
   double ref = InpStaticDrawdown ? g_startingBalance : g_peakEquity;
   return AccountInfoDouble(ACCOUNT_EQUITY) <= ref * (1.0 - InpMaxDDPct / 100.0);
}

// Fix 3: cap positions in the SAME direction (opposite-direction overlaps stay allowed)
bool CanOpen(ENUM_POSITION_TYPE side)
{
   int same = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
      if(PositionGetTicket(i) > 0 && PositionGetInteger(POSITION_MAGIC) == InpMagic
         && (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE) == side)
         same++;
   return same < InpMaxSameDirection;   // 3 in the tested configuration
}
