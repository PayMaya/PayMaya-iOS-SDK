//
//  PMSDKCheckoutItemTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKCheckoutItemTest : XCTestCase

@end

@implementation PMSDKCheckoutItemTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitCheckoutItem {
    PMSDKItemAmount *amount = [[PMSDKItemAmount alloc] initWithCurrency:@"PHP"
                                                                  value:@(2800.50)];
    PMSDKCheckoutItem *checkoutItem = [[PMSDKCheckoutItem alloc] initWithName:@"Love Marie"
                                                                     quantity:@(3)
                                                                  totalAmount:amount];
    XCTAssertTrue([@"Love Marie" isEqualToString:checkoutItem.name]);
    XCTAssertNil(checkoutItem.code);
    XCTAssertNil(checkoutItem.itemDescription);
    XCTAssertTrue([@(3) isEqualToNumber:checkoutItem.quantity]);
    XCTAssertNil(checkoutItem.amount);
    XCTAssertTrue([@"PHP" isEqualToString:checkoutItem.totalAmount.currency]);
    XCTAssertTrue([@(2800.50) isEqualToNumber:checkoutItem.totalAmount.value]);
}

@end
