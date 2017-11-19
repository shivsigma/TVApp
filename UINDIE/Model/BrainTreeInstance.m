//
//  BrainTreeInstance.m
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 10/15/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "BrainTreeInstance.h"
static  BrainTreeInstance * Singleton = nil;
@implementation BrainTreeInstance
@synthesize getCardArr=_getCardArr;
+(BrainTreeInstance *)Instance
{
    if (Singleton == nil) {
        Singleton = [[BrainTreeInstance alloc]init];
    }
    return Singleton;
}



///////////////////////// delete credit card ////////////

-(void)DeleteCreditCard:(GetCardsInfo *)cardinfo Delegate:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request * request = [[Request alloc]initWithUrlPart:DELETE_CREDITCARD andDelegate:self andMethod:POST];
     Account * account = [AccountManager Instance].activeAccount;
     [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:cardinfo.token forKey:@"token"];
    request.Tag=DELETE_CREDITCARD;
    [request startRequest];
}

- (void)removeItembyTableEditRowFromCreditcard:(GetCardsInfo *)item {
    
    if ([_getCardArr containsObject:item]) {
        int index = [self Find:item];
        [_getCardArr removeObjectAtIndex:index];
    }
}


- (int)Find:(GetCardsInfo *)item {
    
    for (int i = 0; i < [_getCardArr count]; i++) {
        GetCardsInfo *cii = [_getCardArr objectAtIndex:i];
        if([cii isEqual:item]){
            return i;
        }
    }
    return -1;
}

////////////////////////////////////////////////////////



#pragma getcards 

-(NSMutableArray *)getAllCards{
    
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    
    for (GetCardsInfo * info in _getCardArr)
    {
        [temp addObject:info];
    }
    return temp;
}

-(void)GETAllCardsDetails:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request * request = [[Request alloc]initWithUrlPart:GET_CARDS andDelegate:self andMethod:POST];
    Account * account = [AccountManager Instance].activeAccount;
    //NSLog(@"user id %d",account.userId);
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    request.Tag=GET_CARDS;
    [request startRequest];
}

-(NSString *)getProductId{
    
    NSMutableArray * pro = [[NSMutableArray alloc]init];
    
    for (CartItem * ci in [Cart Instance].productsInCart) {
        [pro addObject:[NSString stringWithFormat:@"%d",ci.product.product_id]];
    }
    
    return [pro componentsJoinedByString:@","];
}

- (NSString *)getProductQty{
    NSMutableArray * pro = [[NSMutableArray alloc]init];
    
    for (CartItem * ci in [Cart Instance].productsInCart) {
        [pro addObject:[NSString stringWithFormat:@"%d",ci.qty]];
    }
    
    return [pro componentsJoinedByString:@","];
}

- (NSString *)getProductColor{
    NSMutableArray * pro = [[NSMutableArray alloc]init];
    
    for (CartItem * ci in [Cart Instance].productsInCart) {
        NSString * nameStr = @"-1";
        if ([ci.productAtt.name isEqual:@"color"] && ci.productAtt.pv != nil) {
            nameStr = [NSString stringWithFormat:@"%d",ci.productAtt.pv.Id];
        }
        [pro addObject:nameStr];
    }
    return [pro componentsJoinedByString:@","];
}
- (NSString *)getProductSize{
    NSMutableArray * pro = [[NSMutableArray alloc]init];
    
    for (CartItem * ci in [Cart Instance].productsInCart) {
        NSString * nameStr = @"-1";
        if ([ci.productAtt.name isEqual:@"size"] && ci.productAtt.pv != nil) {
            nameStr = [NSString stringWithFormat:@"%d",ci.productAtt.pv.Id];
        }
        [pro addObject:nameStr];
    }
    return [pro componentsJoinedByString:@","];
}


-(void)postOrderWithBraintree:(Order *)order Delegate:(id<UniversalDelegate>)uDelegate{
    _udelegate=uDelegate;
   
    Request * request = [[Request alloc]initWithUrlPart:FINAL_ORDER andDelegate:self andMethod:POST];
    Account * account = [AccountManager Instance].activeAccount;
    
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:order.token forKey:@"token"];
   //  order.amount = 1.0;
    [request setParameter:[NSNumber numberWithFloat:order.amount] forKey:@"amount"];
    [request setParameter:order.billing_add forKey:@"billing_add"];
    [request setParameter:order.postal_code forKey:@"postal_code"];
    [request setParameter:account.email forKey:@"email"];
    [request setParameter:@"" forKey:@"phone"];
    [request setParameter:[self getProductId] forKey:@"product_id"];
    [request setParameter:[self getProductQty] forKey:@"quantity"];
    [request setParameter:[self getProductColor] forKey:@"color_id"];
    [request setParameter:[self getProductSize] forKey:@"size_id"];
    [request setParameter:order.ShipingBilling_add forKey:@"shiping_add"];
    [request setParameter:order.ShipingPostal_code forKey:@"ship_postal_code"];
    [request setParameter:order.ShipingCity forKey:@"ship_city"];
    [request setParameter:order.ShipingState forKey:@"ship_state"];
    /*
     shiping_add
     ship_postal_code
     ship_city
     ship_state
     */
    

    
    request.Tag = FINAL_ORDER;
    
    [request startRequest];

}
-(void)getClientTokenWithUserID:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request *request = [[Request alloc] initWithUrlPart:CLIENT_TOKEN andDelegate:self andMethod:POST];
    Account * account = [AccountManager Instance].activeAccount;
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    request.Tag=CLIENT_TOKEN;
    [request startRequest];
}

#pragma RequestDelegate
-(void)requestDidSucceed:(Request *)request{
    
    if([request.Tag isEqual:CLIENT_TOKEN])
    {
    NSDictionary * dict = [request.responseData objectForKey:@"Data"];
    _client_token = [dict objectForKey:@"client_token"];
        if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_del ModelListLoadedSuccessfullyTag:request.Tag];
        }

    }
    else if ([request.Tag isEqual:GET_CARDS])
    {
        NSArray * DataArray = [request.responseData objectForKey:@"Data"];
        
        _getCardArr = [[NSMutableArray alloc]init];
        if (DataArray != (id)[NSNull null])
        {
            for (NSDictionary * dict in DataArray) {
                GetCardsInfo * info = [GetCardsInfo parseWithDictionary:dict];
                
                [_getCardArr addObject:info];
            }
        }
        if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_del ModelListLoadedSuccessfullyTag:request.Tag];
        }

    }
    else if([request.Tag isEqual:FINAL_ORDER])
    {
        NSDictionary * dict = [request.responseData objectForKey:@"Data"];
        if (_udelegate && [_udelegate respondsToSelector:@selector(DataAddedSuccessfully:)]) {
            [_udelegate DataAddedSuccessfully:request.Tag];
        }

        
    }
    else if([request.Tag isEqual:DELETE_CREDITCARD])
    {
        NSArray * dic = [request.responseData objectForKey:@"Data"];
        if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_del ModelListLoadedSuccessfullyTag:request.Tag];
        }
    }
    
    
    // [[NSNotificationCenter defaultCenter]postNotificationName:@"XXXX" object:nil];
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error{
    
     if([request.Tag isEqual:FINAL_ORDER]){
        if (_udelegate && [_udelegate respondsToSelector:@selector(DataAddFailedWithError:)]){
            [_udelegate DataAddFailedWithError:[error.userInfo objectForKey:@"message"]];
        }
     }else{
         if (_del && [_del respondsToSelector:@selector(ModelListLoadFailWithError:)]) {
             [_del ModelListLoadFailWithError:[error.userInfo objectForKey:@"message"]];
         }
     }
}


@end
