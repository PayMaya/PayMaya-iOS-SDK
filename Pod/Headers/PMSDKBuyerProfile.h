//
//  PMSDKBuyerProfile.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMSDKAddress;
@class PMSDKContact;

@interface PMSDKBuyerProfile : NSObject

/**
 Specifies the buyer's first name. Required.
 */
@property (nonatomic, strong) NSString *firstName;

/**
 Specifies the buyer's middle name. Optional.
 */
@property (nonatomic, strong) NSString *middleName;

/**
 Specifies the buyer's last name. Required.
 */
@property (nonatomic, strong) NSString *lastName;

/**
 List of buyer's contact information. The array must consist of PMSDKContact objects. Optional.
 */
@property (nonatomic, strong) PMSDKContact *contacts;

/**
 Shipping address to be used for the transaction. Optional.
 */
@property (nonatomic, strong) PMSDKAddress *shippingAddress;

/**
 Billing address to be used for the transaction. Optional.
 */
@property (nonatomic, strong) PMSDKAddress *billingAddress;

@end
