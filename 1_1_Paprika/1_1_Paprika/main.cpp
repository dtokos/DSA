#include <iostream>
#include <vector>
#include <limits.h>
#include "ProfitCalculator.hpp"

int getNumOfRuns(void);
void runScenario(ProfitCalculator& calculator);
vector<int> getPredictions();

int main(int argc, const char * argv[]) {
	int numOfRuns = getNumOfRuns();
	ProfitCalculator calculator;
	
	for (int run = 0; run < numOfRuns; run++)
		runScenario(calculator);
	
	return 0;
}

int getNumOfRuns() {
	int runs;
	cin >> runs;
	
	return runs;
}

void runScenario(ProfitCalculator& calculator) {
	vector<int> predictions = getPredictions();
	int profit = calculator.calculate(predictions);
	
	cout << profit << endl;
}

vector<int> getPredictions() {
	int numOfPredictions, prediction;
	vector<int> predictions;
	
	cin >> numOfPredictions;
	
	for (int predictionNo = 0; predictionNo < numOfPredictions; predictionNo++) {
		cin >> prediction;
		predictions.push_back(prediction);
	}

	return predictions;
}
