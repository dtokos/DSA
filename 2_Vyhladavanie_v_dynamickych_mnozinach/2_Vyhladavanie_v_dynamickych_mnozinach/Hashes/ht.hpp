#ifndef hash_hpp
#define hash_hpp

#include <stdlib.h>

extern const int INITIAL_TABLE_SIZE;

struct KeyValuePair {
	int key, value;
	struct KeyValuePair *next;
};
typedef struct KeyValuePair KeyValuePair;

struct HashTable {
	KeyValuePair **pairs;
	unsigned size, count;
};
typedef struct HashTable HashTable;

HashTable *htMake();
void htInsert(HashTable *table, int key, int value);
KeyValuePair *htSearch(HashTable *table, int key);
unsigned htCalculateIndex(int key, int tableSize);

#endif
