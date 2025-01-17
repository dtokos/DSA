#import <XCTest/XCTest.h>
#include "jrht.hpp"

@interface TestJRHTSearch : XCTestCase

@end

@implementation TestJRHTSearch

- (void)testSearchOnEmptyTable {
	ht_hash_table *table = ht_new();
	char *result = ht_search(table, "1");
	XCTAssertTrue(result == NULL);
}

- (void)testSearch {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	char *result = ht_search(table, "1");
	XCTAssertEqual(strcmp(result, "5"), 0);
}

- (void)testSearchOnCollision {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	ht_insert(table, "51", "6");
	char *result = ht_search(table, "51");
	XCTAssertEqual(strcmp(result, "6"), 0);
}

@end
