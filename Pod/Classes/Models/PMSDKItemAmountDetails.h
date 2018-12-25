//
//  PMSDKItemAmountDetails.h
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

@interface PMSDKItemAmountDetails : NSObject

/**
 Discount amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber * _Nullable discount;

/**
 Service charge amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber * _Nullable serviceCharge;

/**
 Shipping fee amount for the transaction. Value should only be numeric. Optional.
 */
@property (nonatomic, strong) NSNumber * _Nullable shippingFee;

/**
 Tax amount for the transaction. Optional.
 */
@property (nonatomic, strong) NSNumber * _Nullable tax;

/**
 Sum of amounts for all items in the transaction. Optional.
 */
@property (nonatomic, strong) NSNumber * _Nullable subtotal;

@end
