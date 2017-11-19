//
//  Cart.h
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartItem.h"
@interface Cart : NSObject{
    NSMutableArray * _productsInCart;
    CartItem * _ci;
}
@property (nonatomic ,retain) NSMutableArray * productsInCart;

@property (nonatomic ,retain) CartItem * ci;

+ (void)clearInstance;

+ (Cart *)Instance;

-(void)addCartItemInList:(CartItem *)item;

- (int)cartProductQty;

- (void)removeItembyTableEditRowFromCart:(CartItem *)item;
- (int)Find:(CartItem *)item;
- (void)removeItembyQtyFromCart:(CartItem *)item;
- (float) cartTotal;
-(float) cartTax;
- (float) cartSubTotal;

@end
