//
//  RequestDelegate.h
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Request;

@protocol RequestDelegate <NSObject>

-(void)requestDidSucceed:(Request*) request;

-(void)requestDidFail:(Request*) request withError:(NSError*) error;

@end
