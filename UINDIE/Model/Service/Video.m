//
//  Video.m
//  UINDIE
//
//  Created by apple on 3/23/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Video.h"

@implementation Video
@synthesize url=_url;
@synthesize startTime=_startTime;
@synthesize endTime=_endTime;
@synthesize duration=_duration;
@synthesize title=_title;
@synthesize provider=_provider;
@synthesize description=_description;
@synthesize on_demand = _on_demand;

+(Video *)parseWithDict:(NSDictionary *)dict{
    Video * info  = [[Video alloc]init];
    
    if ([dict objectForKey:@"url"]!= [NSNull null]) {
        info.url = [dict objectForKey:@"url"];
    }
    if ([dict objectForKey:@"starttime"]!= [NSNull null]) {
        info.startTime = [dict objectForKey:@"starttime"];
        //info.startTime = @"01:00:00";
    }
    if ([dict objectForKey:@"endtime"]!= [NSNull null]) {
        info.endTime = [dict objectForKey:@"endtime"];
    }
    if ([dict objectForKey:@"duration"]!= [NSNull null]) {
        info.duration = [dict objectForKey:@"duration"];
    }
    if ([dict objectForKey:@"video_title"]!= [NSNull null]) {
        info.title = [dict objectForKey:@"video_title"];
    }
    if ([dict objectForKey:@"title"]) {
        info.title = [dict objectForKey:@"title"];
    }
    
    if ([dict objectForKey:@"provider"]!= [NSNull null]) {
        info.provider = [dict objectForKey:@"provider"];
    }
    if ([dict objectForKey:@"description"]!= [NSNull null]) {
        info.description = [dict objectForKey:@"description"];
    }
    if ([dict objectForKey:@"on_demand"]) {
        info.on_demand = [[dict objectForKey:@"on_demand"]boolValue];
    }
    
    
    if ([dict objectForKey:@"is_fav"] != [NSNull null]) {
        if ([[dict objectForKey:@"is_fav"] isEqual:@"1"]) {
          info.is_fav = YES;
        }else{
         info.is_fav = NO;
        }
       
    }
    if ([dict objectForKey:@"video_id"] != [NSNull null]) {
      info.video_id = [[dict objectForKey:@"video_id"]intValue];
    }
    if ([dict objectForKey:@"video_img"] != [NSNull null]) {
        info.video_img = [dict objectForKey:@"video_img"];
    }
    return info;
}

@end
