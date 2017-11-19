//
//  GenericInfo.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import "GenericInfo.h"

@implementation GenericInfo

+ (GenericInfo *)parse:(NSDictionary *)dict{
    GenericInfo * info = [[GenericInfo alloc]init];
    if ([dict objectForKey:@"idgen"]) {
        info.idgen = [dict objectForKey:@"idgen"];
    }
    if ([dict objectForKey:@"generename"]) {
        info.generename = [dict objectForKey:@"generename"];
    }
    return  info;
}

@end
