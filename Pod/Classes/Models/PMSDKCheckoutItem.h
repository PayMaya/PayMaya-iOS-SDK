//
//  PMSDKCheckoutItem.h
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

@class PMSDKItemAmount;

@interface PMSDKCheckoutItem : NSObject

/**
Specifies the item name. Required.
 */
@property (nonatomic, strong) NSString *name;

/**
 Specifies the merchant assigned SKU code. Optional.
 */
@property (nonatomic, strong) NSString *code;

/**
 Specifies the item description. Optional.
 */
@property (nonatomic, strong) NSString *itemDescription;

/**
 Specifies the number of bought items. Value should only be numeric. Required.
 */
@property (nonatomic, strong) NSNumber *quantity;

/**
 Specifies the price amount per item. Optional.
 */
@property (nonatomic, strong) PMSDKItemAmount *amount;

/**
 Specifies the total price amount for all the bought items. Required.
 */
@property (nonatomic, strong) PMSDKItemAmount *totalAmount;

@end
