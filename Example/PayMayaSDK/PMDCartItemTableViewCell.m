//
//  PMDCartItemTableViewCell.m
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import "PMDCartItemTableViewCell.h"
#import "PMDUtilities.h"

@interface PMDCartItemTableViewCell ()

@property (nonatomic, strong) UILabel *itemNameLabel;
@property (nonatomic, strong) UILabel *itemPriceLabel;
@property (nonatomic, strong) UILabel *multiplierLabel;
@property (nonatomic, strong) UILabel *itemQuantityLabel;
@property (nonatomic, strong) UILabel *itemPriceTotalLabel;

@end

@implementation PMDCartItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.itemNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemNameLabel.numberOfLines = 0;
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemNameLabel];
        
        self.itemPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemPriceLabel];
        
        self.multiplierLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.multiplierLabel.text = @"X";
        self.multiplierLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.multiplierLabel];
        
        self.itemQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemQuantityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemQuantityLabel];
        
        self.itemPriceTotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemPriceTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.itemPriceTotalLabel];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_itemNameLabel, _itemPriceLabel, _multiplierLabel, _itemQuantityLabel, _itemPriceTotalLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_itemNameLabel(75)]-[_itemPriceLabel(80)]-[_multiplierLabel]-[_itemQuantityLabel]->=0-[_itemPriceTotalLabel]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_itemNameLabel]-|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)bindWithProduct:(PMDProduct *)product withQuantity:(NSNumber *)quantity
{
    self.itemNameLabel.text = product.name;
    self.itemPriceLabel.text = [[PMDUtilities currencyFormatter] stringFromNumber:product.amount];
    self.itemQuantityLabel.text = [quantity stringValue];
    self.itemPriceTotalLabel.text = [[PMDUtilities currencyFormatter] stringFromNumber:@([product.amount doubleValue] * [quantity doubleValue])];
}

+ (NSString *)reuseIdentifier
{
    return @"PMDCartItemTableViewCell";
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
