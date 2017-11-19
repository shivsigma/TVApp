//
//  Cart.m
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Cart.h"
static  Cart * Singleton = nil;
@implementation Cart
+(Cart *)Instance
{
    if (Singleton == nil) {
        Singleton = [[Cart alloc]init];
        Singleton.productsInCart =[[NSMutableArray alloc]init];
    }
    return Singleton;
}

+(void)clearInstance{
    Singleton = nil;
}

-(int)cartProductQty{
    return _ci.qty;
}

-(void)addCartItemInList:(CartItem *)item{

    if (![_productsInCart containsObject:item]) {
        [_productsInCart addObject:item];
    }else
    {
        int index = [self Find:item];
        if(index >= 0)
        {
            _ci = [_productsInCart objectAtIndex:index];
            if ([_ci isEqual:[_productsInCart objectAtIndex:index]]) {
                _ci.qty = item.qty;
            }else{
                //item.qty = 1;
                [_productsInCart addObject:item];
            }
        }
    }
}

- (void)removeItembyQtyFromCart:(CartItem *)item {
    
    if ([_productsInCart containsObject:item]) {
        int index = [self Find:item];
        if(index >= 0){
            _ci = [_productsInCart objectAtIndex:index];
            if ([_ci isEqual:[_productsInCart objectAtIndex:index]]) {
                _ci.qty = _ci.qty -1;
            }else{
                item.qty = 1;
                [_productsInCart addObject:item];
            }
        }
    }
}


- (void)removeItembyTableEditRowFromCart:(CartItem *)item {
    
    if ([_productsInCart containsObject:item]) {
        int index = [self Find:item];
        [_productsInCart removeObjectAtIndex:index];
    }
   }


- (int)Find:(CartItem *)item {
    for (int i = 0; i < [_productsInCart count]; i++)
    {
        CartItem *cii = [_productsInCart objectAtIndex:i];
        if([cii isEqual:item]){
            return i;
        }
    }
    return -1;
}
- (float) cartTotal{
    float total = 0.0f;
    for (CartItem *cia in _productsInCart)
    {
        total += (cia.product.product_price * cia.qty) + (cia.product.product_tax * cia.qty);
        
    }
    return  total;
}
-(float) cartTax
{
    float tax = 0.0f;
    for (CartItem * ct in _productsInCart) {
        tax+= (ct.product.product_tax * ct.qty);
    }
    return tax;
}

- (float) cartSubTotal{
    float total = 0.0f;
    for (CartItem *cia in _productsInCart) {
        total += (cia.product.product_price * cia.qty);
        
    }
    return  total;
}
@end
