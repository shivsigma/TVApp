//
//  CardInfo.h
//  UINDIE
//
//  Created by apple on 9/3/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfo : NSObject

@property (nonatomic ,retain) NSString * cardNumber;
@property (nonatomic ,retain) NSString * year;
@property (nonatomic ,retain) NSString * month;
@property (nonatomic ,retain) NSString * cvv;
@property (nonatomic ,retain) NSString * postalcode;

@property (nonatomic ,retain) NSString * city;
@property (nonatomic ,retain) NSString * state;
@property (nonatomic ,retain) NSString * street_address;

@end
