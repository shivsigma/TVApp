//
//  Video.h
//  UINDIE
//
//  Created by apple on 3/23/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
{
    NSString * _url;
    NSString * _startTime;
    NSString * _endTime;
    NSString * _duration;
    NSString * _title;
    NSString * _provider;
    NSString * _description;
    BOOL is_fav;
    int _video_id;
    NSString * video_img;
    BOOL _on_demand;
}
@property (nonatomic ,retain) NSString * url;
@property (nonatomic ,retain) NSString * startTime;
@property (nonatomic ,retain) NSString * endTime;
@property (nonatomic ,retain) NSString * duration;
@property (nonatomic ,retain) NSString * title;
@property (nonatomic ,retain) NSString * provider;
@property (nonatomic ,retain) NSString * description;
@property (nonatomic ,assign) BOOL is_fav;
@property (nonatomic ,assign) int video_id;
@property (nonatomic ,retain) NSString * video_img;
@property (nonatomic ,assign) BOOL on_demand;


/*
 url: "http://adminofunidie.uindie.net/application/controllers/video/03052015094303.mov"
 duration: "00:01:00"
 title: "COUNTER!!!"
 provider: ""
 description: ""
 is_fav: null
 */
+ (Video *)parseWithDict:(NSDictionary *)dict;

@end
