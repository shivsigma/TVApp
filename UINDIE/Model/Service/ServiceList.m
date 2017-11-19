//
//  ServiceList.m
//  UINDIE
//
//  Created by apple on 2/24/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ServiceList.h"
static  ServiceList * Singleton = nil;
@implementation ServiceList
@synthesize del=_del;
@synthesize videoArray=_videoArray;
@synthesize videoStreamArray=_videoStreamArray;
@synthesize favArr=_favArr;

+(ServiceList *)Instance
{
    if (Singleton == nil) {
        Singleton = [[ServiceList alloc]init];
        Singleton.videoArray =[[NSMutableArray alloc]init];
        Singleton.videoStreamArray = [[NSMutableArray alloc]init];
        Singleton.favArr=[[NSMutableArray alloc]init];
    }
    return Singleton;
}

-(NSMutableArray *)getVideoArray{
    return _videoArray;
}

-(NSMutableArray *)getAllVideos{
    
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    for (ServiceInfo * info in _videoArray) {
        for (Video * vinfo in info.videoArray) {
            [temp addObject:vinfo];
        }
    }
    return temp;
}

-(NSMutableArray *)getAllArticle{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productId" ascending:NO];
    NSArray *orderedArray = [_articleArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return [orderedArray mutableCopy];
}
- (NSMutableArray *)getDemandVideo{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *orderedArray = [_ondemandVideoArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return orderedArray.mutableCopy;
}
-(NSMutableArray *)getAllFavouriteVideos{
    
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    
    for (FavouriteInfo * info in _favArr)
    {
        [temp addObject:info];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fev_id" ascending:NO];
    NSArray *orderedArray = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return orderedArray.mutableCopy;
}

-(ServiceInfo *)getCurrentObject{
    ServiceInfo * info;
    if (_videoStreamArray != nil && _videoStreamArray.count > 0) {
        info = [_videoStreamArray objectAtIndex:0];
    }
    return info;
}


-(NSMutableArray *)getCurrentTimeVideos{
    NSMutableArray * temp =[[NSMutableArray alloc]init];
    for (ServiceInfo * info in _videoStreamArray) {
        for (Video * vinfo in info.videoArray) {
            [temp addObject:vinfo];
        }
    }
    return temp;
}

+ (void)clearInstance{
    Singleton = [[ServiceList alloc]init];
}

-(NSArray *)updateVideofavStatus:(Video *)vinfo{
    for (ServiceInfo * info in _videoStreamArray) {
        for (Video * xx in info.videoArray) {
            if (xx.video_id == vinfo.video_id) {
                xx.is_fav = YES;
            }
        }
    }
    return nil;
}


- (void)removeItembyTableEditRowFromFavorite:(FavouriteInfo *)item {
    
    if ([_favArr containsObject:item]) {
        int index = [self Find:item];
        [_favArr removeObjectAtIndex:index];
    }
}


- (int)Find:(FavouriteInfo *)item {
    
    for (int i = 0; i < [_favArr count]; i++) {
        FavouriteInfo *cii = [_favArr objectAtIndex:i];
        if([cii isEqual:item]){
            return i;
        }
    }
    return -1;
}
- (NSArray *)getAllProductsByCity:(NSString *)city Array:(NSMutableArray *)arr{
    if ([city isEqual:@"All"]) {
        return _products;
        
    }
    NSMutableArray * tt = [[NSMutableArray alloc]init];
    for (NewProductInfo * ap in arr) {
        if ([ap.countryname isEqual:city]) {
            [tt addObject:ap];
        }
    }
    return tt;
}

-(NSArray *)getAllProductsByGeneric:(NSString *)generic Array:(NSMutableArray *)arr{
    if ([generic isEqual:@"All"]) {
        return _products;
        
    }
    NSMutableArray * tt = [[NSMutableArray alloc]init];
    for (NewProductInfo * ap in arr) {
        if ([ap.generename isEqual:generic]) {
            [tt addObject:ap];
        }
    }
    return tt;
}

-(void)loadArticleDelegate:(id<ModelListLoadedDelegate>)delegate{
    _del=delegate;
    Request *request = [[Request alloc] initWithUrlPart:kArticle andDelegate:self andMethod:GET];
    request.Tag=kArticle;
    [request startRequest];
}
-(void)loadOndemandVideoDelegate:(id<ModelListLoadedDelegate>)delegate{
    _del=delegate;
    Request *request = [[Request alloc] initWithUrlPart:DemandVideo andDelegate:self andMethod:GET];
    request.Tag=DemandVideo;
    [request startRequest];
}
-(void)loadMayLikeListByID:(int)vId Delegate:(id<ModelListLoadedDelegate>)delegate{
    _del=delegate;
    Request *request = [[Request alloc] initWithUrlPart:kYouMayLikeList andDelegate:self andMethod:POST];
    [request setParameter:[NSNumber numberWithInt:vId] forKey:@"video_id"];//
    request.Tag=kYouMayLikeList;
    [request startRequest];
}


-(void)DeleteFavVideoInfo:(FavouriteInfo *)FavId Delegate:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request * request = [[Request alloc]initWithUrlPart:FEV_DELETE andDelegate:self andMethod:POST];
    [request setParameter:[NSNumber numberWithInt:FavId.fev_id] forKey:@"fev_id"];
    request.Tag=FEV_DELETE;
    [request startRequest];
}


-(void)AccountDeactiveWithUserID:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request *request = [[Request alloc] initWithUrlPart:ACCOUNTDEACTIVE andDelegate:self andMethod:POST];
    Account * account = [AccountManager Instance].activeAccount;
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    request.Tag=ACCOUNTDEACTIVE;
    [request startRequest];
}

-(void)ALLFavouriteVideo:(id<ModelListLoadedDelegate>)delegate
{
    _del=delegate;
    Request * request = [[Request alloc]initWithUrlPart:GET_FAV andDelegate:self andMethod:POST];
    
    Account * account = [AccountManager Instance].activeAccount;
    //NSLog(@"user id %d",account.userId);
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    request.Tag=GET_FAV;
    [request startRequest];
}

//------ ravinder -----//
-(void)hitRequestWithUniqueDeviceID:(NSString *)UdId delegate:(id<ModelListLoadedDelegate>)delegate {
    _del=delegate;
    Request *request = [[Request alloc]initWithUrlPart:DEVICEID andDelegate:self andMethod:POST];
    [request setParameter:UdId forKey:@"deviceId"];
    request.Tag=DEVICEID;
    [request startRequest];
}
//---------------------//

-(void)forgotPassowrdEmail:(NSString *)email delegate:(id<ModelListLoadedDelegate>)delegate{
    _del = delegate;
    Request *request = [[Request alloc] initWithUrlPart:FORGOT andDelegate:self andMethod:POST];
    [request setParameter:email forKey:@"email"];
    request.Tag=FORGOT;
    [request startRequest];
}

-(void)loadMtimerDelegate:(id<ModelListLoadedDelegate>)delegate{
    _del =delegate;
    
    Request * request = [[Request alloc]initWithUrlPart:TIMER andDelegate:self andMethod:GET];
    request.Tag = TIMER;
    [request startRequest];
    
}

-(void)loadAllVideoDelegate:(id<ModelListLoadedDelegate>)delegate{
    _del =delegate;
    
    if (_videoArray.count <= 0) {
        Request * request = [[Request alloc]initWithUrlPart:SERVICE andDelegate:self andMethod:GET];
        request.Tag = SERVICE;
        [request startRequest];
        
    }
    else
    {
        if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_del ModelListLoadedSuccessfullyTag:SERVICE];
        }
    }
}


- (void)EditCreditCardInfo:(CardInfo *)card Delegate:(id<ModelListLoadedDelegate>)delegate{
    _del=delegate;
    Request * request = [[Request alloc]initWithUrlPart:EDIT_CREDITCARD andDelegate:self andMethod:POST];
    
    Account * account = [AccountManager Instance].activeAccount;
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    [request setParameter:card.cardNumber forKey:@"card"];
    [request setParameter:card.month forKey:@"month"];
    [request setParameter:card.year forKey:@"year"];
    if (card.cvv.length <= 0) {
        card.cvv =@"123";
    }
    [request setParameter:card.cvv forKey:@"cvv"];
    [request setParameter:card.street_address forKey:@"address"];
    [request setParameter:card.city forKey:@"city"];
    [request setParameter:card.state forKey:@"state"];
    [request setParameter:card.postalcode forKey:@"postal_code"];
    
    request.Tag=EDIT_CREDITCARD;
    [request startRequest];
}


-(void)addFavVideoInfo:(Video *)video categoryId:(int)catId Delegate:(id<UniversalDelegate>)udelegate{
    Account * account = [AccountManager Instance].activeAccount;
    _univasalDelegate = udelegate;
    Request * request = [[Request alloc]initWithUrlPart:ADD_FEV andDelegate:self andMethod:POST];
    [request setParameter:[NSNumber numberWithInt:video.video_id] forKey:@"video_id"];
    [request setParameter:[NSNumber numberWithInt:catId] forKey:@"cat_id"];
    [request setParameter:[NSNumber numberWithInt:account.userId] forKey:@"user_id"];
    if (video.is_fav) {
        [request setParameter:@"1" forKey:@"fev_status"];
    }else{
        [request setParameter:@"0" forKey:@"fev_status"];
    }
    
    request.Tag = ADD_FEV;
    [request startRequest];
}

-(void)loadtCoutry:(id<ModelListLoadedDelegate>)delegate{
    Request * request = [[Request alloc]initWithUrlPart:getCoutry andDelegate:self andMethod:GET];
    request.Tag = getCoutry;
    
    [request startRequest];

}

-(void)loadGeneric:(id<ModelListLoadedDelegate>)delegate{
    Request * request = [[Request alloc]initWithUrlPart:GetGeneres andDelegate:self andMethod:GET];
    request.Tag = GetGeneres;
    
    [request startRequest];

}

- (void)loadNewProducts:(id<ModelListLoadedDelegate>)delegate{
    Request * request = [[Request alloc]initWithUrlPart:GetProduct andDelegate:self andMethod:GET];
    request.Tag = GetProduct;
    [request startRequest];
}

#pragma RequestDelegate
-(void)requestDidSucceed:(Request *)request{
    NSArray * DataArray = [request.responseData objectForKey:@"Data"];
    if ([request.Tag isEqual:GetProduct]) {
        _products = [[NSMutableArray alloc]init];
        for (NSDictionary * dd in DataArray) {
            NewProductInfo * info = [NewProductInfo parse:dd];
            [_products addObject:info];
        }
        return;
    }else if ([request.Tag isEqual:getCoutry]) {
        _contryArray = [[NSMutableArray alloc]init];
        for (NSDictionary * dd in DataArray) {
            ContryInfo * info = [ContryInfo parse:dd];
            [_contryArray addObject:info];
        }
        return;
    }else if ([request.Tag isEqual:GetGeneres]) {
        _genericArray = [[NSMutableArray alloc]init];
        for (NSDictionary * dd in DataArray) {
            GenericInfo * info = [GenericInfo parse:dd];
            [_genericArray addObject:info];
        }
        return;
    }else if ([request.Tag isEqual:kYouMayLikeList]) {
        _linkArr = [[NSMutableArray alloc]init];
        for (NSDictionary * dd in DataArray) {
            LinkInfo * info = [LinkInfo parse:dd];
            [_linkArr addObject:info];
        }
    }else if ([request.Tag isEqual:kArticle]) {
        _articleArray = [[NSMutableArray alloc]init];
        for (NSDictionary * dd in DataArray) {
            ArticleInfo * info = [ArticleInfo parse:dd];
            [_articleArray addObject:info];
        }
    }else if ([request.Tag  isEqual: TIMER])
    {
        _videoStreamArray =[[NSMutableArray alloc]init];
        if (DataArray != (id)[NSNull null]){
            for (NSDictionary * dict in DataArray) {
                ServiceInfo * info = [ServiceInfo parseWithDictionary:dict];
                [_videoStreamArray addObject:info];
            }
        }
    }else if ([request.Tag  isEqual: DemandVideo])
    {
        _ondemandVideoArray =[[NSMutableArray alloc]init];
        if (DataArray != (id)[NSNull null]){
            for (NSDictionary * dict in DataArray) {
                Video * info = [Video parseWithDict:dict];
                [_ondemandVideoArray addObject:info];
            }
        }
    }
    else if ([request.Tag isEqual:SERVICE])
    {
        _videoArray = [[NSMutableArray alloc]init];
        NSArray * dataArr = [request.responseData objectForKey:@"Data"];
        if (dataArr != (id)[NSNull null]){
            for (NSDictionary * dict in dataArr) {
                
                ServiceInfo * info = [ServiceInfo parseWithDictionary:dict];
                if (![info.category_name isEqual:@"Counter"]) {
                    [_videoArray addObject:info];
                }
                
            }
        }
    }
    else if([request.Tag isEqual:GET_FAV])
    {
        _favArr = [[NSMutableArray alloc]init];
        if (DataArray != (id)[NSNull null])
        {
            for (NSDictionary * dict in DataArray) {
                FavouriteInfo * info = [FavouriteInfo parseWithDictionary:dict];
                
                [_favArr addObject:info];
            }
        }
    }
    else if([request.Tag isEqual:ACCOUNTDEACTIVE])
    {
        NSDictionary * dict = [request.responseData objectForKey:@"Data"];
    }
    else if([request.Tag isEqual:EDIT_CREDITCARD])
    {
        [[ActivityIndicator currentIndicator]displayCompleted];
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:[request.responseData objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([request.Tag isEqual:FORGOT])
    { [[ActivityIndicator currentIndicator]displayCompleted];
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"Please Check your mailbox." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([request.Tag isEqual:FEV_DELETE])
    {
        NSArray * dic = [request.responseData objectForKey:@"Data"];
    }
    
    //----- ravinder -----//
    else if([request.Tag isEqual:DEVICEID])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.totalCount = request.responseData[@"Data"];
    }
    //-------------//
    
    
    if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
        [_del ModelListLoadedSuccessfullyTag:request.Tag];
    }
    // [[NSNotificationCenter defaultCenter]postNotificationName:@"XXXX" object:nil];
}

-(void)requestDidFail:(Request *)request withError:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    if([request.Tag isEqual:FORGOT]){
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:[error.userInfo objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if([request.Tag isEqual:EDIT_CREDITCARD]){
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:[error.userInfo objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([request.Tag isEqual:GET_FAV])
    {
        _favArr = [[NSMutableArray alloc]init];
        if (_del && [_del respondsToSelector:@selector(ModelListLoadedSuccessfullyTag:)]) {
            [_del ModelListLoadedSuccessfullyTag:request.Tag];
        }
    }
}

@end
