#include "table.hpp"

#define shouldResize(table) (table->count / table->size > MAX_FULFILLMENT)

const int PRRIMES[] = {769, 1543, 3079, 6151, 12289};
const int MAX_FULFILLMENT = 10;

struct KeyValuePair {
	unsigned long key;
	struct KeyValuePair *next;
};
typedef struct KeyValuePair KeyValuePair;

struct HashTable {
	KeyValuePair **pairs;
	unsigned size, sizeIndex, count;
};
typedef struct HashTable HashTable;

HashTable *htMake();
int htInsert(HashTable *table, char *key);
unsigned long htCalculateKey(char *key);
unsigned htCalculateIndex(unsigned long key, int tableSize);
void htFree(HashTable *table);

KeyValuePair **allocPairs(unsigned count);
void resize(HashTable *table);
void movePairs(KeyValuePair **oldPairs, KeyValuePair **newPairs, unsigned size, unsigned newSize);
void movePair(KeyValuePair *pair, KeyValuePair **newPairs, unsigned newSize);
KeyValuePair *newKeyValuePair(unsigned long key);

int vyhadzovac(char *ids[], int count) {
	HashTable *table = htMake();
	int result = 0;
	
	for (int i = 0; i < count; i++)
		result += htInsert(table, ids[i]);
	
	htFree(table);
	
	return result;
}

HashTable *htMake() {
	HashTable *table = (HashTable *)malloc(sizeof(HashTable));
	table->sizeIndex = 0;
	table->size = PRRIMES[table->sizeIndex];
	table->pairs = allocPairs(table->size);
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
	
	unsigned long intKey = htCalculateKey(key);
	unsigned index = htCalculateIndex(intKey, table->size);
	KeyValuePair **insertPosition = &table->pairs[index];
	
	while (*insertPosition != NULL && (*insertPosition)->key != intKey)
		insertPosition = &(*insertPosition)->next;
	
	if (*insertPosition == NULL) {
		*insertPosition = newKeyValuePair(intKey);
		table->count++;
		
		return 0;
	} else
		return 1;
}

void resize(HashTable *table) {
	unsigned newSize = PRRIMES[table->sizeIndex + 1];
	KeyValuePair **newPairs = allocPairs(newSize);
	movePairs(table->pairs, newPairs, table->size, newSize);
	free(table->pairs);
	table->size = newSize;
	table->sizeIndex++;
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

unsigned long htCalculateKey(char *key) {
	unsigned long result = 0;
	
	for (int i = 0; *key != '\0'; key++, i++) {
		switch(*key) {
			case '0': case '1': case '2': case '3': case '4':
			case '5': case '6': case '7': case '8': case '9':
				result += (unsigned long)(*key - '0') << (i * 6);
				break;
			case 'A': case 'B': case 'C': case 'D': case 'E':
			case 'F': case 'G': case 'H': case 'I': case 'J':
			case 'K': case 'L': case 'M': case 'N': case 'O':
			case 'P': case 'Q': case 'R': case 'S': case 'T':
			case 'U': case 'V': case 'W': case 'X': case 'Y':
			case 'Z':
				result += (unsigned long)(*key - 'A' + 10) << (i * 6);
				break;
			default:
				result += (unsigned long)(*key - 'a' + 10 + 26) << (i * 6);
				break;
		}
	}
	
	return result;
}

unsigned htCalculateIndex(unsigned long key, int tableSize) {
	return key % tableSize;
}

KeyValuePair *newKeyValuePair(unsigned long key) {
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
