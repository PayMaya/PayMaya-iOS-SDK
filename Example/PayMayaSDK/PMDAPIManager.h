//
//  PMSDKAPIManager.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/02/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMSDKPaymentToken.h"
#import "PMSDKItemAmount.h"
#import "PMSDKBuyerProfile.h"

@interface PMSDKAPIManager : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSURLSession *session;

- (void)setBaseUrl:(NSString *)baseUrl
         clientKey:(NSString *)clientKey
      clientSecret:(NSString *)clientSecret;

- (void)executePaymentWithPaymentToken:(PMSDKPaymentToken *)paymentToken
                                    totalAmount:(PMSDKItemAmount *)itemAmount
                                    buyerProfile:(PMSDKBuyerProfile *)buyerProfile
                                successBlock:(void (^)(id))successBlock
                                   failureBlock:(void (^)(NSError *))failureBlock;

@end
