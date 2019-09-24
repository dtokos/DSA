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
			if (shouldPurchase(lastPrediction, prediction))
				purchase(psPoints, lastPrediction, findingPruchasePoint);	
		} else if (!findingPruchasePoint) {
			if (shouldSell(lastPrediction, prediction))
				sell(psPoints, lastPrediction, findingPruchasePoint);
		}
		
		lastPrediction = prediction;
	}
	
	if (!findingPruchasePoint)
		purchase(psPoints, lastPrediction, findingPruchasePoint);
	
	return psPoints;
}

bool ProfitCalculator::shouldPurchase(int lastPrediction, int prediction) {
	return lastPrediction < prediction;
}

void ProfitCalculator::purchase(vector<int>& psPoints, int prediction, bool& findingPruchasePoint) {
	psPoints.push_back(prediction);
	findingPruchasePoint = false;
}


bool ProfitCalculator::shouldSell(int lastPrediction, int prediction) {
	return lastPrediction > prediction;
}

void ProfitCalculator::sell(vector<int>& psPoints, int prediction, bool& findingPruchasePoint) {
	psPoints.push_back(prediction);
	findingPruchasePoint = true;
}
