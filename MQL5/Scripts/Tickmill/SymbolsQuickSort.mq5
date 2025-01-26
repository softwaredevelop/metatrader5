//+------------------------------------------------------------------+
//|                                             SymbolsQuickSort.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
// QuickSort function
void QuickSort(string &array[], int low, int high)
  {
   if(low < high) // Check if there are at least two elements
     {
      // Partitioning the array
      int pivot_index = Partition(array, low, high);

      // Recursively sort the left and right parts
      QuickSort(array, low, pivot_index - 1);
      QuickSort(array, pivot_index + 1, high);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// Partition function for QuickSort
int Partition(string &array[], int low, int high)
  {
   string pivot = array[high]; // Pivot is the last element
   int i = low - 1;

   for(int j = low; j < high; j++) // Loop through the array
     {
      if(array[j] <= pivot) // If the element is smaller or equal to the pivot
        {
         i++;
         // Swap elements
         string temp = array[i];
         array[i] = array[j];
         array[j] = temp;
        }
     }

// Place the pivot in its correct position
   string temp = array[i + 1];
   array[i + 1] = array[high];
   array[high] = temp;

   return i + 1; // Return the pivot index
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// OnStart main function
void OnStart()
  {
//--- Total number of symbols
   int total = SymbolsTotal(false); // Get the total number of symbols
   string paths[]; // Dynamic array to store symbol paths
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

//--- Sorting paths using QuickSort
   QuickSort(paths, 0, ArraySize(paths) - 1);

//--- Printing sorted paths
   for(int i = 0; i < ArraySize(paths); i++) // Loop through the sorted paths
     {
      Print(paths[i]); // Print each sorted path
     }
  }
//+------------------------------------------------------------------+
