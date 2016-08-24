//
//  PMSDKAddress+NSCoding.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 24/08/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMSDKAddress+NSCoding.h"

@implementation PMSDKAddress (NSCoding)

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.primaryAddressLine = [decoder decodeObjectForKey:@"primaryAddressLine"];
    self.secondaryAddressLine = [decoder decodeObjectForKey:@"secondaryAddressLine"];
    self.city = [decoder decodeObjectForKey:@"city"];
    self.state = [decoder decodeObjectForKey:@"state"];
    self.zipCode = [decoder decodeObjectForKey:@"zipCode"];
    self.countryCode = [decoder decodeObjectForKey:@"countryCode"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.primaryAddressLine forKey:@"primaryAddressLine"];
    [encoder encodeObject:self.secondaryAddressLine forKey:@"secondaryAddressLine"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.zipCode forKey:@"zipCode"];
    [encoder encodeObject:self.countryCode forKey:@"countryCode"];
}


@end
