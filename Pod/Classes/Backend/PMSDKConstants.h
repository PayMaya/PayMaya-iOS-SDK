//
//  PMSDKConstants.h
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

@interface PMSDKConstants : NSObject

/*
 @abstract The error domain for errors from PayMayaSDK.
 */
extern NSString *const PMSDKErrorDomain;

/*
 @typedef NS_ENUM(NSInteger, PMSDKErrorCode)
 @abstract Error codes for PMSDKErrorDomain.
 */
typedef NS_ENUM(NSInteger, PMSDKErrorCode)
{
    /*
     @abstract Reserved.
     */
    PMSDKReservedErrorCode = 0,
    
    /*
     @abstract A request failed due to a network error. Use NSUnderlyingErrorKey to retrieve
     the error object from the NSURLConnection for more information.
     */
    PMSDKNetworkErrorCode,
    
    /*
     @abstract Indicates an operation failed because a required access token was not found.
     */
    PMSDKAuthorizationHeaderRequiredErrorCode
};

/*
 @abstract The error domain for errors related to Checkout.
 */
extern NSString *const PMSDKCheckoutErrorDomain;

/*
 @typedef NS_ENUM(NSInteger, PMSDKErrorCode)
 @abstract Error codes for PMSDKCheckoutErrorDomain.
 */
typedef NS_ENUM(NSInteger, PMSDKCheckoutErrorCode)
{
    /*
     @abstract Reserved.
     */
    PMSDKCheckoutReservedErrorCode = 0,
    
    /*
     @abstract SDK not initialized.
     */
    PMSDKCheckoutNotInitializedErrorCode,
    
    /*
     @abstract Checkout API error
     */
    PMSDKCheckoutAPIErrorCode
};

/*
 @abstract The error domain for errors related to Payments.
 */
extern NSString *const PMSDKPaymentsErrorDomain;

/*
 @typedef NS_ENUM(NSInteger, PMSDKErrorCode)
 @abstract Error codes for PMSDKCheckoutErrorDomain.
 */
typedef NS_ENUM(NSInteger, PMSDKPaymentsErrorCode)
{
    /*
     @abstract Reserved.
     */
    PMSDKPaymentsReservedErrorCode = 0,
    
    /*
     @abstract SDK not initialized.
     */
    PMSDKPaymentsNotInitializedErrorCode,
    
    /*
     @abstract Payments API error
     */
    PMSDKPaymentsAPIErrorCode
};

@end
