//
//  GetCardsInfo.h
//  UINDIE
//
//  Created by Savan Shah on 10/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCardsInfo : NSObject
{
    NSString * _card;
    NSString * _exp_date;
    NSString * _token;
    NSString * _nonce;
    
    NSString * _add;
    NSString * _city;
    NSString * _state;
    NSString * _zip;
    
}

@property (nonatomic ,retain) NSString * card;
@property (nonatomic ,retain) NSString * exp_date;
@property (nonatomic ,retain) NSString * token;
@property (nonatomic ,retain) NSString * nonce;

@property (nonatomic ,retain) NSString * add;
@property (nonatomic ,retain) NSString * city;
@property (nonatomic ,retain) NSString * state;
@property (nonatomic ,retain) NSString * zip;

+ (GetCardsInfo *)parseWithDictionary:(NSDictionary *)dict;


/*
 {
 Data: [2]
 0:  {
 card: "411111******1111"
 exp_date: "05/2017"
 token: "cwz9br"
 nonce: "ec5eff75-289a-41a8-ba0c-007cd24d0b22"
 }-
 1:  {
 card: "411111******1111"
 exp_date: "05/2017"
 token: "8x284g"
 nonce: "5a244652-fc08-4b46-98f7-9f51f97c2ef9"
 }-
 -
 message: "cardit card information."
 success: true
 }
 */
@end
