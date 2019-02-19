//
//  PMSDKCheckoutInformationTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKCheckoutInformationTest : XCTestCase

@end

@implementation PMSDKCheckoutInformationTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitCheckoutInformation {
    PMSDKItemAmount *totalAmount = [[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(2800.50)];
    PMSDKBuyerProfile *buyer = [[PMSDKBuyerProfile alloc] initWithFirstName:@"Juan" lastName:@"Dela Cruz"];
    NSArray<PMSDKCheckoutItem *> *items = @[
                                           [[PMSDKCheckoutItem alloc] initWithName:@"Love Marie"
                                           quantity:@(1)
                                           totalAmount:[[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(2800.50)]]
                                     ];
    PMSDKCheckoutInformation *checkoutInfo = [[PMSDKCheckoutInformation alloc]
                                              initWithTotalAmount:totalAmount
                                              buyer:buyer
                                              items:items
                                              requestReferenceNumber:@"12071001212678418"];
    XCTAssertTrue([@"PHP" isEqualToString:checkoutInfo.totalAmount.currency]);
    XCTAssertTrue([@(2800.50) isEqualToNumber:checkoutInfo.totalAmount.value]);
    XCTAssertTrue([@"Juan" isEqualToString:checkoutInfo.buyer.firstName]);
    XCTAssertTrue([@"Dela Cruz" isEqualToString:checkoutInfo.buyer.lastName]);
    XCTAssertTrue(1 == checkoutInfo.items.count);
    XCTAssertTrue([@"12071001212678418" isEqualToString:checkoutInfo.requestReferenceNumber]);
}

- (void)testFailableInitCheckoutInformation {
    PMSDKItemAmount *totalAmount1 = [[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(-2800.50)];
    PMSDKBuyerProfile *buyer = [[PMSDKBuyerProfile alloc] initWithFirstName:@"Juan" lastName:@"Dela Cruz"];
    NSArray<PMSDKCheckoutItem *> *items = @[
                                            [[PMSDKCheckoutItem alloc] initWithName:@"Love Marie"
                                                                           quantity:@(1)
                                                                        totalAmount:[[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(2800.50)]]
                                            ];
    PMSDKCheckoutInformation *checkoutInfoFailed1 = [[PMSDKCheckoutInformation alloc]
                                                     initWithTotalAmount:totalAmount1
                                                     buyer:buyer
                                                     items:items
                                                     requestReferenceNumber:@"12071001212678418"];
    XCTAssertNil(checkoutInfoFailed1);
    PMSDKItemAmount *totalAmount2 = [[PMSDKItemAmount alloc] initWithCurrency:@"PHP" value:@(2800.50)];
    PMSDKCheckoutInformation *checkoutInfoFailed2 = [[PMSDKCheckoutInformation alloc]
                                                     initWithTotalAmount:totalAmount2
                                                     buyer:buyer
                                                     items:@[]
                                                     requestReferenceNumber:@"12071001212678418"];
    XCTAssertNil(checkoutInfoFailed2);
    PMSDKCheckoutInformation *checkoutInfoFailed3 = [[PMSDKCheckoutInformation alloc]
                                                     initWithTotalAmount:totalAmount2
                                                     buyer:buyer
                                                     items:nil
                                                     requestReferenceNumber:@"12071001212678418"];
    XCTAssertNil(checkoutInfoFailed3);
    
}

@end
