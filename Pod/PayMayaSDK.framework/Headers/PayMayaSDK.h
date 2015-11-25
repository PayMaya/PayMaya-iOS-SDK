//
//  PayMayaSDK.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 22/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMSDKAddress.h"
#import "PMSDKBuyerProfile.h"
#import "PMSDKCheckoutInformation.h"
#import "PMSDKCheckoutItem.h"
#import "PMSDKCheckoutResult.h"
#import "PMSDKContact.h"
#import "PMSDKItemAmount.h"
#import "PMSDKItemAmountDetails.h"

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
typedef void(^PayMayaCheckoutResultBlock)(PMSDKCheckoutResult* result);
@protocol PayMayaCheckoutDelegate <NSObject>
- (void)didCheckout:(PMSDKCheckoutResult*)result;
@end

@interface PayMayaSDK : NSObject

@property (nonatomic, readonly) PayMayaEnvironment environment;

#pragma mark - Initializers

/**
PayMaya SDK singleton.
 */
+ (PayMayaSDK *)sharedInstance;

/**
 Method to initailize the PayMaya SDK with the user's credentials and environment.
 Refer to PayMayaEnvironment for the different environment that can be used.
 
 @param clientKey The client key given to you for the specified environment
 @param clientSecret The client secret given to you for the specified environment
 @param environment The environment to be used by the SDK application
 */
- (void)setClientKey:(NSString *)clientKey withSecret:(NSString *)clientSecret forEnvironment:(PayMayaEnvironment)environment;

#pragma mark - Checkout APIs

/**
 This method will present a view controller where the customer can complete the whole checkout process. The delegate method as defined in the PayMayaCheckoutDelegate protocol allows an object to receive callbacks regarding the success or failure of a checkout operation.
 
 @param checkoutInfo The checkout information details to be processed
 @param result The delegate for checkout completion
 */
- (void)checkout:(PMSDKCheckoutInformation*)checkoutInfo delegate:(id<PayMayaCheckoutDelegate>)delegate;

/**
 This method will present a view controller where the customer can complete the whole checkout process. The block will be called upon checkout completion.
 
 @param checkoutInfo The checkout information details to be processed
 @param result A block that will be called upon checkout completion
 */
- (void)checkout:(PMSDKCheckoutInformation*)checkoutInfo result:(PayMayaCheckoutResultBlock)result;

@end
