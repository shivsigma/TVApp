//
//  Store.m
//  UINDIE
//
//  Created by apple on 7/6/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Store.h"
static  Store * Singleton = nil;
@implementation Store

+(Store *)Instance
{
    if (Singleton == nil) {
        Singleton = [[Store alloc]init];
        Singleton.categoryArray =[[NSMutableArray alloc]init];
    }
    return Singleton;
}

-(NSMutableArray *)getCategoryArray{
    return _categoryArray;
}

-(NSMutableArray *)getAllProduct{
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    
  //  for (CategoryInfo * info in _categoryArray) {
        for (ProductInfo * pinfo in _categoryArray) {
            [temp addObject:pinfo];
            
        }
   // }
    return temp;
}

-(CategoryInfo *)getProductByCateId:(int)cid{
    if (_categoryArray && _categoryArray.count <= 0) {
        return nil;
    }
    for (CategoryInfo * info in _categoryArray) {
        if (info.cat_id == cid) {
            return  info;
        }
    }
    return [_categoryArray objectAtIndex:0];
}
-(void)loadAllProductDelegate:(id<ModelListLoadedDelegate>)delegate{
    _modelDelegate = delegate;
    if(_categoryArray.count <= 0){
        Request * request = [[Request alloc]initWithUrlPart:PRODUCT andDelegate:self andMethod:GET];
        request.Tag = PRODUCT;
        [request startRequest];
    }else{
        if(_modelDelegate && [_modelDelegate respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]){
            [_modelDelegate ModelListLoadedSuccessfullyTag:PRODUCT];
        }
    }
}

#pragma RequestDelegate
-(void)requestDidSucceed:(Request *)request{
    NSArray * DataArray = [request.responseData objectForKey:@"Data"];
    
    self.categoryArray = [[NSMutableArray alloc]init];
    if (DataArray != (id)[NSNull null]){
        
        for (NSDictionary * dict in DataArray) {
            ProductInfo * info = [ProductInfo parseWithDictionary:dict];
            [self.categoryArray addObject:info];
        }
    }
    if (_modelDelegate && [_modelDelegate respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
        [_modelDelegate ModelListLoadedSuccessfullyTag:request.Tag];
    }
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error{
    if (_modelDelegate && [_modelDelegate respondsToSelector:@selector(ModelListLoadFailWithError:)]) {
        [_modelDelegate ModelListLoadFailWithError:[error.userInfo objectForKey:@"message"]];
    }
    
}
@end
