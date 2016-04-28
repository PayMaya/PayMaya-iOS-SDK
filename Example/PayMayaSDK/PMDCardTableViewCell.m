//
//  PMDCardTableViewCell.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCardTableViewCell.h"
#import "PMDCard.h"

@interface PMDCardTableViewCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *maskedPanLabel;
@property (nonatomic, strong) UIImageView *typeImageView;

@property (nonatomic, strong) UIView *cardOverlayView;
@property (nonatomic, strong) UILabel *tapToVerifyLabel;


@end

@implementation PMDCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.cardView = [[UIView alloc] initWithFrame:CGRectZero];
        self.cardView.translatesAutoresizingMaskIntoConstraints = NO;
        self.cardView.layer.cornerRadius = 6.0f;
        self.cardView.layer.borderWidth = 2.0f;
        self.cardView.layer.borderColor = [[UIColor blackColor] CGColor];
        [self.contentView addSubview:self.cardView];
        
        self.maskedPanLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.maskedPanLabel.backgroundColor = [UIColor clearColor];
        self.maskedPanLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.cardView addSubview:self.maskedPanLabel];
        
        self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.typeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.typeImageView.backgroundColor = [UIColor clearColor];
        self.typeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.cardView addSubview:self.typeImageView];
        
        self.cardOverlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.cardOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
        self.cardOverlayView.layer.cornerRadius = 6.0f;
        self.cardOverlayView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
        self.cardOverlayView.alpha = 0.6f;
        [self.cardView addSubview:self.cardOverlayView];
        
        self.tapToVerifyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.tapToVerifyLabel.backgroundColor = [UIColor clearColor];
        self.tapToVerifyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.tapToVerifyLabel.text = @"Tap to Verify";
        self.tapToVerifyLabel.textColor = [UIColor whiteColor];
        self.tapToVerifyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:32];
        [self.cardOverlayView addSubview:self.tapToVerifyLabel];
        
        [self setUpLayoutConstraints];
    }
    return self;
}

- (void)setUpLayoutConstraints
{
    NSMutableDictionary *viewsDictionary = [NSDictionaryOfVariableBindings(_cardView, _cardOverlayView, _maskedPanLabel, _typeImageView) mutableCopy];
    [viewsDictionary setObject:self.contentView forKey:@"contentView"];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_cardView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cardView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cardOverlayView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cardOverlayView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.cardView addConstraint:[NSLayoutConstraint constraintWithItem:self.cardOverlayView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cardView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.cardView addConstraint:[NSLayoutConstraint constraintWithItem:self.cardOverlayView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cardView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_typeImageView(75)]-[_maskedPanLabel]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_typeImageView(120)]" options:0 metrics:nil views:viewsDictionary]];
    [self.cardView addConstraint:[NSLayoutConstraint constraintWithItem:self.typeImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cardView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.cardView addConstraint:[NSLayoutConstraint constraintWithItem:self.typeImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cardView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:-20.0f]];
    
    [self.cardOverlayView addConstraint:[NSLayoutConstraint constraintWithItem:self.tapToVerifyLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cardOverlayView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.cardOverlayView addConstraint:[NSLayoutConstraint constraintWithItem:self.tapToVerifyLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cardOverlayView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
}

- (void)bindWithCard:(PMDCard *)card
{
    self.maskedPanLabel.text = [NSString stringWithFormat:@"****-****-****-%@", card.maskedPan];
    
    if ([card.type isEqualToString:@"master-card"]) {
        [self.typeImageView setImage:[UIImage imageNamed:@"mastercard-logo"]];
    } else if ([card.type isEqualToString:@"visa"]) {
        [self.typeImageView setImage:[UIImage imageNamed:@"visa-logo"]];
    }
    
    if ([card.state isEqualToString:@"PREVERIFICATION"]) {
        self.cardOverlayView.hidden = NO;
        self.tapToVerifyLabel.hidden = NO;
    }
    else {
        self.cardOverlayView.hidden = YES;
        self.tapToVerifyLabel.hidden = YES;
    }
}

+ (NSString *)reuseIdentifier
{
    return @"PMDCardTableViewCell";
}

+ (CGFloat)height
{
    float cardWidth = [UIScreen mainScreen].bounds.size.width - 20;
    float cardHeight = (cardWidth * 0.63);
    return cardHeight;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
