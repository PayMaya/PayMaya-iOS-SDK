//
//  PMDCardTableViewCell.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMDCard;

@interface PMDCardTableViewCell : UITableViewCell

- (void)bindWithCard:(PMDCard *)card;
+ (NSString *)reuseIdentifier;
+ (CGFloat)height;

@end
