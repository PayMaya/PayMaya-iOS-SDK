//
//  PayMayaSDK.h
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

#import <Foundation/Foundation.h>
#import "PMSDKAddress.h"
#import "PMSDKBuyerProfile.h"
#import "PMSDKCard.h"
#import "PMSDKCheckoutInformation.h"
#import "PMSDKCheckoutItem.h"
#import "PMSDKCheckoutResult.h"
#import "PMSDKContact.h"
#import "PMSDKItemAmount.h"
#import "PMSDKItemAmountDetails.h"
#import "PMSDKPaymentTokenResult.h"

typedef NS_ENUM(NSInteger, PayMayaEnvironment) {
#if DEBUG
    PayMayaEnvironmentDebug,
    PayMayaEnvironmentTest,
    PayMayaEnvironmentStaging,
#endif
    /**
     Sandbox: Uses sandbox environment for all transactions. Useful for testing.
     */
    PayMayaEnvironmentSandbox,
    /**
     Production. Uses live environment for all transactions. This environment must be used for App Store submissions.
     */
    PayMayaEnvironmentProduction
};

#pragma mark - Checkout
typedef void(^PayMayaCheckoutResultBlock)(PMSDKCheckoutResult *result, NSError *error);
@protocol PayMayaCheckoutDelegate <NSObject>
/**
 Delegate method called upon successful checkout. Checkout is considered successful when it has a valid completion status (i.e success, failed, canceled)
 
 @param result The checkout completion object containing status and checkout id
 */
- (void)checkoutDidFinishWithResult:(PMSDKCheckoutResult *)result;

/**
 Delegate method called upon failed checkout. Checkout is considered failed when it encouters an error before reaching a valid status.
 
 @param error Checkout error details
 */
- (void)checkoutDidFailWithError:(NSError *)error;
@end

#pragma mark - Payments
typedef void(^PayMayaPaymentTokenResultBlock)(PMSDKPaymentTokenResult *result, NSError *error);
@protocol PayMayaPaymentsDelegate <NSObject>
/**
 Delegate method called upon successful payment token creation. Payment token creation is considered successful when it has a valid completion status (i.e created, used)
 
 @param result The payment token creation completion object containing status and token details
 */
- (void)createPaymentTokenDidFinishWithResult:(PMSDKPaymentTokenResult *)result;

/**
 Delegate method called upon failed payment token creation. Payment token creation is considered failed when it encouters an error before reaching a valid status.
 
 @param error Payment token creation error details
 */
- (void)createPaymentTokenDidFailWithError:(NSError *)error;
@end

@interface PayMayaSDK : NSObject

@property (nonatomic, readonly) PayMayaEnvironment environment;

#pragma mark - Initializers

/**
PayMaya SDK singleton.
 */
+ (PayMayaSDK *)sharedInstance;

/**
 Method to initialize the PayMaya Checkout SDK with the user's API key and environment.
 Refer to PayMayaEnvironment for the different environments that can be used.
 
 @param apiKey The public-facing API key given to you for the specified environment
 @param environment The environment to be used by the Checkout SDK application
 */
- (void)setCheckoutAPIKey:(NSString *)apiKey forEnvironment:(PayMayaEnvironment)environment;

/**
 Method to initialize the PayMaya Payments SDK with the user's API key and environment.
 Refer to PayMayaEnvironment for the different environments that can be used.
 
 @param apiKey The public-facing API key given to you for the specified environment
 @param environment The environment to be used by the Payments SDK application
 */
- (void)setPaymentsAPIKey:(NSString *)apiKey forEnvironment:(PayMayaEnvironment)environment;

#pragma mark - Checkout APIs

/**
 This method will present a view controller where the customer can complete the whole checkout process. The delegate methods as defined in the PayMayaCheckoutDelegate protocol allows an object to receive information regarding the success or failure of a checkout transaction.
 
 @param viewController UIViewContoller where PMSDKCheckoutViewController will be presented
 @param checkoutInfo The checkout information details to be processed
 @param delegate The delegate for checkout completion
 */
- (void)presentCheckoutIn:(UIViewController *)viewController
             checkoutInfo:(PMSDKCheckoutInformation *)checkoutInfo
                 delegate:(id <PayMayaCheckoutDelegate>)delegate;

/**
 This method will present a view controller where the customer can complete the whole checkout process. The completion block will be called upon checkout completion.
 
 @param viewController UIViewContoller where PMSDKCheckoutViewController will be presented
 @param checkoutInfo The checkout information details to be processed
 @param result A block that will be called upon checkout completion
 */
- (void)presentCheckoutIn:(UIViewController *)viewController
             checkoutInfo:(PMSDKCheckoutInformation *)checkoutInfo
                   result:(PayMayaCheckoutResultBlock)result;

#pragma mark - Payments APIs

/**
 This method allows you to generate a payment token given a customer's credit card information. This payment token should then be passed to your servers for payment execution. The delegate methods as defined in the PayMayaPaymentsDelegate protocol allows an object to receive information regarding the success or failure of payment token generation.
 
 @param card Customer's card information (i.e. card number, expiry month, expiry year, cvv)
 @param delegate The delegate for payment token generation completion
 */
- (void)createPaymentTokenFromCard:(PMSDKCard *)card delegate:(id <PayMayaPaymentsDelegate>)delegate;

/**
 This method allows you to generate a payment token given a customer's credit card information. This payment token should then be passed to your servers for payment execution. The completion block will be called upon payment token generation completion.
 
 @param card Customer's card information (i.e. card number, expiry month, expiry year, cvv)
 @param result A block that will be called upon payment token generation completion
 */
- (void)createPaymentTokenFromCard:(PMSDKCard *)card result:(PayMayaPaymentTokenResultBlock)result;

@end
