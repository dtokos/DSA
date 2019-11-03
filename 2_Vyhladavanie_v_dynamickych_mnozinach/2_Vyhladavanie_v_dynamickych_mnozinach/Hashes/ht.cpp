#include "ht.hpp"

const int INITIAL_TABLE_SIZE = 512;
const int MAX_FULFILLMENT = 10;

#define shouldResize(table) (table->count / table->size > MAX_FULFILLMENT)

KeyValuePair **allocPairs(unsigned count);
void resize(HashTable *table);
void movePairs(KeyValuePair **oldPairs, KeyValuePair **newPairs, unsigned size, unsigned newSize);
void movePair(KeyValuePair *pair, KeyValuePair **newPairs, unsigned newSize);
unsigned reverseKey(unsigned key);
KeyValuePair *newKeyValuePair(int key, int value);

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

void htInsert(HashTable *table, int key, int value) {
	if (shouldResize(table))
		resize(table);
	
	table->count++;
	unsigned index = htCalculateIndex(key, table->size);
	KeyValuePair **insertPosition = &table->pairs[index];
	
	while (*insertPosition != NULL)
		insertPosition = &(*insertPosition)->next;
	
	*insertPosition = newKeyValuePair(key, value);
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

unsigned htCalculateIndex(int key, int tableSize) {
	unsigned index = ~(~(key & 0xFFFF0000) >> 16) + ((key & 0xFFFF) << 16);
	index ^= key ^ 0xE5B46A9B;
	index ^= key ^ 0xAB5C4357;
	index ^= key ^ 0x3698F782;
	index ^= key ^ 0xA2BD71CF;
	index ^= key ^ 0xD4E60853;
	index ^= ~reverseKey(key);
	
	return index % tableSize;
}

unsigned reverseKey(unsigned key) {
	unsigned result = 0;
	
	while (key > 0) {
		result |= (unsigned)~((unsigned)~(0) >> 1) * (key & 0x1);
		key >>= 1;
		result >>= 1;
	}
	
	return result;
}

KeyValuePair *newKeyValuePair(int key, int value) {
	KeyValuePair *pair = (KeyValuePair *)malloc(sizeof(KeyValuePair));
	pair->key = key;
	pair->value = value;
	pair->next = NULL;
	
	return pair;
}

KeyValuePair *htSearch(HashTable *table, int key) {
	unsigned index = htCalculateIndex(key, table->size);
	KeyValuePair *pair = table->pairs[index];
	
	while (pair != NULL && pair->key != key)
		pair = pair->next;
	
	return pair;
}
