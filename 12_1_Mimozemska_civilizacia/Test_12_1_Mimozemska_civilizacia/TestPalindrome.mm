#import <XCTest/XCTest.h>
#include "palindrome.hpp"

@interface TestPalindrome : XCTestCase

@end

@implementation TestPalindrome

-(void)testExample1 {
	XCTAssertEqual(length((char *)"abecedazjedladeda", 17), 5);
	XCTAssertEqual(length((char *)"povedalanamedveda", 17), 3);
	XCTAssertEqual(length((char *)"abbabaabaabbaabab", 17), 10);
}

-(void)testExample2 {
	XCTAssertEqual(length((char *)"bcaacbcaab", 10), 7);
	XCTAssertEqual(length((char *)"abbcccbabb", 10), 5);
	XCTAssertEqual(length((char *)"aacbcacbab", 10), 5);
	XCTAssertEqual(length((char *)"baacabbcaa", 10), 3);
	XCTAssertEqual(length((char *)"ababbaabbb", 10), 6);
	XCTAssertEqual(length((char *)"abaabaaaba", 10), 7);
	XCTAssertEqual(length((char *)"bbaabbbbab", 10), 6);
	XCTAssertEqual(length((char *)"bbaaaaabbb", 10), 9);
	XCTAssertEqual(length((char *)"bbabababaa", 10), 7);
	XCTAssertEqual(length((char *)"bbbbbbabab", 10), 6);
	XCTAssertEqual(length((char *)"aaabbbabbb", 10), 7);
	XCTAssertEqual(length((char *)"babbabaaaa", 10), 6);
	XCTAssertEqual(length((char *)"abccaaaaba", 10), 4);
	XCTAssertEqual(length((char *)"abaaababbb", 10), 7);
	XCTAssertEqual(length((char *)"bcbcbbabcc", 10), 5);
	XCTAssertEqual(length((char *)"bcbbcccbcc", 10), 5);
}

@end
