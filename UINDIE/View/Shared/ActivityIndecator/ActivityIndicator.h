//
//  ActivityIndicator.h
//  TwitterAndFacebook
//
//  Created by SAVAN on 16/06/2012.
//  Copyright (c) 2012 __HARDIK TALAVIYA __. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ActivityIndicator : UIView{
    UILabel *centerMessageLabel;
    UILabel *subMessageLabel;
    
    UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) UILabel *centerMessageLabel;
@property (nonatomic, retain) UILabel *subMessageLabel;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;


+ (ActivityIndicator *)currentIndicator;

- (void)show;
- (void)hideAfterDelay;
- (void)hide;
- (void)hidden;
- (BOOL) ishidden;
- (void)displayActivity:(NSString *)m;
- (void)displayCompleted:(NSString *)m;
- (void)displayCompleted;
- (void)displayCompletedWithError:(NSString *)m;
- (void)setCenterMessage:(NSString *)message;
- (void)setSubMessage:(NSString *)message;
- (void)showSpinner;
- (void)setProperRotation;
- (void)setProperRotation:(BOOL)animated;

@end
