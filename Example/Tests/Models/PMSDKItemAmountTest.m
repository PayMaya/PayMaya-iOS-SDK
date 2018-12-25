//
//  PMSDKItemAmountTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKItemAmountTest : XCTestCase

@end

@implementation PMSDKItemAmountTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitItemAmount {
    PMSDKItemAmount *amount = [[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(1200.77)];
    XCTAssertTrue([@"PHP" isEqualToString:amount.currency]);
    XCTAssertTrue([@(1200.77) isEqualToNumber:amount.value]);
    XCTAssertNil(amount.details);
}

- (void)testFailableInitItemAmount {
    PMSDKItemAmount *amount = [[PMSDKItemAmount alloc] initWithCurrency:@"QWE" value:@(1200.77)];
    XCTAssertNil(amount);
}

@end
