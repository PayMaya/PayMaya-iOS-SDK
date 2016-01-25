//
//  PMSDKPaymentTokenResult.h
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
#import "PMSDKPaymentToken.h"

typedef NS_ENUM(NSInteger, PMSDKPaymentTokenStatus) {
    /**
     Payment token is successfully created.
     */
    PMSDKPaymentTokenStatusCreated = 0,
    
    /**
     Payment token is already used.
     */
    PMSDKPaymentTokenStatusUsed
};

@interface PMSDKPaymentTokenResult : NSObject

/**
 Payment token status.
 */
@property (nonatomic, assign) PMSDKPaymentTokenStatus status;

/**
 Payment token details.
 */
@property (nonatomic, strong) PMSDKPaymentToken *paymentToken;

@end
