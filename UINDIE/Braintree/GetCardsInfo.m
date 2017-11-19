//
//  GetCardsInfo.m
//  UINDIE
//
//  Created by Savan Shah on 10/14/15.
//  Copyright (c) 2015 NARENDRA MISTRI. All rights reserved.
//

#import "GetCardsInfo.h"

@implementation GetCardsInfo
@synthesize card= _card;
@synthesize exp_date= _exp_date;
@synthesize token= _token;
@synthesize nonce= _nonce;

+(GetCardsInfo *)parseWithDictionary:(NSDictionary *)dict{
    GetCardsInfo * info =[[GetCardsInfo alloc]init];
    
    if ([dict objectForKey:@"card"]) {
        info.card = [dict objectForKey:@"card"];
    }
    
    
    if ([dict objectForKey:@"exp_date"]) {
        info.exp_date = [dict objectForKey:@"exp_date"];
    }
    
    if ([dict objectForKey:@"token"]) {
        info.token = [dict objectForKey:@"token"];
    }
    
    if ([dict objectForKey:@"nonce"]) {
        info.nonce = [dict objectForKey:@"nonce"];
    }
    return info;
}
@end
