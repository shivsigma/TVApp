//
//  CategoryInfo.h
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInfo.h"
@interface CategoryInfo : NSObject{
    int _cat_id;
    NSString * _category_name;
    NSMutableArray * _productArray;
}
@property (nonatomic ,assign) int cat_id;
@property (nonatomic ,retain) NSString * category_name;
@property (nonatomic ,retain) NSMutableArray * productArray;

+ (CategoryInfo *)parseWithDictionary:(NSDictionary *)dict;

@end
