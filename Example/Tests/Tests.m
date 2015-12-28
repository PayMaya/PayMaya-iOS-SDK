//
//  PayMayaSDKTests.m
//  PayMayaSDKTests
//
//  Created by Patrick Medina on 10/29/2015.
//  Copyright (c) 2015 Patrick Medina. All rights reserved.
//

@import XCTest;

#import "PMSDKCheckoutAPIManager.h"
#import "PMSDKUtilities.h"

@interface Tests : XCTestCase

@property (nonatomic, strong) PMSDKCheckoutAPIManager *checkoutAPIManager;

@end

@implementation Tests

NSInteger const kTimeoutInterval = 30;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.checkoutAPIManager = [[PMSDKCheckoutAPIManager alloc] init];
    [self.checkoutAPIManager setBaseUrl:[PMSDKUtilities checkoutBaseURLForEnvironment:PayMayaEnvironmentDebug]
                      clientKey:@"pk-Vcbn4FBDmR7CXiBD4SfVnftbgHUG40AM4AqRlOBwRze"
                   clientSecret:@""];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckout
{
    NSLog(@"*** TEST START: Checkout ***");
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"testCheckout"];
    
    NSDictionary *totalAmount = @{
                                  @"currency" : @"PHP",
                                  @"value" : @"69.00",
                                  @"details" : @{
                                          @"shippingFee" : @"5.00",
                                          @"tax" : @"5.00",
                                          @"subtotal" : @"59.00"
                                          }
                                  };
    
    NSDictionary *address = @{
                              @"line1" : @"12/F Anson's Building",
                              @"line2" : @"ADB Avenue, Ortigas",
                              @"city" : @"Pasig",
                              @"state" : @"Metro Manila",
                              @"zipCode" : @"1600",
                              @"countryCode" : @"PH"
                              };
    
    NSDictionary *buyer = @{
                            @"firstName" : @"Elijah Joshua",
                            @"middleName" : @"Barboza",
                            @"lastName" : @"Cayabyab",
                            @"contact" : @{
                                    @"phone" : @"+6398284457524",
                                    @"email" : @"ebcayabyab01@gmail.com"
                                    },
                            @"shippingAddress" : address,
                            @"billingAddress" : address
                            };
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSDictionary *item = @{
                           @"name" : @"Bag",
                           @"code" : @"pmd_bag",
                           @"description" : @"leather bag",
                           @"quantity" : @"2",
                           @"amount" : @{
                                   @"value" : @"29.50"
                                   },
                           @"totalAmount" : @{
                                   @"value" : @"59.00"
                                   }
                           };
    [items addObject:item];
    
    NSDictionary *checkoutDictionary = @{
                                         @"totalAmount" : totalAmount,
                                         @"buyer" : buyer,
                                         @"items" : items,
                                         @"requestReferenceNumber" : @"123456789"
                                         };
    
    PMSDKCheckoutInformation *checkoutInformation = [[PMSDKCheckoutInformation alloc] initWithDictionary:checkoutDictionary];
    
    [self.checkoutAPIManager initiateCheckoutWithCheckoutInformation:checkoutInformation successBlock:^(id response) {
        NSLog(@"Success, response is %@", response);
        [completionExpectation fulfill];
    } failureBlock:^(id error) {
        NSLog(@"Error %@", error);
        XCTFail(@"Fail execute checkout");
        [completionExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeoutInterval handler:nil];
    NSLog(@"### TEST END: Checkout ###");
}

@end

