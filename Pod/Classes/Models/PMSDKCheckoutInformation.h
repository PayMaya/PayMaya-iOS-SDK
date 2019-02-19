//
//  PMSDKCheckoutInformation.h
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

@class PMSDKItemAmount;
@class PMSDKBuyerProfile;
@class PMSDKCheckoutItem;
@class PMSDKCheckoutRedirectURL;

#import <Foundation/Foundation.h>

@interface PMSDKCheckoutInformation : NSObject

/**
 Total amount details for the transaction. Required.
 */
@property (nonatomic, strong) PMSDKItemAmount * _Nonnull totalAmount;

/**
 Customer profile information. Required.
 */
@property (nonatomic, strong) PMSDKBuyerProfile * _Nonnull buyer;

/**
 List of bought items for the transaction. The array must consist of PMSDKCheckoutItem objects. Required.
 */
@property (nonatomic, strong) NSArray<PMSDKCheckoutItem *> * _Nonnull items;

/**
 A unique identifier to a transaction for tracking purposes. Required.
 */
@property (nonatomic, strong) NSString * _Nonnull requestReferenceNumber;

/**
 List of redirect URLs depending on checkout completion status. Optional.
 */
@property (nonatomic, strong) PMSDKCheckoutRedirectURL * _Nullable redirectUrl;

/**
 Merchant provided additional cart information. Optional.
 */
@property (nonatomic, strong) NSDictionary * _Nullable metadata;

// Disable default initialzer
- (instancetype _Nonnull)init NS_UNAVAILABLE;

/**
 Create checkout information details. Total amount value should be positive and purchased items
 should not be empty.

 @param totalAmount Total amount
 @param buyer Buyer profile
 @param items Purchased items.
 @param requestReferenceNumber Request reference number
 @return Checkout information details
 */
- (instancetype _Nullable)initWithTotalAmount:(PMSDKItemAmount * _Nonnull)totalAmount
                                        buyer:(PMSDKBuyerProfile * _Nonnull)buyer
                                        items:(NSArray<PMSDKCheckoutItem *> * _Nonnull)items
                       requestReferenceNumber:(NSString * _Nonnull)requestReferenceNumber;

/**
 Allows initialization of checkout information object from dictionary
 */
- (instancetype _Nonnull)initWithDictionary:(NSDictionary *)dictionary;

@end
