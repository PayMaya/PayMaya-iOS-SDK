//
//  PMSDKAddress.m
//  PayMayaSDK
//
//  Copyright (c) 2016 PayMaya Philippines, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PMSDKAddress.h"
#import "NSObject+KVCParsing.h"

@implementation PMSDKAddress

- (instancetype _Nullable)initWithPrimaryAddressLine:(NSString * _Nonnull)primaryAddressLine
                                                city:(NSString * _Nonnull)city
                                               state:(NSString * _Nonnull)state
                                             zipCode:(NSString * _Nonnull)zipCode
                                         countryCode:(NSString * _Nonnull)countryCode {
    self = [super init];
    if (nil != self) {
        self.primaryAddressLine = primaryAddressLine;
        self.city = city;
        self.state = state;
        self.zipCode = zipCode;
        if ([[NSLocale ISOCountryCodes] containsObject:countryCode]) {
            self.countryCode = countryCode;
        } else {
            return nil;
        }
    }
    
    return self;
}

- (NSDictionary *)mappingForKVCParsing
{
    return @{@"line1": @"primaryAddressLine",
             @"line2": @"secondaryAddressLine",
             @"city": @"city",
             @"state": @"state",
             @"zipCode": @"zipCode",
             @"countryCode": @"countryCode"};
}

@end
