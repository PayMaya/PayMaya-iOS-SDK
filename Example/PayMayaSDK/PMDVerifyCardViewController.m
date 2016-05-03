//
//  PMSDKVerifyCardViewController.m
//  PayMayaSDKDemo
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

#import "PMDVerifyCardViewController.h"
#import "PMSDKLoadingView.h"

@interface PMDVerifyCardViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *checkoutWebView;
@property (nonatomic, strong) PMSDKLoadingView *checkoutLoadingView;
@property (nonatomic, strong) NSString *checkoutURL;
@property (nonatomic, strong) NSString *checkoutRedirectURL;

@end

@implementation PMDVerifyCardViewController

- (instancetype)initWithCheckoutURL:(NSString *)checkoutURL redirectUrl:(NSString *)redirectURL
{
    self = [self init];
    if (!self) return nil;
    
    self.checkoutURL = checkoutURL;
    self.checkoutRedirectURL = redirectURL;
    
    return self;
}

- (void)loadView
{
    self.checkoutLoadingView = [[PMSDKLoadingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.checkoutWebView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.checkoutWebView addSubview:self.checkoutLoadingView];
    self.checkoutWebView.delegate = self;
    self.checkoutWebView.scrollView.bounces = NO;
    self.view = self.checkoutWebView;
    
    [self.checkoutWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.checkoutURL copy]]]];
}

- (void)viewDidLoad
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(didTapCancelButton:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)didTapCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:request.URL resolvingAgainstBaseURL:NO];
    urlComponents.query = nil;
    if ([[urlComponents string] containsString:self.checkoutRedirectURL]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    } else {
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.checkoutLoadingView removeFromSuperview];
}

@end
