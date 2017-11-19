//
//  ProductInfo.h
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductAttributeInfo.h"


@interface ProductInfo : NSObject{
    int _product_id;
    NSString * _product_title;
    NSString * _product_desc;
    float _product_price;
    NSString * _product_img;
    float  _product_tax;
    int _cat_id;
    NSString * _categoryName;
    NSString * _product_tags;
    NSMutableArray * _productImageArr;
}

@property (nonatomic ,retain) NSMutableArray * productAttributes;
@property (nonatomic ,retain) NSMutableArray * productImageArr;
@property (nonatomic ,assign) int product_id;
@property (nonatomic ,retain) NSString * product_title;
@property (nonatomic ,retain) NSString * product_desc;
@property (nonatomic ,assign) float product_price;
@property (nonatomic ,retain) NSString * product_img;
@property (nonatomic ,assign) float  product_tax;
@property (nonatomic ,assign) int cat_id;
@property (nonatomic ,retain) NSString * categoryName;
@property (nonatomic ,retain) NSString * product_tags;
+ (ProductInfo *)parseWithDictionary:(NSDictionary *)dict;


@end
