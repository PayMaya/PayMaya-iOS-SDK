//
//  PMDAPIManager.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/02/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDAPIManager.h"

@interface PMDAPIManager ()

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *accessToken;

@end

@implementation PMDAPIManager

- (instancetype)initWithBaseUrl:(NSString *)baseUrl accessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForResource = 30.0f;
        config.timeoutIntervalForRequest = 30.0f;
        
        self.accessToken = accessToken;
        self.baseUrl = baseUrl;
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)getCustomerSuccessBlock:(void (^)(id))successBlock
                   failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customers", self.baseUrl]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                if (![responseDictionary isKindOfClass:[NSDictionary class]] || (![responseDictionary objectForKey:@"error"] && ![responseDictionary objectForKey:@"fault"])) {
                    successBlock(responseDictionary);
                } else {
                    NSDictionary *apiErrorDictionary = [responseDictionary objectForKey:@"error"];
                    NSInteger apiErrorCode = [[apiErrorDictionary objectForKey:@"code"] integerValue];
                    NSString *apiErrorLocalizedDescription = [apiErrorDictionary objectForKey:@"message"];
                    NSError *error = [NSError errorWithDomain:@"com.backend.error.payments" code:apiErrorCode userInfo:@{NSLocalizedDescriptionKey : apiErrorLocalizedDescription, @"PaymentsAPIErrorDictionary" : apiErrorDictionary}];
                    failureBlock(error);
                }
            } else {
                NSString *apiErrorLocalizedDescription = [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode];
                NSError *error = [NSError errorWithDomain:@"com.backend.error.payments" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey : apiErrorLocalizedDescription}];
                failureBlock(error);
            }
        } else {
            failureBlock(error);
        }
    }];
    
    [postDataTask resume];
}

- (void)executePaymentWithPaymentToken:(NSString *)paymentToken
                           paymentInformation:(NSDictionary *)paymentInformation
                          successBlock:(void (^)(id))successBlock
                          failureBlock:(void (^)(NSError *))failureBlock
{
    NSError *error = nil;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/payments", self.baseUrl]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *postFieldsDictionary = @{
                                          @"paymentToken" : paymentToken,
                                          @"totalAmount" : paymentInformation[@"totalAmount"],
                                          @"buyer" : paymentInformation[@"buyer"]
                                          };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postFieldsDictionary options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                if (![responseDictionary isKindOfClass:[NSDictionary class]] || (![responseDictionary objectForKey:@"error"] && ![responseDictionary objectForKey:@"fault"])) {
                    successBlock(responseDictionary);
                } else {
                    NSDictionary *apiErrorDictionary = [responseDictionary objectForKey:@"error"];
                    NSInteger apiErrorCode = [[apiErrorDictionary objectForKey:@"code"] integerValue];
                    NSString *apiErrorLocalizedDescription = [apiErrorDictionary objectForKey:@"message"];
                    NSError *error = [NSError errorWithDomain:@"com.backend.error.payments" code:apiErrorCode userInfo:@{NSLocalizedDescriptionKey : apiErrorLocalizedDescription,
                            @"PaymentsAPIErrorDictionary" : apiErrorDictionary}];
                    failureBlock(error);
                }
            } else {
                NSString *apiErrorLocalizedDescription = [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode];
                NSError *error = [NSError errorWithDomain:@"com.backend.error.payments" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey : apiErrorLocalizedDescription}];
                failureBlock(error);
            }
        } else {
            failureBlock(error);
        }
    }];
    
    [postDataTask resume];
}

@end
