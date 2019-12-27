#include "table.hpp"

#define shouldResize(table) (table->count / table->size > MAX_FULFILLMENT)

const int INITIAL_TABLE_SIZE = 512;
const int MAX_FULFILLMENT = 10;

struct KeyValuePair {
	char *key;
	struct KeyValuePair *next;
};
typedef struct KeyValuePair KeyValuePair;

struct HashTable {
	KeyValuePair **pairs;
	unsigned size, count;
};
typedef struct HashTable HashTable;

HashTable *htMake();
int htInsert(HashTable *table, char *key);
unsigned htCalculateIndex(char *key, int tableSize);
void htFree(HashTable *table);

KeyValuePair **allocPairs(unsigned count);
void resize(HashTable *table);
void movePairs(KeyValuePair **oldPairs, KeyValuePair **newPairs, unsigned size, unsigned newSize);
void movePair(KeyValuePair *pair, KeyValuePair **newPairs, unsigned newSize);
KeyValuePair *newKeyValuePair(char *key);

int vyhadzovac(char *ids[], int count) {
	HashTable *table = htMake();
	int result = 0;
	
	for (int i = 0; i < count; i++)
		result += htInsert(table, ids[i]);
	
	return result;
}

HashTable *htMake() {
	HashTable *table = (HashTable *)malloc(sizeof(HashTable));
	table->pairs = allocPairs(INITIAL_TABLE_SIZE);
	table->size = INITIAL_TABLE_SIZE;
	table->count = 0;
	
	return table;
}

KeyValuePair **allocPairs(unsigned count) {
	KeyValuePair **pairs = (KeyValuePair **)malloc(sizeof(KeyValuePair *) * count);
	for (unsigned i = 0; i < count; i++)
		pairs[i] = NULL;
	
	return pairs;
}

int htInsert(HashTable *table, char *key) {
	if (shouldResize(table))
		resize(table);
	
	unsigned index = htCalculateIndex(key, table->size);
	KeyValuePair **insertPosition = &table->pairs[index];
	
	while (*insertPosition != NULL && strcmp((*insertPosition)->key, key) != 0)
		insertPosition = &(*insertPosition)->next;
	
	if (*insertPosition == NULL) {
		*insertPosition = newKeyValuePair(key);
		table->count++;
		
		return 0;
	} else
		return 1;
}

void resize(HashTable *table) {
	unsigned newSize = table->size * 2;
	KeyValuePair **newPairs = allocPairs(newSize);
	movePairs(table->pairs, newPairs, table->size, newSize);
	free(table->pairs);
	table->size = newSize;
	table->pairs = newPairs;
}

void movePairs(KeyValuePair **oldPairs, KeyValuePair **newPairs, unsigned size, unsigned newSize) {
	KeyValuePair *pair, *nextPair;
	
	for (int i = 0; i < size; i++) {
		pair = oldPairs[i];
		
		while (pair != NULL) {
			nextPair = pair->next;
			movePair(pair, newPairs, newSize);
			pair = nextPair;
		}
	}
}

void movePair(KeyValuePair *pair, KeyValuePair **newPairs, unsigned newSize) {
	unsigned index = htCalculateIndex(pair->key, newSize);
	KeyValuePair **insertPosition = &newPairs[index];
	
	while (*insertPosition != NULL)
		insertPosition = &(*insertPosition)->next;
	
	pair->next = NULL;
	*insertPosition = pair;
}

unsigned htCalculateIndex(char *key, int tableSize) {
	unsigned index = 0;
	
	for (; *key != '\0'; key++)
		index += *key;
	
	return index % tableSize;
}

KeyValuePair *newKeyValuePair(char *key) {
	KeyValuePair *pair = (KeyValuePair *)malloc(sizeof(KeyValuePair));
	pair->key = key;
	pair->next = NULL;
	
	return pair;
}

void htFree(HashTable *table) {
	KeyValuePair *next;
	
	for (int i = 0; i < table->size; i++) {
		for (KeyValuePair *pair = table->pairs[i]; pair != NULL; pair = next) {
			next = pair->next;
			free(pair);
		}
	}
	
	free(table->pairs);
	free(table);
}
