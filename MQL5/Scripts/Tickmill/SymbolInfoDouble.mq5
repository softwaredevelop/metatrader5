//+------------------------------------------------------------------+
//|                                             SymbolInfoDouble.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   string symbol = Symbol(); // The current symbol name
   double value;
   string result;

// Iterate through ENUM_SYMBOL_INFO_DOUBLE values
   for(int i = SYMBOL_BID; i <= SYMBOL_TRADE_CALC_MODE; i++) // ENUM_SYMBOL_INFO_DOUBLE range
     {
      if(SymbolInfoDouble(symbol, ENUM_SYMBOL_INFO_DOUBLE(i), value)) // Query
        {
         result = StringFormat("ID: %d, Property: %s, Value: %f", i, EnumToString(ENUM_SYMBOL_INFO_DOUBLE(i)), value);
         Print(result);
        }
      else
        {
         result = StringFormat("ID: %d, Property: %s, Not Available", i, EnumToString(ENUM_SYMBOL_INFO_DOUBLE(i)));
         Print(result);
        }
     }
  }
//+------------------------------------------------------------------+
