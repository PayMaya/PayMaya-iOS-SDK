//
//  PMDAddToCartViewController.h
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMDProduct.h"

@protocol PMDAddToCartViewControllerDelegate;

@interface PMDAddToCartViewController : UIViewController

@property (nonatomic, assign) id <PMDAddToCartViewControllerDelegate> delegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil product:(PMDProduct *)product;

@end

@protocol PMDAddToCartViewControllerDelegate <NSObject>

- (void)addToCartViewController:(PMDAddToCartViewController *)addToCartViewController didAddProductToCart:(PMDProduct *)product quantity:(NSNumber *)quantity;

@end
