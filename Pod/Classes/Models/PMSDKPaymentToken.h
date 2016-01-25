//
//  PMSDKPaymentToken.h
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

@interface PMSDKPaymentToken : NSObject

/**
 Token identifier. It should be used once for payment execution.
 */
@property (nonatomic, strong) NSString *identifier;

/**
 Token type.
 */
@property (nonatomic, strong) NSString *type;

/**
 Token state can be created or used
 */
@property (nonatomic, strong) NSString *state;

/**
 Specifies whether token can be used in sandbox or production envrionment.
 */
@property (nonatomic, strong) NSString *environment;

/**
Source IP that requested for token generation.
 */
@property (nonatomic, strong) NSString *sourceIP;

/**
 Specifies the timestamp the token is created.
 */
@property (nonatomic, strong) NSDate *createdAt;

/**
 Specifies the timestamp the token is last updated.
 */
@property (nonatomic, strong) NSDate *updatedAt;

@end
