//
//  PMSDKUtilities.m
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

#import "PMSDKUtilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation PMSDKUtilities

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

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        // Sample format: 2015-06-02T04:13:22.186Z
        [dateFormatter setDateFormat:@"yyyy-MM-ddEEEEEHH:mm:ss.SSSX"];
    });
    return dateFormatter;
}

+ (NSDictionary *)dictionaryFromQueryString:(NSString *)queryString
{
    NSArray *params = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:params.count];
    for (NSString *param in params) {
        NSRange range = [param rangeOfString:@"="];
        NSString *key = range.length ? [param substringToIndex:range.location] : param;
        NSString *val = range.length ? [param substringFromIndex:range.location+1] : @"";
        key = [key stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        val = [val stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        val = [val stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dictionary setObject:val forKey:key];
    }
    return dictionary;
}

+ (NSString *)queryStringFromDictionary:(NSDictionary*)dictionary
{
    NSMutableArray *params = [NSMutableArray array];
    for (NSString *key in [dictionary keyEnumerator]) {
        id param = [dictionary objectForKey:key];
        NSString *plainText = nil;
        if ([param isKindOfClass:[NSString class]]) {
            plainText = (NSString *)param;
        } else if ([param isKindOfClass:[NSNumber class]]) {
            NSNumber *number = (NSNumber *)param;
            plainText = number.stringValue;
        }
        if (plainText) {
            NSString *escapedText = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                          kCFAllocatorDefault,
                                                                                                          (CFStringRef)plainText,
                                                                                                          NULL,
                                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                          kCFStringEncodingUTF8));
            [params addObject:[NSString stringWithFormat:@"%@=%@", key, escapedText]];
        }
    }
    
    NSString *queryString = nil;
    if (params.count > 0) {
        queryString = [params componentsJoinedByString:@"&"];
    } else {
        queryString = @"";
    }
    
    return queryString;
}

+ (NSString *)checkoutBaseURLForEnvironment:(PayMayaEnvironment)environment
{
    NSString *baseURL = nil;
    switch (environment) {
#if DEBUG
        case PayMayaEnvironmentDebug:
            baseURL = @"http://52.76.74.110:8088";
            break;
        case PayMayaEnvironmentTest:
            baseURL = @"https://test-checkout-api.paymaya.com";
            break;
        case PayMayaEnvironmentStaging:
            baseURL = @"https://staging-checkout-api.paymaya.com";
            break;
#endif
        case PayMayaEnvironmentSandbox:
            baseURL = @"https://pg-sandbox.paymaya.com/checkout";
            break;
        case PayMayaEnvironmentProduction:
            baseURL = @"https://checkout-api.paymaya.com";
            break;
    }
    return baseURL;
}

+ (NSString *)paymentsBaseURLForEnvironment:(PayMayaEnvironment)environment
{
    NSString *baseURL = nil;
    switch (environment) {
#if DEBUG
        case PayMayaEnvironmentDebug:
            baseURL = @"http://52.76.57.133:8001";
            break;
        case PayMayaEnvironmentTest:
            baseURL = @"http://private-anon-39be75513-paymayapaymentsapi.apiary-mock.com";
            break;
        case PayMayaEnvironmentStaging:
            baseURL = @"http://private-anon-39be75513-paymayapaymentsapi.apiary-mock.com";
            break;
#endif
        case PayMayaEnvironmentSandbox:
            baseURL = @"https://pg-sandbox.paymaya.com/payments";
            break;
        case PayMayaEnvironmentProduction:
            baseURL = @"https://api.paymaya.com/payments";
            break;
    }
    return baseURL;
}

+ (NSString *)checkoutResultUrl
{
    NSString *url = nil;
    PayMayaEnvironment environment = [[PayMayaSDK sharedInstance] environment];
    switch (environment) {
#if DEBUG
        case PayMayaEnvironmentDebug:
            url = @"http://52.76.74.110:8082/checkout/result";
            break;
        case PayMayaEnvironmentTest:
            url = @"https://test-checkout-api.paymaya.com/checkout/result";
            break;
        case PayMayaEnvironmentStaging:
            url = @"https://staging-checkout-api.paymaya.com/checkout/result";
            break;
#endif
        case PayMayaEnvironmentSandbox:
            url = @"https://sandbox-checkout-v2.paymaya.com/checkout/result";
            break;
        case PayMayaEnvironmentProduction:
            url = @"https://checkout-api.paymaya.com/checkout/result";
            break;
    }
    return url;
}

+ (NSString *)checkoutResultRedirectUrl
{
    NSString* url = nil;
    PayMayaEnvironment environment = [[PayMayaSDK sharedInstance] environment];
    switch (environment) {
#if DEBUG
        case PayMayaEnvironmentDebug:
            url = @"https://paymaya.com/";
            break;
        case PayMayaEnvironmentTest:
            url = @"https://paymaya.com/";
            break;
        case PayMayaEnvironmentStaging:
            url = @"https://paymaya.com/";
            break;
#endif
        case PayMayaEnvironmentSandbox:
            url = @"https://paymaya.com/";
            break;
        case PayMayaEnvironmentProduction:
            url = @"https://paymaya.com/";
            break;
    }
    return url;
}

+ (NSString*)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    NSNumber *dataLength = [NSNumber numberWithInteger:data.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, [dataLength intValue], digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
