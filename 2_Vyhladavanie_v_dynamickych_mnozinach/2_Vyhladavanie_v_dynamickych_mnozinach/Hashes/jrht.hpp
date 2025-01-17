#ifndef jrht_hpp
#define jrht_hpp

// Source: https://github.com/jamesroutley/algorithms-and-data-structures/blob/master/hash-table/src/hash_table.c

typedef struct ht_item {
	char* key;
	char* value;
} ht_item;


typedef struct {
	int size_index;
	int size;
	int count;
	ht_item** items;
} ht_hash_table;

ht_hash_table* ht_new();
void ht_del_hash_table(ht_hash_table* ht);

void ht_insert(ht_hash_table* ht, const char* key, const char* value);
char* ht_search(ht_hash_table* ht, const char* key);
void ht_delete(ht_hash_table* h, const char* key);

#endif
