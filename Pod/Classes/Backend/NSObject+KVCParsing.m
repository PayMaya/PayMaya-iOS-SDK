//
//  NSObject+JSONParsing.m
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

#import "NSObject+KVCParsing.h"
#import "PMSDKUtilities.h"

@implementation NSObject (KVCParsing)

- (NSDictionary *)mappingForKVCParsing
{
    return @{};
}

- (void)parseValue:(id)value forKey:(NSString *)key
{
    NSString *mappedKey = [[self mappingForKVCParsing] valueForKey:key];
    
    if (mappedKey) {
        key = mappedKey;
    }
    else return;
    
    NSError *error = nil;
    BOOL validated = [self validateValue:&value forKey:mappedKey error:&error];
    
    if (validated) {
        if (value != [NSNull null] && value != nil) {
            [self setValue:value forKey:mappedKey];
        }
        else {
            [self setNilValueForKey:mappedKey];
        }
    }
    else {
        NSLog(@"Value for Key %@ is not valid in class %@. Error: %@", key, [self.class description], error);
    }
}

- (void)parseValuesForKeysWithDictionary:(NSDictionary *)keyDictionary
{
    for (NSString *key in keyDictionary) {
        id value = keyDictionary[key];
        [self parseValue:value forKey:key];
    }
}

- (NSMutableDictionary *)propertiesDictionary
{
    NSMutableDictionary *propertiesDictionary = [[NSMutableDictionary alloc] init];
    
    NSDictionary *propertyNamesDictionary = [self mappingForKVCParsing];
    for (NSString *key in propertyNamesDictionary) {
        NSString *propertyName = [propertyNamesDictionary objectForKey:key];
        id property = [self valueForKey:propertyName];
        if (property) {
            if ([property isKindOfClass:[NSString class]] || [property isKindOfClass:[NSNumber class]] || [property isKindOfClass:[NSDictionary class]] || [property isKindOfClass:[NSNumber class]]) {
                if ([property isKindOfClass:[NSNumber class]]) {
                    property = [[[PMSDKUtilities currencyFormatter] stringFromNumber:property] stringByReplacingOccurrencesOfString:@"," withString:@""];
                }
                [propertiesDictionary setObject:property forKey:key];
            }
            else if ([property isKindOfClass:[NSArray class]]) {
                NSMutableArray *innerPropertiesArray = [[NSMutableArray alloc] init];
                for (id innerProperty in property) {
                    [innerPropertiesArray addObject:[innerProperty propertiesDictionary]];
                }
                [propertiesDictionary setObject:innerPropertiesArray forKey:key];
            } else {
                [propertiesDictionary setObject:[property propertiesDictionary] forKey:key];
            }
        }
    }
    
    return propertiesDictionary;
}

@end
