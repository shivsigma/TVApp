//
//  ServiceInfo.h
//  UINDIE
//
//  Created by apple on 2/24/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"
#import "ProductInfo.h"

@interface ServiceInfo : NSObject{
    NSString * _category_name;
    NSString * _broadcast_date;
    NSString * _broadcast_time;
    NSMutableArray * _videoArray;
    NSString * _endbroadcast;
    NSString * _total_duration;
    NSString * _total_second;
    BOOL _cat_status;
    NSString * _playtime;
    int _cat_id;
    NSDate * _date;
    NSString * _broadcast_dateTime;
    
   NSMutableArray * _productArray;
}
@property (nonatomic ,retain) NSString * category_name;
@property (nonatomic ,retain) NSString * CateDescription;
@property (nonatomic ,retain) NSString * broadcast_date;
@property (nonatomic ,retain) NSString * broadcast_time;
@property (nonatomic ,retain) NSString * endbroadcast;
@property (nonatomic ,retain) NSString * total_duration;
@property (nonatomic ,retain) NSString * total_second;
@property (nonatomic ,assign) BOOL cat_status;
@property (nonatomic ,retain) NSString * playtime;
@property (nonatomic ,assign) int cat_id;
@property (nonatomic ,retain) NSMutableArray * videoArray;
@property (nonatomic ,retain) NSDate * dateTime;
@property (nonatomic ,retain) NSDate * date;
@property (nonatomic ,retain) NSString * broadcast_dateTime;
@property (nonatomic ,retain) NSMutableArray * productArray;

+ (ServiceInfo *)parseWithDictionary:(NSDictionary *)dict;
/*
 cat_id: "13"
 category_name: "savan 123"
 video: [...24]-
 broadcast_date: "04/02/2015"
 broadcast_time: "08:38:00:PM"
 endbroadcast: "10:24:17:PM"
 total_duration: "01:46:17"
 total_second: "6377"
 cat_status: "true"
 playtime: "00:08:32"
 */
@end
