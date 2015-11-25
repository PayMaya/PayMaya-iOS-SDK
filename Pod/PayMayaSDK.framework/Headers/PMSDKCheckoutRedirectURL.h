//
//  PMSDKCheckoutRedirectURL.h
//  Pods
//
//  Created by Elijah Cayabyab on 13/11/2015.
//
//

#import <Foundation/Foundation.h>

@interface PMSDKCheckoutRedirectURL : NSObject

@property (nonatomic, strong) NSString *successRedirectURL;
@property (nonatomic, strong) NSString *failureRedirectURL;
@property (nonatomic, strong) NSString *cancelRedirectURL;

@end
