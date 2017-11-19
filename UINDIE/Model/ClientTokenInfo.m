//
//  ClientTokenInfo.m
//  UINDIE
//
//  Created by Savan Shah on 10/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ClientTokenInfo.h"

@implementation ClientTokenInfo

@synthesize client_token=_client_token;

+(ClientTokenInfo *)parseWithDictionary:(NSDictionary *)dict{
    ClientTokenInfo * info =[[ClientTokenInfo alloc]init];
    
    if ([dict objectForKey:@"client_token"])
    {
        info.client_token = [dict objectForKey:@"client_token"];
    }
    return info;
}

@end
