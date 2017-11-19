//
//  GenericInfo.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import <Foundation/Foundation.h>

@interface GenericInfo : NSObject
@property (nonatomic ,retain) NSString * idgen;
@property (nonatomic ,retain) NSString * generename;

/*
 "idgen": "2",
 "generename": "test"
 */
+ (GenericInfo *) parse:(NSDictionary *)dict;
@end
