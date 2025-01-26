//+------------------------------------------------------------------+
//|                                         SymbolsInsertionSort.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
// Insertion sort function
void InsertionSort(string &array[])
  {
   int n = ArraySize(array); // Get the size of the array
   for(int i = 1; i < n; i++) // Loop through each element starting from the second
     {
      string key = array[i]; // Set the key as the current element
      int j = i - 1; // Start from the previous element

      // Move elements that are greater than the key to one position ahead
      while(j >= 0 && array[j] > key)
        {
         array[j + 1] = array[j]; // Shift element to the right
         j = j - 1; // Move to the previous element
        }
      array[j + 1] = key; // Place the key in its correct position
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

//--- Sorting paths using insertion sort
   InsertionSort(paths);

//--- Printing sorted paths
   for(int i = 0; i < ArraySize(paths); i++) // Loop through the sorted paths
     {
      Print(paths[i]); // Print each sorted path
     }
  }
//+------------------------------------------------------------------+
