//
//  PMSDKCard.m
//  Pods
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

#import "PMSDKCard.h"
#import "NSObject+KVCParsing.h"
#import "PMSDKUtilities.h"

NSString * const ExpiryMonthType_toString[] = {
    [ExpiryMonthJanuary] = @"01",
    [ExpiryMonthFebruary] = @"02",
    [ExpiryMonthMarch] = @"03",
    [ExpiryMonthApril] = @"04",
    [ExpiryMonthMay] = @"05",
    [ExpiryMonthJune] = @"06",
    [ExpiryMonthJuly] = @"07",
    [ExpiryMonthAugust] = @"08",
    [ExpiryMonthSeptember] = @"09",
    [ExpiryMonthOctober] = @"10",
    [ExpiryMonthNovember] = @"11",
    [ExpiryMonthDecember] = @"12",
};

@implementation PMSDKCard

- (instancetype _Nonnull)initWithCardNumber:(NSString * _Nonnull)cardNumber
                                expiryMonth:(ExpiryMonthType)expiryMonth
                                 expiryYear:(int)expiryYear
                                        cvc:(NSString * _Nonnull)cvc {
    self = [super init];
    if (nil != self) {
        self.number = cardNumber;
        self.expiryMonth = ExpiryMonthType_toString[expiryMonth];
        self.expiryYear = [@(expiryYear) stringValue];
        self.cvc = cvc;
    }
    
    return self;
}

- (instancetype _Nonnull)initWithStringCardNumber:(NSString * _Nonnull)cardNumber
                                      expiryMonth:(NSString * _Nonnull)expiryMonth
                                       expiryYear:(NSString * _Nonnull)expiryYear
                                              cvc:(NSString * _Nonnull)cvc {
    self = [super init];
    if (nil != self) {
        self.number = cardNumber;
        self.expiryMonth = expiryMonth;
        self.expiryYear = expiryYear;
        self.cvc = cvc;
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
    return @{@"number": @"number",
             @"expMonth": @"expiryMonth",
             @"expYear": @"expiryYear",
             @"cvc": @"cvc"};
}

- (NSString *)idempotentKey
{
    NSString *cardInfoString = [NSString stringWithFormat:@"%@%@%@%@", self.number, self.expiryMonth, self.expiryYear, self.cvc];
    return [PMSDKUtilities sha1:cardInfoString];
}

@end
