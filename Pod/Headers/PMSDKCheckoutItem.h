//
//  PMSDKCheckoutItem.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMSDKItemAmount;

@interface PMSDKCheckoutItem : NSObject

/**
Specifies the item name. Required.
 */
@property (nonatomic, strong) NSString *name;

/**
 Specifies the merchant assigned SKU code. Optional.
 */
@property (nonatomic, strong) NSString *code;

/**
 Specifies the item description. Optional.
 */
@property (nonatomic, strong) NSString *itemDescription;

/**
 Specifies the number of bought items. Value should only be numeric. Required.
 */
@property (nonatomic, strong) NSNumber *quantity;

/**
 Specifies the price amount per item. Optional.
 */
@property (nonatomic, strong) PMSDKItemAmount *amount;

/**
 Specifies the total price amount for all the bought items. Required.
 */
@property (nonatomic, strong) PMSDKItemAmount *totalAmount;

@end
