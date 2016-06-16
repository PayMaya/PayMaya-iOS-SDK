//
//  PMDCustomer.m
//  PayMayaSDKDemo
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

#import "PMDCustomer.h"

@implementation PMDCustomer

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.identifier = [decoder decodeObjectForKey:@"identifier"];
    self.firstName = [decoder decodeObjectForKey:@"firstName"];
    self.middleName = [decoder decodeObjectForKey:@"middleName"];
    self.lastName = [decoder decodeObjectForKey:@"lastName"];
    self.contact = [decoder decodeObjectForKey:@"contact"];
    self.shippingAddress = [decoder decodeObjectForKey:@"shippingAddress"];
    self.billingAddress = [decoder decodeObjectForKey:@"billingAddress"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.middleName forKey:@"middleName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.contact forKey:@"contact"];
    [encoder encodeObject:self.shippingAddress forKey:@"shippingAddress"];
    [encoder encodeObject:self.billingAddress forKey:@"billingAddress"];
}

@end
