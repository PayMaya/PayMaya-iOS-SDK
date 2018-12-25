//
//  PMSDKContactTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKContactTest : XCTestCase

@end

@implementation PMSDKContactTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitContact {
    PMSDKContact *contact = [PMSDKContact new];
    XCTAssertNotNil(contact);
    XCTAssertNil(contact.phone);
    XCTAssertNil(contact.email);
}


@end
