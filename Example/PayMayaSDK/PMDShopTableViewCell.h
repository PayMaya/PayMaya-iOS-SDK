//
//  PMDShopTableViewCell.h
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 31/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMDProduct;
@protocol PMDShopTableViewCellDelegate;

@interface PMDShopTableViewCell : UITableViewCell

@property (nonatomic, assign) id <PMDShopTableViewCellDelegate> delegate;

- (void)bindWithProduct:(PMDProduct *)product;

+ (NSString *)reuseIdentifier;
+ (CGFloat)height;

@end

@protocol PMDShopTableViewCellDelegate <NSObject>

- (void)shopTableViewCellDidTapBuy:(PMDShopTableViewCell *)shopTableViewCell withProduct:(PMDProduct *)product;

@end
