//
//  PMDShopTableViewCell.m
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

#import "PMDShopTableViewCell.h"
#import "PMDProduct.h"
#import "PMDUtilities.h"

@interface PMDShopTableViewCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UIView *productDetailsView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) PMDProduct *product;

@end

@implementation PMDShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.layer.borderWidth = 0.50f;
        self.containerView.layer.borderColor = [UIColor blackColor].CGColor;
        self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.containerView];
        
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.productImageView.backgroundColor = [UIColor clearColor];
        self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.productImageView];
        
        self.productDetailsView = [[UIView alloc] initWithFrame:CGRectZero];
        self.productDetailsView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:self.productDetailsView];
        
        self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.productNameLabel.backgroundColor = [UIColor clearColor];
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.productDetailsView addSubview:self.productNameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.productDetailsView addSubview:self.priceLabel];
        
        self.buyButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.buyButton.enabled = YES;
        self.buyButton.layer.cornerRadius = 3.0f;
        self.buyButton.layer.borderWidth = 0.5f;
        self.buyButton.clipsToBounds = YES;
        self.buyButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        [self.buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:self.buyButton];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_containerView, _productImageView, _productDetailsView, _productNameLabel, _priceLabel, _buyButton);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[_containerView]-4-|" options:0 metrics:nil views:viewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_containerView]-8-|" options:0 metrics:nil views:viewsDictionary]];
            
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[_productImageView(80)]-30-[_productDetailsView]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    [self.productDetailsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=0-[_productNameLabel]->=0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.productDetailsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_productNameLabel]-10-[_priceLabel]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:viewsDictionary]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_buyButton(100)]" options:0 metrics:nil views:viewsDictionary]];
     [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[_productImageView(80)]-10-[_buyButton(35)]" options:0 metrics:nil views:viewsDictionary]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.buyButton attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
}

- (void)bindWithProduct:(PMDProduct *)product
{
    self.product = product;
    [self.productImageView setImage:product.image];
    self.productNameLabel.text = product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", product.currency, [[PMDUtilities currencyFormatter] stringFromNumber:product.amount]];
}

- (void)buyButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(shopTableViewCellDidTapBuy:withProduct:)]) {
        [self.delegate shopTableViewCellDidTapBuy:sender withProduct:self.product];
    }
}

+ (CGFloat)height
{
    return 165.0f;
}

+ (NSString *)reuseIdentifier
{
    return @"PMShopTableViewCell";
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
