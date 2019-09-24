#ifndef ProfitCalculator_hpp
#define ProfitCalculator_hpp

#include <vector>

using namespace std;

class ProfitCalculator {
public:
	int calculate(const vector<int>& predictions);

private:
	vector<int> analyzePurchaseAndSellingPoints(const vector<int>& predictions);
};

#endif
