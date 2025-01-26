//+------------------------------------------------------------------+
//|                                          SymbolsSearchByPath.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.03"
#property script_show_inputs // Enable input panel
//+------------------------------------------------------------------+
//| Input parameters                                                 |
//+------------------------------------------------------------------+
input string searchTerm = "Forex\\Minors"; // Search term

// Define options for the dropdown menu
enum ReturnType
  {
   ByPath,      // Path
   BySymbolName // Symbol name
  };

input ReturnType returnType = ByPath; // Return type
//+------------------------------------------------------------------+
//| Quick Sort Algorithm                                             |
//+------------------------------------------------------------------+
void QuickSort(string &array[], int left, int right)
  {
   if(left >= right)
      return; // Base case: if the array has one or no elements, it's sorted
   int pivotIndex = left + (right - left) / 2; // Choose pivot element
   string pivotValue = array[pivotIndex];
   int i = left, j = right;

   while(i <= j)
     {
      while(StringCompare(array[i], pivotValue) < 0)
         i++; // Move left index right
      while(StringCompare(array[j], pivotValue) > 0)
         j--; // Move right index left
      if(i <= j)
        {
         // Swap elements
         string temp = array[i];
         array[i] = array[j];
         array[j] = temp;
         i++;
         j--;
        }
     }

// Recursively sort left and right partitions
   if(left < j)
      QuickSort(array, left, j);
   if(i < right)
      QuickSort(array, i, right);
  }
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   int total = SymbolsTotal(false); // Get the total number of symbols
   string results[]; // Dynamic array to store results
   ArrayResize(results, 0); // Explicit initialization

//--- Collecting symbols with matching paths
   for(int i = 0; i < total; i++) // Loop through all symbols
     {
      string symbol_name = SymbolName(i, false); // Get the symbol name
      string path = SymbolInfoString(symbol_name, SYMBOL_PATH); // Get the symbol path
      if(path != NULL && StringFind(path, searchTerm) != -1) // Check if the search string is found in the path
        {
         ArrayResize(results, ArraySize(results) + 1); // Resize the array to add a new element
         if(returnType == ByPath)
            results[ArraySize(results) - 1] = path; // Add the symbol path to the array
         else
            results[ArraySize(results) - 1] = symbol_name; // Add the symbol name to the array
        }
     }

//--- Sorting the results using QuickSort
   if(ArraySize(results) > 0)
     {
      QuickSort(results, 0, ArraySize(results) - 1); // Sort the results

      if(returnType == ByPath)
         Print("Sorted paths matching the search term '", searchTerm, "':");
      else
         Print("Sorted symbol names matching the search term '", searchTerm, "':");

      for(int i = 0; i < ArraySize(results); i++) // Loop through the sorted results
        {
         Print(results[i]); // Print each sorted result
        }
     }
   else
     {
      Print("No matches found for the search term '", searchTerm, "'.");
     }
  }
//+------------------------------------------------------------------+
