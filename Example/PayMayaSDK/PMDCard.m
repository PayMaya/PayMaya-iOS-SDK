//
//  PMDCard.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCard.h"

@implementation PMDCard

- (NSString *)verificationURL
{
    NSString *key = [NSString stringWithFormat:@"%@_VERIFICATION_URL", _tokenIdentifier];
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end
