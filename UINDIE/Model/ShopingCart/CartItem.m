//
//  CartItem.m
//  UINDIE
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CartItem.h"
#import "ProductAttributeInfo.h"
@implementation CartItem
@synthesize product=_product;
@synthesize qty=_qty;

+ (CartItem *)initWithProduct:(ProductInfo *)product {
    CartItem *item = [[CartItem alloc] init];
    item.qty= 1;
    item.product = product;
    return item;
}

@end
