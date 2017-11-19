//
//  Order.h
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniversalDelegate.h"
#import "RequestDelegate.h"
#import "Request.h"
#import "CardInfo.h"
#import "ProductInfo.h"
#import "CartItem.h"
#import "Cart.h"

@interface Order : NSObject<RequestDelegate>

@property (nonatomic ,retain) id<UniversalDelegate>univasalDelegate;
@property (nonatomic ,assign) int user_id;
@property (nonatomic ,assign) float amount;
@property (nonatomic ,assign) NSString * product_id;
@property (nonatomic ,assign) NSString * quantity;
@property (nonatomic ,retain) NSString * firstname;
@property (nonatomic ,retain) NSString * lastname;
@property (nonatomic ,retain) NSString * HideNumber;
@property (nonatomic ,retain) NSString * number;
@property (nonatomic ,retain) NSString * cvv;
@property (nonatomic ,retain) NSString * month;
@property (nonatomic ,retain) NSString * year;
@property (nonatomic ,retain) NSString * billing_add;
@property (nonatomic ,retain) NSString * postal_code;
@property (nonatomic ,retain) NSString * email;
@property (nonatomic ,retain) NSString * phone;
@property (nonatomic ,retain) NSString * city;
@property (nonatomic ,retain) NSString * state;
@property (nonatomic ,retain) NSString * token;
@property (nonatomic ,retain) NSString * color_id;
@property (nonatomic ,retain) NSString * size_id;

@property (nonatomic ,retain) NSString * ShipingBilling_add;
@property (nonatomic ,retain) NSString * ShipingPostal_code;
@property (nonatomic ,retain) NSString * ShipingCity;
@property (nonatomic ,retain) NSString * ShipingState;



-(void)postOrderDelegate:(id<UniversalDelegate>)del;

@end
