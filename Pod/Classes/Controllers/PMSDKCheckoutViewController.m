//
//  PMSDKCheckoutViewController.m
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

#import "PMSDKCheckoutViewController.h"
#import "PMSDKCheckoutInformation.h"
#import "PMSDKCheckoutAPIManager.h"
#import "PMSDKLoadingView.h"
#import "PayMayaSDK.h"
#import "PMSDKUtilities.h"

static NSString *checkoutPaymentSuccess = @"PAYMENT_SUCCESS";
static NSString *checkoutPaymentFailure = @"PAYMENT_FAILURE";

typedef NS_ENUM(NSInteger, PMSDKCheckoutType) {
    PMSDKCheckoutTypeDelegate,
    PMSDKCheckoutTypeBlock
};

@interface PMSDKCheckoutViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIViewController *checkoutWebViewController;
@property (nonatomic, strong) UIWebView *checkoutWebView;
@property (nonatomic, strong) PMSDKLoadingView *checkoutLoadingView;
@property (nonatomic, strong) PMSDKCheckoutInformation *checkoutInformation;
@property (nonatomic, strong) PMSDKCheckoutResult *checkoutResult;
@property (nonatomic, strong, readwrite) NSString* checkoutId;
@property (nonatomic, strong) NSError* checkoutError;
@property (nonatomic) BOOL resultDisplayed;

- (PayMayaEnvironment)statusForPage:(UIWebView *)webView;

@end

@implementation PMSDKCheckoutViewController

- (instancetype)init
{
    self.checkoutLoadingView = [[PMSDKLoadingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.checkoutWebViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.checkoutWebViewController.title = @"PayMaya Checkout";
    self.checkoutWebView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.checkoutWebView addSubview:self.checkoutLoadingView];
    self.checkoutWebView.delegate = self;
    self.checkoutWebView.scrollView.bounces = NO;
    self.checkoutWebViewController.view = self.checkoutWebView;
    self = [super initWithRootViewController:self.checkoutWebViewController];
    self.resultDisplayed = NO;
    
    return self;
}

- (instancetype)initWithCheckoutInformation:(PMSDKCheckoutInformation *)checkoutInformation
{
    self = [self init];
    if (!self) return nil;

    self.checkoutInformation = checkoutInformation;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didTapCancelButton:)];
    self.checkoutWebViewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.checkoutResult = [PMSDKCheckoutResult new];
    __weak typeof(self) weakSelf = self;
    [self.checkoutAPIManager initiateCheckoutWithCheckoutInformation:self.checkoutInformation successBlock:^(id response) {
#if DEBUG
        NSLog(@"[PayMaya SDK] Checkout Response: %@", response);
#endif
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.checkoutId = [response objectForKey:@"checkoutId"];
        NSString *url = [NSString stringWithFormat:@"%@%@", [response objectForKey:@"redirectUrl"], @"&in_app=true"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.checkoutWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url copy]]]];
        });
    } failureBlock:^(NSError *error) {
#if DEBUG
        NSLog(@"[PayMaya SDK] Error while initiating checkout: %@", error);
#endif
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.checkoutError = error;
        [self handleCheckoutResult];
    }];
}

- (void)didTapCancelButton:(id)sender
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.checkoutResult.status = PMSDKCheckoutStatusCanceled;
    self.checkoutResult.checkoutId = nil;
    [self handleCheckoutResult];
}

- (void)handleCheckoutResult
{
    if (!self.checkoutError) {
        if ([self.checkoutDelegate respondsToSelector:@selector(checkoutViewController:checkoutDidFinishWithResult:)]) {
            [self.checkoutDelegate checkoutViewController:self checkoutDidFinishWithResult:self.checkoutResult];
        }
    }
    else {
        if ([self.checkoutDelegate respondsToSelector:@selector(checkoutViewController:checkoutDidFailWithError:)]) {
            [self.checkoutDelegate checkoutViewController:self checkoutDidFailWithError:self.checkoutError];
        }
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.resultDisplayed) {
        self.checkoutResult.checkoutId = self.checkoutId;
        [self handleCheckoutResult];
        return NO;
    } else {
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([PMSDKUtilities isResultPage:webView.request.URL]) {
        self.resultDisplayed = YES;
        self.checkoutResult.status = [self statusForPage:webView];
    }

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.checkoutLoadingView removeFromSuperview];
}

- (PayMayaEnvironment)statusForPage:(UIWebView *)webView
{
    NSString *javascript = @"e = document.getElementsByClassName('title')[0]; e ? e.innerText : '';";
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:javascript];

    if ([title isEqualToString:@"Payment Confirmation Successful"]) {
        return PMSDKCheckoutStatusSuccess;
    } else if ([title isEqualToString:@"Payment Failed"]) {
        return PMSDKCheckoutStatusFailed;
    }
    NSLog(@"[PayMaya SDK] WARNING ! Unknown checkout status with ID(%@), result was not found in params!", self.checkoutId);
    return PMSDKCheckoutStatusUnknown;
}


@end
