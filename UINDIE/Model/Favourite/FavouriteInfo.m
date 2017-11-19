//
//  FavouriteInfo.m
//  UINDIE
//
//  Created by Savan Shah on 10/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "FavouriteInfo.h"

@implementation FavouriteInfo
@synthesize fev_id=_fev_id;
@synthesize cat_id=_cat_id;
@synthesize user_id=_user_id;
@synthesize fev_status=_fev_status;
@synthesize videoArr=_videoArr;
@synthesize video_id= _video_id;
@synthesize video_title= _video_title;
@synthesize video_name= _video_name;
@synthesize video_status= _video_status;
@synthesize duration= _duration;
@synthesize video_img= _video_img;
@synthesize description= _description;
@synthesize provider= _provider;

+(FavouriteInfo *)parseWithDictionary:(NSDictionary *)dict{
    FavouriteInfo * info =[[FavouriteInfo alloc]init];
    
    if ([dict objectForKey:@"fev_id"]) {
        info.fev_id = [[dict objectForKey:@"fev_id"]intValue];
    }
    
    if ([dict objectForKey:@"video"])
    {
      NSMutableDictionary * arr = [dict objectForKey:@"video"];
            if ([arr objectForKey:@"video_id"]!=[NSNull null])
            {
                info.video_id = [[arr objectForKey:@"video_id"]intValue];
            }
            if ([arr objectForKey:@"video_title"]) {
                info.video_title = [arr objectForKey:@"video_title"];
            }
            if ([arr objectForKey:@"video_name"]) {
                info.video_name = [arr objectForKey:@"video_name"];
            }
            if ([arr objectForKey:@"video_status"]) {
                info.video_status = [arr objectForKey:@"video_status"];
            }
            if ([arr objectForKey:@"duration"])
            {
                info.duration = [arr objectForKey:@"duration"];
            }
            if ([arr objectForKey:@"video_img"])
            {
                info.video_img = [arr objectForKey:@"video_img"];
            }
        
        if ([arr objectForKey:@"description"])
        {
            info.description = [arr objectForKey:@"description"];
        }

        if ([arr objectForKey:@"provider"])
        {
            info.provider = [arr objectForKey:@"provider"];
        }
    }

    if ([dict objectForKey:@"cat_id"]) {
        info.cat_id = [[dict objectForKey:@"cat_id"]intValue];
    }
    
    if ([dict objectForKey:@"user_id"]) {
        info.user_id = [[dict objectForKey:@"user_id"]intValue];
    }
    
    if ([dict objectForKey:@"fev_status"]) {
        info.fev_status = [[dict objectForKey:@"fev_status"]intValue];
    }
    
       return info;
}

@end
