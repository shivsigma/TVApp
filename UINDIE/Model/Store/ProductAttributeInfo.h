//
//  ProductAttributeInfo.h
//  UINDIE
//
//  Created by Savan Shah on 7/23/16.
//
//

#import <Foundation/Foundation.h>
#import "ProductValueInfo.h"

@interface ProductAttributeInfo : NSObject


@property (nonatomic ,assign) int Id;
@property (nonatomic ,retain) ProductValueInfo * pv;
@property (nonatomic ,retain) NSString * name;
@property (nonatomic ,retain) NSMutableArray * productValue;

+ (ProductAttributeInfo *) parseWithDict:(NSDictionary *)dict;

@end
