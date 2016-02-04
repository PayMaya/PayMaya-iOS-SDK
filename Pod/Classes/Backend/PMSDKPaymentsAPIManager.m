//
//  PMSDKPaymentsAPIManager.m
//  Pods
//
//  Copyright (c) 2016 PayMaya Philippines, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PMSDKPaymentsAPIManager.h"
#import "NSObject+KVCParsing.h"
#import "PMSDKConstants.h"

@implementation PMSDKPaymentsAPIManager

- (void)createPaymentTokenFromCard:(PMSDKCard *)card
                      successBlock:(void (^)(id))successBlock
                      failureBlock:(void (^)(NSError *))failureBlock
{
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/payment-tokens", self.baseUrl]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[card idempotentKey] forHTTPHeaderField:@"Idempotent-Token"];
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *postFieldsDictionary = [[NSMutableDictionary alloc] init];
    [postFieldsDictionary setObject:[card propertiesDictionary] forKey:@"card"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postFieldsDictionary options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (![responseDictionary isKindOfClass:[NSDictionary class]] || (![responseDictionary objectForKey:@"error"] && ![responseDictionary objectForKey:@"fault"])) {
                successBlock(responseDictionary);
            } else {
                NSError *apiError = nil;
                if ([[responseDictionary objectForKey:@"error"] isKindOfClass:[NSString class]]) {
                    apiError = [NSError errorWithDomain:PMSDKPaymentsErrorDomain code:PMSDKPaymentsAPIErrorCode userInfo:@{NSLocalizedDescriptionKey : [responseDictionary objectForKey:@"error"]}];
                }
                else {
                    NSDictionary *apiErrorDictionary = [responseDictionary objectForKey:@"error"];
                    NSInteger apiErrorCode = [[apiErrorDictionary objectForKey:@"code"] integerValue];
                    NSString *apiErrorLocalizedDescription = [apiErrorDictionary objectForKey:@"message"];
                    apiError = [NSError errorWithDomain:PMSDKPaymentsErrorDomain code:apiErrorCode userInfo:@{NSLocalizedDescriptionKey : apiErrorLocalizedDescription}];
                }
                NSError *customError = [NSError errorWithDomain:PMSDKPaymentsErrorDomain code:PMSDKPaymentsAPIErrorCode userInfo:@{NSUnderlyingErrorKey: apiError}];
                failureBlock(customError);
            }
        } else {
            NSInteger code = 0;
            if ([error.domain isEqualToString:NSURLErrorDomain]) {
                code = PMSDKNetworkErrorCode;
            }
            NSError *customError = [NSError errorWithDomain:PMSDKErrorDomain code:code userInfo:@{NSUnderlyingErrorKey: error}];
            failureBlock(customError);
        }
    }];
    
    [postDataTask resume];
}

@end
