//
//  PMSDKAppDelegate.m
//  PayMayaSDK
//
//  Created by Patrick Medina on 10/29/2015.
//  Copyright (c) 2015 Patrick Medina. All rights reserved.
//

#import "PMSDKAppDelegate.h"
#import <PayMayaSDK/PayMayaSDK.h>
#import "PMDShopViewController.h"
#import "PMDCardInputViewController.h"

@implementation PMSDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Setup PayMaya SDK
    [[PayMayaSDK sharedInstance] setCheckoutAPIKey:@"pk-Vcbn4FBDmR7CXiBD4SfVnftbgHUG40AM4AqRlOBwRze" forEnvironment:PayMayaEnvironmentDebug
     ];
    [[PayMayaSDK sharedInstance] setPaymentsAPIKey:@"pk-SjRNZLyr9OmovoHs2dXZ6obTxQ39YsPyc3f7oyrtNCX" forEnvironment:PayMayaEnvironmentDebug];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController *)tabBarController
{
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    [tabBarController setViewControllers:@[[self checkoutNavigationController], [self paymentsNavigationController]] animated:NO];
    return tabBarController;
}

- (UINavigationController *)checkoutNavigationController
{
    PMDShopViewController *shopViewController = [[PMDShopViewController alloc] initWithNibName:nil bundle:nil];
    shopViewController.title = @"Checkout SDK Demo";
    shopViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Checkout" image:[[UIImage imageNamed:@"checkout"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"checkout-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return [[UINavigationController alloc] initWithRootViewController:shopViewController];
}

- (UINavigationController *)paymentsNavigationController
{
    PMDCardInputViewController *cardInputViewController = [[PMDCardInputViewController alloc] initWithNibName:nil bundle:nil];
    cardInputViewController.title = @"Payments SDK Demo";
    cardInputViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Payments" image:[[UIImage imageNamed:@"payments"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"payments-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return [[UINavigationController alloc] initWithRootViewController:cardInputViewController];
}

@end
