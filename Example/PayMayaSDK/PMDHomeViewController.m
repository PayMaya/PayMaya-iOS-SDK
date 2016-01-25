//
//  PMDHomeViewController.m
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

#import "PMDHomeViewController.h"
#import "PMDCardInputViewController.h"
#import "PMDShopViewController.h"
#import "UIColor+Conversion.h"

@interface PMDHomeViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton *checkoutButton;
@property (nonatomic, strong) UILabel *checkoutLabel;
@property (nonatomic, strong) UIButton *paymentsButton;
@property (nonatomic, strong) UILabel *paymentsLabel;

@end

@implementation PMDHomeViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.containerView];
    
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.logoImageView];
    
    self.checkoutButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
    [self.checkoutButton addTarget:self action:@selector(didTapCheckoutButton:) forControlEvents:UIControlEventTouchUpInside];
    self.checkoutButton.backgroundColor = [UIColor colorWithHex:@"2FA3E0"];
    self.checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.checkoutButton];
    
    self.checkoutLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.checkoutLabel.text = @"Demonstrates purchase via Checkout API";
    self.checkoutLabel.numberOfLines = 0;
    self.checkoutLabel.textAlignment = NSTextAlignmentCenter;
    self.checkoutLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.checkoutLabel];
    
    self.paymentsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.paymentsButton setTitle:@"Payments" forState:UIControlStateNormal];
    [self.paymentsButton addTarget:self action:@selector(didTapPaymentsButton:) forControlEvents:UIControlEventTouchUpInside];
    self.paymentsButton.backgroundColor = [UIColor colorWithHex:@"2FA3E0"];
    self.paymentsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.paymentsButton];
    
    self.paymentsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.paymentsLabel.text = @"Demonstrates purchase via Payments API";
    self.paymentsLabel.numberOfLines = 0;
    self.paymentsLabel.textAlignment = NSTextAlignmentCenter;
    self.paymentsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.paymentsLabel];

    [self setUpLayoutConstraints];
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(
                                                                   _containerView,
                                                                   _logoImageView,
                                                                   _checkoutButton,
                                                                   _checkoutLabel,
                                                                   _paymentsButton,
                                                                   _paymentsLabel
                                                                   );
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_containerView]-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_logoImageView]-30-[_checkoutButton(30)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_checkoutButton(30)]-[_checkoutLabel]-30-[_paymentsButton(30)]-[_paymentsLabel]|" options:(NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing) metrics:nil views:viewsDictionary]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_checkoutButton]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)didTapCheckoutButton:(id)sender
{
    PMDShopViewController *shopViewController = [[PMDShopViewController alloc] initWithNibName:nil bundle:nil];
    shopViewController.title = @"Checkout SDK Demo";
    [self.navigationController pushViewController:shopViewController animated:YES];
}

- (void)didTapPaymentsButton:(id)sender
{
    PMDCardInputViewController *cardInputViewController = [[PMDCardInputViewController alloc] initWithNibName:nil bundle:nil];
    cardInputViewController.title = @"Payments SDK Demo";
    [self.navigationController pushViewController:cardInputViewController animated:YES];
}

@end
