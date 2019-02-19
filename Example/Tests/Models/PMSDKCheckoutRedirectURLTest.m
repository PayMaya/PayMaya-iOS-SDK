//
//  PMSDKCheckoutRedirectURLTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKCheckoutRedirectURLTest : XCTestCase

@end

@implementation PMSDKCheckoutRedirectURLTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitCheckoutRedirectURL {
    PMSDKCheckoutRedirectURL *checkoutRedirect = [PMSDKCheckoutRedirectURL new];
    XCTAssertNotNil(checkoutRedirect);
    XCTAssertNil(checkoutRedirect.successRedirectURL);
    XCTAssertNil(checkoutRedirect.failureRedirectURL);
    XCTAssertNil(checkoutRedirect.cancelRedirectURL);
}

@end
