#include "trie.hpp"

void initTrieArray(TrieNode **array);

Trie *newTrie() {
	Trie *trie = (Trie *)malloc(sizeof(Trie));
	initTrieArray(trie->tries);
	
	return trie;
}

void initTrieArray(TrieNode **array) {
	for (int i = 0; i < TRIE_SIZE; i++)
		*(array + i) = NULL;
}

TrieNode *newTrieNode(char character) {
	TrieNode *node = (TrieNode *)malloc(sizeof(TrieNode));
	node->character = character;
	initTrieArray(node->children);
	
	return node;
}

int trieInsert(Trie *tree, char *word) {
	return trieNodeInsert(&tree->tries[*word - 'A'], word);
}

int trieNodeInsert(TrieNode **node, char *word) {
	if (*word == '\0')
		return 0;
	
	int score = 1;
	
	if (*node == NULL) {
		*node = newTrieNode(*word);
		score = 0;
	}
	
	word++;
	
	return trieNodeInsert(&(*node)->children[*word - 'A'], word) + score;
}

