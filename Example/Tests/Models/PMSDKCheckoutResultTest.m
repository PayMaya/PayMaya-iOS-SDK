//
//  PMSDKCheckoutResultTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKCheckoutResultTest : XCTestCase

@end

@implementation PMSDKCheckoutResultTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitCheckoutResult {
    PMSDKCheckoutResult *checkoutResult = [PMSDKCheckoutResult new];
    XCTAssertTrue(checkoutResult.status == PMSDKCheckoutStatusUnknown);
    XCTAssertNil(checkoutResult.checkoutId);
    
    PMSDKCheckoutResult *checkoutResult2 = [[PMSDKCheckoutResult alloc] initWithStatus:PMSDKCheckoutStatusSuccess
                                                                            checkoutId:@"12071001212678418"];
    XCTAssertTrue(checkoutResult2.status == PMSDKCheckoutStatusSuccess);
    XCTAssertTrue([@"12071001212678418" isEqualToString:checkoutResult2.checkoutId]);
}

@end
