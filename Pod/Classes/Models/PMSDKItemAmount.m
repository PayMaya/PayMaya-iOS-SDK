//
//  PMSDKItemAmount.m
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

#import "PMSDKItemAmount.h"
#import "NSObject+KVCParsing.h"
#import "PMSDKItemAmountDetails.h"
#import "PMSDKUtilities.h"

@implementation PMSDKItemAmount

- (NSDictionary *)mappingForKVCParsing
{
    return @{@"currency": @"currency",
             @"value": @"value",
             @"details": @"details"};
}

- (BOOL)validateValue:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    *ioValue = [[PMSDKUtilities currencyFormatter] numberFromString:*ioValue];
    return YES;
}

- (BOOL)validateDetails:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
        PMSDKItemAmountDetails *itemAmountDetails = [[PMSDKItemAmountDetails alloc] init];
        [itemAmountDetails parseValuesForKeysWithDictionary:*ioValue];
        *ioValue = itemAmountDetails;
    }
    return YES;
}

@end
