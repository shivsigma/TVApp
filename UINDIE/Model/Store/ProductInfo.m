//
//  ProductInfo.m
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ProductInfo.h"

@implementation ProductInfo
@synthesize productAttributes;


+(ProductInfo *)parseWithDictionary:(NSDictionary *)dict{
    ProductInfo * info = [[ProductInfo alloc]init];
    if([dict objectForKey:@"product_id"]){
        info.product_id = [[dict objectForKey:@"product_id"]intValue];
    }
    if([dict objectForKey:@"product_title"]){
        info.product_title = [dict objectForKey:@"product_title"];
    }
    if([dict objectForKey:@"product_desc"]){
        info.product_desc = [dict objectForKey:@"product_desc"];
    }
    if([dict objectForKey:@"product_price"]){
        info.product_price = [[dict objectForKey:@"product_price"]floatValue];
    }
    if([dict objectForKey:@"product_img"]){
        info.productImageArr = [[NSMutableArray alloc]init];
        NSArray * aar = [dict objectForKey:@"product_img"];
        for (NSDictionary * dic in aar) {
            [info.productImageArr addObject:[dic objectForKey:@"images"]];
        }
    }
    
    if([dict objectForKey:@"productAttribute"]){
        info.productAttributes = [[NSMutableArray alloc]init];
        NSArray * aar = [dict objectForKey:@"productAttribute"];
        for (NSDictionary * dic in aar) {
            ProductAttributeInfo * inff = [ProductAttributeInfo parseWithDict:dic];
            
            [info.productAttributes addObject:inff];
        }
    }
    
    
    
    if([dict objectForKey:@"product_tax"]){
        info.product_tax = [[dict objectForKey:@"product_tax"]floatValue];
    }
   
    
    if([dict objectForKey:@"product_tags"]){
        info.product_tags = [dict objectForKey:@"product_tags"];
    }
    return info;
}

@end
