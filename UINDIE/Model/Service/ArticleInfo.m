//
//  ArticleInfo.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra on 7/24/17.
//
//

#import "ArticleInfo.h"

@implementation ArticleInfo

+ (ArticleInfo *)parse:(NSDictionary *)dict{
    ArticleInfo * info = [[ArticleInfo alloc]init];
    if ([dict objectForKey:@"product_id"]) {
        info.productId = [dict objectForKey:@"product_id"];
    }
    if ([dict objectForKey:@"product_title"]) {
        info.productTitle = [dict objectForKey:@"product_title"];
    }
    if ([dict objectForKey:@"product_desc"]) {
        info.productDesc = [dict objectForKey:@"product_desc"];
    }
    if ([dict objectForKey:@"product_source"]) {
        info.productSource = [dict objectForKey:@"product_source"];
    }
    if ([dict objectForKey:@"datess"]) {
        info.productDatess = [dict objectForKey:@"datess"];
    }
    if ([dict objectForKey:@"product_desc"]) {
        info.product_desc = [dict objectForKey:@"product_desc"];
    }
    if ([dict objectForKey:@"product_img"]) {
        info.productsImages = [NSMutableArray new];
        for (NSDictionary * dd in [dict objectForKey:@"product_img"]) {
            [info.productsImages addObject:[dd objectForKey:@"images"]];
        }
    }
    return info;
}

@end
