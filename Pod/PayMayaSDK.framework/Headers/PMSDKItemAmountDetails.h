//
//  PMSDKItemAmountDetails.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMSDKItemAmountDetails : NSObject

/**
 Discount amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber *discount;

/**
 Service charge amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber *serviceCharge;

/**
 Shipping fee amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber *shippingFee;

/**
 Tax amount for the transaction. Optional.
 */
@property (nonatomic, strong) NSNumber *tax;

/**
 Sum of amounts for all items in the transaction. Optional.
 */
@property (nonatomic, strong) NSNumber *subtotal;

@end
