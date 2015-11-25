//
//  NSObject+KVCParsing.h
//  Pods
//
//  Created by Elijah Cayabyab on 12/11/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (KVCParsing)

- (NSDictionary*)mappingForKVCParsing;
- (void)parseValue:(id)value forKey:(NSString*)key;
- (void)parseValuesForKeysWithDictionary:(NSDictionary*)dictionary;
- (NSMutableDictionary *)propertiesDictionary;

@end
