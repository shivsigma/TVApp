//
//  ChatList.h
//  UINDIE
//
//  Created by apple on 6/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelListLoadedDelegate.h"
#import "RequestDelegate.h"
#import "Request.h"
#import "ChatInfo.h"
#import "UniversalDelegate.h"

@interface ChatList : NSObject<RequestDelegate>{
    NSMutableArray * _chatArray;
    id<ModelListLoadedDelegate>_delegate;
    id<UniversalDelegate>_uDelegate;
}
@property (nonatomic ,retain) NSMutableArray * chatArray;
@property (nonatomic ,retain) id<ModelListLoadedDelegate>delegate;
@property (nonatomic ,retain) id<UniversalDelegate>uDelegate;

+ (void)clearInstance;
+ (ChatList *)Instance;
- (NSMutableArray *)getAllMessage;
- (void)loadAllMessage:(id<ModelListLoadedDelegate>)del;
- (void)sendMessage:(id<UniversalDelegate>)udel Message:(NSString *)message;
-(void)sendImageMessage:(id<UniversalDelegate>)udel MessageImage:(UIImage *)image;
@end
