//
//  ModelListLoadedDelegate.h
//  Circuit
//
//  Created by SAVAN on 5/19/14.
//  Copyright (c) 2014 SAVAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelListLoadedDelegate <NSObject>

-(void)ModelListLoadedSuccessfullyTag:(NSString*)tag;
-(void)ModelListLoadFailWithError:(NSString *)error;

@end
