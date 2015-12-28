//
//  PMDCartTableHeaderView.m
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import "PMDCartTableHeaderView.h"

@interface PMDCartTableHeaderView ()

@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *quantityLabel;

@end

@implementation PMDCartTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemLabel.text = @"Item";
        self.itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.itemLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLabel.text = @"Price";
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.priceLabel];
        
        self.quantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.quantityLabel.text = @"Quantity";
        self.quantityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.quantityLabel];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_itemLabel, _priceLabel, _quantityLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_itemLabel]-48-[_priceLabel]-45-[_quantityLabel]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
