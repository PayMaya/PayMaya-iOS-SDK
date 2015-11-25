//
//  PMSDKCheckoutInformation.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

@class PMSDKItemAmount;
@class PMSDKBuyerProfile;
@class PMSDKCheckoutRedirectURL;

#import <Foundation/Foundation.h>

@interface PMSDKCheckoutInformation : NSObject

/**
 Total amount details for the transaction. Required.
 */
@property (nonatomic, strong) PMSDKItemAmount *totalAmount;

/**
 Customer profile information. Required.
 */
@property (nonatomic, strong) PMSDKBuyerProfile *buyer;

/**
 List of bought items for the transaction. The array must consist of PMSDKCheckoutItem objects. Required.
 */
@property (nonatomic, strong) NSArray *items;

/**
 A unique identifier to a transaction for tracking purposes. Required.
 */
@property (nonatomic, strong) NSString *requestReferenceNumber;

/**
 List of redirect URLs depending on checkout completion status. Optional.
 */
@property (nonatomic, strong) PMSDKCheckoutRedirectURL *redirectUrl;

/**
 Merchant provided additional cart information. Optional.
 */
@property (nonatomic, strong) NSDictionary *metadata;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
