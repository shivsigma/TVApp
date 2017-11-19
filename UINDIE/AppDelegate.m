//
//  AppDelegate.m
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "AppDelegate.h"
#import "DashBoardViewController.h"
#import "RegistrationViewController.h"
#import "SaveCardAddressViewController.h"
#import "EditCreditCardDetailsViewController.h"
#import "ChangePasswordViewController.h"
#import "ProductDetailView.h"
#import "ProfileViewController.h"
#import "CreditView.h"
#import "BraintreeCreditView.h"
#import "FavoriteDetailView.h"
#import "CategoryDetailView.h"
#import "InterNetStatusView.h"
@import HockeySDK;




@interface AppDelegate ()

@end

@implementation AppDelegate
- (NSNumber *) dataNetworkTypeFromStatusBar {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"]    subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    return [dataNetworkItemView valueForKey:@"dataNetworkType"];
}

/*
 
 func reachabilityChanged(notification: NSNotification) {
 if self.reach!.isReachableViaWiFi() || self.reach!.isReachableViaWWAN() {
 println("Service avalaible!!!")
 } else {
 println("No service avalaible!!!")
 }
 }
 */

- (void) reachabilityChanged:(NSNotification*)notification{
    if ([self isReachable]) {
       
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
//    NSDate * dddd = [formatter dateFromString:@"2016-04-24 11:02 PM"];
//    NSString * sssss = [formatter stringFromDate:dddd];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"0190c5408488451facaa19d8df112dfe"];
    // Do some additional configuration if needed here
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator
     authenticateInstallation];


    [Uitility saveBool:NO ForKey:kAudioControlMute];
    //[Uitility saveBool:NO ForKey:kar];
    
    
   // [Uitility saveValue:[NSString stringWithFormat:@"%0.1f",[MPMusicPlayerController applicationMusicPlayer].volume] ForKey:kAudioControlVolumeLevel];
    
    NSString * timeZone = [Uitility getStringValueForKey:kTimeZoneSelected];
    if (timeZone.length <= 0) {
        [Uitility saveStringValue:@"PST" ForKey:kTimeZoneSelected];
    }
    
    
    _isFirstTimeAlert = YES;
    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    
   /* AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];*/
   
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
     [self.window makeKeyAndVisible];
    
    NSNumber * status = [self dataNetworkTypeFromStatusBar];
    if (status  != [NSNumber numberWithInt:5]) {
        InterNetStatusView * statusView =   [InterNetStatusView initView];
        [[KGModal sharedInstance]showWithContentView:statusView];
    }
    
    
  //
    return YES;
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification Received" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
+(AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
- (BOOL)isReachable {
    Reachability *reach =[Reachability reachabilityWithHostname:@"www.google.com"];
    return [reach isReachable];
}

- (void)backPlay{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BACKGROUNDTOFORE" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    //[[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    //[[ServiceList Instance]loadAllVideoDelegate:nil];
    
//    while (true) {
//        NSLog(@"Narendra");
//    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BACKGROUNDTOFORE" object:nil];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


    
//////////////////////


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.fullScreenVideoIsPlaying == YES) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
