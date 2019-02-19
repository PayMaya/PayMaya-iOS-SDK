//
//  PMSDKCardTest.m
//  PayMayaSDK-Unit-Tests
//
//  Created by Julius Lundang on 25/12/2018.
//

@import XCTest;
@import PayMayaSDK;

@interface PMSDKCardTest : XCTestCase

@end

@implementation PMSDKCardTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInitCard{
    PMSDKCard *card = [[PMSDKCard alloc]
                       initWithCardNumber:@"5453010000064154"
                       expiryMonth:ExpiryMonthJuly
                       expiryYear:2022
                       cvc:@"111"];
    XCTAssertTrue([@"5453010000064154" isEqualToString:card.number]);
    XCTAssertTrue([@"07" isEqualToString:card.expiryMonth]);
    XCTAssertTrue([@"2022" isEqualToString:card.expiryYear]);
    XCTAssertTrue([@"111" isEqualToString:card.cvc]);
}

- (void)testStringInitCard {
    PMSDKCard *card = [[PMSDKCard alloc]
                       initWithStringCardNumber:@"5453010000064154"
                       expiryMonth:@"07"
                       expiryYear:@"2022"
                       cvc:@"111"];
    XCTAssertTrue([@"5453010000064154" isEqualToString:card.number]);
    XCTAssertTrue([@"07" isEqualToString:card.expiryMonth]);
    XCTAssertTrue([@"2022" isEqualToString:card.expiryYear]);
    XCTAssertTrue([@"111" isEqualToString:card.cvc]);
}

@end
