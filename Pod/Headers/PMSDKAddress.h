//
//  PMSDKAddress.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMSDKAddress : NSObject

/**
 Specifies the primary address line. Required.
 */
@property (nonatomic, strong) NSString *primaryAddressLine;

/**
 Specifies the secondary address line. Optional.
 */
@property (nonatomic, strong) NSString *secondaryAddressLine;

/**
 Specifies the city. Required.
 */
@property (nonatomic, strong) NSString *city;

/**
 Specifies the state or province. Required. 
 */
@property (nonatomic, strong) NSString *state;

/**
 Specifies the postal or zip code. Value should only be numeric. Required.
 */
@property (nonatomic, strong) NSString *zipCode;

/**
 Specifies the country code as defined in the ISO 3166-1 alpha-2 currency code standard (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Value should only be uppercase letters. Maximum of 2 characters. Required.
 */
@property (nonatomic, strong) NSString *countryCode;

@end
