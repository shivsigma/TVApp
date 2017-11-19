//
//  LinkInfo.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 04/10/17.
//
//

#import <Foundation/Foundation.h>

@interface LinkInfo : NSObject

@property (nonatomic ,retain) NSString * entityId;
@property (nonatomic ,retain) NSString * video_id;
@property (nonatomic ,retain) NSString * iduser;
@property (nonatomic ,retain) NSString * image_title;
@property (nonatomic ,retain) NSString * image_link;
@property (nonatomic ,retain) NSString * image_name;
@property (nonatomic ,retain) NSString * image_date;
@property (nonatomic ,retain) NSString * image_ext;
@property (nonatomic ,retain) NSString * image_filepath;
@property (nonatomic ,retain) NSString * image_url;

+ (LinkInfo *) parse:(NSDictionary *)dict;

@end
