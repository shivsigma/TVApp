//
//  FavouriteInfo.h
//  UINDIE
//
//  Created by Savan Shah on 10/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FavouriteInfo : NSObject
{
    int  _user_id;
    int  _cat_id;
    int  _fev_id;
    int  _fev_status;
    NSMutableArray * _videoArr;
    
    
    int _video_id;
    NSString * _video_title;
    NSString * _video_name;
    NSString * _video_status;
    NSString * _duration;
    NSString * _video_img;
    NSString *_description;
    NSString * _provider;
    
}

@property (nonatomic ,assign) int cat_id;
@property (nonatomic ,assign) int user_id;
@property (nonatomic ,assign) int fev_id;
@property (nonatomic ,assign) int fev_status;
@property (nonatomic ,retain) NSMutableArray * videoArr;

@property (nonatomic ,assign) int video_id;
@property (nonatomic ,retain) NSString * video_title;
@property (nonatomic ,retain) NSString * video_name;
@property (nonatomic ,retain) NSString * video_status;
@property (nonatomic ,retain) NSString * duration;
@property (nonatomic ,retain) NSString * video_img;
@property (nonatomic ,retain) NSString * description;
@property (nonatomic ,retain) NSString * provider;


+ (FavouriteInfo *)parseWithDictionary:(NSDictionary *)dict;


/*

Data: [1]
0:  {
fev_id: "16"
video: {
    video_id: "66"
    video_title: "Ayo-Chris Brown"
    provider: ""
    video_name: "http://adminofunidie.uindie.net/video/21032015092955.mp4"
    video_status: "active"
    duration: "00:06:00"
    description: "Chris Brown and Tyga are just having fun living life!"
    video_img: "http://adminofunidie.uindie.net/vidimg/17092015044400.jpg"
}-
cat_id: "394"
user_id: "74"
fev_status: "1"
}-
-
message: "Fevourite videos"
 
 
 
  */
@end
