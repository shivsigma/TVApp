//
//  Account.h
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestDelegate.h"
#import "AccountAuthenticateDelegate.h"
#import "UniversalDelegate.h"
#import "AccountManager.h"
#import "URLSchema.h"
#import "Request.h"
@interface Account : NSObject<RequestDelegate>{
    
    NSString * _username;
    NSString * _password;
    id<AccountAuthenticateDelegate> _delegate;
    NSString * _first_name;
    NSString * _last_name;
    NSString * _email;
    NSString * _gender;
    NSString * _dateofbirth;
    NSString * _profile_pic;
    
    
    NSString *_user_type;
    
    int _userId;
    int _userStatus;
    UIImage * _profileImage;
    
    NSString * _city;
    NSString * _state;

    
  
    
}

@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) int userStatus;
@property (nonatomic, retain) NSString * username;
@property (nonatomic ,retain) NSString * password;
@property (nonatomic ,retain) NSString * first_name;
@property (nonatomic ,retain) NSString * last_name;
@property (nonatomic ,retain) NSString * email;
@property (nonatomic ,retain) NSString * state;
@property (nonatomic ,retain) NSString * city;
@property (nonatomic ,retain) NSString * gender;
@property (nonatomic ,retain) NSString * dateofbirth;
@property (nonatomic ,retain) NSString * profile_pic;
@property (nonatomic ,retain) UIImage * profileImage;
@property (nonatomic,retain) NSString *user_type;


@property (nonatomic ,retain) id<AccountAuthenticateDelegate> delegate;

- (void) updateDeviceToken;

- (void)authenticatedWithUserName:(NSString *)username andPassword:(NSString *)password withDelegate:(id<AccountAuthenticateDelegate>) del;

//- (void)authenticatedWithUserName:(NSString *)username andPassword:(NSString *)password anddevicetoken:(NSString *)devicetoken anddeviceType:(NSString *)devicetype withDelegate:(id<AccountAuthenticateDelegate>) del;

- (void)registrationWithDelegate:(id<AccountAuthenticateDelegate>) del;

////////////

-(void)ProfilePicWithdelegate:(id<AccountAuthenticateDelegate>)del;
-(void)ChangePasswordWithDelegate:(NSString *)oldpassword delegate:(id<AccountAuthenticateDelegate>)del;
-(void)AccountDeactiveWithUserID:(id<AccountAuthenticateDelegate>)delegate;
@end
