//
//  PMDVerifyCardViewController.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMDVerifyCardViewController : UIViewController

- (instancetype)initWithCheckoutURL:(NSString *)checkoutURL redirectUrl:(NSString *)redirectURL;

@end
