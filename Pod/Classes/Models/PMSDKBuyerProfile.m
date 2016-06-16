//
//  PMSDKBuyerProfile.m
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

#import "PMSDKBuyerProfile.h"
#import "NSObject+KVCParsing.h"
#import "PMSDKContact.h"
#import "PMSDKAddress.h"

@implementation PMSDKBuyerProfile

- (NSDictionary *)mappingForKVCParsing
{
    return @{@"firstName": @"firstName",
             @"middleName": @"middleName",
             @"lastName": @"lastName",
             @"contact": @"contact",
             @"shippingAddress": @"shippingAddress",
             @"billingAddress": @"billingAddress"};
    
}

- (BOOL)validateContact:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
        PMSDKContact *contact = [[PMSDKContact alloc] init];
        [contact parseValuesForKeysWithDictionary:*ioValue];
        *ioValue = contact;
    }
    return YES;
}

- (BOOL)validateShippingAddress:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
        PMSDKAddress *shippingAddress = [[PMSDKAddress alloc] init];
        [shippingAddress parseValuesForKeysWithDictionary:*ioValue];
        *ioValue = shippingAddress;
    }
    return YES;
}

- (BOOL)validateBillingAddress:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
        PMSDKAddress *billingAddress = [[PMSDKAddress alloc] init];
        [billingAddress parseValuesForKeysWithDictionary:*ioValue];
        *ioValue = billingAddress;
    }
    return YES;
}

@end
