//
//  PMSDKLoadingView.m
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

#import "PMSDKLoadingView.h"

@interface PMSDKLoadingView ()

@property (nonatomic, strong) UIView *loadingBackgroundView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingActivityIndicatorView;
@property (nonatomic, strong) UILabel *loadingLabel;

@end

@implementation PMSDKLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadingBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.loadingBackgroundView.backgroundColor = [UIColor blackColor];
        self.loadingBackgroundView.alpha = 0.80f;
        self.loadingBackgroundView.layer.cornerRadius = 5;
        self.loadingBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.loadingBackgroundView];
        
        self.loadingActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.loadingActivityIndicatorView startAnimating];
        self.loadingActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.loadingBackgroundView addSubview:self.loadingActivityIndicatorView];
        
        self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.loadingLabel.text = @"Loading";
        self.loadingLabel.textColor = [UIColor whiteColor];
        self.loadingLabel.font = [UIFont fontWithName:@"Helvetica-Neue" size:22.0f];
        self.loadingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.loadingBackgroundView addSubview:self.loadingLabel];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_loadingBackgroundView, _loadingActivityIndicatorView, _loadingLabel);
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.loadingBackgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.loadingBackgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [self.loadingBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_loadingLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [self.loadingBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_loadingActivityIndicatorView]-[_loadingLabel]-20-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
