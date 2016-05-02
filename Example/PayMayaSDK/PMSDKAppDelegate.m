//
//  PMSDKAppDelegate.m
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

#import "PMSDKAppDelegate.h"
#import <PayMayaSDK/PayMayaSDK.h>
#import "PMDShopViewController.h"
#import "PMDCardVaultViewController.h"
#import "PMDAPIManager.h"

@implementation PMSDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Setup PayMaya SDK
    [[PayMayaSDK sharedInstance] setCheckoutAPIKey:@"pk-iaioBC2pbY6d3BVRSebsJxghSHeJDW4n6navI7tYdrN" forEnvironment:PayMayaEnvironmentSandbox
     ];
    [[PayMayaSDK sharedInstance] setPaymentsAPIKey:@"pk-N6TvoB4GP2kIgNz4OCchCTKYvY5kPQd2HDRSg8rPeQG" forEnvironment:PayMayaEnvironmentSandbox];

    PMDAPIManager *apiManager = [[PMDAPIManager alloc] initWithBaseUrl:@"http://52.77.55.105" accessToken:@"3BI4dTaewiyfJGcc9Fzg+r2MM1qSc80LcRqxVpZTIoaRb2uIQ1SSRtfQWEsHeJud"];
    
    // Get customer ID
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"PayMayaSDKCustomerID"]) {
        [apiManager getCustomerSuccessBlock:^(id response) {
            [[NSUserDefaults standardUserDefaults] setObject:response[@"id"] forKey:@"PayMayaSDKCustomerID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } failureBlock:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    
    // Setup view controllers
    PMDShopViewController *shopViewController = [[PMDShopViewController alloc] initWithNibName:nil bundle:nil];
    shopViewController.title = @"Shop";
    shopViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Shop" image:[UIImage imageNamed:@"shop"] selectedImage:[UIImage imageNamed:@"shop-active"]];
    shopViewController.apiManager = apiManager;
    UINavigationController *shopNavigationController = [[UINavigationController alloc] initWithRootViewController:shopViewController];
    
    PMDCardVaultViewController *cardVaultViewController = [[PMDCardVaultViewController alloc] initWithNibName:nil bundle:nil];
    cardVaultViewController.title = @"Cards";
    cardVaultViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Cards" image:[UIImage imageNamed:@"vault"] selectedImage:[UIImage imageNamed:@"vault-active"]];
    cardVaultViewController.apiManager = apiManager;
    UINavigationController *cardVaultNavigationController = [[UINavigationController alloc] initWithRootViewController:cardVaultViewController];
     
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    [tabBarController.tabBar setTranslucent:NO];
    tabBarController.viewControllers = @[shopNavigationController, cardVaultNavigationController];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
