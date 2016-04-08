//
//  PMDAPIManager.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/02/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMDAPIManager : NSObject

- (instancetype)initWithBaseUrl:(NSString *)baseUrl accessToken:(NSString *)accessToken;

- (void)executePaymentWithPaymentToken:(NSString *)paymentToken
                                paymentInformation:(NSDictionary *)paymentInformation
                                successBlock:(void (^)(id))successBlock
                                   failureBlock:(void (^)(NSError *))failureBlock;

@end
