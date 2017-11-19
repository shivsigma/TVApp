//
//  Uitility.h
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/12/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#define kTimeZoneSelected @"kTimeZoneSelected"
#define kAudioControlMute   @"kAudioControl"

#define kAudioControlVolumeLevel   @"kAudioControlVolumeLevel"
@interface Uitility : NSObject

+(UIImage*) getThumbnailFromVideo:(NSString *)urls;
+ (CGRect)getWindowHeight;

+ (void) saveValue:(NSString *)value ForKey:(NSString *)key;
+ (NSString *)getValueForKey:(NSString *)key;

+ (void) saveBool:(BOOL)value ForKey:(NSString *)key;
+ (BOOL) getBoolForKey:(NSString *)key;

+ (NSString *) platformType:(NSString *)platform;
+ (NSString*) getCurrencyStringFromAmount:(float) amount;
+(NSDate*)getDateString:(NSString *)datestring;
+(NSDate*)getDateMMDDyyyyString:(NSString *)datestring;
+ (NSMutableArray *)getStyleCurrencyFormat:(float)str;
+ (NSMutableArray *)getStyleCurrencyFormatType:(NSString *)str;

+ (NSString*) getCurrencyStringFromAmountString:(NSString*) amount;
+ (int)getRandom;

+(NSString *)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

+ (float)getStringFromCurrencyStyleString:(NSString *)str;
+ (void)NSNotificationPostNotificationName:(NSString *)notificationName DictInfo:(NSMutableDictionary *)dict;

+ (void) alignLabelWithTop:(UILabel *)label;

+ (UIImage *)convertImageFromView:(UIView *)view;

+ (NSString *)getSystemDateByFormated;

+ (NSString *)getSystemTimeByFormated;

+ (BOOL)isContactNumberValid:(NSString *)number;

+ (float)getAttributeAdjustPrice:(NSString *)productValuePrice;

+ (UIColor *)colorFromHexString:(NSString *)hex;


+ (UIImage *)imageWithColor:(UIColor *)color;

+(BOOL)isEmailValid:(NSString *)emailAddress;

+ (NSString*) translateFromWindowsTimezone: (NSString*) timezoneName;

+ (void)saveStringValue:(NSString *)value ForKey:(NSString *)key;

+ (NSString *)getStringValueForKey:(NSString *)key;


@end
