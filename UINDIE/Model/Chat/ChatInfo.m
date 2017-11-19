//
//  ChatInfo.m
//  UINDIE
//
//  Created by apple on 6/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ChatInfo.h"

@implementation ChatInfo

+(ChatInfo *)parsewithDictionary:(NSDictionary *)dict{
    ChatInfo * info = [[ChatInfo alloc]init];
    if([dict objectForKey:@"user_id"] != [NSNull null]){
        info.user_id = [[dict objectForKey:@"user_id"]intValue];
    }
    if([dict objectForKey:@"user_name"]!= [NSNull null]){
        info.user_name = [dict objectForKey:@"user_name"];
    }
    if([dict objectForKey:@"first_name"]!= [NSNull null]){
        info.first_name = [dict objectForKey:@"first_name"];
    }
    if([dict objectForKey:@"last_name"]!= [NSNull null]){
        info.last_name = [dict objectForKey:@"last_name"];
    }
    if([dict objectForKey:@"email"]!= [NSNull null]){
        info.email = [dict objectForKey:@"email"];
    }
    if([dict objectForKey:@"gender"]!= [NSNull null]){
        info.gender = [dict objectForKey:@"gender"];
    }
    if([dict objectForKey:@"dateofbirth"]!= [NSNull null]){
        info.dateofbirth = [dict objectForKey:@"dateofbirth"];
    }
    if([dict objectForKey:@"profile_pic"]!= [NSNull null]){
        info.profile_pic = [dict objectForKey:@"profile_pic"];
    }
    if([dict objectForKey:@"city"]!= [NSNull null]){
        info.city = [dict objectForKey:@"city"];
    }
    if([dict objectForKey:@"state"]!= [NSNull null]){
        info.state = [dict objectForKey:@"state"];
    }
    

    if([dict objectForKey:@"message"]!= [NSNull null]){
        NSData *emojiData = [[dict objectForKey:@"message"] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *emojiString = [[NSString alloc] initWithData:emojiData encoding:NSNonLossyASCIIStringEncoding];
        //NSLog(@"emojiString: %@", emojiString);
        info.message=emojiString;
       // info.message = [dict objectForKey:@"message"];
    }
    if([dict objectForKey:@"img"]!= [NSNull null]){
        info.img = [dict objectForKey:@"img"];
    }
    
    
    
    Account * account = [AccountManager Instance].activeAccount;
    if(account.userId == info.user_id){
        info.messageType = ktextByme;
    }
    
    else{
        info.messageType = ktextbyother;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    info.messageTime = [dateFormatter stringFromDate:[NSDate date]];

    
    if([dict objectForKey:@"user_type"]!= [NSNull null]){
        info.user_type = [dict objectForKey:@"user_type"];
    }


    return info;
    

}

@end
