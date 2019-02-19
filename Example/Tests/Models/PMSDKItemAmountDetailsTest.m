//
//  PMSDKItemAmountDetailsTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKItemAmountDetailsTest : XCTestCase

@end

@implementation PMSDKItemAmountDetailsTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitItemAmountDetails {
    PMSDKItemAmountDetails *amountDetails = [PMSDKItemAmountDetails new];
    XCTAssertNotNil(amountDetails);
    XCTAssertNil(amountDetails.discount);
    XCTAssertNil(amountDetails.serviceCharge);
    XCTAssertNil(amountDetails.shippingFee);
    XCTAssertNil(amountDetails.tax);
    XCTAssertNil(amountDetails.subtotal);
}

@end
