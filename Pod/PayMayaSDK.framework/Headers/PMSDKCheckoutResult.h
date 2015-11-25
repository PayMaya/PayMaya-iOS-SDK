//
//  PMSDKCheckoutResult.h
//  Pods
//
//  Created by Patrick J. D. Medina on 06/11/2015.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PMSDKCheckoutStatus) {
    PMSDKCheckoutStatusUnknown = -1,
    PMSDKCheckoutStatusCompleted,
    PMSDKCheckoutStatusFailed,
    PMSDKCheckoutStatusCanceled,
    PMSDKCheckoutStatusPending,
    // TODO: Implement as NSError
    PMSDKCheckoutStatusError
};

@interface PMSDKCheckoutResult : NSObject

@property (nonatomic, assign) PMSDKCheckoutStatus status;
@property (nonatomic, strong) NSString* checkoutId;

@end
