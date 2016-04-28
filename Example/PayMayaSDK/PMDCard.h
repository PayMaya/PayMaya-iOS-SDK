//
//  PMDCard.h
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMDCard : NSObject

@property (nonatomic, strong) NSString *tokenIdentifier;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *maskedPan;
@property (nonatomic, strong) NSString *state;

@end
