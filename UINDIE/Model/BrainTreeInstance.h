//
//  BrainTreeInstance.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 10/15/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelListLoadedDelegate.h"
#import "UniversalDelegate.h"
#import "RequestDelegate.h"
#import "Request.h"
#import "URLSchema.h"
#import "GetCardsInfo.h"
#import "Order.h"

@interface BrainTreeInstance : NSObject<RequestDelegate>{
    id<ModelListLoadedDelegate> _del;
        NSMutableArray * _getCardArr;
}

@property (nonatomic ,retain) NSMutableArray * getCardArr;
@property (nonatomic ,retain) id<ModelListLoadedDelegate> del;
@property (nonatomic ,retain) id<UniversalDelegate> udelegate;
@property (nonatomic ,retain) NSString * client_token;


+(BrainTreeInstance *)Instance;

-(void)getClientTokenWithUserID:(id<ModelListLoadedDelegate>)delegate;

-(NSMutableArray *)getAllCards;
-(void)GETAllCardsDetails:(id<ModelListLoadedDelegate>)delegate;

- (void) postOrderWithBraintree:(Order *)order Delegate:(id<UniversalDelegate>) uDelegate;



//// delete credit card 
-(void)DeleteCreditCard:(GetCardsInfo *)cardinfo Delegate:(id<ModelListLoadedDelegate>)delegate;
- (void)removeItembyTableEditRowFromCreditcard:(GetCardsInfo *)item;
- (int)Find:(GetCardsInfo *)item;
@end
