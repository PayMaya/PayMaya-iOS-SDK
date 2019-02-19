//
//  PMSDKCard.h
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ExpiryMonthType) {
    ExpiryMonthJanuary,
    ExpiryMonthFebruary,
    ExpiryMonthMarch,
    ExpiryMonthApril,
    ExpiryMonthMay,
    ExpiryMonthJune,
    ExpiryMonthJuly,
    ExpiryMonthAugust,
    ExpiryMonthSeptember,
    ExpiryMonthOctober,
    ExpiryMonthNovember,
    ExpiryMonthDecember
};

extern NSString * const ExpiryMonthType_toString[];

@interface PMSDKCard : NSObject

/**
 Primary Account Number (PAN) of customer's card. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull number;

/**
 Expiry month of customer's card. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull expiryMonth;

/**
 Expiry year of customer's card. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull expiryYear;

/**
 CVV of customer's card. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull cvc;

// Disable default initializer
- (instancetype _Nonnull)init NS_UNAVAILABLE;

/**
 Creates a new card object

 @param cardNumber Card number (eg. 5123456789012346)
 @param expiryMonth Expiry month (eg January = 01 so on)
 @param expiryYear Expiry year (eg. 2022)
 @param cvc CVC
 @return Card object
 */
- (instancetype _Nonnull)initWithCardNumber:(NSString * _Nonnull)cardNumber
                                expiryMonth:(ExpiryMonthType)expiryMonth
                                 expiryYear:(int)expiryYear
                                        cvc:(NSString * _Nonnull)cvc;

/**
 Creates a new card object. Prefer using the typed initializer above.
 
 @param cardNumber Card number (eg. 5123456789012346)
 @param expiryMonth Expiry month (eg January = 01 so on)
 @param expiryYear Expiry year (eg. 2022)
 @param cvc CVC
 @return Card object
 */
- (instancetype _Nonnull)initWithStringCardNumber:(NSString * _Nonnull)cardNumber
                                      expiryMonth:(NSString * _Nonnull)expiryMonth
                                       expiryYear:(NSString * _Nonnull)expiryYear
                                              cvc:(NSString * _Nonnull)cvc;

/**
 Allows initialization of card object from dictionary
 */
- (instancetype _Nonnull)initWithDictionary:(NSDictionary *)dictionary;

/** 
 The generated idempotent key will be the same for each unique card information
 */
- (NSString * _Nonnull)idempotentKey;

@end
