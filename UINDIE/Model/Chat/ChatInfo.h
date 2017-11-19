//
//  ChatInfo.h
//  UINDIE
//
//  Created by apple on 6/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "SPHMacro.h"
@interface ChatInfo : NSObject{
    int _user_id;
    NSString * _user_name;
    NSString * _first_name;
    NSString * _last_name;
    NSString * _email;
    NSString * _gender;
    NSString * _dateofbirth;
    NSString * _profile_pic;
    NSString * _message;
    NSString * _img;
    NSString * _messageType;
    NSString * _messagestatus;
    NSString * _messageTime;

    NSString *_user_type;
    NSString * _state;
    NSString * _city;
}
@property (nonatomic ,assign) int user_id;
@property (nonatomic ,retain) NSString * user_name;
@property (nonatomic ,retain) NSString * first_name;
@property (nonatomic ,retain) NSString * last_name;
@property (nonatomic ,retain) NSString * email;
@property (nonatomic ,retain) NSString * gender;
@property (nonatomic ,retain) NSString * dateofbirth;
@property (nonatomic ,retain) NSString * profile_pic;
@property (nonatomic ,retain) NSString * message;
@property (nonatomic ,retain) NSString * img;
@property (nonatomic ,retain) NSString * messageType;
@property (nonatomic ,retain) NSString * messagestatus;
@property (nonatomic ,retain) NSString * messageTime;
@property(nonatomic,retain) NSString * user_type;
@property(nonatomic,retain) NSString * state;
@property(nonatomic,retain) NSString * city;



+ (ChatInfo *)parsewithDictionary:(NSDictionary *)dict;



@end
