#ifndef trie_hpp
#define trie_hpp

#include <stdio.h>
#include <stdlib.h>

#define TRIE_SIZE ('Z' - 'A' + 1)

struct TrieNode {
	char character;
	struct TrieNode *children[TRIE_SIZE];
};
typedef struct TrieNode TrieNode;


struct Trie {
	TrieNode *tries[TRIE_SIZE];
};
typedef struct Trie Trie;

Trie *newTrie();
TrieNode *newTrieNode(char character);
int trieInsert(Trie *tree, char *word);
int trieNodeInsert(TrieNode **node, char *word);

#endif
