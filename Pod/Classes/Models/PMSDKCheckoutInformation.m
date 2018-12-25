//
//  PMSDKCheckoutInformation.m
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

#import "PMSDKCheckoutInformation.h"
#import "NSObject+KVCParsing.h"
#import "PMSDKItemAmount.h"
#import "PMSDKBuyerProfile.h"
#import "PMSDKCheckoutItem.h"
#import "PMSDKCheckoutRedirectURL.h"

@implementation PMSDKCheckoutInformation

- (instancetype _Nullable)initWithTotalAmount:(PMSDKItemAmount * _Nonnull)totalAmount
                                        buyer:(PMSDKBuyerProfile * _Nonnull)buyer
                                        items:(NSArray<PMSDKCheckoutItem *> * _Nonnull)items
                       requestReferenceNumber:(NSString * _Nonnull)requestReferenceNumber {
    self = [super init];
    if (nil != self) {
        if ([totalAmount.value doubleValue] <= 0.0) {
            return nil;
        }
        self.totalAmount = totalAmount;
        self.buyer = buyer;
        if (items == nil || items.count == 0) {
            return nil;
        }
        self.items = items;
        self.requestReferenceNumber = requestReferenceNumber;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self parseValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (NSDictionary *)mappingForKVCParsing
{
    return @{@"totalAmount": @"totalAmount",
             @"buyer": @"buyer",
             @"items": @"items",
             @"redirectUrl": @"redirectUrl",
             @"requestReferenceNumber": @"requestReferenceNumber",
             @"metadata": @"metadata"};
}

//- (BOOL)validateTotalAmount:(id *)ioValue error:(NSError * __autoreleasing *)outError
//{
//    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
//        PMSDKItemAmount *totalAmount = [[PMSDKItemAmount alloc] init];
//        [totalAmount parseValuesForKeysWithDictionary:*ioValue];
//        *ioValue = totalAmount;
//    }
//    return YES;
//}

//- (BOOL)validateBuyer:(id *)ioValue error:(NSError * __autoreleasing *)outError
//{
//    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
//        PMSDKBuyerProfile *buyer = [[PMSDKBuyerProfile alloc] init];
//        [buyer parseValuesForKeysWithDictionary:*ioValue];
//        *ioValue = buyer;
//    }
//    return YES;
//}

//- (BOOL)validateItems:(id *)ioValue error:(NSError * __autoreleasing *)outError
//{
//    if ([*ioValue isKindOfClass:[NSArray class]]) {
//        NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
//        for (NSDictionary *item in *ioValue) {
//            PMSDKCheckoutItem *checkoutItem = [[PMSDKCheckoutItem alloc] init];
//            [checkoutItem parseValuesForKeysWithDictionary:item];
//            [itemsArray addObject:checkoutItem];
//        }
//        *ioValue = itemsArray;
//    }
//    return YES;
//}

- (BOOL)validateRedirectUrl:(id *)ioValue error:(NSError * __autoreleasing *)outError
{
    if ([*ioValue isKindOfClass:[NSDictionary class]]) {
        PMSDKCheckoutRedirectURL *redirectURL = [[PMSDKCheckoutRedirectURL alloc] init];
        [redirectURL parseValuesForKeysWithDictionary:*ioValue];
        *ioValue = redirectURL;
    }
    return YES;
}

@end
