//
//  PMDActivityIndicatorView.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 26/02/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDActivityIndicatorView.h"

@interface PMDActivityIndicatorView ()

@property (nonatomic, strong) UIView *loadingBackgroundView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingActivityIndicatorView;
@property (nonatomic, strong) UILabel *loadingLabel;

@end

@implementation PMDActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame label:(NSString *)label
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        
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
        self.loadingLabel.text = label;
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
