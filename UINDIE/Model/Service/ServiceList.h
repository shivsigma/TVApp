//
//  ServiceList.h
//  UINDIE
//
//  Created by apple on 2/24/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelListLoadedDelegate.h"
#import "UniversalDelegate.h"
#import "RequestDelegate.h"
#import "Request.h"
#import "ServiceInfo.h"
#import "FavouriteInfo.h"
#import "CardInfo.h"
#import "ActivityIndicator.h"
#import "ArticleInfo.h"
#import "LinkInfo.h"
#import "ContryInfo.h"
#import "GenericInfo.h"
#import "NewProductInfo.h"
@interface ServiceList : NSObject<RequestDelegate>{
    NSMutableArray * _videoArray;
    id<ModelListLoadedDelegate> _del;
    NSMutableArray * _videoStreamArray;
    NSMutableArray * _favArr;
    
}
//@property (nonatomic ,retain) NSMutableArray * products;

@property (nonatomic ,retain) NSMutableArray * contryArray;
@property (nonatomic ,retain) NSMutableArray * genericArray;
@property (nonatomic ,retain) NSMutableArray * ondemandVideoArray;
@property (nonatomic ,retain) NSMutableArray * articleArray;
@property (nonatomic ,retain) NSMutableArray * videoArray;
@property (nonatomic ,retain) NSMutableArray * videoStreamArray;
@property (nonatomic ,retain) NSMutableArray * favArr;
@property (nonatomic ,retain) NSMutableArray * linkArr;
@property (nonatomic ,retain) id<ModelListLoadedDelegate> del;
@property (nonatomic ,retain) id<UniversalDelegate>univasalDelegate;
@property (nonatomic ,retain) NSMutableArray * products;
+ (ServiceList *)Instance;

- (NSMutableArray *)getVideoArray;

- (NSMutableArray *)getAllVideos;

- (NSMutableArray *)getAllArticle;

- (NSMutableArray *)getDemandVideo;

- (NSArray *) updateVideofavStatus:(Video *)vinfo;

- (NSMutableArray *)getCurrentTimeVideos;

- (ServiceInfo * )getCurrentObject;

- (NSArray *)getAllProductsByCity:(NSString *)city Array:(NSMutableArray *)arr;
- (NSArray *)getAllProductsByGeneric:(NSString *)generic Array:(NSMutableArray *)arr;

+ (void) clearInstance;
-(void)loadOndemandVideoDelegate:(id<ModelListLoadedDelegate>)delegate;
- (void) loadArticleDelegate:(id<ModelListLoadedDelegate>)delegate;

- (void) loadAllVideoDelegate:(id<ModelListLoadedDelegate>)delegate;

- (void) loadMtimerDelegate:(id<ModelListLoadedDelegate>)delegate;

-(void)ALLFavouriteVideo:(id<ModelListLoadedDelegate>)delegate;

-(void)loadMayLikeListByID:(int)vId Delegate:(id<ModelListLoadedDelegate>)delegate;

- (void)addFavVideoInfo:(Video *)video categoryId:(int)catId Delegate:(id<UniversalDelegate>)udelegate;

-(NSMutableArray *)getAllFavouriteVideos;

-(void)AccountDeactiveWithUserID:(id<ModelListLoadedDelegate>)delegate;

- (void)EditCreditCardInfo:(CardInfo *)card Delegate:(id<ModelListLoadedDelegate>)delegate;


-(void)forgotPassowrdEmail:(NSString *)email delegate:(id<ModelListLoadedDelegate>)delegate;

//---- ravinder ----//
-(void)hitRequestWithUniqueDeviceID:(NSString *)UdId delegate:(id<ModelListLoadedDelegate>)delegate;
//------------------//

//
-(void)DeleteFavVideoInfo:(FavouriteInfo *)FavId Delegate:(id<ModelListLoadedDelegate>)udelegate;
- (void)removeItembyTableEditRowFromFavorite:(FavouriteInfo *)item;
- (int)Find:(FavouriteInfo *)item;
- (void) loadtCoutry:(id<ModelListLoadedDelegate>)delegate;
- (void) loadGeneric:(id<ModelListLoadedDelegate>)delegate;
- (void)loadNewProducts:(id<ModelListLoadedDelegate>)delegate;
@end
