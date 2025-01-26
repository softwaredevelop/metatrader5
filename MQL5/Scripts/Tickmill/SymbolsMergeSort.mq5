//+------------------------------------------------------------------+
//|                                             SymbolsMergeSort.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
// MergeSort helper function
void Merge(string &array[], int left, int right)
  {
   if(left < right) // Check if there is more than one element
     {
      int mid = (left + right) / 2; // Find the middle index

      // Recursively sort the left and right halves
      Merge(array, left, mid);
      Merge(array, mid + 1, right);

      // Merge the sorted halves
      MergeArrays(array, left, mid, right);
     }
  }

// Merge two sorted parts of the array
void MergeArrays(string &array[], int left, int mid, int right)
  {
   int n1 = mid - left + 1; // Size of the left subarray
   int n2 = right - mid; // Size of the right subarray

// Temporary arrays
   string leftArray[];
   string rightArray[];

   ArrayResize(leftArray, n1);
   ArrayResize(rightArray, n2);

// Fill the temporary arrays with data from the main array
   for(int i = 0; i < n1; i++)
      leftArray[i] = array[left + i];

   for(int j = 0; j < n2; j++)
      rightArray[j] = array[mid + 1 + j];

   int i = 0, j = 0, k = left;

// Merge the sorted parts
   while(i < n1 && j < n2)
     {
      if(leftArray[i] <= rightArray[j]) // Compare and add the smaller element to the array
        {
         array[k] = leftArray[i];
         i++;
        }
      else
        {
         array[k] = rightArray[j];
         j++;
        }
      k++;
     }

// If there are remaining elements in the left subarray
   while(i < n1)
     {
      array[k] = leftArray[i];
      i++;
      k++;
     }

// If there are remaining elements in the right subarray
   while(j < n2)
     {
      array[k] = rightArray[j];
      j++;
      k++;
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

//--- Sorting paths using MergeSort
   Merge(paths, 0, ArraySize(paths) - 1);

//--- Printing sorted paths
   for(int i = 0; i < ArraySize(paths); i++) // Loop through the sorted paths
     {
      Print(paths[i]); // Print each sorted path
     }
  }
//+------------------------------------------------------------------+
