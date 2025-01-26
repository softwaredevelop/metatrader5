//+------------------------------------------------------------------+
//|                                            SymbolsBubbleSort.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
// Bubble sort function
void BubbleSort(string &array[])
  {
   int n = ArraySize(array); // Get the size of the array
   for(int i = 0; i < n - 1; i++) // Outer loop for iterations
     {
      for(int j = 0; j < n - i - 1; j++) // Inner loop for comparisons
        {
         if(array[j] > array[j + 1]) // If the order is incorrect
           {
            // Swap elements
            string temp = array[j];
            array[j] = array[j + 1];
            array[j + 1] = temp;
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- Total number of symbols
   int total = SymbolsTotal(false); // Get the total number of symbols
   string paths[]; // Dynamic array to store the symbol paths
   ArrayResize(paths, 0); // Explicit initialization

//--- Collecting symbol paths
   for(int i = 0; i < total; i++) // Loop through all symbols
     {
      string symbol_name = SymbolName(i, false); // Get the symbol name
      string path = SymbolInfoString(symbol_name, SYMBOL_PATH); // Get the symbol path
      if(path != NULL) // Check if the path is not empty
        {
         ArrayResize(paths, ArraySize(paths) + 1); // Resize the array to add a new element
         paths[ArraySize(paths) - 1] = path; // Assign the path to the last position in the array
        }
     }

//--- Sorting paths using bubble sort
   BubbleSort(paths);

//--- Printing sorted paths
   for(int i = 0; i < ArraySize(paths); i++) // Loop through the sorted paths
     {
      Print(paths[i]); // Print each sorted path
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
