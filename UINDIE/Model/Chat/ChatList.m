//
//  ChatList.m
//  UINDIE
//
//  Created by apple on 6/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ChatList.h"
static  ChatList * Singleton = nil;
@implementation ChatList

+(ChatList *)Instance
{
    if (Singleton == nil) {
        Singleton = [[ChatList alloc]init];
        Singleton.chatArray =[[NSMutableArray alloc]init];
    }
    return Singleton;
}

+(void)clearInstance{
    Singleton = nil;
}

-(NSMutableArray *)getAllMessage{
    return _chatArray;
}

-(void)sendMessage:(id<UniversalDelegate>)udel Message:(NSString *)message{
    _uDelegate =udel;
    Request * request = [[Request alloc]initWithUrlPart:SEND_MESSAGE andDelegate:self andMethod:POST];
    
    Account * account = [AccountManager Instance].activeAccount;
    
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:message forKey:@"message"];
    [request setParameter:@"" forKey:@"img"];
    request.Tag = SEND_MESSAGE;
    [request startRequest];
}


-(void)sendImageMessage:(id<UniversalDelegate>)udel MessageImage:(UIImage *)image{
    _uDelegate =udel;
    Request * request = [[Request alloc]initWithUrlPart:SEND_MESSAGE_IMAGE andDelegate:self andMethod:POST];
    
    Account * account = [AccountManager Instance].activeAccount;
    
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:@" " forKey:@"message"];
    request.image = image;
    [request setParameter:@"" forKey:@"img"];
    request.Tag = SEND_MESSAGE_IMAGE;
    [request startRequest];
}


-(void)loadAllMessage:(id<ModelListLoadedDelegate>)del{
    _delegate = del;
    
    if (_chatArray.count <= 0) {
        Request * request = [[Request alloc]initWithUrlPart:GET_ALL_MESSAGES andDelegate:self andMethod:GET];
        request.Tag = GET_ALL_MESSAGES;
        [request startRequest];
        
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_delegate ModelListLoadedSuccessfullyTag:GET_ALL_MESSAGES];
        }
    }
}
#pragma RequestDelegate
-(void)requestDidSucceed:(Request *)request{
    
    if(request.IsSuccess){
        if([request.Tag isEqual:SEND_MESSAGE] && [request.Tag isEqual:SEND_MESSAGE_IMAGE])
        {
            if (_uDelegate && [_uDelegate respondsToSelector:@selector(DataAddedSuccessfully:)]) {
                [_uDelegate DataAddedSuccessfully:@""];
            }
        }
        else if ([request.Tag isEqual:GET_ALL_MESSAGES]){
            NSArray * DataArray = [request.responseData objectForKey:@"Data"];
            _chatArray  = [[NSMutableArray alloc]init];
            for (NSDictionary * dict in DataArray) {
                ChatInfo * info = [ChatInfo parsewithDictionary:dict];
                [_chatArray addObject:info];
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
                [_delegate ModelListLoadedSuccessfullyTag:request.Tag];
            }
        }
    }
    
    
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(ModelListLoadFailWithError:)]) {
        [_delegate ModelListLoadFailWithError:[error.userInfo objectForKey:@"message"]];
    }
    
}
@end
