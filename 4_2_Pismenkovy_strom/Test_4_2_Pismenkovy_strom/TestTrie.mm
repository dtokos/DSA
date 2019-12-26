#import <XCTest/XCTest.h>
#include "trie.hpp"

@interface TestTrie : XCTestCase

@end

@implementation TestTrie

-(void)testNewTrie {
	Trie *trie = newTrie();
	for (int i = 0; i < TRIE_SIZE; i++)
		XCTAssertTrue(trie->tries[i] == NULL);
}

-(void)testNewTrieNode {
	TrieNode *node = newTrieNode('A');
	XCTAssertEqual(node->character, 'A');
	for (int i = 0; i < TRIE_SIZE; i++)
		XCTAssertTrue(node->children[i] == NULL);
}

-(void)testExample1 {
	Trie *trie = newTrie();
	XCTAssertEqual(trieInsert(trie, (char *)"SLON"),    0);
	XCTAssertEqual(trieInsert(trie, (char *)"MASLO"),   0);
	XCTAssertEqual(trieInsert(trie, (char *)"SILONKY"), 1);
	XCTAssertEqual(trieInsert(trie, (char *)"MAPA"),    2);
	XCTAssertEqual(trieInsert(trie, (char *)"MASKA"),   3);
}

-(void)testExample2 {
	Trie *trie = newTrie();
	XCTAssertEqual(trieInsert(trie, (char *)"BABCBBAABCBCBCB"),                 0);
	XCTAssertEqual(trieInsert(trie, (char *)"AB"),                              0);
	XCTAssertEqual(trieInsert(trie, (char *)"CCAACCCBBBCAAACABB"),              0);
	XCTAssertEqual(trieInsert(trie, (char *)"BAA"),                             2);
	XCTAssertEqual(trieInsert(trie, (char *)"CCBCCCACBBCCACCBBAACACC"),         2);
	XCTAssertEqual(trieInsert(trie, (char *)"ABCAAAACACCACBAACC"),              2);
	XCTAssertEqual(trieInsert(trie, (char *)"ACCBAACABBBAACABCBCACCAABC"),      1);
	XCTAssertEqual(trieInsert(trie, (char *)"CCB"),                             3);
	XCTAssertEqual(trieInsert(trie, (char *)"CBCBAABACACABABCA"),               1);
	XCTAssertEqual(trieInsert(trie, (char *)"CBCCCBAC"),                        3);
	XCTAssertEqual(trieInsert(trie, (char *)"ACAABCBAACCBCABCCBCCBCBBCBABCCA"), 2);
	XCTAssertEqual(trieInsert(trie, (char *)"CBABBCCBCCABCBCBABCCAAA"),         2);
	XCTAssertEqual(trieInsert(trie, (char *)"CBBBCCCBBBA"),                     2);
	XCTAssertEqual(trieInsert(trie, (char *)"AACACAACCCBCBACCCBAC"),            1);
	XCTAssertEqual(trieInsert(trie, (char *)"CBAABCCCACABCB"),                  3);
	XCTAssertEqual(trieInsert(trie, (char *)"CBABBABCACBAACCBACCAACAA"),        5);
	XCTAssertEqual(trieInsert(trie, (char *)"CABC"),                            1);
	XCTAssertEqual(trieInsert(trie, (char *)"ACABBCBABCCBA"),                   3);
	XCTAssertEqual(trieInsert(trie, (char *)"BACBC"),                           2);
	XCTAssertEqual(trieInsert(trie, (char *)"CABCAAABAABACCBBAACCACAABABB"),    4);
}

@end
