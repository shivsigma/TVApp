//
//  ContryInfo.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import <Foundation/Foundation.h>

@interface ContryInfo : NSObject
@property (nonatomic ,retain) NSString * idcoun;
@property (nonatomic ,retain) NSString * countryname;

+ (ContryInfo *) parse:(NSDictionary *)dict;
@end
