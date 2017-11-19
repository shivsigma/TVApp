//
//  ProductValueInfo.h
//  UINDIE
//
//  Created by Savan Shah on 7/23/16.
//
//

#import <Foundation/Foundation.h>
@class ProductInfo;
@class ProductAttributeInfo;

@interface ProductValueInfo : NSObject
@property (nonatomic ,assign) int Id;
//@property (nonatomic ,retain) ProductAttributeInfo * pa;

@property (nonatomic ,retain) NSString * name;

+ (ProductValueInfo *) parseWithDict:(NSDictionary *)dict;
@end
