//
//  PMSDKCheckoutViewController.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayMayaSDK.h"
#import "PMSDKCheckoutResult.h"

@class PMSDKCheckoutViewController;
@class PMSDKCheckoutInformation;

@interface PMSDKCheckoutViewController : UINavigationController

- (instancetype)initWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation delegate:(id <PayMayaCheckoutDelegate>)delegate;
- (instancetype)initWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation result:(PayMayaCheckoutResultBlock)result;

@property (nonatomic, strong, readonly) NSString* checkoutId;

@end
