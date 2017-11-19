//
//  ContryInfo.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import "ContryInfo.h"

@implementation ContryInfo

+ (ContryInfo *)parse:(NSDictionary *)dict{
    ContryInfo * info = [[ContryInfo alloc]init];
    if ([dict objectForKey:@"idcoun"]) {
        info.idcoun = [dict objectForKey:@"idcoun"];
    }
    if ([dict objectForKey:@"countryname"]) {
        info.countryname = [dict objectForKey:@"countryname"];
    }
    return info;
}

@end
