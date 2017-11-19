//
//  NewProductInfo.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 12/11/17.
//
//

#import <Foundation/Foundation.h>

@interface NewProductInfo : NSObject
@property (nonatomic ,retain) NSString * productstore_id;
@property (nonatomic ,retain) NSString * product_title;
@property (nonatomic ,retain) NSString * product_desc;
@property (nonatomic ,retain) NSString * product_price;
@property (nonatomic ,retain) NSString * product_img;
@property (nonatomic ,retain) NSMutableArray * images;
@property (nonatomic ,retain) NSString * product_tax;
@property (nonatomic ,retain) NSString * product_tags;
@property (nonatomic ,retain) NSString * genereid;
@property (nonatomic ,retain) NSString * countryid;
@property (nonatomic ,retain) NSString * countryname;
@property (nonatomic ,retain) NSString * generename;

+ (NewProductInfo *) parse:(NSDictionary *)dict;

@end
