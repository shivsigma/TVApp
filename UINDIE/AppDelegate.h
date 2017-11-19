//
//  AppDelegate.h
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "VideoLandscapeViewController.h"
#import <AVFoundation/AVFoundation.h>





#define alertTitle @"UND TV"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet UINavigationController * nav;

@property (nonatomic ,assign) BOOL isFirstTimeAlert;

+ (AppDelegate*)appDelegate;
- (BOOL)isReachable;

@property (nonatomic) BOOL fullScreenVideoIsPlaying;
//------- ravinder ----//
@property(nonatomic)BOOL isLoginFromFB;
@property(nonatomic) NSString *totalCount;
//--------------------//
@end

