//
//  PMSDKUtilities.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 02/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayMayaSDK.h"

@interface PMSDKUtilities : NSObject

+ (NSNumberFormatter *)currencyFormatter;
+ (NSDictionary *)dictionaryFromQueryString:(NSString *)queryString;
+ (NSString *)queryStringFromDictionary:(NSDictionary*)dictionary;
+ (NSString *)baseURLForEnvironment:(PayMayaEnvironment)environment;
+ (NSString*)checkoutResultUrl;
+ (NSString*)checkoutResultRedirectUrl;

@end
