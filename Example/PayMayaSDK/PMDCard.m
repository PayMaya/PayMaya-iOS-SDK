//
//  PMDCard.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 29/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCard.h"

@implementation PMDCard

- (void)setVerificationURL:(NSString *)verificationURL
{
    NSString *key = [NSString stringWithFormat:@"%@_VERIFICATION_URL", _tokenIdentifier];
    [[NSUserDefaults standardUserDefaults] setObject:verificationURL forKey:key];
}

- (NSString *)verificationURL
{
    NSString *key = [NSString stringWithFormat:@"%@_VERIFICATION_URL", _tokenIdentifier];
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end
