//
//  NewProductInfo.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import "NewProductInfo.h"

@implementation NewProductInfo
+ (NewProductInfo *)parse:(NSDictionary *)dict{
    NewProductInfo * info = [[NewProductInfo alloc]init];
    if ([dict objectForKey:@"productstore_id"]) {
        info.productstore_id = [dict objectForKey:@"productstore_id"];
    }
    if ([dict objectForKey:@"product_title"]) {
        info.product_title = [dict objectForKey:@"product_title"];
    }
    if ([dict objectForKey:@"product_desc"]) {
        info.product_desc = [dict objectForKey:@"product_desc"];
    }
    if ([dict objectForKey:@"product_price"]) {
        info.product_price = [dict objectForKey:@"product_price"];
    }
    
    if ([dict objectForKey:@"product_img"]) {
        NSArray * tt = [dict objectForKey:@"product_img"];
        info.images = [NSMutableArray new];
        if (tt.count > 0) {
            for (NSDictionary * dd in tt) {
                if ([dd objectForKey:@"images"]) {
                    info.images = [dd objectForKey:@"images"];
                }
            }
        }
        
    }
    
    
    if ([dict objectForKey:@"product_img"]) {
        NSArray * tt = [dict objectForKey:@"product_img"];
        if (tt.count > 0) {
            NSDictionary * dd = [tt objectAtIndex:0];
            if ([dd objectForKey:@"images"]) {
                info.product_img = [dd objectForKey:@"images"];
            }
        }
       
    }
    
    if ([dict objectForKey:@"product_tax"]) {
        info.product_tax = [dict objectForKey:@"product_tax"];
    }
    if ([dict objectForKey:@"product_tags"]) {
        info.product_tags = [dict objectForKey:@"product_tags"];
    }
    if ([dict objectForKey:@"genereid"]) {
        info.genereid = [dict objectForKey:@"genereid"];
    }
    if ([dict objectForKey:@"countryid"]) {
        info.countryid = [dict objectForKey:@"countryid"];
    }
    if ([dict objectForKey:@"countryname"]) {
        info.countryname = [dict objectForKey:@"countryname"];
    }
    if ([dict objectForKey:@"generename"]) {
        info.generename = [dict objectForKey:@"generename"];
    }
    return info;
}

@end
