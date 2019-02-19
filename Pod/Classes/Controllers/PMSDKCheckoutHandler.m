//
//  PMSDKCheckoutHandler.m
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

#import "PMSDKCheckoutHandler.h"
#import "PMSDKCheckoutViewController.h"
#import "PMSDKConstants.h"

typedef NS_ENUM(NSInteger, PMSDKCheckoutType) {
    PMSDKCheckoutTypeDelegate,
    PMSDKCheckoutTypeBlock
};

@interface PMSDKCheckoutHandler () <PMSDKCheckoutViewControllerDelegate>

@property (nonatomic, strong) PMSDKCheckoutInformation *checkoutInformation;
@property (nonatomic, assign) PMSDKCheckoutType checkoutType;
@property (nonatomic, weak) id <PayMayaCheckoutDelegate> checkoutDelegate;
@property (nonatomic, strong) PayMayaCheckoutResultBlock checkoutBlock;
@property (nonatomic, strong) PMSDKCheckoutResult *checkoutResult;
@property (nonatomic, strong) NSError* checkoutError;

@end

@implementation PMSDKCheckoutHandler

- (instancetype)initWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation delegate:(id <PayMayaCheckoutDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.checkoutInformation = checkoutInformation;
        self.checkoutDelegate = delegate;
        self.checkoutBlock = nil;
        self.checkoutType = PMSDKCheckoutTypeDelegate;
    }
    return self;
}

- (instancetype)initWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation result:(PayMayaCheckoutResultBlock)result
{
    self = [super init];
    if (self) {
        self.checkoutInformation = checkoutInformation;
        self.checkoutDelegate = nil;
        self.checkoutBlock = result;
        self.checkoutType = PMSDKCheckoutTypeBlock;
    }
    return self;
}

- (void)presentCheckoutIn:(UIViewController *)viewController
{
    if (!self.checkoutAPIManager) {
        self.checkoutError = [NSError errorWithDomain:PMSDKCheckoutErrorDomain code:PMSDKCheckoutNotInitializedErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Checkout SDK not initialized."}];
        [self handleCheckoutResult];
        return;
    }
    
    self.checkoutResult = [[PMSDKCheckoutResult alloc] init];
    self.checkoutError = nil;
    PMSDKCheckoutViewController* controller = [[PMSDKCheckoutViewController alloc] initWithCheckoutInformation:self.checkoutInformation];
    controller.checkoutAPIManager = self.checkoutAPIManager;
    controller.checkoutDelegate = self;
    [viewController presentViewController:controller animated:YES completion:nil];
}

#pragma mark - PMSDKCheckoutViewControllerDelegate methods

- (void)checkoutViewController:(PMSDKCheckoutViewController *)checkoutViewController checkoutDidFinishWithResult:(PMSDKCheckoutResult *)result
{
    [checkoutViewController dismissViewControllerAnimated:YES completion:^{
        self.checkoutResult = result;
        [self handleCheckoutResult];
    }];
}

- (void)checkoutViewController:(PMSDKCheckoutViewController *)checkoutViewController checkoutDidFailWithError:(NSError *)error
{
    [checkoutViewController dismissViewControllerAnimated:YES completion:^{
        self.checkoutError = error;
        [self handleCheckoutResult];
    }];
}

- (void)handleCheckoutResult
{
    switch (self.checkoutType) {
        case PMSDKCheckoutTypeBlock: {
            if (self.checkoutBlock) {
                self.checkoutBlock(self.checkoutResult, self.checkoutError);
            }
            break;
        }
        case PMSDKCheckoutTypeDelegate: {
            if (!self.checkoutError) {
                if ([self.checkoutDelegate respondsToSelector:@selector(checkoutDidFinishWithResult:)]) {
                    [self.checkoutDelegate checkoutDidFinishWithResult:self.checkoutResult];
                }
            }
            else {
                if ([self.checkoutDelegate respondsToSelector:@selector(checkoutDidFailWithError:)]) {
                    [self.checkoutDelegate checkoutDidFailWithError:self.checkoutError];
                }
            }
            break;
        }
    }
}

@end
