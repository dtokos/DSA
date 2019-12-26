#include <stdio.h>
#include "trie.hpp"

int main(int argc, const char * argv[]) {
	Trie *trie = newTrie();
	char word[52];
	int max = 0;
	
	while (scanf("%s", word) != EOF) {
		int prefixLength = trieInsert(trie, word);
		
		if (prefixLength > max)
			max = prefixLength;
	}
	
	printf("%i\n", max);
	
	return 0;
}
