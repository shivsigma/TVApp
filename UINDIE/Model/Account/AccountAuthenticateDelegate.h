//
//  AccountAuthenticateDelegate.h

//  Circuit
//
//  Created by SAVAN on 5/17/14.
//  Copyright (c) 2014 SAVAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@protocol AccountAuthenticateDelegate <NSObject>

-(void)accountAuthenticatedWithAccount:(Account*) account;
-(void)accountDidFailAuthentication:(NSError*) error;
- (void)forgotPasswordWithMessage:(NSString *)message;

@end
