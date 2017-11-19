//
//  UniversalDelegate.h
//  Circuit
//
//  Created by SAVAN on 5/26/14.
//  Copyright (c) 2014 SAVAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversalDelegate <NSObject>

- (void) DataAddedSuccessfully:(NSString *)message;
- (void) DataAddFailedWithError:(NSString*) error;

@end
