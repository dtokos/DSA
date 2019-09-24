#ifndef ProfitCalculator_hpp
#define ProfitCalculator_hpp

#include <vector>

using namespace std;

class ProfitCalculator {
public:
	int calculate(const vector<int>& predictions);

private:
	vector<int> analyzePurchaseAndSellingPoints(const vector<int>& predictions);
	bool shouldPurchase(int lastPrediction, int prediction);
	bool shouldSell(int lastPrediction, int prediction);
	void purchase(vector<int>& psPoints, int prediction, bool& findingPruchasePoint);
	void sell(vector<int>& psPoints, int prediction, bool& findingPruchasePoint);
};

#endif
