//
//  PMSDKItemAmount.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

@class PMSDKItemAmountDetails;

#import <Foundation/Foundation.h>

@interface PMSDKItemAmount : NSObject

/**
 Specifies the currency as defined in the ISO standard currency code (http://en.wikipedia.org/wiki/ISO_4217). Value should only be uppercase letters. Required.
 */
@property (nonatomic, strong) NSString *currency;

/**
 Specifies the price amount. Value should be numeric. Required.
 */
@property (nonatomic, strong) NSNumber *value;

/**
 Specifies the amount breakdown. Optional.
 */
@property (nonatomic, strong) PMSDKItemAmountDetails *details;

@end
