//
//  PayMayaSDK.m
//  PayMayaSDK
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

#import "PayMayaSDK.h"
#import "PMSDKUtilities.h"
#import "PMSDKCheckoutAPIManager.h"
#import "PMSDKPaymentsAPIManager.h"
#import "PMSDKCheckoutHandler.h"
#import "PMSDKConstants.h"
#import "NSObject+KVCParsing.h"

@interface PayMayaSDK ()

@property (nonatomic, readwrite) PayMayaEnvironment environment;
@property (nonatomic, strong) PMSDKCheckoutAPIManager* checkoutAPIManager;
@property (nonatomic, strong) PMSDKPaymentsAPIManager* paymentsAPIManager;
@property (nonatomic, strong) PMSDKCheckoutHandler *checkoutHandler;

@end

@implementation PayMayaSDK

#pragma mark - Initializers
+ (PayMayaSDK *)sharedInstance
{
    static dispatch_once_t onceToken;
    static PayMayaSDK *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[PayMayaSDK alloc] init];
    });
    return _instance;
}

- (void)setCheckoutAPIKey:(NSString *)apiKey forEnvironment:(PayMayaEnvironment)environment
{
    if (!self.checkoutAPIManager) {
        self.environment = environment;
        self.checkoutAPIManager = [[PMSDKCheckoutAPIManager alloc] init];
        [self.checkoutAPIManager setBaseUrl:[PMSDKUtilities checkoutBaseURLForEnvironment:environment]
                          clientKey:apiKey
                       clientSecret:@""];
    }
}

- (void)setPaymentsAPIKey:(NSString *)apiKey forEnvironment:(PayMayaEnvironment)environment
{
    if (!self.paymentsAPIManager) {
        self.environment = environment;
        self.paymentsAPIManager = [[PMSDKPaymentsAPIManager alloc] init];
        [self.paymentsAPIManager setBaseUrl:[PMSDKUtilities paymentsBaseURLForEnvironment:environment]
                          clientKey:apiKey
                       clientSecret:@""];
    }
}

#pragma mark - Checkout APIs
- (void)checkout:(PMSDKCheckoutInformation *)checkoutInfo delegate:(id <PayMayaCheckoutDelegate>)delegate
{
    self.checkoutHandler = [[PMSDKCheckoutHandler alloc] initWithCheckoutInformation:checkoutInfo delegate:delegate];
    self.checkoutHandler.checkoutAPIManager = self.checkoutAPIManager;
    [self.checkoutHandler presentCheckoutViewController];
}

- (void)checkout:(PMSDKCheckoutInformation *)checkoutInfo result:(PayMayaCheckoutResultBlock)result
{
    self.checkoutHandler = [[PMSDKCheckoutHandler alloc] initWithCheckoutInformation:checkoutInfo result:result];
    self.checkoutHandler.checkoutAPIManager = self.checkoutAPIManager;
    [self.checkoutHandler presentCheckoutViewController];
}

#pragma mark - Payments APIs

- (void)createPaymentTokenFromCard:(PMSDKCard *)card delegate:(id <PayMayaPaymentsDelegate>)delegate
{
    NSError *paymentTokenError;
    if (!self.paymentsAPIManager) {
        paymentTokenError = [NSError errorWithDomain:PMSDKPaymentsErrorDomain code:PMSDKPaymentsNotInitializedErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Payments SDK not initialized."}];
        if ([delegate respondsToSelector:@selector(createPaymentTokenDidFailWithError:)]) {
            [delegate createPaymentTokenDidFailWithError:paymentTokenError];
        }
        return;
    }
    
    [self.paymentsAPIManager createPaymentTokenFromCard:card successBlock:^(id responseDictionary) {
        if ([delegate respondsToSelector:@selector(createPaymentTokenDidFinishWithResult:)]) {
            [delegate createPaymentTokenDidFinishWithResult:[self paymentTokenResultFromResponseDictionary:responseDictionary]];
        }
    } failureBlock:^(NSError* error) {
        if ([delegate respondsToSelector:@selector(createPaymentTokenDidFailWithError:)]) {
            [delegate createPaymentTokenDidFailWithError:error];
        }
    }];
}

- (void)createPaymentTokenFromCard:(PMSDKCard *)card result:(PayMayaPaymentTokenResultBlock)result
{
    NSError *paymentTokenError;
    if (!self.paymentsAPIManager) {
        paymentTokenError = [NSError errorWithDomain:PMSDKPaymentsErrorDomain code:PMSDKPaymentsNotInitializedErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Payments SDK not initialized."}];
        if (result) {
            result(nil, paymentTokenError);
        }
        return;
    }
    
    [self.paymentsAPIManager createPaymentTokenFromCard:card successBlock:^(id responseDictionary) {
        if (result) {
            result([self paymentTokenResultFromResponseDictionary:responseDictionary], nil);
        }
    } failureBlock:^(NSError *error) {
        if (result) {
            result(nil, error);
        }
    }];
}

- (PMSDKPaymentTokenResult *)paymentTokenResultFromResponseDictionary:(NSDictionary *)responseDictionary
{
    PMSDKPaymentToken *paymentToken = [[PMSDKPaymentToken alloc] init];
    [paymentToken parseValuesForKeysWithDictionary:responseDictionary];
    PMSDKPaymentTokenResult *paymentTokenResult = [[PMSDKPaymentTokenResult alloc] init];
    if ([paymentToken.state isEqualToString:@"created"]) {
        paymentTokenResult.status = PMSDKPaymentTokenStatusCreated;
    }
    else if ([paymentToken.state isEqualToString:@"used"]) {
        paymentTokenResult.status = PMSDKPaymentTokenStatusUsed;
    }
    paymentTokenResult.paymentToken = paymentToken;
    return paymentTokenResult;
}

@end
