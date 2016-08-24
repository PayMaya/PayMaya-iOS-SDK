//
//  PMSDKContact+NSCoding.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 24/08/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMSDKContact+NSCoding.h"

@implementation PMSDKContact (NSCoding)

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.phone = [decoder decodeObjectForKey:@"phone"];
    self.email = [decoder decodeObjectForKey:@"email"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.email forKey:@"email"];
}

@end
