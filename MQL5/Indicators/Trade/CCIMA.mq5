//+------------------------------------------------------------------+
//|                                                       CCIMA.mq5  |
//|                             Copyright 2000-2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright   "Copyright 2000-2024, MetaQuotes Ltd."
#property link        "https://www.mql5.com"
#property description "CCI with Moving Average"
//---
#property indicator_separate_window
#property indicator_level1       -100.0
#property indicator_level2        100.0
#property indicator_buffers       5
#property indicator_plots         2
//--- plot CCI
#property indicator_label1        "CCI"
#property indicator_type1         DRAW_LINE
#property indicator_color1        clrGreen
#property indicator_style1        STYLE_SOLID
#property indicator_width1        1
//--- plot CCIMA
#property indicator_label2        "CCIMA"
#property indicator_type2         DRAW_LINE
#property indicator_color2        clrDodgerBlue
#property indicator_style2        STYLE_SOLID
#property indicator_width2        1
//--- input parameters
input int  InpCCIPeriod=20;   // CCI Period
input int  InpMAPeriod=20;    // Moving Average Period
input ENUM_MA_METHOD InpMAMethod=MODE_EMA; // MA Method
//--- indicator buffers
double     ExtSPBuffer[];
double     ExtDBuffer[];
double     ExtMBuffer[];
double     ExtCCIBuffer[];
double     ExtCCIMABuffer[];

int        ExtCCIPeriod;
double     ExtMultiplyer;
//--- includes
#include <MovingAverages.mqh>
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
  {
//--- check for input value of period
   ExtCCIPeriod = InpCCIPeriod > 0 ? InpCCIPeriod : 14;
   ExtMultiplyer = 0.015 / ExtCCIPeriod;
//--- define buffers
   SetIndexBuffer(0, ExtCCIBuffer);
   SetIndexBuffer(1, ExtCCIMABuffer);
   SetIndexBuffer(2, ExtDBuffer, INDICATOR_CALCULATIONS);
   SetIndexBuffer(3, ExtMBuffer, INDICATOR_CALCULATIONS);
   SetIndexBuffer(4, ExtSPBuffer, INDICATOR_CALCULATIONS);
//--- indicator name
   string short_name = StringFormat("CCI MA (%d, %d)", ExtCCIPeriod, InpMAPeriod);
   IndicatorSetString(INDICATOR_SHORTNAME, short_name);
//--- indexes draw begin settings
   PlotIndexSetInteger(0, PLOT_DRAW_BEGIN, ExtCCIPeriod - 1);
   PlotIndexSetInteger(1, PLOT_DRAW_BEGIN, ExtCCIPeriod + InpMAPeriod - 1);
//--- number of digits of indicator value
   IndicatorSetInteger(INDICATOR_DIGITS, 2);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
   int start = (ExtCCIPeriod - 1) + begin;
   if(rates_total < start)
      return (0);
//--- correct draw begin
   if(begin > 0)
      PlotIndexSetInteger(0, PLOT_DRAW_BEGIN, start + (ExtCCIPeriod - 1));
//--- calculate position
   int pos = prev_calculated - 1;
   if(pos < start)
      pos = start;
//--- main cycle
   for(int i = pos; i < rates_total && !IsStopped(); i++)
     {
      ExtSPBuffer[i] = SimpleMA(i, ExtCCIPeriod, price);
      //--- calculate D
      double tmp_d = 0.0;
      for(int j = 0; j < ExtCCIPeriod; j++)
         tmp_d += MathAbs(price[i - j] - ExtSPBuffer[i]);
      ExtDBuffer[i] = tmp_d * ExtMultiplyer;
      //--- calculate M
      ExtMBuffer[i] = price[i] - ExtSPBuffer[i];
      //--- calculate CCI
      if(ExtDBuffer[i] != 0.0)
         ExtCCIBuffer[i] = ExtMBuffer[i] / ExtDBuffer[i];
      else
         ExtCCIBuffer[i] = 0.0;
     }
//--- calculate MA of CCI
   switch(InpMAMethod)
     {
      case MODE_EMA:
         ExponentialMAOnBuffer(rates_total, prev_calculated, ExtCCIPeriod, InpMAPeriod, ExtCCIBuffer, ExtCCIMABuffer);
         break;
      case MODE_SMMA:
         SmoothedMAOnBuffer(rates_total, prev_calculated, ExtCCIPeriod, InpMAPeriod, ExtCCIBuffer, ExtCCIMABuffer);
         break;
      case MODE_LWMA:
         LinearWeightedMAOnBuffer(rates_total, prev_calculated, ExtCCIPeriod, InpMAPeriod, ExtCCIBuffer, ExtCCIMABuffer);
         break;
      default:
         SimpleMAOnBuffer(rates_total, prev_calculated, ExtCCIPeriod, InpMAPeriod, ExtCCIBuffer, ExtCCIMABuffer);
         break;
     }
//--- OnCalculate done. Return new prev_calculated.
   return (rates_total);
  }
//+------------------------------------------------------------------+
