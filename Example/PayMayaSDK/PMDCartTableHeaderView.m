//
//  PMDCartTableHeaderView.m
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
