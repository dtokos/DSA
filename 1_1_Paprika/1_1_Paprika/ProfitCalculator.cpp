#include "ProfitCalculator.hpp"

int ProfitCalculator::calculate(const vector<int>& predictions) {
	int balance = 0;
	bool didSell = true;
	vector<int> psPoints = analyzePurchaseAndSellingPoints(predictions);
	
	for (int psPoint : psPoints)
		balance += psPoint * (-1 + 2 * (didSell = !didSell));
	
	return balance;
}

vector<int> ProfitCalculator::analyzePurchaseAndSellingPoints(const vector<int>& predictions) {
	vector<int> psPoints;
	int lastPrediction = INT_MAX;
	bool findingPruchasePoint = true;
	
	for (int prediction : predictions) {
		if (findingPruchasePoint) {
			if (lastPrediction < prediction) {
				psPoints.push_back(lastPrediction);
				findingPruchasePoint = false;
			}
			
			lastPrediction = prediction;
		} else if (!findingPruchasePoint) {
			if (lastPrediction > prediction) {
				psPoints.push_back(lastPrediction);
				findingPruchasePoint = true;
			}
			
			lastPrediction = prediction;
		}
	}
	
	if (!findingPruchasePoint) {
		psPoints.push_back(lastPrediction);
		findingPruchasePoint = true;
	}
	
	return psPoints;
}
