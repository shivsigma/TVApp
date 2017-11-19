//
//  LinkInfo.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 04/10/17.
//
//

#import "LinkInfo.h"

@implementation LinkInfo
+ (LinkInfo *)parse:(NSDictionary *)dict{
    LinkInfo * info = [[LinkInfo alloc]init];
    if ([dict objectForKey:@"id"]) {
        info.entityId = [dict objectForKey:@"id"];
    }
    if ([dict objectForKey:@"video_id"]) {
        info.video_id = [dict objectForKey:@"video_id"];
    }
    if ([dict objectForKey:@"iduser"]) {
        info.iduser = [dict objectForKey:@"iduser"];
    }
    if ([dict objectForKey:@"image_title"]) {
        info.image_title = [dict objectForKey:@"image_title"];
    }
    if ([dict objectForKey:@"image_link"]!= [NSNull null]) {
        info.image_link = [dict objectForKey:@"image_link"];
    }
    if ([dict objectForKey:@"image_name"]) {
        info.image_name = [dict objectForKey:@"image_name"];
    }
    if ([dict objectForKey:@"image_date"]) {
        info.image_date = [dict objectForKey:@"image_date"];
    }
    if ([dict objectForKey:@"image_ext"]) {
        info.image_ext = [dict objectForKey:@"image_ext"];
    }
    if ([dict objectForKey:@"image_filepath"]) {
        info.image_filepath = [dict objectForKey:@"image_filepath"];
    }
    info.image_url = @"http://www.google.com";
    if ([dict objectForKey:@"image_url"]) {
        info.image_url = [dict objectForKey:@"image_url"];
    }
    
    return info;
}

@end
