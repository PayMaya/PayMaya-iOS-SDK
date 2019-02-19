//
//  PMSDKBuyerProfile.h
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

@class PMSDKAddress;
@class PMSDKContact;

@interface PMSDKBuyerProfile : NSObject

/**
 Specifies the buyer's first name. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull firstName;

/**
 Specifies the buyer's middle name. Optional.
 */
@property (nonatomic, strong) NSString * _Nullable middleName;

/**
 Specifies the buyer's last name. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull lastName;

/**
 Buyer's contact information. Phone number and/or email address. Optional.
 */
@property (nonatomic, strong) PMSDKContact * _Nullable contact;

/**
 Shipping address to be used for the transaction. Optional.
 */
@property (nonatomic, strong) PMSDKAddress * _Nullable shippingAddress;

/**
 Billing address to be used for the transaction. Optional.
 */
@property (nonatomic, strong) PMSDKAddress * _Nullable billingAddress;

/**
 Creates a new buyer profile object

 @param firstName First name of buyer
 @param lastName Last name of buyer
 @return Buyer profile
 */
- (instancetype _Nonnull)initWithFirstName:(NSString * _Nonnull)firstName
                                  lastName:(NSString * _Nonnull)lastName;

@end
