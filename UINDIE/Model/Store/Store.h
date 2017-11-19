//
//  Store.h
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#include "Request.h"
#import "ModelListLoadedDelegate.h"
#import "UniversalDelegate.h"
#import "ProductInfo.h"
#import "CategoryInfo.h"

@interface Store : NSObject<RequestDelegate>{
    NSMutableArray * _categoryArray;
    id<ModelListLoadedDelegate>_modelDelegate;
}
@property (nonatomic ,retain) NSMutableArray * categoryArray;
@property (nonatomic ,retain) id<ModelListLoadedDelegate>modelDelegate;

+(Store *)Instance;
- (NSMutableArray *)getCategoryArray;
- (CategoryInfo *)getProductByCateId:(int)cid;
- (void) loadAllProductDelegate:(id<ModelListLoadedDelegate>)delegate;
-(NSMutableArray *)getAllProduct;

@end
