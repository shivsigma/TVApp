//
//  Account.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Account.h"
#define ENCODING_VERSION        2
@implementation Account
@synthesize username=_username;
@synthesize delegate=_delegate;
@synthesize first_name=_first_name;
@synthesize last_name=_last_name;
@synthesize gender=_gender;
@synthesize dateofbirth=_dateofbirth;
@synthesize email=_email;
@synthesize profile_pic=_profile_pic;
@synthesize userId=_userId;
@synthesize userStatus=_userStatus;
@synthesize profileImage=_profileImage;
@synthesize city=_city;
@synthesize state=_state;
@synthesize user_type=_user_type;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self)
    {
        if ([aDecoder decodeIntForKey:@"version"] == ENCODING_VERSION)
        {
            _username = [aDecoder decodeObjectForKey:@"username"];
            _password = [aDecoder decodeObjectForKey:@"password"];
            _first_name = [aDecoder decodeObjectForKey:@"first_name"];
            _last_name = [aDecoder decodeObjectForKey:@"last_name"];
            _email = [aDecoder decodeObjectForKey:@"email"];
            _state = [aDecoder decodeObjectForKey:@"state"];
            _city = [aDecoder decodeObjectForKey:@"city"];
            _gender = [aDecoder decodeObjectForKey:@"gender"];
            _dateofbirth = [aDecoder decodeObjectForKey:@"dateofbirth"];
            _profile_pic = [aDecoder decodeObjectForKey:@"profile_pic"];
            _profileImage = [aDecoder decodeObjectForKey:@"ProfileImage"];
            _userId = [[aDecoder decodeObjectForKey:@"user_id"]intValue];
            _userStatus = [[aDecoder decodeObjectForKey:@"user_status"] intValue];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:ENCODING_VERSION forKey:@"version"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_first_name forKey:@"first_name"];
    [aCoder encodeObject:_profileImage forKey:@"ProfileImage"];
    [aCoder encodeObject:_last_name forKey:@"last_name"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_state forKey:@"state"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_gender forKey:@"gender"];
    [aCoder encodeObject:_dateofbirth forKey:@"dateofbirth"];
    [aCoder encodeObject:_profile_pic forKey:@"profile_pic"];
    [aCoder encodeObject:[NSNumber numberWithInt:_userId] forKey:@"user_id"];
    [aCoder encodeObject:[NSNumber numberWithInt:_userStatus] forKey:@"user_status"];
    
}

- (void)updateDeviceToken{
    Request *request = [[Request alloc] initWithUrlPart:DEVICE_TOKEN andDelegate:self andMethod:POST];
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [defaults stringForKey:@"deviceToken"];
    
    [request setParameter:@"dynamic" forKey:@"token"];
   // [request setParameter:deviceToken forKey:@"token"];
    [request setParameter:@"iPhone" forKey:@"DeviceType"];
    [request setParameter:[NSNumber numberWithInt:self.userId] forKey:@"UserId"];
    [request startRequest];
}

- (void)authenticatedWithUserName:(NSString *)username andPassword:(NSString *)password withDelegate:(id<AccountAuthenticateDelegate>) del{
    
    _delegate = del;
    Request *request = [[Request alloc] initWithUrlPart:LOGIN andDelegate:self andMethod:POST];
    [request setParameter:username forKey:@"email"];
    [request setParameter:_password forKey:@"password"];
    [request startRequest];
}

/*
 - (void)authenticatedWithUserName:(NSString *)username andPassword:(NSString *)password anddevicetoken:(NSString *)devicetoken anddeviceType:(NSString *)devicetype withDelegate:(id<AccountAuthenticateDelegate>) del{
 
 _delegate = del;
 Request *request = [[Request alloc] initWithUrlPart:LOGIN andDelegate:self andMethod:POST];
 [request setParameter:_username forKey:@"email"];
 [request setParameter:_password forKey:@"password"];
 //   [request setParameter:devicetoken forKey:@"device_token"];
 //   [request setParameter:devicetype forKey:@"device_type"];
 [request startRequest];
 }
 */




-(void)registrationWithDelegate:(id<AccountAuthenticateDelegate>)del{
    
    _delegate = del;
    Request *request = [[Request alloc] initWithUrlPart:REGISTRATION andDelegate:self andMethod:POST];
    [request setParameter:_username forKey:@"username"];
    [request setParameter:_password forKey:@"password"];
    [request setParameter:_first_name forKey:@"first_name"];
    [request setParameter:_last_name forKey:@"last_name"];
    [request setParameter:_email forKey:@"email"];
    [request setParameter:_email forKey:@"email"];
    [request setParameter:_state forKey:@"state"];
    [request setParameter:_city forKey:@"city"];
    [request setParameter:_gender forKey:@"gender"];
    [request setParameter:_dateofbirth forKey:@"dateofbirth"];
    // [request setParameter:_profile_pic forKey:@"profile_pic"];
    request.image = _profileImage;
    [request startRequest];
}

#pragma CircuitRequestDelegate

-(void)requestDidSucceed:(Request *)request
{
    if (request.IsSuccess)
    {
        
        if ([request.Tag isEqual:CHANGEPASSWORD])
        {
            NSDictionary * dict = [request.responseData objectForKey:@"Data"];
            
        }
     
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AddressInfo"];
            NSArray * dataArr = [request.responseData objectForKey:@"Data"];
            if (dataArr.count > 0 ) {
                for (NSDictionary * dict in dataArr) {
                    if ([dict objectForKey:@"user_id"]) {
                        _userId = [[dict objectForKey:@"user_id"]intValue];
                    }
                    if ([dict objectForKey:@"user_status"]) {
                        _userStatus = [[dict objectForKey:@"user_status"]intValue];
                    }
                    if ([dict objectForKey:@"username"]) {
                        _username = [dict objectForKey:@"username"];
                    }
                    if ([dict objectForKey:@"first_name"]) {
                        _first_name = [dict objectForKey:@"first_name"];
                    }
                    if ([dict objectForKey:@"last_name"]) {
                        _last_name = [dict objectForKey:@"last_name"];
                    }
                    if ([dict objectForKey:@"email"]) {
                        _email = [dict objectForKey:@"email"];
                    }
                    if ([dict objectForKey:@"state"]) {
                        _state = [dict objectForKey:@"state"];
                    }
                    if ([dict objectForKey:@"city"]) {
                        _city = [dict objectForKey:@"city"];
                    }
                    if ([dict objectForKey:@"gender"]) {
                        _gender = [dict objectForKey:@"gender"];
                    }
                    if ([dict objectForKey:@"dateofbirth"]) {
                        _dateofbirth = [dict objectForKey:@"dateofbirth"];
                    }
                    if ([dict objectForKey:@"profile_pic"]) {
                        _profile_pic = [dict objectForKey:@"profile_pic"];
                    }
                    
                    if ([dict objectForKey:@"user_type"]) {
                        _user_type = [dict objectForKey:@"user_type"];
                    }
                }
            }
            
        }
        [AccountManager Instance].activeAccount = self;;
        if (_delegate && [_delegate respondsToSelector:@selector(accountAuthenticatedWithAccount:)])
        {
            [_delegate accountAuthenticatedWithAccount:self];
        }
        
        
    }
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error {
    
    if (_delegate && [_delegate respondsToSelector:@selector(accountDidFailAuthentication:)]) {
        [_delegate accountDidFailAuthentication:error];
    }
}

/*********** my code ***********/

-(void)ProfilePicWithdelegate:(id<AccountAuthenticateDelegate>)del{
    _delegate = del;
    Request *request = [[Request alloc] initWithUrlPart:PROFILEPIC andDelegate:self andMethod:POST];
    //   [request setParameter:_profileImage forKey:@"profile_pic"];
    [request setParameter:[NSNumber numberWithInt:self.userId] forKey:@"user_id"];
    request.image = _profileImage;
    request.Tag = PROFILEPIC;
    [request startRequest];
}

-(void)ChangePasswordWithDelegate:(NSString *)oldpassword delegate:(id<AccountAuthenticateDelegate>)del
{
    _delegate = del;
    Request *request = [[Request alloc] initWithUrlPart:CHANGEPASSWORD andDelegate:self andMethod:POST];
   [request setParameter:[NSNumber numberWithInt:self.userId] forKey:@"user_id"];
    [request setParameter:oldpassword forKey:@"old"];
    [request setParameter:_password forKey:@"new"];
    request.Tag = CHANGEPASSWORD;
    [request startRequest];
}


@end
