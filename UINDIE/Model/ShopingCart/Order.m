//
//  Order.m
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize user_id=_user_id;
@synthesize amount=_amount;
@synthesize product_id=_product_id;
@synthesize quantity=_quantity;
@synthesize firstname=_firstname;
@synthesize lastname=_lastname;
@synthesize number=_number;
@synthesize cvv=_cvv;
@synthesize month=_month;
@synthesize year=_year;
@synthesize billing_add=_billing_add;
@synthesize postal_code=_postal_code;
@synthesize email=_email;
@synthesize phone=_phone;
@synthesize city=_city;
@synthesize state=_state;


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



//if (cartItem.productAtt) {
//    _lblAttribute.text = cartItem.productAtt.name;
//}
//if (cartItem.productAtt.pv){
//    _lblAttribute.text = [_lblAttribute.text stringByAppendingFormat:@",%@",cartItem.productAtt.pv.name];
//}

-(void)postOrderDelegate:(id<UniversalDelegate>)del
{
    _univasalDelegate = del;
    Request * request = [[Request alloc]initWithUrlPart:ONE_TIME_PAYMENT andDelegate:self andMethod:POST];
    Account * account = [AccountManager Instance].activeAccount;
    //self.amount = 1.00;
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:[NSNumber numberWithFloat:self.amount] forKey:@"amount"];
    [request setParameter:[self getProductId] forKey:@"product_id"];
    [request setParameter:[self getProductQty] forKey:@"quantity"];
    
    [request setParameter:account.first_name forKey:@"firstname"];
    [request setParameter:account.last_name forKey:@"lastname"];
    [request setParameter:self.number forKey:@"number"];
    if (self.cvv.length <= 0) {
        self.cvv =@"123";
    }
    [request setParameter:self.cvv forKey:@"cvv"];
    [request setParameter:[self getProductColor] forKey:@"color_id"];
    [request setParameter:[self getProductSize] forKey:@"size_id"];
    [request setParameter:self.month forKey:@"month"];
    [request setParameter:self.year forKey:@"year"];
    
    [request setParameter:self.billing_add forKey:@"billing_add"];
    [request setParameter:self.postal_code forKey:@"postal_code"];
    [request setParameter:account.email forKey:@"email"];
    [request setParameter:@"" forKey:@"phone"];
    [request setParameter:self.city forKey:@"city"];
    [request setParameter:self.state forKey:@"state"];
    
    
    [request setParameter:self.ShipingBilling_add forKey:@"shiping_add"];
    [request setParameter:self.ShipingPostal_code forKey:@"ship_postal_code"];
    [request setParameter:self.ShipingCity forKey:@"ship_city"];
    [request setParameter:self.ShipingState forKey:@"ship_state"];
    
    
    request.Tag = ONE_TIME_PAYMENT;
    
    [request startRequest];
}

#pragma RequestDelegate
-(void)requestDidSucceed:(Request *)request{
    NSString * message = [request.responseData objectForKey:@"message"];
if (_univasalDelegate && [_univasalDelegate respondsToSelector:@selector(DataAddedSuccessfully:)]) {
    [_univasalDelegate DataAddedSuccessfully:message];
}
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error{
    if (_univasalDelegate && [_univasalDelegate respondsToSelector:@selector(DataAddFailedWithError:)]) {
        [_univasalDelegate DataAddFailedWithError:[error.userInfo objectForKey:@"message"]];
    }
    
}


@end
