//
//  AccountManager.h
//  Circuit
//
//  Created by SAVAN on 5/17/14.
//  Copyright (c) 2014 SAVAN. All rights reserved.

#import <Foundation/Foundation.h>
@class Account;
@interface AccountManager : NSObject
{
    Account *_activeAccount;
    NSMutableDictionary *_savedAccounts;
}

@property (nonatomic, readwrite, retain) Account *activeAccount;

+(AccountManager*)Instance;

-(void)saveAccount;



@end
