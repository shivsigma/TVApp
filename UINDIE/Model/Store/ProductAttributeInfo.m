//
//  ProductAttributeInfo.m
//  UINDIE
//
//  Created by Savan Shah on 7/23/16.
//
//

#import "ProductAttributeInfo.h"
#import "ProductInfo.h"

@implementation ProductAttributeInfo
@synthesize Id = _Id;
@synthesize name=_name;
+ (ProductAttributeInfo *)parseWithDict:(NSDictionary *)dict{
    ProductAttributeInfo * info = [[ProductAttributeInfo alloc]init] ;
    if ([dict objectForKey:@"id"]) {
        info.Id = [[dict objectForKey:@"id"]intValue];
    }
    if ([dict objectForKey:@"name"]) {
        info.name = [dict objectForKey:@"name"];
        if (info.name.length <= 0) {
            info.name  = @"none";
        }
    }
    if([dict objectForKey:@"productVarient"]){
        info.productValue = [[NSMutableArray alloc]init];
        NSArray * aar = [dict objectForKey:@"productVarient"];
        for (NSDictionary * dic in aar) {
            ProductValueInfo * inff = [ProductValueInfo parseWithDict:dic];
            
            //inff.pa = info;
            [info.productValue addObject:inff];
        }
    }
    return info;
}

@end
