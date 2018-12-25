//
//  PMSDKAddressTest.m
//  PayMayaSDK_Tests
//
//  Created by Julius Lundang on 25/12/2018.
//  Copyright © 2018 PayMaya Philippines, Inc. All rights reserved.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKAddressTest : XCTestCase

@end

@implementation PMSDKAddressTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitAddress {
    PMSDKAddress *address = [[PMSDKAddress alloc] initWithPrimaryAddressLine:@"Flr. Robinsons Summit Center"
                                                                        city:@"Makati"
                                                                       state:@"NCR"
                                                                     zipCode:@"1226"
                                                                 countryCode:@"PH"];
    XCTAssertTrue([@"Flr. Robinsons Summit Center" isEqualToString:address.primaryAddressLine]);
    XCTAssertNil(address.secondaryAddressLine);
    XCTAssertTrue([@"Makati" isEqualToString:address.city]);
    XCTAssertTrue([@"NCR" isEqualToString:address.state]);
    XCTAssertTrue([@"1226" isEqualToString:address.zipCode]);
    XCTAssertTrue([@"PH" isEqualToString:address.countryCode]);
}

- (void)testFailableInitAddress {
    PMSDKAddress *address = [[PMSDKAddress alloc] initWithPrimaryAddressLine:@"Flr. Robinsons Summit Center"
                                                                        city:@"Makati"
                                                                       state:@"NCR"
                                                                     zipCode:@"1226"
                                                                 countryCode:@"Unkown code"];
    XCTAssertNil(address);
}

@end
