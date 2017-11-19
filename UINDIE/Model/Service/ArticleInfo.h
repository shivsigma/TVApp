//
//  ArticleInfo.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra on 7/24/17.
//
//

#import <Foundation/Foundation.h>

@interface ArticleInfo : NSObject
@property (nonatomic ,retain) NSString * productId;
@property (nonatomic ,retain) NSString * productTitle;
@property (nonatomic ,retain) NSString * productDesc;
@property (nonatomic ,retain) NSString * productSource;
@property (nonatomic ,retain) NSString * productDatess;
@property (nonatomic ,retain) NSString * product_desc;
@property (nonatomic ,retain) NSMutableArray * productsImages;

+ (ArticleInfo *)parse:(NSDictionary *)dict;

@end
