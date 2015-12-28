//
//  PMDProduct.h
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 31/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMDProduct : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *currency;

@end
