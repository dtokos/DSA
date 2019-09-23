#include <iostream>
#include <vector>
#include <limits.h>

using namespace std;

int getNumOfRuns();
void runScenario();
vector<int> getPredictions();
int calculateProfit(vector<int> predictions);
vector<int> analyzePurchaseAndSellingPoints(vector<int> predictions);

int main(int argc, const char * argv[]) {
	int numOfRuns = getNumOfRuns();
	for (int run = 0; run < numOfRuns; run++)
		runScenario();
	
	return 0;
}

int getNumOfRuns() {
	int runs;
	cin >> runs;
	
	return runs;
}

void runScenario() {
	vector<int> predictions = getPredictions();
	int profit = calculateProfit(predictions);
	
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

int calculateProfit(vector<int> predictions) {
	int balance = 0;
	bool willSell = false;
	vector<int> psPoints = analyzePurchaseAndSellingPoints(predictions);
	
	for (int psPoint : psPoints) {
		if ((willSell = !willSell))
			balance -= psPoint;
		else
			balance += psPoint;
	}
	
	return balance;
}

vector<int> analyzePurchaseAndSellingPoints(vector<int> predictions) {
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
