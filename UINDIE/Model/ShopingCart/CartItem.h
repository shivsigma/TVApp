//
//  CartItem.h
//  UINDIE
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfo.h"
@class ProductAttributeInfo;
@interface CartItem : NSObject

@property (nonatomic, readwrite, retain) ProductInfo *product;
@property (nonatomic, readwrite, retain) ProductAttributeInfo *productAtt;
@property (nonatomic, assign) int qty;

+ (CartItem*) initWithProduct:(ProductInfo*) product;

@end
