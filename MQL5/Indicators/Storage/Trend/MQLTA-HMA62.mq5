//+------------------------------------------------------------------+
//|                                          MQLTA MT5 Moving Average|
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots 1
#property indicator_color1 clrDarkGray
#property indicator_type1   DRAW_LINE
#property indicator_width1  1
#property indicator_label1  "Moving Average"

#include <MQLTA ErrorHandling.mqh>
#include <MQLTA Utils.mqh>

enum ENUM_CANDLE_TO_CHECK
  {
   CURRENT_CANDLE = 0, // CURRENT CANDLE
   CLOSED_CANDLE = 1   // PREVIOUS CANDLE
  };

enum ENUM_MA_METHOD_EXTENDED
  {
   EXT_MODE_SMA,  // Simple
   EXT_MODE_EMA,  // Exponential
   EXT_MODE_SMMA, // Smoothed
   EXT_MODE_LWMA, // Linear-weighted
   EXT_MODE_HULL  // Hull
  };

input string IndicatorName = "MA";          // Indicator Short Name
input int MAPeriod = 62;                            // Moving Average Period
input int MAShift = 0;                              // Moving Average Shift
input ENUM_MA_METHOD_EXTENDED MAMethod = EXT_MODE_HULL; // Moving Average Method
input ENUM_APPLIED_PRICE MAAppliedPrice = PRICE_CLOSE; // Moving Average Applied Price
input ENUM_CANDLE_TO_CHECK CandleToCheck = CURRENT_CANDLE; // Candle To Use For Analysis
input int BarsToScan = 500;                         // Number Of Candles To Analyse

double BufferMA[];
int BufferMAHandle; // Normal MA for all timeframes. In case of Hull MA, will store the p / 2 WMA handle.
int BufferMAHandle2; // Only for Hull MA - second WMA handle.
datetime LastNotificationTime;
int Shift = 0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   IndicatorSetString(INDICATOR_SHORTNAME, IndicatorName);

   OnInitInitialization();
   if(!OnInitPreChecksPass())
     {
      return INIT_FAILED;
     }

   InitialiseHandles();
   InitialiseBuffers();

   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   bool IsNewCandle = CheckIfNewCandle();

   int counted_bars = 0;
   if(prev_calculated == 0)
     {
      for(int i = 0; i < rates_total; i++)
        {
         BufferMA[i] = 0;
        }
     }
   if(prev_calculated > 0)
      counted_bars = prev_calculated - 1;

   if(counted_bars < 0)
      return -1;
   if(counted_bars > 0)
      counted_bars--;
   int limit = rates_total - counted_bars;

   if(limit > BarsToScan)
     {
      limit = BarsToScan;
      if(rates_total < BarsToScan + MAPeriod + MAShift)
         limit = BarsToScan - 2 - MAPeriod - MAShift;
      if(limit <= 0)
        {
         Print("Need more historical data.");
         return 0;
        }
     }
   if(limit > rates_total - 2 - MAPeriod - MAShift)
      limit = rates_total - 2 - MAPeriod - MAShift;

   if(MAMethod == EXT_MODE_HULL)
     {
      // Do Hull MA calculations.
      if(iHull(-MAShift, limit, BufferMA) <= 0)
        {
         Print("Waiting for data...");
         return 0;
        }
     }
   else
     {
      if(CopyBuffer(BufferMAHandle, 0, -MAShift, limit, BufferMA) <= 0)
        {
         Print("Waiting for data...");
         return 0;
        }
     }

   return rates_total;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   CleanChart();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInitInitialization()
  {
   LastNotificationTime = TimeCurrent();
   Shift = CandleToCheck;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OnInitPreChecksPass()
  {
   if(MAPeriod <= 0)
     {
      Print("MA Period should be a positive number.");
      return false;
     }
   if(Bars(Symbol(), PERIOD_CURRENT) < MAPeriod + MAShift)
     {
      Print("Not enough historical candles.");
      return false;
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CleanChart()
  {
   ObjectsDeleteAll(ChartID(), IndicatorName);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InitialiseHandles()
  {
   if(MAMethod != EXT_MODE_HULL)  // Normal MAs.
     {
      BufferMAHandle = iMA(Symbol(), PERIOD_CURRENT, MAPeriod, MAShift, (ENUM_MA_METHOD)MAMethod, MAAppliedPrice);
     }
   else // Hull MA.
     {
      BufferMAHandle =  iMA(Symbol(), PERIOD_CURRENT, MAPeriod / 2, MAShift, MODE_LWMA, MAAppliedPrice);
      BufferMAHandle2 = iMA(Symbol(), PERIOD_CURRENT, MAPeriod, MAShift, MODE_LWMA, MAAppliedPrice);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InitialiseBuffers()
  {
   SetIndexBuffer(0, BufferMA, INDICATOR_DATA);
   ArraySetAsSeries(BufferMA, true);
   ArrayInitialize(BufferMA, 0);
   IndicatorSetInteger(INDICATOR_DIGITS, _Digits);
   PlotIndexSetInteger(0, PLOT_SHIFT, MAShift);
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, 0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime NewCandleTime = TimeCurrent();
bool CheckIfNewCandle()
  {
   if(NewCandleTime == iTime(Symbol(), 0, 0))
      return false;
   else
     {
      NewCandleTime = iTime(Symbol(), 0, 0);
      return true;
     }
  }

// Implements Hull moving average calculation. Copies the results into buff[].
// Returns the number of copied elements.
int iHull(const int start, const int limit, double &buff[])
  {
   double HMABuffer[];
   int sqrt_period = (int)MathFloor(MathSqrt(MAPeriod));
   ArrayResize(HMABuffer, sqrt_period);

   double Buf1[], Buf2[];
   ArrayResize(Buf1, sqrt_period);
   ArrayResize(Buf2, sqrt_period);
   ArraySetAsSeries(Buf1, true);
   ArraySetAsSeries(Buf2, true);

   for(int i = start; i < limit; i++)
     {
      int weightsum = 0;
      double WMA = 0;

      int count = CopyBuffer(BufferMAHandle, 0, i, sqrt_period, Buf1);
      if(count < sqrt_period)
        {
         Print("MA data not ready...");
         return 0;
        }
      count = CopyBuffer(BufferMAHandle2, 0, i, sqrt_period, Buf2);
      if(count < sqrt_period)
        {
         Print("MA data not ready...");
         return 0;
        }

      for(int j = 0; j < sqrt_period; j++)
        {
         HMABuffer[j] = 2 * Buf1[j] - Buf2[j];
         WMA += HMABuffer[j] * (sqrt_period - j);
         weightsum += (j + 1);
        }
      WMA /= weightsum;
      buff[i] = WMA;
     }
   return limit;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
