#include "calculator.hpp"

int calculateBalance(int* predictions, int count);
int findPruchasePoint(int *predictions, int count, int *index);
int findSellingPoint(int *predictions, int count, int *index);

int calculate(int *predictions, int count) {
	if (count < 2)
		return 0;
	
	return calculateBalance(predictions, count);
}

int calculateBalance(int *predictions, int count) {
	int balance = 0, index = 1, point = 0;
	bool didSell = true;
	
	while (index != count) {
		if (didSell) {
			point = findPruchasePoint(predictions, count, &index);
			balance -= point;
			didSell = false;
		}
		if (!didSell) {
			point = findSellingPoint(predictions, count, &index);
			balance += point;
			didSell = true;
		}
	}
	
	return balance;
}

int findPruchasePoint(int *predictions, int count, int *index) {
	int lastPrediction = predictions[*index - 1];
	
	while (lastPrediction >= predictions[*index] && *index < count) {
		lastPrediction = predictions[*index];
		(*index)++;
	}
	
	return lastPrediction;
}

int findSellingPoint(int *predictions, int count, int *index) {
	int lastPrediction = predictions[*index - 1];
	
	while (lastPrediction <= predictions[*index] && *index < count) {
		lastPrediction = predictions[*index];
		(*index)++;
	}
	
	return lastPrediction;
}
