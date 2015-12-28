//
//  PMDUtilities.m
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import "PMDUtilities.h"

@implementation PMDUtilities

+ (NSNumberFormatter *)currencyFormatter
{
    static NSNumberFormatter *numberFormatter;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@""];
    });
    return numberFormatter;
}

+ (NSNumberFormatter *)decimalNumberFormatter
{
    static NSNumberFormatter *numberFormatter;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    });
    return numberFormatter;
}

@end
