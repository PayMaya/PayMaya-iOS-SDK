//
//  PMSDKAddress.h
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

#import <Foundation/Foundation.h>

@interface PMSDKAddress : NSObject

/**
 Specifies the primary address line. Required.
 */
@property (nonatomic, strong) NSString *primaryAddressLine;

/**
 Specifies the secondary address line. Optional.
 */
@property (nonatomic, strong) NSString *secondaryAddressLine;

/**
 Specifies the city. Required.
 */
@property (nonatomic, strong) NSString *city;

/**
 Specifies the state or province. Required. 
 */
@property (nonatomic, strong) NSString *state;

/**
 Specifies the postal or zip code. Value should only be numeric. Required.
 */
@property (nonatomic, strong) NSString *zipCode;

/**
 Specifies the country code as defined in the ISO 3166-1 alpha-2 currency code standard (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Value should only be uppercase letters. Maximum of 2 characters. Required.
 */
@property (nonatomic, strong) NSString *countryCode;

@end
