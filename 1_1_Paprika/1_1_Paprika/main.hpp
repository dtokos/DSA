#ifndef main_h
#define main_h

#include <iostream>
#include <vector>
#include <limits.h>

using namespace std;

int getNumOfRuns(void);
void runScenario(void);
vector<int> getPredictions();
int calculateProfit(vector<int> predictions);
vector<int> analyzePurchaseAndSellingPoints(vector<int> predictions);

#endif
