//
//  PMSDKAPIManager.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 27/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMSDKCheckoutInformation.h"

@interface PMSDKAPIManager : NSObject

+ (PMSDKAPIManager *)sharedInstance;
- (void)setBaseUrl:(NSString*)baseUrl
         clientKey:(NSString*)clientKey
      clientSecret:(NSString*)clientSecret;

- (void)initiateCheckoutWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation
                                    successBlock:(void (^)(id))successBlock
                                   failureBlock:(void (^)(id))failureBlock;

@end
