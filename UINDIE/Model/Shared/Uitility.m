//
//  Uitility.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/12/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Uitility.h"



@implementation Uitility

+ (CGRect) getWindowSize{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}
//+(UIImage*) getThumbnailFromVideo:(NSString *)urls
//{
//    
//}
+ (NSString *) platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}





+ (NSMutableArray *)getStyleCurrencyFormat:(float)str{
    
    NSString * tem =[Uitility getCurrencyStringFromAmount:str];
    
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    NSArray * com =[tem componentsSeparatedByString:@"."];
    
    [temp addObject:[com objectAtIndex:0]];
    [temp addObject:[NSString stringWithFormat:@".%@",[com objectAtIndex:1]]];
    return temp;
    
}

+ (NSMutableArray *)getStyleCurrencyFormatType:(NSString *)str{
    
    //NSString * tem =[Utility getCurrencyStringFromAmount:str];
    
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    NSArray * com =[str componentsSeparatedByString:@"."];
    
    [temp addObject:[com objectAtIndex:0]];
    [temp addObject:[NSString stringWithFormat:@".%@",[com objectAtIndex:1]]];
    return temp;
    
}


+ (void) saveValue:(NSString *)value ForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) saveBool:(BOOL)value ForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getBoolForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+(BOOL)isEmailValid:(NSString *)emailAddress{
    
    BOOL isValid = NO;
    NSString *emailString = emailAddress;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""]){
        isValid = YES;
    }
    return  isValid;
}

+ (NSString *)getCurrencyStringFromAmount:(float)amount {
    return [Uitility getCurrencyStringFromAmountString:[NSString stringWithFormat:@"%.2f", amount]];
}

+ (NSString *)getCurrencyStringFromAmountString:(NSString *)amount {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setLenient:YES];
    [formatter setGeneratesDecimalNumbers:YES];
    NSString * temp = [NSString stringWithFormat:@"%@",amount];
    NSDecimalNumber *number = (NSDecimalNumber*) [formatter numberFromString:temp];
    return [formatter stringFromNumber:number];
}
+(float)getStringFromCurrencyStyleString:(NSString *)str{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:str];
    return [number floatValue];
}

+ (int)getRandom {
    int max = 9999;
    int min = 1;
    int randNum = rand() % (max - min) + min;
    return randNum;
}
+(NSString *)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setLenient:YES];
    [formatter setGeneratesDecimalNumbers:YES];
    
    
    NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSDecimalNumber *amount1 = (NSDecimalNumber*) [formatter numberFromString:replaced];
    if (amount1 == nil) {
        
        return NO;
    }
    
    short powerOf10 = 0;
    if ([textField.text isEqualToString:@""]) {
        powerOf10 = -formatter.maximumFractionDigits;
    }
    else if (range.location + formatter.maximumFractionDigits >= textField.text.length) {
        if (range.length) {
            powerOf10 = -range.length;
        }
        
        else {
            powerOf10 = [string length];
        }
    }
    amount1 = [amount1 decimalNumberByMultiplyingByPowerOf10:powerOf10];
    return [formatter stringFromNumber:amount1];
}
+ (void)NSNotificationPostNotificationName:(NSString *)notificationName DictInfo:(NSMutableDictionary *)dict{
    [[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:nil userInfo:dict];
}

+ (void) alignLabelWithTop:(UILabel *)label {
    CGSize maxSize = CGSizeMake(label.frame.size.width,label.frame.size.height);
    label.adjustsFontSizeToFitWidth = NO;
    
    CGSize actualSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
    CGRect rect = label.frame;
    rect.size.height = actualSize.height;
    label.frame = rect;
}



+(UIImage *)convertImageFromView:(UIView *)view
{
    CGRect rect = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *imageCaptureRect;
    
    imageCaptureRect = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return imageCaptureRect;
}

+(NSString *)getSystemDateByFormated{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy";
    return [formatter stringFromDate:[NSDate date]];
}

+(NSString *)getSystemTimeByFormated{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"KK:mm a";
    return [formatter stringFromDate:[NSDate date]];
}
+(BOOL)isContactNumberValid:(NSString *)number{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL phoneValidates = [phoneTest evaluateWithObject:number];
    return phoneValidates;
}
+(float)getAttributeAdjustPrice:(NSString *)productValuePrice{
    if (productValuePrice.length <= 0) {
        productValuePrice = @"$0.00";
    }
    NSArray *subStrings = [productValuePrice componentsSeparatedByString:@"$"];
    NSString *minutes = [subStrings objectAtIndex:1];
    return [minutes floatValue];
}

+ (UIColor *)colorFromHexString:(NSString *)hex {
    //http://stackoverflow.com/questions/6207329/how-to-set-hex-color-code-for-background
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+(NSDate*)getDateString:(NSString *)datestring{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm a"];
    
    NSDate * date =[dateFormatter dateFromString:datestring];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return destinationDate;
}

+(NSDate*)getDateMMDDyyyyString:(NSString *)datestring{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSDate * date =[dateFormatter dateFromString:datestring];
    
    //    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    //
    //    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //
    //    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return date;
}
+ (NSString*) translateFromWindowsTimezone: (NSString*) timezoneName{
    NSDictionary *timezoneDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"Australia/Darwin", @"AUS Central Standard Time",
                                        @"",
                                        @"",
                                        @"",
                                        
                                        @"Asia/Kabul", @"Afghanistan Standard Time",
                                        @"America/Anchorage", @"Alaskan Standard Time",
                                        @"Asia/Riyadh", @"Arab Standard Time",
                                        @"Asia/Baghdad", @"Arabic Standard Time",
                                        @"America/Buenos_Aires", @"Argentina Standard Time",
                                        @"America/Halifax", @"Atlantic Standard Time",
                                        @"Asia/Baku", @"Azerbaijan Standard Time",
                                        @"Atlantic/Azores",@"Azores Standard Time",
                                        @"America/Bahia", @"Bahia Standard Time",
                                        @"Asia/Dhaka", @"Bangladesh Standard Time",
                                        @"America/Regina", @"Canada Central Standard Time",
                                        @"Atlantic/Cape_Verde", @"Cape Verde Standard Time",
                                        @"Asia/Yerevan", @"Caucasus Standard Time",
                                        @"Australia/Adelaide", @"Cen. Australia Standard Time",
                                        @"America/Guatemala", @"Central America Standard Time",
                                        @"Asia/Almaty", @"Central Asia Standard Time",
                                        @"America/Cuiaba", @"Central Brazilian Standard Time",
                                        @"Europe/Budapest", @"Central Europe Standard Time",
                                        @"Europe/Warsaw", @"Central European Standard Time",
                                        @"Pacific/Guadalcanal", @"Central Pacific Standard Time",
                                        @"America/Chicago", @"Central Standard Time",
                                        @"America/Mexico_City", @"Central Standard Time (Mexico)",
                                        @"Asia/Shanghai", @"China Standard Time",
                                        @"Etc/GMT+12", @"Dateline Standard Time",
                                        @"Africa/Nairobi", @"E. Africa Standard Time",
                                        @"Australia/Brisbane", @"E. Australia Standard Time",
                                        @"Asia/Nicosia", @"E. Europe Standard Time",
                                        @"America/Sao_Paulo", @"E. South America Standard Time",
                                        @"America/New_York", @"Eastern Standard Time",
                                        @"Africa/Cairo", @"Egypt Standard Time",
                                        @"Asia/Yekaterinburg", @"Ekaterinburg Standard Time",
                                        @"Europe/Kiev", @"FLE Standard Time",
                                        @"Pacific/Fiji", @"Fiji Standard Time",
                                        @"Europe/London", @"GMT Standard Time",
                                        @"Europe/Bucharest", @"GTB Standard Time",
                                        @"Asia/Tbilisi", @"Georgian Standard Time",
                                        @"America/Godthab", @"Greenland Standard Time",
                                        @"Atlantic/Reykjavik", @"Greenwich Standard Time",
                                        @"Pacific/Honolulu", @"Hawaiian Standard Time",
                                        @"Asia/Calcutta", @"India Standard Time",
                                        @"Asia/Tehran", @"Iran Standard Time",
                                        @"Asia/Jerusalem", @"Israel Standard Time",
                                        @"Asia/Amman", @"Jordan Standard Time",
                                        @"Europe/Kaliningrad", @"Kaliningrad Standard Time",
                                        @"Asia/Seoul", @"Korea Standard Time",
                                        @"Indian/Mauritius", @"Mauritius Standard Time",
                                        @"Asia/Beirut", @"Middle East Standard Time",
                                        @"America/Montevideo", @"Montevideo Standard Time",
                                        @"Africa/Casablanca", @"Morocco Standard Time",
                                        @"America/Denver", @"Mountain Standard Time",
                                        @"America/Chihuahua", @"Mountain Standard Time (Mexico)",
                                        @"Asia/Rangoon", @"Myanmar Standard Time",
                                        @"Asia/Novosibirsk", @"N. Central Asia Standard Time",
                                        @"Africa/Windhoek", @"Namibia Standard Time",
                                        @"Asia/Katmandu", @"Nepal Standard Time",
                                        @"Pacific/Auckland", @"New Zealand Standard Time",
                                        @"America/St_Johns", @"Newfoundland Standard Time",
                                        @"Asia/Irkutsk", @"North Asia East Standard Time",
                                        @"Asia/Krasnoyarsk", @"North Asia Standard Time",
                                        @"America/Santiago", @"Pacific SA Standard Time",
                                        @"America/Los_Angeles", @"Pacific Standard Time",
                                        @"America/Santa_Isabel", @"Pacific Standard Time (Mexico)",
                                        @"Asia/Karachi", @"Pakistan Standard Time",
                                        @"America/Asuncion", @"Paraguay Standard Time",
                                        @"Europe/Paris", @"Romance Standard Time",
                                        @"Europe/Moscow", @"Russian Standard Time",
                                        @"America/Cayenne", @"SA Eastern Standard Time",
                                        @"America/Bogota", @"SA Pacific Standard Time",
                                        @"America/La_Paz", @"SA Western Standard Time",
                                        @"Asia/Bangkok", @"SE Asia Standard Time",
                                        @"Pacific/Apia", @"Samoa Standard Time",
                                        @"Asia/Singapore", @"Singapore Standard Time",
                                        @"Africa/Johannesburg", @"South Africa Standard Time",
                                        @"Asia/Colombo", @"Sri Lanka Standard Time",
                                        @"Asia/Damascus", @"Syria Standard Time",
                                        @"Asia/Taipei", @"Taipei Standard Time",
                                        @"Australia/Hobart", @"Tasmania Standard Time",
                                        @"Asia/Tokyo", @"Tokyo Standard Time",
                                        @"Pacific/Tongatapu", @"Tonga Standard Time",
                                        @"Europe/Istanbul", @"Turkey Standard Time",
                                        @"America/Indianapolis", @"US Eastern Standard Time",
                                        @"America/Phoenix", @"US Mountain Standard Time",
                                        @"Etc/GMT", @"UTC",
                                        @"Etc/GMT-12", @"UTC+12",
                                        @"Etc/GMT+2", @"UTC-02",
                                        @"Etc/GMT+11", @"UTC-11",
                                        @"Asia/Ulaanbaatar", @"Ulaanbaatar Standard Time",
                                        @"America/Caracas", @"Venezuela Standard Time",
                                        @"Asia/Vladivostok", @"Vladivostok Standard Time",
                                        @"Australia/Perth", @"W. Australia Standard Time",
                                        @"Africa/Lagos", @"W. Central Africa Standard Time",
                                        @"Europe/Berlin", @"W. Europe Standard Time",
                                        @"Asia/Tashkent", @"West Asia Standard Time",
                                        @"Pacific/Port_Moresby", @"West Pacific Standard Time",
                                        @"Asia/Yakutsk", @"Yakutsk Standard Time", nil];
    return [timezoneDictionary objectForKey:timezoneName];
}

+ (void)saveStringValue:(NSString *)value ForKey:(NSString *)key{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:value forKey:key];
    [prefs synchronize];
}

+ (NSString *)getStringValueForKey:(NSString *)key{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:key];
    return myString;
}

@end
