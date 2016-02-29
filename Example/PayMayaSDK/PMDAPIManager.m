//
//  PMSDKAPIManager.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/02/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMSDKAPIManager.h"

@implementation PMSDKAPIManager

- (void)setBaseUrl:(NSString *)baseUrl
         clientKey:(NSString *)clientKey
      clientSecret:(NSString *)clientSecret
{
    // Set authorization header
    NSData *clientKeySecretData = [[NSString stringWithFormat:@"%@:%@", clientKey, clientSecret] dataUsingEncoding:NSUTF8StringEncoding];
    [clientKeySecretData base64EncodedStringWithOptions:0];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Authorization" : [NSString stringWithFormat:@"Basic %@", [clientKeySecretData base64EncodedStringWithOptions:0]]}];
    
    self.baseUrl = baseUrl;
    self.session = [NSURLSession sessionWithConfiguration:config];
}

- (void)executePaymentWithPaymentToken:(PMSDKPaymentToken *)paymentToken
                           totalAmount:(PMSDKItemAmount *)itemAmount
                          buyerProfile:(PMSDKBuyerProfile *)buyerProfile
                          successBlock:(void (^)(id))successBlock
                          failureBlock:(void (^)(NSError *))failureBlock
{
    NSError *error = nil;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/payments", self.baseUrl]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *postFieldsDictionary = nil;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postFieldsDictionary options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (![responseDictionary isKindOfClass:[NSDictionary class]] || (![responseDictionary objectForKey:@"error"] && ![responseDictionary objectForKey:@"fault"])) {
                successBlock(responseDictionary);
            } else {
                NSError *error = [NSError errorWithDomain:@"com.backend.error.payments" code:0 userInfo:@{NSLocalizedDescriptionKey : [responseDictionary objectForKey:@"error"]}];
                failureBlock(error);
            }
        } else {
            failureBlock(error);
        }
    }];
    
    [postDataTask resume];
}

@end
