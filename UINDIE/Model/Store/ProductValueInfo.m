//
//  ProductValueInfo.m
//  UINDIE
//
//  Created by Savan Shah on 7/23/16.
//
//

#import "ProductValueInfo.h"

@implementation ProductValueInfo
@synthesize Id = _Id;
@synthesize name=_name;
+ (ProductValueInfo *)parseWithDict:(NSDictionary *)dict{
    ProductValueInfo * info = [[ProductValueInfo alloc]init] ;
    if ([dict objectForKey:@"id"]) {
        info.Id = [[dict objectForKey:@"id"]intValue];
    }
    if ([dict objectForKey:@"color_name"]) {
        info.name = [dict objectForKey:@"color_name"];
        if (info.name.length <= 0) {
            info.name  = @"none";
        }
    }
    
    if ([dict objectForKey:@"size_id"]) {
        info.Id = [[dict objectForKey:@"size_id"]intValue];
    }
    if ([dict objectForKey:@"size_name"]) {
        info.name = [dict objectForKey:@"size_name"];
        if (info.name.length <= 0) {
            info.name  = @"none";
        }
    }
    return info;
}

@end
