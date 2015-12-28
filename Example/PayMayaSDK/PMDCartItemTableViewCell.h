//
//  PMDCartItemTableViewCell.h
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMDProduct.h"

@interface PMDCartItemTableViewCell : UITableViewCell

- (void)bindWithProduct:(PMDProduct *)product withQuantity:(NSNumber *)quantity;

+ (NSString *)reuseIdentifier;

@end
