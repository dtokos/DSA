#import <XCTest/XCTest.h>
#include "heap.hpp"

@interface TestHeap : XCTestCase

@end

@implementation TestHeap

- (void)testInsert {
	vloz((char *)"Peter", 100);
	vloz((char *)"Jana", 150);
	vloz((char *)"dsa2044897763", 2044897763);
}

- (void)testExample1 {
	vloz((char *)"Peter", 100);
	vloz((char *)"Jana", 50);
	XCTAssertFalse(strcmp(vyber_najvyssie(), "Peter"));
	vloz((char *)"Marek", 20);
	XCTAssertFalse(strcmp(vyber_najvyssie(), "Jana"));
	XCTAssertFalse(strcmp(vyber_najvyssie(), "Marek"));
}

- (void)testExample2 {
	vloz((char *)"dsa1804289383", 1804289383);
	vloz((char *)"dsa1681692777", 1681692777);
	vloz((char *)"dsa1957747793", 1957747793);
	vloz((char *)"dsa719885386",   719885386);
	XCTAssertFalse(strcmp(vyber_najvyssie(), "dsa1957747793"));
	vloz((char *)"dsa596516649",   596516649);
	vloz((char *)"dsa1025202362", 1025202362);
	vloz((char *)"dsa783368690",   783368690);
	vloz((char *)"dsa2044897763", 2044897763);
	vloz((char *)"dsa1365180540", 1365180540);
	XCTAssertFalse(strcmp(vyber_najvyssie(), "dsa2044897763"));
}

@end
