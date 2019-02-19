//
//  PMSDKBuyerProfileTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKBuyerProfileTest : XCTestCase

@end

@implementation PMSDKBuyerProfileTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitBuyerProfile {
    PMSDKBuyerProfile *buyerProfile = [[PMSDKBuyerProfile alloc] initWithFirstName:@"Juan"
                                                                          lastName:@"Dela Cruz"];
    XCTAssertTrue([@"Juan" isEqualToString:buyerProfile.firstName]);
    XCTAssertNil(buyerProfile.middleName);
    XCTAssertTrue([@"Dela Cruz" isEqualToString:buyerProfile.lastName]);
    XCTAssertNil(buyerProfile.contact);
    XCTAssertNil(buyerProfile.shippingAddress);
    XCTAssertNil(buyerProfile.billingAddress);
}

@end
