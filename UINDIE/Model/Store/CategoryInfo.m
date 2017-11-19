//
//  CategoryInfo.m
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CategoryInfo.h"

@implementation CategoryInfo
@synthesize category_name=_category_name;
@synthesize cat_id=_cat_id;
@synthesize productArray=_productArray;

+(CategoryInfo *)parseWithDictionary:(NSDictionary *)dict{
    CategoryInfo * info = [[CategoryInfo alloc]init];
    if([dict objectForKey:@"cat_id"]){
        info.cat_id = [[dict objectForKey:@"cat_id"]intValue];
    }
    if([dict objectForKey:@"category_name"]){
        info.category_name = [dict objectForKey:@"category_name"];
    }
    if([dict objectForKey:@"product"]){
        info.productArray = [[NSMutableArray alloc]init];
        NSArray * temp = [dict objectForKey:@"product"];
        for (NSDictionary * dict in temp) {
            ProductInfo * pinfo = [ProductInfo parseWithDictionary:dict];
            [info.productArray addObject:pinfo];
        }
    }
    return info;
}

@end
