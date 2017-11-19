//
//  ServiceInfo.m
//  UINDIE
//
//  Created by apple on 2/24/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ServiceInfo.h"

@implementation ServiceInfo
@synthesize category_name=_category_name;
@synthesize broadcast_date=_broadcast_date;
@synthesize broadcast_time=_broadcast_time;
@synthesize videoArray=_videoArray;
@synthesize cat_id=_cat_id;
@synthesize endbroadcast=_endbroadcast;
@synthesize total_duration=_total_duration;
@synthesize total_second=_total_second;
@synthesize cat_status=_cat_status;
@synthesize playtime=_playtime;
@synthesize broadcast_dateTime=_broadcast_dateTime;
@synthesize productArray=_productArray;
@synthesize CateDescription=_CateDescription;

+(ServiceInfo *)parseWithDictionary:(NSDictionary *)dict{
    ServiceInfo * info =[[ServiceInfo alloc]init];
    
    if ([dict objectForKey:@"category_name"]) {
      info.category_name = [dict objectForKey:@"category_name"];
    }
    if ([dict objectForKey:@"cat_id"]) {
        info.cat_id = [[dict objectForKey:@"cat_id"]intValue];
    }
    if ([dict objectForKey:@"description"]) {
        info.CateDescription = [dict objectForKey:@"description"];
    }
    
    if ([dict objectForKey:@"endbroadcast"]) {
        info.endbroadcast = [dict objectForKey:@"endbroadcast"];
    }
    
    if ([dict objectForKey:@"total_duration"]) {
        info.total_duration = [dict objectForKey:@"total_duration"];
    }
    
    if ([dict objectForKey:@"total_second"]) {
        info.total_second = [dict objectForKey:@"total_second"];
    }
    
    if ([dict objectForKey:@"cat_status"]) {
        info.cat_status = [dict objectForKey:@"cat_status"];
    }
    
    if ([dict objectForKey:@"playtime"]) {
        info.playtime = [dict objectForKey:@"playtime"];
    }
    
    if ([dict objectForKey:@"video"])
    {
        info.videoArray = [[NSMutableArray alloc]init];
        NSArray * arr = [dict objectForKey:@"video"];
        for (NSDictionary * subDict in arr) {
            Video * video =[Video parseWithDict:subDict];
            [info.videoArray addObject:video];
        }
    }
    
    if ([dict objectForKey:@"product"])
    {
        
        if([[dict objectForKey:@"product"] isKindOfClass:[NSArray class]] == YES)
        {
            info.productArray = [[NSMutableArray alloc]init];
            NSArray * arr = [dict objectForKey:@"product"];
            for (NSDictionary * subDict in arr)
            {
                ProductInfo * product =[ProductInfo parseWithDictionary:subDict];
                [info.productArray addObject:product];
            }
        }
    }
    
    if ([dict objectForKey:@"broadcast_date"]) {
        info.broadcast_date  = [dict objectForKey:@"broadcast_date"];
        
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MM-dd-yyyy"];  // 09:30 AM
//        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-7]]; // For GMT+1
//        NSDate * time = [formatter dateFromString:info.broadcast_date];
//    
//        info.date =time;
        
    }
    
    
    /*if ([dict objectForKey:@"broadcast_time"]) {
        NSString * temp = [dict objectForKey:@"broadcast_time"];
        NSArray * tempArr = [temp componentsSeparatedByString:@":"];
        info.broadcast_time  = [NSString stringWithFormat:@"%@:%@:%@",[tempArr objectAtIndex:0],[tempArr objectAtIndex:1],@"00"];
    }
    
    
    if ([dict objectForKey:@"broadcast_date"] && [dict objectForKey:@"broadcast_time"]) {
        NSString * temp = [dict objectForKey:@"broadcast_time"];
        NSArray * tempArr = [temp componentsSeparatedByString:@":"];
         NSString * temp1  = [NSString stringWithFormat:@"%@:%@:%@",[tempArr objectAtIndex:0],[tempArr objectAtIndex:1],@"00"];
        
        NSString * dateString = [NSString stringWithFormat:@"%@ %@",info.broadcast_date,temp1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy hh:mm:ss"];  // 09:30 AM
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-7]]; // For GMT+1
        NSDate * time = [formatter dateFromString:dateString];
        
        info.dateTime  = time;
    }
*/
    
    
    if ([dict objectForKey:@"broadcast_time"]) {
        NSString * temp = [dict objectForKey:@"broadcast_time"];
        NSArray * tempArr = [temp componentsSeparatedByString:@":"];
        info.broadcast_time  = [NSString stringWithFormat:@"%@:%@ %@",[tempArr objectAtIndex:0],[tempArr objectAtIndex:1],[tempArr objectAtIndex:2]];
        if ([info.broadcast_time isEqualToString:@"00:22 AM"]) {
            NSLog(@"");
        }
    }
    if ([dict objectForKey:@"broadcast_date"] && [dict objectForKey:@"broadcast_time"]) {
        info.broadcast_dateTime = [NSString stringWithFormat:@"%@ %@",info.broadcast_date,info.broadcast_time];
    }
    
    return info;
}

@end
