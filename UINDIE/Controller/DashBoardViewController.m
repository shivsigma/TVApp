//
//  DashBoardViewController.m
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "DashBoardViewController.h"

#import "WelcomeViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController
@synthesize categoryInfo=_categoryInfo;

-(void)resetAllButton{
    
    _tblArticleView.hidden = YES;
    
    _btnCloseArticle.hidden = YES;
    _lblNoItem.hidden = YES;
    _lblNoItemInfo.hidden = YES;
    _btnGoCart.hidden = YES;
    
    _lblCount.hidden = YES;
    self.OnDemandView.hidden = YES;
    
    [_btnArticlexxxxx setImage:[UIImage imageNamed:@"cartNew.png"] forState:UIControlStateNormal];
    [_btnChat setImage:[UIImage imageNamed:@"livechat.png"] forState:UIControlStateNormal];
    [_btnShow setImage:[UIImage imageNamed:@"showinfo.png"] forState:UIControlStateNormal];
    [_btnStore setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
    [_btnLineup setImage:[UIImage imageNamed:@"lineup.png"] forState:UIControlStateNormal];
}
- (void)categoryTable{
    [_LineUpView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _lblNoItem.hidden = YES;
    _lblNoItemInfo.hidden = YES;
    _lblCount.layer.cornerRadius = 10;
    self.view.userInteractionEnabled = YES;
    UITextField *textField = [_searchBar valueForKey:@"_searchField"];
    textField.clearButtonMode = UITextFieldViewModeNever;
    
    UITextField *textField1 = [_articleSearch valueForKey:@"_searchField"];
    textField1.clearButtonMode = UITextFieldViewModeNever;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryTable) name:@"TimeZonePickerView" object:nil];
    
    
    btn.hidden = YES;
    [CardIOUtilities preload];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        messageWidth = 768;
    }else{
        
        messageWidth = 298;
    }
    [[ServiceList Instance]ALLFavouriteVideo:self];
    
    
    
    
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).fullScreenVideoIsPlaying = YES;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    sectionDateFormatter = [[NSDateFormatter alloc] init];
    sectionDateFormatterMonDay = [[NSDateFormatter alloc] init];
    [sectionDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [sectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    sectionDateFormatterMonDay.dateFormat = @"EEE";
    
    Account * account = [AccountManager Instance].activeAccount;
    _login = [UIButton buttonWithType:UIButtonTypeCustom];
    [_login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // _login.frame = CGRectMake(0, 0,85,35);
    _login.frame = CGRectMake(0, 0, 50,10);
    [_login.titleLabel setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [_login addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (account) {
        
        [_login setTitle:@"PROFILE" forState:UIControlStateNormal];
        
    }else{
        [_login setTitle:@"LOGIN" forState:UIControlStateNormal];
    }
    
    refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadxx)];
    refresh.tintColor = [UIColor blackColor];
    audioControlBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"unmute.png"] style:UIBarButtonItemStylePlain target:self action:@selector(audioControls)];
    
    // audioControlBarItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItems = @[refresh,audioControlBarItem];
    
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithCustomView:_login];
    self.navigationItem.leftBarButtonItem =loginItem;
    
    //    _lblProvider.text =[NSString stringWithFormat:@"%@",account.username];
    //    _lblTitle.text =[NSString stringWithFormat:@"%@",_categoryInfo.category_name];
    //    _txtDescription.text = @"No Description Available.";
    
    ///// hardik  ///
    
    Video * videoInfo;
    
   // _lblProvider.text =@"";
    //_lblTitle.text =@"";
    
    _txtDescription.text = @"";
    [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
    
    if (_videosArray.count > 0)
    {
        videoInfo = [_videosArray objectAtIndex:_current_index];
        
        _lblTitle.text = [NSString stringWithFormat:@"%@",videoInfo.title];
        _lblProvider.text = [NSString stringWithFormat:@"%@",videoInfo.provider];
        _txtDescription.text = [NSString stringWithFormat:@"%@",videoInfo.description];;
        
        
        _FavVideo=[[NSMutableArray alloc]init];
        _FavVideo=[[ServiceList Instance]getAllFavouriteVideos];
        
        for (FavouriteInfo *fi in _FavVideo) {
            if (fi.video_id ==_videoObj.video_id) {
                _videoObj.is_fav = YES;
                [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
                break;
            }
            else{
                _videoObj.is_fav = NO;
                [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
            }
        }
        
        
        
        
    }
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: CGRectMake(-200, -200, 0, 0)];
    [self.view addSubview: volumeView];
    //[_player setUseApplicationAudioSession:YES];;
    
    if ([Uitility getBoolForKey:kAudioControlMute]) {
        
        audioControlBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mute.png"] style:UIBarButtonItemStylePlain target:self action:@selector(audioControls)];
        [Uitility saveValue:[NSString stringWithFormat:@"%f",[MPMusicPlayerController applicationMusicPlayer].volume] ForKey:kAudioControlVolumeLevel];
        // [[MPMusicPlayerController applicationMusicPlayer]setVolume:0.0];
        
    }else{
        audioControlBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"unmute.png"] style:UIBarButtonItemStylePlain target:self action:@selector(audioControls)];
        // [[MPMusicPlayerController applicationMusicPlayer]setVolume:[[Uitility getValueForKey:kAudioControlVolumeLevel] floatValue]];
    }
    // audioControlBarItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItems = @[refresh,audioControlBarItem];
    
    [self setChatViewAreaShort];
    
    
    //[Uitility saveBool:NO ForKey:@"articleClicked"];
    //    if ([Uitility getBoolForKey:@"articleClicked"]) {
    //        _tblArticleView.hidden = NO;
    //        containerView.hidden = YES;
    //        _btnArticle.selected = YES;
    //    }else{
    //        _tblArticleView.hidden = YES;
    //        _btnArticle.selected = NO;
    //        containerView.hidden = NO;
    //    }
    //    [_tblArticleView reloadData];
    [_viewEmail setHidden:YES];
    [self startTimerForDashboard];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_playerDemand pause];
    [_player pause];
}

/*
 if ([[NSUserDefaults standardUserDefaults] boolForKey:@"RINGER_IS_ON"]) {
 [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil]; // Ignore the side swicth - play audio
 } else {
 [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil]; // Respect the side switch - don't play audio
 }
 */
- (void)audioControls{
    // [_player setUseApplicationAudioSession:YES];;
    if ([Uitility getBoolForKey:kAudioControlMute]) {
        audioControlBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"unmute.png"] style:UIBarButtonItemStylePlain target:self action:@selector(audioControls)];
        
        ;
        
        [[MPMusicPlayerController applicationMusicPlayer]setVolume:[[Uitility getValueForKey:kAudioControlVolumeLevel] floatValue]];
        
        
        
        
        [Uitility saveBool:NO ForKey:kAudioControlMute];
    }else{
        [Uitility saveBool:YES ForKey:kAudioControlMute];
        [Uitility saveValue:[NSString stringWithFormat:@"%f",[MPMusicPlayerController applicationMusicPlayer].volume] ForKey:kAudioControlVolumeLevel];
        [[MPMusicPlayerController applicationMusicPlayer]setVolume:0.0];
        audioControlBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mute.png"] style:UIBarButtonItemStylePlain target:self action:@selector(audioControls)];
    }
    self.navigationItem.rightBarButtonItems = @[refresh,audioControlBarItem];
}


- (void)reloadxx{
    [Store Instance].categoryArray = [[NSMutableArray alloc]init];
    [ServiceList Instance].videoArray = [[NSMutableArray alloc]init];
    [[ActivityIndicator currentIndicator]displayActivity:@"Reloading..."];
    
    [self backToforeground];
    [self getEarlierMessages];
    [[ServiceList Instance]loadArticleDelegate:self];
    [[ServiceList Instance]loadOndemandVideoDelegate:self];
}


- (IBAction)tappedApplePay:(id)sender {
    
}

//----- ravinder -------//
-(void)callServiceAgainAndAgain{
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    [[ServiceList Instance] hitRequestWithUniqueDeviceID:currentDeviceId delegate:self];
}
//---------------------//
- (void)handle_VolumeChanged:(NSNotification *)notification{
    if([MPMusicPlayerController applicationMusicPlayer].volume >0 ){
        [Uitility saveValue:[NSString stringWithFormat:@"%f",[MPMusicPlayerController applicationMusicPlayer].volume] ForKey:kAudioControlVolumeLevel];
    }
    
}
-(void)doneButtonClick:(NSNotification*)aNotification{
    NSNumber *reason = [aNotification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
   // UIViewController *c = [[UIViewController alloc]init];
    //[self.navigationController presentViewController:c animated:NO completion:nil];
    //[self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


-(void)ListViewDelegate:(NewProductInfo *)info{
    NewProductDetailView * viewsss = [NewProductDetailView initViewCartItem:info Delegate:self];
    [[KGModal sharedInstance]showWithContentView:viewsss];
}

-(void)productNext{
    NewProductCalanderView * view = [NewProductCalanderView initViewNewProductInfo:nil Delegate:nil];
//    [[KGModal sharedInstance]hideAnimated:view];
    [[KGModal sharedInstance] showWithContentView:view];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"viewdidload");
    
    [[ServiceList Instance]loadGeneric:self];
    [[ServiceList Instance]loadtCoutry:self];
    [[ServiceList Instance]loadNewProducts:self];
    
    if ([AccountManager Instance].activeAccount == nil) {
        
        WelcomeViewController *controller = [WelcomeViewController initViewController:self];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        // Narendra [self presentViewController:controller animated:YES completion:^{
            
       // }];
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEmailView) name:@"ShowEmail" object:nil];
    
    _btnOndemand.hidden = YES;
    _lblCount.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cartClicked:)];
    [_lblCount addGestureRecognizer:tapGesture];
    
    self.viewShow.hidden = YES;
    [self articleClose:nil];
    [self resetAllButton];
    [[MPMusicPlayerController applicationMusicPlayer] beginGeneratingPlaybackNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handle_VolumeChanged:)
                                                 name:MPMusicPlayerControllerVolumeDidChangeNotification
                                               object:[MPMusicPlayerController applicationMusicPlayer]];
    
    [[ServiceList Instance]loadArticleDelegate:self];
    [[ServiceList Instance]loadOndemandVideoDelegate:self];
    
    
    //------------ ravinder -----//
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    [[ServiceList Instance] hitRequestWithUniqueDeviceID:currentDeviceId delegate:self];
    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(callServiceAgainAndAgain) userInfo:nil repeats:YES];
    //---------------------//
    
    [self chatdisplay];
    
    [[Store Instance]loadAllProductDelegate:self];
    [self backToforeground];
    playbackDurationSet=NO;
    
    _infoImage.layer.masksToBounds = YES;
    [_infoImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_infoImage.layer setBorderWidth: 2.0];
    
    _BtnApplepay.layer.masksToBounds = YES;
    _BtnApplepay.layer.cornerRadius = 8;
    
    _BtnBraintree.layer.masksToBounds=YES;
    _BtnBraintree.layer.cornerRadius=8;
    
    //  [[BrainTreeInstance Instance]getClientTokenWithUserID:self];;
    
    _selectedIndex=-1;
    cnt=0;
    _selectedcellindex=-1;
    _Selectedcellsection=-1;
    
    _searchBar.enablesReturnKeyAutomatically = false;
    _value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:_value forKey:@"orientation"];
    
    [_btnChat setImage:[UIImage imageNamed:@"livechat-hover.png"] forState:UIControlStateNormal];
    UIImageView * imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo120.png"]];
    [imagev setContentMode:UIViewContentModeScaleAspectFit];
    imagev.frame = CGRectMake(0, 0,50, 35);
    self.navigationItem.titleView = imagev;
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = NO;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setChatViewAreaShortIPad];
    }
    else{
        [self setChatViewAreaShort];
    }
    _islongChatArea = NO;
    // [self backToforeground];
    [self getEarlierMessages];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToforeground) name:@"BACKGROUNDTOFORE" object:nil];
    
    [_timer invalidate];
    _timer = nil;
    _timer =  [NSTimer scheduledTimerWithTimeInterval:30.0
                                               target:self
                                             selector:@selector(getEarlierMessages)
                                             userInfo:nil
                                              repeats:YES];
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [_storeCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellidentifier"];
        [_profileProductCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellidentifierProduct"];
    }else{
        [_storeCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellidentifier"];
        [_profileProductCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCellInfo" bundle:nil] forCellWithReuseIdentifier:@"CellidentifierProduct"];
        
        [_OnDemandCollectionView registerNib:[UINib nibWithNibName:@"OnDemandCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OnDemandCollectionViewCell"];
        
    }
    
    
    [self articleClicked:nil];
    
    //
    
    /*  [_storeCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellidentifier"];
     */
    
    
}

-(void)cartTotalXX{
    // _lblItem.text = [NSString stringWithFormat:@"Item(%lu)   : %@",(unsigned long)[Cart Instance].productsInCart.count,[Uitility getCurrencyStringFromAmount:[Cart Instance].cartTotal]];
    
    _lblItem.text = [NSString stringWithFormat:@"Item(%lu)   : %@",(unsigned long)[self CountCartqty],[Uitility getCurrencyStringFromAmount:[Cart Instance].cartSubTotal]];
    _lblCount.text = [NSString stringWithFormat:@"%d",[self CountCartqty]];
    
    _lblShipping.text = [NSString stringWithFormat:@"Shipping : FREE"];
    
    _lblTax.text = [NSString stringWithFormat:@"Tax          : %@",[Uitility getCurrencyStringFromAmount:[Cart Instance].cartTax]];
    _lblTotal.text = [NSString stringWithFormat:@"Total        : %@",[Uitility getCurrencyStringFromAmount:[Cart Instance].cartTax + [Cart Instance].cartSubTotal+ 0.00]];
}

-(void)getEarlierMessages{
    [ChatList clearInstance];
    [[ChatList Instance]loadAllMessage:self];
    [[ServiceList Instance]ALLFavouriteVideo:self];
}

- (IBAction)showInfoClicked:(id)sender{
    
    [self resetAllButton];
    
    if (_profileProductArr.count <= 0) {
        _lblNoItemInfo.hidden = NO;
    }
    
    
    
    [_btnShow setImage:[UIImage imageNamed:@"showinfo-hover.png"] forState:UIControlStateNormal];
    
    self.showInfoView.hidden = NO;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    self.articleSearch.hidden = YES;
    
    
    _FavVideo = [[NSMutableArray alloc]init];
    _FavVideo = [[ServiceList Instance]getAllFavouriteVideos];
    
    for (FavouriteInfo *fi in _FavVideo) {
        if (fi.video_id==_videoObj.video_id) {
            [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
            break;
        }else{
            [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
        }
    }
    
    containerView.hidden=YES;
    
    if (!_btnOndemand.hidden) {
        // Demand play
        _lblTitle.text = [NSString stringWithFormat:@"%@",demandVideo.title];
        _lblProvider.text = [NSString stringWithFormat:@"%@",demandVideo.provider];
        _txtDescription.text = demandVideo.description;
        
        _infoImage.url=[NSURL URLWithString:demandVideo.video_img];
        
    }else{
        if (_videosArray.count > 0) {
            Video * videoInfo = [_videosArray objectAtIndex:_current_index];
            
            
            
            _lblTitle.text = videoInfo.title;
            
            _lblProvider.text = [NSString stringWithFormat:@"%@",videoInfo.provider];;
            _txtDescription.text = videoInfo.description;
            
            _infoImage.url = [NSURL URLWithString:videoInfo.video_img];
            
        }
    }
    
   
    
    _btnGoCart.hidden = NO;
    
    _lblCount.hidden = NO;
    [self setChatViewAreaShort];
    
}



-(void)addFavClicked:(id)sender{
    
    
    if ([AccountManager Instance].activeAccount == nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Please Login" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (_videoObj.is_fav) {
        _videoObj.is_fav = NO;
        [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
        for ( FavouriteInfo *fi in _FavVideo) {
            if (fi.video_id==_videoObj.video_id) {
                // [[ActivityIndicator currentIndicator]displayActivity:@"Unfavoriting..."];
                [[ServiceList Instance]DeleteFavVideoInfo:fi Delegate:self];
                break;
            }
        }
        
    }else{
        _videoObj.is_fav = YES;
        [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
        //[[ActivityIndicator currentIndicator]displayActivity:@"Favoriting..."];
        [[ServiceList Instance]addFavVideoInfo:_videoObj categoryId:_catId Delegate:nil];
    }
    
    
    
    //
    //    if ([_videosArray containsObject:_videoObj])
    //    {
    //        int index = [self FindVideo:_videoObj];
    //        [_videosArray replaceObjectAtIndex:index withObject:_videoObj];
    //    }
    //
    //
    //    for ( FavouriteInfo *fi in _FavVideo) {
    //        if (fi.video_id==_videoObj.video_id) {
    //            [[ServiceList Instance]DeleteFavVideoInfo:fi Delegate:self];
    //            return;
    //        }
    //    }
    
    
}
- (int)FindVideo:(Video *)item {
    
    for (int i = 0; i < [_videosArray count]; i++) {
        Video *cii = [_videosArray objectAtIndex:i];
        if([cii isEqual:item]){
            return i;
        }
    }
    return -1;
}

- (IBAction)liveChatClicked:(id)sender{
    [self resetAllButton];
    [_btnChat setImage:[UIImage imageNamed:@"livechat-hover.png"] forState:UIControlStateNormal];
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = NO;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    self.articleSearch.hidden = YES;
    
    containerView.hidden=NO;
    
}
- (IBAction)cartClicked:(id)sender{
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = NO;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    containerView.hidden=YES;
    self.articleSearch.hidden = YES;
    [self resetAllButton];
    
    
}
- (IBAction)storeClicked:(id)sender{
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = NO;
    self.searchBar.hidden = NO;
    containerView.hidden=YES;
    self.articleSearch.hidden = YES;
    
    [self resetAllButton];
    _btnGoCart.hidden = NO;
    _lblCount.hidden = NO;
    if (_searchResults.count <= 0) {
        _lblNoItem.hidden = NO;
    }
    
    [_btnStore setImage:[UIImage imageNamed:@"store-hover.png"] forState:UIControlStateNormal];
    [self setChatViewAreaShort];
    
    
}
- (IBAction)lineUpClicked:(id)sender{
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = NO;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    self.articleSearch.hidden = YES;
    
    containerView.hidden=YES;
    [self resetAllButton];
    [_btnLineup setImage:[UIImage imageNamed:@"lineup-hover.png"] forState:UIControlStateNormal];
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    picker.allowsEditing=YES;
    picker.delegate=self;
    UIImage * profileImage = info[UIImagePickerControllerEditedImage];
    
    profileImage = [self imageWithImage:profileImage scaledToWidth:200.0];
    
    [[ActivityIndicator currentIndicator]displayActivity:@"Message Sending..."];
    [[ChatList Instance]sendImageMessage:self MessageImage:profileImage];
    _txtMessage.text = @"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)applePayClicked:(id)sender{
    
}
- (IBAction)BrainTreeClicked:(id)sender{
    Order* order = [[Order alloc]init];
    order.amount = [Cart Instance].cartTotal + 6.0;
    
    if ([AccountManager Instance].activeAccount == nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Login to Support Great Music" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    if ([Cart Instance].productsInCart.count <= 0) {
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:alertTitle message:@"Support Great Music: Add an Item" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    BraintreeCreditView * view = [BraintreeCreditView initViewOrder:order Delegate:self];
    [[KGModal sharedInstance]showWithContentView:view];;
}
- (void) BrainTreeorderData:(Order *)order{
    
    [[KGModal sharedInstance]hideAnimated:YES];
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[BrainTreeInstance Instance]postOrderWithBraintree:order Delegate:self];
}
//    Order* order = [[Order alloc]init];
//    order.amount = [Cart Instance].cartTotal + 6.0;
//    order.token = token;
//    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
//    [[BrainTreeInstance Instance]postOrderWithBraintree:order Delegate:self];
//}

- (IBAction)OneTimeClicked:(id)sender{
    
    if ([AccountManager Instance].activeAccount == nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Login to Support Great Music" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([Cart Instance].productsInCart.count <= 0) {
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:alertTitle message:@"Support Great Music: Add an Item" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    OneTimeViewController * controller = [OneTimeViewController initViewController];
    [self.navigationController pushViewController:controller animated:NO];
    
    
    //CreditView * view = [CreditView initViewDelegate:self];
    //[[KGModal sharedInstance]showWithContentView:view];;
    
}
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    //NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    //NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
    
    Order* order = [[Order alloc]init];
    order.amount = [Cart Instance].cartTotal + 6.0;
    order.number = info.cardNumber;
    order.HideNumber = info.redactedCardNumber;
    order.cvv = info.cvv;
    order.month = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    order.year = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    
    
    CreditView *view = [CreditView initViewOrder:order Delegate:self];
    
    [[KGModal sharedInstance]showWithContentView:view andAnimated:YES];
}
- (void) orderData:(Order *)order{
    
    [[KGModal sharedInstance]hideAnimated:YES];
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [order postOrderDelegate:self];
}

-(void)loginClicked:(id)sender{
    if ([AccountManager Instance].activeAccount == nil) {
        LoginViewController * controller =[LoginViewController initViewControlller:@""];
        UINavigationController * navigationController =[[UINavigationController alloc]initWithRootViewController:controller];
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }else{
        ProfileViewController * controller =[ProfileViewController initViewController];
        UINavigationController * navigationController =[[UINavigationController alloc]initWithRootViewController:controller];
        navigationController.navigationBar.translucent = NO;
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_txtMessage resignFirstResponder];
    [self.view reloadInputViews];
    
    return YES;
    
}
    
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == _txtEmail) {
        if (![Uitility isEmailValid:_txtEmail.text]) {
            [_viewEmail setHidden:YES];
            [self.view endEditing:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:_txtEmail.text forKey:@"Email"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isShowGetEmailFirstTime"];
        }else{
            return NO;
        }
        
        

    }
    return YES;
}
    
-(IBAction)messageSent:(id)sender{
    [textView resignFirstResponder];
    [self.view reloadInputViews];
    if([AccountManager Instance].activeAccount == nil){
        // UIAlertView * alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"You must be login before start Chat." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Please login." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (textView.text.length <= 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"What's on your mine?" delegate:nil cancelButtonTitle:@"Chat Below" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSData *data = [textView.text dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"abc123 %@",goodValue);
    
    NSString *newString = [goodValue stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    
    //NSLog(@"hardik  msg %@",newString);
    
    [[ChatList Instance]sendMessage:self Message:newString];
    // rowIndexMessage = [sender intValue];
    //  [[ChatList Instance]sendMessage:self Message:_txtMessage.text];
    textView.text = @"";
    [textView resignFirstResponder];
}

-(void)sliderClicked:(id)sender{
    if (_islongChatArea) {
        [_iconBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
        //[self setChatViewAreaShort];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self setChatViewAreaShortIPad];
        }
        else{
            [self setChatViewAreaShort];
        }
        
        
    }else{
        [_iconBtn setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
        
        // [self setChatViewAreaLong];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self setChatViewAreaLongIPad];
        }
        else{
            [self setChatViewAreaLong];
        }
    }
    _islongChatArea =! _islongChatArea;
}

- (void)setChatViewAreaShort{
    self.playerView.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,197);
    
    //----- ravinder ----//
    self.countIcon.frame=CGRectMake(self.countIcon.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+3, self.countIcon.frame.size.width, self.countIcon.frame.size.height);
    self.btnArticle.frame = CGRectMake(self.btnArticle.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height-1, self.btnArticle.frame.size.width, self.btnArticle.frame.size.height);
    self.btnShare.frame = CGRectMake(self.btnShare.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+1, self.btnShare.frame.size.width, self.btnShare.frame.size.height);;
    
    self.totalCountLbl.frame = CGRectMake(self.totalCountLbl.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+3, self.totalCountLbl.frame.size.width, self.totalCountLbl.frame.size.height);
    self.btnFav.frame = CGRectMake(self.btnFav.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+1, self.btnFav.frame.size.width, self.btnFav.frame.size.height);
    //------------------//
    
    self.btnLANDSCAPE.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,197);
    
    
    self.player.view.frame = self.playerView.frame;
    self.playerDemand.view.frame = self.playerView.frame;
    
    _iconBtn.frame =CGRectMake(_iconBtn.frame.origin.x, self.playerView.frame.size.height, _iconBtn.frame.size.width,_iconBtn.frame.size.height);
    
    self.tblChatView.frame =CGRectMake(self.tblChatView.frame.origin.x,self.playerView.frame.size.height + self.iconBtn.frame.size.height, self.tblChatView.frame.size.width,203);
    
    self.showInfoView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width + 39);
    
    self.OnDemandView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y-13, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width + 39);
    
    self.LineUpView.frame = CGRectMake(self.tblChatView.frame.origin.x,self.playerView.frame.size.height + self.iconBtn.frame.size.height, self.tblChatView.frame.size.width,196+40);
    
    //  self.storeCollectionView.frame = self.tblChatView.frame;
    
    self.cartView.frame = self.showInfoView.frame;
    
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, _countIcon.frame.origin.y - 13, _searchBar.frame.size.width, _searchBar.frame.size.height);
    
    
    if (!self.showInfoView.hidden) {
        _btnGoCart.frame = CGRectMake(145,201 ,_btnGoCart.frame.size.width, _btnGoCart.frame.size.height);
        
        _lblCount.frame = CGRectMake(118, 201 , _lblCount.frame.size.width, _lblCount.frame.size.height);
    }else{
        _btnGoCart.frame = CGRectMake(290, _searchBar.frame.origin.y + _searchBar.frame.size.height, _btnGoCart.frame.size.width, _btnGoCart.frame.size.height);
        
        _lblCount.frame = CGRectMake(263, _searchBar.frame.origin.y + _searchBar.frame.size.height , _lblCount.frame.size.width, _lblCount.frame.size.height);
    }
    
    
    
    
    
    _articleSearch.frame =CGRectMake(_articleSearch.frame.origin.x, _countIcon.frame.origin.y - 13, _articleSearch.frame.size.width, _articleSearch.frame.size.height);
    
    self.storeCollectionView.frame = CGRectMake(self.playerView.frame.origin.x,_btnGoCart.frame.origin.y + _btnGoCart.frame.size.height, self.tblChatView.frame.size.width,self.tblChatView.frame.size.height);
    
    self.tblArticleView.frame = CGRectMake(self.tblArticleView.frame.origin.x,_articleSearch.frame.origin.y + _articleSearch.frame.size.height + 5, self.tblArticleView.frame.size.width,self.tblArticleView.frame.size.height);
    
    self.lblNoItem.frame =CGRectMake(self.lblNoItem.frame.origin.x,self.storeCollectionView.frame.origin.y+5, self.lblNoItem.frame.size.width,self.lblNoItem.frame.size.height);
    //  _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, 417, _searchBar.frame.size.width, _searchBar.frame.size.height);
}

-(void)setChatViewAreaLong{
    
    self.playerView.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,110.0);
    
    //----- ravinder ----//
    self.countIcon.frame=CGRectMake(self.countIcon.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+3, self.countIcon.frame.size.width, self.countIcon.frame.size.height);
    self.btnArticle.frame = CGRectMake(self.btnArticle.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height-1, self.btnArticle.frame.size.width, self.btnArticle.frame.size.height);
    self.btnShare.frame = CGRectMake(self.btnShare.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+1, self.btnShare.frame.size.width, self.btnShare.frame.size.height);;
    self.totalCountLbl.frame = CGRectMake(self.totalCountLbl.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+3, self.totalCountLbl.frame.size.width, self.totalCountLbl.frame.size.height);
    self.btnFav.frame = CGRectMake(self.btnFav.frame.origin.x, self.playerView.frame.origin.y + self.playerView.frame.size.height+1, self.btnFav.frame.size.width, self.btnFav.frame.size.height);
    //------------------//
    
    
    self.btnLANDSCAPE.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,110.0);
    
    self.player.view.frame = self.playerView.frame;
    self.playerDemand.view.frame = self.playerView.frame;
    
    _iconBtn.frame =CGRectMake(_iconBtn.frame.origin.x, self.playerView.frame.size.height,_iconBtn.frame.size.width,_iconBtn.frame.size.height);
    
    _tblChatView.frame =CGRectMake(_tblChatView.frame.origin.x,_iconBtn.frame.size.height + self.playerView.frame.size.height, _tblChatView.frame.size.width,293.0);
    
    self.showInfoView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width + 38);
    
    self.OnDemandView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y-13, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width + 38);
    
    self.LineUpView.frame = CGRectMake(_tblChatView.frame.origin.x,_iconBtn.frame.size.height + self.playerView.frame.size.height, _tblChatView.frame.size.width,288.0+40);
    
    
    self.cartView.frame = self.showInfoView.frame;
    
    
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, _countIcon.frame.origin.y - 13 , _searchBar.frame.size.width, _searchBar.frame.size.height);
    
    
    
    if (!self.showInfoView.hidden) {
        
        _btnGoCart.frame = CGRectMake(145, 201 , _btnGoCart.frame.size.width, _btnGoCart.frame.size.height);
        
        _lblCount.frame = CGRectMake(118,201, _lblCount.frame.size.width, _lblCount.frame.size.height);
        
    }else{
        _btnGoCart.frame = CGRectMake(290, _searchBar.frame.origin.y + _searchBar.frame.size.height , _btnGoCart.frame.size.width, _btnGoCart.frame.size.height);
        
        _lblCount.frame = CGRectMake(263, _searchBar.frame.origin.y + _searchBar.frame.size.height, _lblCount.frame.size.width, _lblCount.frame.size.height);
        
        
    }
    
    
    
    self.storeCollectionView.frame = CGRectMake(self.playerView.frame.origin.x,_btnGoCart.frame.origin.y + _btnGoCart.frame.size.height, self.tblChatView.frame.size.width,self.tblChatView.frame.size.height);
    
    
    
    self.lblNoItem.frame =CGRectMake(self.lblNoItem.frame.origin.x,self.storeCollectionView.frame.origin.y+5, self.lblNoItem.frame.size.width,self.lblNoItem.frame.size.height);
    
    _articleSearch.frame =CGRectMake(_articleSearch.frame.origin.x, _countIcon.frame.origin.y-13, _articleSearch.frame.size.width, _articleSearch.frame.size.height);
    
    self.tblArticleView.frame = CGRectMake(self.tblArticleView.frame.origin.x,_articleSearch.frame.origin.y + _articleSearch.frame.size.height + 5, self.tblArticleView.frame.size.width,self.tblArticleView.frame.size.height);
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view.window endEditing:YES];
}
- (void)backToforeground{
    //[[ActivityIndicator currentIndicator]displayActivity:@"Reloading..."];
    [ServiceList Instance].videoArray = [[NSMutableArray alloc]init];
    [[ServiceList Instance]loadMtimerDelegate:self];
    [[ServiceList Instance]loadAllVideoDelegate:self];
    
}
- (void)goLive{
//    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    
    [[ServiceList Instance]loadMtimerDelegate:self];
}

-(void)videoPlay:(int)playindex seekPlayTime:(float)playtime{
    _btnOndemand.hidden = YES;
    if (_videosArray.count > 0) {
        playbackDurationSet=NO;
        [_player.view removeFromSuperview];
        _player = nil;
        [_playerDemand.view removeFromSuperview];
        _playerDemand = nil;
        
        Video * info =[_videosArray objectAtIndex:playindex];
        
        _videoObj = info;
        //// fav code
        _FavVideo=[[NSMutableArray alloc]init];
        _FavVideo=[[ServiceList Instance]getAllFavouriteVideos];
        [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
        if ([_FavVideo count]>0) {
            
            for (FavouriteInfo *fi in _FavVideo) {
                if (fi.video_id==_videoObj.video_id) {
                    [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
                    break;
                }
                else{
                    [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
                }
            }
            
        }
        
        
        NSURL *url = [NSURL URLWithString:info.url];
        
        _player =  [[MPMoviePlayerController alloc]
                    initWithContentURL:url];
        
        
        //[_player setInitialPlaybackTime:playtime];
        playtimeXX = playtime;
        float finish = [self timeFromString:info.duration];
        
        [_player setEndPlaybackTime:finish];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_player];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerPlaybackStateChanged:)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_player];
        /***my code******/
        if(_value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] || _value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight]){
            _player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        else
        {
            _player.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
            
        }
        /***********/
        
        // _player.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
        
        [self.playerView addSubview:_player.view];
        //[_player setFullscreen:NO animated:NO];
        
        _player.controlStyle = MPMovieControlStyleNone;
        [_player prepareToPlay];
        [_player play];
        
       
    }
    
    
    
}

-(void)playOnDemandVideo:(Video*)info{
    demandVideo = info;
    _btnOndemand.hidden = NO;
    _lblTitle.text = [NSString stringWithFormat:@"%@",info.title];
    _lblProvider.text = [NSString stringWithFormat:@"%@",info.provider];
    _txtDescription.text = info.description;
    
    _infoImage.url=[NSURL URLWithString:info.video_img];
    {
       
            playbackDurationSet=NO;
            [_player.view removeFromSuperview];
            _player = nil;
        [_playerDemand.view removeFromSuperview];
        _playerDemand = nil;
        
            //// fav code
            _FavVideo=[[NSMutableArray alloc]init];
            _FavVideo=[[ServiceList Instance]getAllFavouriteVideos];
            [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
            if ([_FavVideo count]>0) {
                
                for (FavouriteInfo *fi in _FavVideo) {
                    if (fi.video_id==_videoObj.video_id) {
                        [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
                        break;
                    }
                    else{
                        [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
                    }
                }
                
            }
            
            
            
            NSURL *url = [NSURL URLWithString:info.url];
            
            _playerDemand =  [[MPMoviePlayerController alloc]
                        initWithContentURL:url];
       
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(moviePlayerDidFinishDemand:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:_playerDemand];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(moviePlayerPlaybackStateChangedDemand:)
                                                         name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                       object:_playerDemand];
            /***my code******/
            if(_value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] || _value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight]){
                _playerDemand.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }
            else
            {
                _playerDemand.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
                
            }
        
            
            [self.playerView addSubview:_playerDemand.view];
            _playerDemand.controlStyle = MPMovieControlStyleDefault;
            [_playerDemand prepareToPlay];
            [_playerDemand setInitialPlaybackTime:0];
            [_playerDemand play];
        }
    
}
-(void) moviePlayerPlaybackStateChangedDemand:(NSNotification*)notification
{
    
}
- (void)moviePlayerDidFinishDemand:(NSNotification *)note
{
    [self goLive];
}

-(void) moviePlayerPlaybackStateChanged:(NSNotification*)notification
{
    MPMoviePlayerController* playeraaa = (MPMoviePlayerController*)notification.object;
    switch (playeraaa.playbackState)
    {
        case MPMoviePlaybackStatePlaying:
            if(!playbackDurationSet)
            {
                [self.player setCurrentPlaybackTime:playtimeXX];
                playbackDurationSet=YES;
                
                /******mycode************/
                if(_value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] || _value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight])
                {
                    [self.navigationController setNavigationBarHidden:YES animated:YES];
                    [_player setFullscreen:YES animated:YES];
                }
                else
                {
//                    [self.navigationController setNavigationBarHidden:NO animated:NO]; //Nimit Comment
                    [_player setFullscreen:NO animated:NO];
                }
                /***********************/
            }
            break;
        case MPMoviePlaybackStatePaused:
            if (_player != nil && [_player playbackState] == MPMoviePlaybackStatePaused)
            {
                [_player play];
            }
            break;
    }
}
- (void)moviePlayerDidFinish:(NSNotification *)note
{
    // [_player.view removeFromSuperview];
    //_player = nil;
    
    if (_current_index < _videosArray.count-1)
    {
        _current_index++;
        
        Video * videoInfo = [_videosArray objectAtIndex:_current_index];
        _videoObj = videoInfo;
        _lblTitle.text = [NSString stringWithFormat:@"%@",videoInfo.title];
        _lblProvider.text = [NSString stringWithFormat:@"%@",videoInfo.provider];;
        _txtDescription.text = [NSString stringWithFormat:@"%@",videoInfo.description];
        
        _infoImage.url = [NSURL URLWithString:videoInfo.video_img];
        
        
        ///////// fav code
        
        for (int i = 0; i < [_FavVideo count]; i++)
        {
            FavouriteInfo *fi = [_FavVideo objectAtIndex:i];
            
            //NSLog(@"fffff fav id  for video %d",fi.video_id);
            //NSLog(@"vvvvv fav id for video %d  \n\n\n\n\n\n\n\n\n",_videoObj.video_id);
            
            
            if (fi.video_id==_videoObj.video_id) {
                [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
                // return;
            }
            else{
                [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
            }
        }
        
        ///////
        // _player=nil;
        [self videoPlay:_current_index seekPlayTime:0];
    }else{
        if(_value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] || _value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight]){
            
            [_player.view removeFromSuperview];
            self.playerView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        _catId=0;
        _player=nil;
        _current_index = 0;
        //        [_timer2 invalidate];
        //        _timer2=nil;
        //        _timer2 =  [NSTimer scheduledTimerWithTimeInterval:1.0
        //                                                   target:self
        //                                                 selector:@selector(nextcategoryplay)
        //                                                 userInfo:nil
        //                                                  repeats:YES];
        
        _lblProvider.text =@"";
        _lblTitle.text =@"";
        _txtDescription.text = @"";
        _infoImage.image=[UIImage imageNamed:@"no_img.png"];
        [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
        _profileProductArr = [[NSMutableArray alloc]init];
        _profileProductArr =  0;
        [self.profileProductCollectionView reloadData];
        [self backToforeground];
        
        
        
        
    }
}

- (void)moviePlayerDidLoad{
    if (_player)
    {
        [_player prepareToPlay];
        [_player play];
    }
}

#pragma mark - UICollectionView Datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    if (_OnDemandCollectionView == view) {
        return onDemandArray.count;
    }
    
    if (_profileProductCollectionView == view) {
        return _profileProductArr.count;
    }
    
    if (_searchResults.count <= 0 ) {
        _lblNoItem.hidden = NO;
    }
    return _searchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_OnDemandCollectionView == cv) {
        OnDemandCollectionViewCell * onDemandCell = [cv dequeueReusableCellWithReuseIdentifier:@"OnDemandCollectionViewCell" forIndexPath:indexPath];
        Video * info = [onDemandArray objectAtIndex:indexPath.row];
        [onDemandCell setData:info];
        return  onDemandCell;
    }
    
    if (_profileProductCollectionView == cv) {
        
        CollectionViewCell *cellProduct = [cv dequeueReusableCellWithReuseIdentifier:@"CellidentifierProduct" forIndexPath:indexPath];
        
        ProductInfo * info = [_profileProductArr objectAtIndex:indexPath.row];
        //NSLog(@"ProfileProductCollectionView");
        if (info.productImageArr.count > 0) {
            cellProduct.productImage.url = [NSURL URLWithString:[info.productImageArr objectAtIndex:0]];
        }
        
        cellProduct.lblProductName.text = info.product_title;
        
        cellProduct.lblProductPrice.text = [Uitility getCurrencyStringFromAmount:info.product_price];
        
        //cellProduct.layer.masksToBounds = YES;
        //cellProduct.layer.cornerRadius = 6;
        cellProduct.layer.masksToBounds = YES;
        cellProduct.layer.cornerRadius = 2;
        //cellProduct.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // cellProduct.layer.borderWidth = 1.0;
        return cellProduct;
    }
    if (_searchResults.count <= 0 ) {
        _lblNoItem.hidden = NO;
    }
    
    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cellidentifier" forIndexPath:indexPath];
    
    ProductInfo * info = [_searchResults objectAtIndex:indexPath.row];
    [cell setDataProductInfo:info];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_OnDemandCollectionView == collectionView) {
        Video * info = [onDemandArray objectAtIndex:indexPath.row];
        [self playOnDemandVideo:info];
        return;
    }
    
    if (_profileProductCollectionView == collectionView) {
        ProductInfo * info = [_profileProductArr objectAtIndex:indexPath.row];
        CartItem * ci = [CartItem initWithProduct:info];
        ProductDetailView * view = [ProductDetailView initViewCartItem:ci Delegate:self];
        [[KGModal sharedInstance]showWithContentView:view andAnimated:YES];
        return;
    }
    ProductInfo * info = [_searchResults objectAtIndex:indexPath.row];
    
    CartItem * ci = [CartItem initWithProduct:info];
    ProductDetailView * view = [ProductDetailView initViewCartItem:ci Delegate:self];
    
    [[KGModal sharedInstance]showWithContentView:view andAnimated:YES];;
    
}
-(void)cartItemDeleteCartItem:(CartItem *)cartItem{
    [[Cart Instance]removeItembyTableEditRowFromCart:cartItem];
    [self cartTotalXX];
    _cartArray = [[NSMutableArray alloc]init];
    _cartArray = [Cart Instance].productsInCart;
    [_tblCartView reloadData];
}
-(void)productAddToCart:(CartItem *)info{
    [[KGModal sharedInstance]hideAnimated:YES];
    [[Cart Instance]addCartItemInList:info];
    _cartArray = [[NSMutableArray alloc]init];
    _cartArray = [Cart Instance].productsInCart;
    [_tblCartView reloadData];
    [self cartTotalXX];
    
}
-(void)articleClose:(id)sender{
    
    _tblArticleView.hidden = YES;
    containerView.hidden = NO;
    _btnCloseArticle.hidden = YES;
    self.articleSearch.hidden = YES;
    
}
-(void)articleClicked:(id)sender{
    
    
    [self resetAllButton];
    [_btnArticlexxxxx setImage:[UIImage imageNamed:@"cartNew.png"] forState:UIControlStateNormal];
    
    self.showInfoView.hidden = NO;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    self.articleSearch.hidden = YES;
    
    
    
    _tblArticleView.hidden = NO;
    containerView.hidden = YES;
    _btnCloseArticle.hidden = NO;
    self.articleSearch.hidden = NO;
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    containerView.hidden=YES;
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"productId"
                                                                ascending: NO];
    NSArray *orderedArray = [articleArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    articleArray = [orderedArray mutableCopy];
    [_tblArticleView reloadData];
    
}
-(void)OnDemandClicked:(id)sender{
    
    
    [self resetAllButton];
    //    [_btnArticlexxxxx setImage:[UIImage imageNamed:@"cart-hover.png"] forState:UIControlStateNormal];
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    self.articleSearch.hidden = YES;
    
    
    
    _tblArticleView.hidden = YES;
    containerView.hidden = YES;
    _btnCloseArticle.hidden = YES;
    self.articleSearch.hidden = YES;
    
    self.showInfoView.hidden = YES;
    self.LineUpView.hidden = YES;
    self.tblChatView.hidden = YES;
    self.cartView.hidden = YES;
    self.storeCollectionView.hidden = YES;
    self.searchBar.hidden = YES;
    containerView.hidden=YES;
    self.OnDemandView.hidden = NO;
    
    
    
    onDemandArray = [[NSMutableArray alloc]init];
    onDemandArray = [[ServiceList Instance]getDemandVideo];
    if (onDemandArray.count <= 0) {
        _OnDemandCollectionView.hidden = YES;
    }
    [_OnDemandCollectionView reloadData];
    
}

-(void)liveClicked:(id)sender{
    _btnOndemand.hidden = YES;
   // [[UIDevice currentDevice] setValue:
     //[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
       //                         forKey:@"orientation"];
    [self goLive];
}



-(void)shareActionClicked:(id)sender{
    NSString *url=@"https://itunes.apple.com/us/app/und-tv/id1065976890?ls=1&mt=8";
    NSString * title =[NSString stringWithFormat:@"Download UNDTV App : %@",url];
    NSArray* dataToShare = @[title];
    UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

-(int)CountCartqty
{
    int cntqty=0;
    for (CartItem *ci in [Cart Instance].productsInCart){
        cntqty=cntqty+ci.qty;
    }
    return cntqty;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 2000) {
        
        return sections.count;
    }else if (tableView == _tblArticleView){
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 2000) {
        return 35.0;
    }
    return 0.5;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2000) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width,35)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        
        NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:section];
        
        NSString * text = [[sectionDateFormatter stringFromDate:dateRepresentingThisDay]  stringByAppendingString:@" (PST)"];
        
        NSString * textDay = [[sectionDateFormatterMonDay stringFromDate:dateRepresentingThisDay]uppercaseString];
        
        //
        UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0,10,tableView.frame.size.width - 70, 25)];
        [label setFont:[UIFont boldSystemFontOfSize:13.0]];
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        label.text = [NSString stringWithFormat:@" %@",text];
        [headerView addSubview:label];
        
        
        UILabel *labelDay = [[UILabel alloc] initWithFrame: CGRectMake(label.frame.size.width,10,70, 25)];
        [labelDay setFont:[UIFont boldSystemFontOfSize:13.0]];
        labelDay.textColor = [UIColor darkGrayColor];
        labelDay.textAlignment = NSTextAlignmentCenter;
        labelDay.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        labelDay.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        labelDay.text = [NSString stringWithFormat:@"   %@",textDay];
        [headerView addSubview:labelDay];
        
        return headerView;
    }else{
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    return nil;
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag == 1000){
        return _chatArray.count;
    }else if(tableView.tag == 2000)
    {
        
        
        NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:section];
        NSArray *eventsOnThisDay1 = [sections objectForKey:dateRepresentingThisDay];
        
        return [eventsOnThisDay1 count];
    }else if (tableView == _tblArticleView){
        return articleArray.count;
    }else{
        if (_cartArray.count <= 0) {
            return 1;
        }
        return _cartArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblArticleView){
        return 67;
    }else if(tableView.tag == 1000){
        ChatInfo * feed_data=[_chatArray objectAtIndex:indexPath.row];
        
        if ([feed_data.messageType isEqualToString:ktextByme]||[feed_data.messageType isEqualToString:ktextbyother])
        {
            float cellHeight;
            // text
            // NSString *messageText = feed_data.message;
            NSString * messageWithName = [NSString stringWithFormat:@"%@ : %@",feed_data.user_name,feed_data.message];
            //
            CGSize boundingSize = CGSizeMake(messageWidth, 10000000);
            CGSize itemTextSize = [messageWithName sizeWithFont:[UIFont systemFontOfSize:13]
                                              constrainedToSize:boundingSize
                                                  lineBreakMode:NSLineBreakByCharWrapping];
            
            // plain text
            
            UITextView *messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(10,0,messageWidth, 0)];
            
            messageTextview.editable=NO;
            messageTextview.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
            messageTextview.text = messageWithName;
            messageTextview.scrollEnabled=false;
            
            [messageTextview sizeToFit]; //added
            [messageTextview layoutIfNeeded]; //added
            
            
            
            cellHeight = messageTextview.frame.size.height-10;
            
            //            if (cellHeight<25)
            //            {
            //                cellHeight=25.0;
            //            }
            //NSLog(@"if cell");
            return cellHeight;
        }
        else{
            //NSLog(@"else cell");
            
            return 140.0;
        }
        
        
    }
    else if (tableView.tag == 2000){
        return 40.0;
    }
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        return 44.0;
    }
    else{
        return  37.0;
    }
}
-(void)closeArticle:(id)sender{
    
    _viewShow.hidden=YES;
    [[MPMusicPlayerController applicationMusicPlayer]setVolume:[[Uitility getValueForKey:kAudioControlVolumeLevel] floatValue]];
    
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _tblArticleView) {
        ArticleInfo * a = [articleArray objectAtIndex:indexPath.row];
        [_webview setBackgroundColor:[UIColor clearColor]];
        
        NSURL *websiteUrl = [NSURL URLWithString:a.product_desc];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
        [self.webview loadRequest:urlRequest];
        
        self.viewShow.hidden = NO;
    }else if (tableView.tag ==2000) {
        NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:indexPath.section];
        NSArray *eventsOnThisDay2 = [sections objectForKey:dateRepresentingThisDay];
        
        
        
        NSArray *myarr=[self sortedBroadcastTime:eventsOnThisDay2];
        
        _serviceInfo = [[myarr mutableCopy]objectAtIndex:indexPath.row];
        
        
        //        if (_catId == _serviceInfo.cat_id) {
        //            return;
        //        }
        BOOL isplay = NO;
        if (_catId == _serviceInfo.cat_id) {
            isplay = YES;
        }
        
        
        
        CategoryDetailView * cDetail = [CategoryDetailView initViewCategoryDetailView:_serviceInfo isNowPlay:isplay Delegate:self];
        
        
        [[KGModal sharedInstance]showWithContentView:cDetail andAnimated:YES];
        
        
        
        
        //         UIAlertView * al =  [[UIAlertView alloc]initWithTitle:alertTitle message:[NSString stringWithFormat:@"Please notify me 5 mins before '%@' plays.",_serviceInfo.category_name] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        //        al.tag = 5000;
        //        [al show];
        
        return;
    }else if (tableView.tag == 1000) {
        return;
    }
    
    if (_cartArray.count <= 0) {
        return;
    }
    CartItem * ci = [_cartArray objectAtIndex:indexPath.row];
    ProductDetailView * view = [ProductDetailView initViewCartItem:ci Delegate:self];
    [[KGModal sharedInstance]showWithContentView:view andAnimated:YES];;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [[ActivityIndicator currentIndicator]displayCompleted];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompletedWithError:error.localizedDescription];
}

- (void)yesCategoryClicked{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm a"];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm a"];
    
    NSDate *fireDate = [dateFormatter dateFromString:_serviceInfo.broadcast_dateTime];
    [self fireSet:fireDate Message:_serviceInfo.category_name];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tblArticleView) {
        ArticleTableViewCell  *cell = (ArticleTableViewCell *)[_tblArticleView dequeueReusableCellWithIdentifier:@"cell11"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil];;
            cell = [topLevelObjects objectAtIndex:0];
        }
        ArticleInfo * a = [articleArray objectAtIndex:indexPath.row];
        if (a.productsImages.count > 0) {
            cell.imgView.url = [NSURL URLWithString:a.productsImages[0]];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy, h:mm a"];
        NSDate * date =[dateFormatter dateFromString:a.productDatess];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyyMMdd"];
        
        NSString *serverDate = [dateFormatter1 stringFromDate:date];
        NSString *currentDate= [dateFormatter1 stringFromDate:[NSDate date]];
        int apiDate = [serverDate intValue] + 5;
        int currentD = [currentDate intValue];
        
        cell.imgNew.hidden = YES;
        if (apiDate >= currentD) {
            cell.imgNew.hidden = NO;
        }
        
        cell.lblTitle.text = a.productTitle;
        cell.lblDate.text = a.productDatess;
        cell.lblSource.text = a.productSource;
        
        return cell;
    }else if (tableView.tag == 1000) {
        ChatTableViewCell  *cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            NSArray *topLevelObjects;
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell_iPad" owner:self options:nil];
            }
            else{
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
            }
            
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        ChatImageTableViewCell  *cellImage = (ChatImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cellImage == nil) {
            NSArray *topLevelObjects1 = [[NSBundle mainBundle] loadNibNamed:@"ChatImageTableViewCell" owner:self options:nil];
            cellImage = [topLevelObjects1 objectAtIndex:0];
        }
        
        ChatInfo * feed_data=[_chatArray objectAtIndex:indexPath.row];
        
        
        NSString * messageWithName = [NSString stringWithFormat:@"%@ : %@",feed_data.user_name,feed_data.message];
        
        NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:messageWithName];
        
        //NSLog(@"user type %@  \n\n\n\n\n",feed_data.user_type);
        
        if([feed_data.user_type  isEqual:@"provider"])
        {
            // [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,feed_data.user_name.length)];
            
            //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:44 green:104 blue:19 alpha:0.0] range:NSMakeRange(0,feed_data.user_name.length)];
            
            
            NSString *stringColor = @"#2C6813";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,feed_data.user_name.length)];
            
            
            
        }
        else if([feed_data.user_type  isEqual:@"admin"])
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,feed_data.user_name.length)];
        }
        else
        {
            Account *account=[AccountManager Instance].activeAccount;
            if([feed_data.user_type  isEqual:@"user"] && feed_data.user_id==account.userId)
            {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,feed_data.user_name.length)];
                
            }
            else
            {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,feed_data.user_name.length)];
            }
        }
        
        [cell SetCellData:feed_data targetedView:self Atrow:indexPath.row];
        
        // cell.lblMessage.attributedText = attributedString;
        if(feed_data.img.length > 0){
            
            cellImage.imgView.url = [NSURL URLWithString:feed_data.img];
            cellImage.lblMessage.attributedText = attributedString;
            return cellImage;
            
        }
        return cell;
    }else if (tableView.tag == 2000)
    {
        //NSLog(@"CELLFOR ROW AT INDEX 1");
        
        
        
        CategoryTableViewCell  *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            // NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
            
            NSArray *topLevelObjects;
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell_iPad" owner:self options:nil];
            }
            else{
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
            }
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        //NSLog(@"CELLFOR ROW AT INDEX 2");
        
        NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:indexPath.section];
        NSArray *eventsOnThisDay2 = [sections objectForKey:dateRepresentingThisDay];
        
        //NSLog(@"event on this day count %lu",(unsigned long)eventsOnThisDay2.count);
        
        //NSLog(@"CELLFOR ROW AT INDEX 3");
        
        NSArray *myarr=[self sortedBroadcastTime:eventsOnThisDay2];
        
        //NSLog(@"myarray count %lu",(unsigned long)myarr.count);
        
        ServiceInfo * info;
        if (myarr.count <= 0) {
            return cell;
        }
        info = [[myarr mutableCopy]objectAtIndex:indexPath.row];
        
        cell.lblPlaying.text = @"";
        
        //NSLog(@"_catid %d",_catId);
        if (info.cat_id == _catId)
        {
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                cell.lblName.frame=CGRectMake(10, 9,400, 21);
                cell.lblPlaying.text = @"Now Playing";
            }
            else{
                cell.lblName.frame=CGRectMake(10, 9,128, 21);
                cell.lblPlaying.text = @"Now Playing";
            }
        }
        else{
            
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell.lblName.frame=CGRectMake(10, 9,565, 21);
            }
            else
            {
                cell.lblName.frame=CGRectMake(10, 9, 204, 21);
            }
            
        }
        
        cell.lblName.text = info.category_name;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        int hoursToAdd = 0;
        
        
        NSString * timeZone = [Uitility getStringValueForKey:kTimeZoneSelected];
        //http://stackoverflow.com/questions/8871727/gmt-timezone-conversion-in-objective-c
        if ([timeZone isEqual:@"EPT"]) {
            //[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EPT"]];
            //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EPT"]];
            //+3:00
            hoursToAdd = 3;
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
        }else if ([timeZone isEqual:@"CST"]){
            // [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
            //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Chicago"]];
            hoursToAdd = 2;
            //-2 :00
        }else{
            //[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
            //  [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
            hoursToAdd = 0;
            
            //+2 :00
        }
        
        [formatter setDateFormat:@"hh:mm a"];
        
        NSDate * dddd = [formatter dateFromString:info.broadcast_time];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setHour:hoursToAdd];
        NSDate *newDate= [calendar dateByAddingComponents:components toDate:dddd options:0];
        
        [formatter setDateFormat:@"hh:mm a"];
        
        NSString * sssss = [formatter stringFromDate:newDate];
        
        
        // NSString *CurrentDateString = [formatter stringFromDate:[NSDate date]];
        
        cell.lblTime.text =[sssss  stringByAppendingString:[NSString stringWithFormat:@"(%@)",timeZone]];
        cell.lblTime.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTimeZoneTap)];
        [cell.lblTime addGestureRecognizer:tapGesture];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    if (_cartArray.count <= 0) {
        //
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"Support Great Music";
        return cell;
    }
    
    CartTableViewCell *cell = [_tblChatView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell_iPad" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil];
        }
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (CartTableViewCell *) currentObject;
                break;
            }
        }
    }
    
    CartItem * ci = [_cartArray objectAtIndex:indexPath.row];
    [cell setCartItem:ci Delegate:self];
    return cell;
}
-(void)categoryTimeZoneTap{
    TimeZonePickerView * view = [TimeZonePickerView initView];
    [[KGModal sharedInstance]showWithContentView:view];
}
-(void)backSearchbarClicked:(id)sender
{
    [_searchBar resignFirstResponder];
    [_articleSearch resignFirstResponder];
    [_searchBarOnDemand resignFirstResponder];
    
    _articleSearch.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    _searchBar.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    _searchBarOnDemand.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    
    
    [_backSearchbar setHidden:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_iconBtn setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    _backSearchbar=[UIButton buttonWithType:UIButtonTypeCustom];
    [ _backSearchbar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ _backSearchbar setImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    [_backSearchbar addTarget:self action:@selector(backSearchbarClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (searchBar == _articleSearch) {
        [_backSearchbar setFrame:CGRectMake(170, 2, 15, 44)];
        [_articleSearch addSubview: _backSearchbar];
    }else if(searchBar == _searchBarOnDemand) {
        [_backSearchbar setFrame:CGRectMake(170, 0, 40, 44)];
        [_searchBarOnDemand addSubview: _backSearchbar];
    }else{
        [_backSearchbar setFrame:CGRectMake(170, 2, 15, 44)];
        [_searchBar addSubview: _backSearchbar];
    }
    
    _articleSearch.backgroundImage = [UIImage imageNamed:@"barIcon.png"];
    _searchBar.backgroundImage = [UIImage imageNamed:@"barIcon.png"];
    _searchBarOnDemand.backgroundImage = [UIImage imageNamed:@"barIcon.png"];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setChatViewAreaLongIPad];
    }
    else
    {
        [self setChatViewAreaLong];
    }
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [_iconBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    [_backSearchbar setHidden:YES];
    _articleSearch.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    _searchBar.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    _searchBarOnDemand.backgroundImage = [UIImage imageNamed:@"barIconWhite.png"];
    
    //  [self setChatViewAreaShort];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setChatViewAreaShortIPad];
    }
    else{
        [self setChatViewAreaShort];
    }
    
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchBar == _articleSearch) {
        if (searchText.length > 0) {
            //            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productTitle CONTAINS[cd] %@ OR product_tags CONTAINS[cd] %@", searchText, searchText];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productTitle CONTAINS[cd] %@", searchText];
            
            articleArray= [[NSMutableArray alloc]init];
            articleArray = [NSMutableArray arrayWithArray:[[[ServiceList Instance]getAllArticle] filteredArrayUsingPredicate:predicate]];
            
            if (_searchResults.count<= 0) {
                _lblNoItem.hidden = NO;
            }
            
            // _searchResults = [NSMutableArray arrayWithArray:[_categoryInfo.productArray filteredArrayUsingPredicate:predicate]];
            
        }else{
            articleArray = [[NSMutableArray alloc]init];
            // _searchResults = _categoryInfo.productArray;
            articleArray = [[ServiceList Instance]getAllArticle];
            [_tblArticleView reloadData];
            
        }
        
        return;
    }else if (searchBar == _searchBarOnDemand){
        if (searchText.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
            
            onDemandArray= [[NSMutableArray alloc]init];
            onDemandArray = [NSMutableArray arrayWithArray:[[[ServiceList Instance]getDemandVideo] filteredArrayUsingPredicate:predicate]];
            [_OnDemandCollectionView reloadData];
        }else{
            
            
            onDemandArray= [[NSMutableArray alloc]init];
            onDemandArray = [[ServiceList Instance]getDemandVideo];
            [_OnDemandCollectionView reloadData];
        }
        return;
    }
    
    /* if([searchText length] == 0) {
     [searchBar performSelector: @selector(resignFirstResponder)
     withObject: nil
     afterDelay: 0.1];
     }*/
    
    
    /***my code***********/
    
    
    
    
    if([searchText length] == 0) {
        [searchBar performSelector: @selector(becomeFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
        
        
    }
    
    ////////////////
    
    if (searchText.length > 0) {
        // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product_title contains[cd]%@",searchText];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product_title CONTAINS[cd] %@ OR product_tags CONTAINS[cd] %@", searchText, searchText];
        
        _searchResults = [[NSMutableArray alloc]init];
        _searchResults = [NSMutableArray arrayWithArray:[[[Store Instance]getAllProduct] filteredArrayUsingPredicate:predicate]];
        
        [self filterStore];
        
        if (_searchResults.count<= 0) {
            _lblNoItem.hidden = NO;
        }
        
        // _searchResults = [NSMutableArray arrayWithArray:[_categoryInfo.productArray filteredArrayUsingPredicate:predicate]];
    
    }else{
        _searchResults = [[NSMutableArray alloc]init];
        // _searchResults = _categoryInfo.productArray;
        _searchResults = [[Store Instance]getAllProduct];
        
        if (_searchResults.count > 0 ) {
            _lblNoItem.hidden = YES;
        }
    }
    [_storeCollectionView reloadData];
}

#pragma mark - ModelListLoadedDelegate
-(void)DataAddedSuccessfully:(NSString *)message{
    [[ActivityIndicator currentIndicator]displayCompleted];
    if (message.length > 0) {
        
        
        if ([message isEqual:FINAL_ORDER]) {
            [Cart clearInstance];
            [self cartTotalXX];
            message = @"Your Order Successful.";
            _cartArray = [[NSMutableArray alloc]init];
            [_tblCartView reloadData];
        }else if ([message isEqual:@"Your Order Successful."]) {
            [Cart clearInstance];
            [self cartTotalXX];
            _cartArray = [[NSMutableArray alloc]init];
            [_tblCartView reloadData];
        }
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [ChatList Instance].chatArray = [[NSMutableArray alloc]init];
        [[ChatList Instance]loadAllMessage:self];
    }
}

-(void)DataAddFailedWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL ) stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}
-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    
    _categoryArray = [[NSMutableArray alloc]init];
    _categoryArray = [[Store Instance]getCategoryArray];
    
    if ([tag isEqual:kArticle]) {
        articleArray = [ServiceList Instance].articleArray;
        [self articleClicked:nil];
        [_tblArticleView reloadData];
        [_tblArticleView setContentSize:CGSizeMake(0, _tblArticleView.contentSize.height)];
    }else if ([tag isEqual:ADD_FEV] || [tag isEqual:FEV_DELETE]) {
        [[ServiceList Instance]ALLFavouriteVideo:self];
    }else if ([tag isEqual:CLIENT_TOKEN])
    {
        
        
    }
    else if ([tag isEqual:GET_FAV]) {
        // [[ActivityIndicator currentIndicator]displayCompleted];
        _FavVideo=[[NSMutableArray alloc]init];
        _FavVideo=[[ServiceList Instance]getAllFavouriteVideos];
        
        //        for (FavouriteInfo *fi in _FavVideo) {
        //            if (fi.video_id ==_videoObj.video_id) {
        //                _videoObj.is_fav = YES;
        //                [_btnFav setImage:[UIImage imageNamed:@"favourite_hover.png"] forState:UIControlStateNormal];
        //                break;
        //            }
        //            else{
        //                _videoObj.is_fav = NO;
        //                [_btnFav setImage:[UIImage imageNamed:@"favourite.png"] forState:UIControlStateNormal];
        //            }
        //        }
        
        
        
        
    }
    else if ([tag isEqual:SERVICE])
    {
        _serviceArray = [[NSMutableArray alloc]init];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
        [formatter setDateFormat:@"MM-dd-yyyy hh:mm a"];
        NSString *CurrentDateString = [formatter stringFromDate:[NSDate date]];
        NSString * str = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        
        sections = [NSMutableDictionary dictionary];
        if ([ServiceList Instance].videoArray.count > 0)
        {
            for (ServiceInfo *order in [ServiceList Instance].videoArray)
            {
                
                NSDate * infoDate = [Uitility getDateString:order.broadcast_dateTime];
                
                NSDate * sysDate = [Uitility getDateString:CurrentDateString];
                
                
                //  NSString *langID = [[NSLocale preferredLanguages] objectAtIndex:0];
                // NSString *lang = [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:langID];
                
                
                if([order.category_name  isEqual: @"Quick test"]){
                    
                }
                
                if ([sysDate compare:infoDate] == NSOrderedAscending || [sysDate compare:infoDate] == NSOrderedSame)
                {
                    
                    NSDate * Date = [Uitility getDateMMDDyyyyString:order.broadcast_date];
                    NSDate *dateRepresentingThisDay = [self dateAtBeginningOfDayForDate:Date];
                    
                    _serviceArray = [sections objectForKey:dateRepresentingThisDay];
                    
                    if (_serviceArray == nil)
                    {
                        _serviceArray = [NSMutableArray array];
                        
                        [sections setObject:_serviceArray forKey:dateRepresentingThisDay];
                        
                    }
                    
                    //NSLog(@"date1 is later than date2 or Equal");
                    [_serviceArray addObject:order];
                } else
                {
                    if (order.cat_id == _catId)
                    {
                        //NSLog(@"cat id current category %d",_catId);
                        //NSLog(@"cat id %d",order.cat_id);
                        
                        NSDate * Date = [Uitility getDateMMDDyyyyString:order.broadcast_date];
                        NSDate *dateRepresentingThisDay = [self dateAtBeginningOfDayForDate:Date];
                        
                        _serviceArray = [sections objectForKey:dateRepresentingThisDay];
                        
                        if (_serviceArray == nil){
                            _serviceArray = [NSMutableArray array];
                            [sections setObject:_serviceArray forKey:dateRepresentingThisDay];
                            
                        }
                        [_serviceArray addObject:order];
                    }
                    //NSLog(@"date1 is earlier than date2");
                }
            }
            
            sectionedListContent = _serviceArray;
            
            NSArray *unsortedDays = [sections allKeys];
            sortedDays = [unsortedDays sortedArrayUsingSelector:@selector(compare:)];
            
            
            
            
            
            [_LineUpView reloadData];
            
            //            if(sections.count > 0)
            //            {
            //                [_LineUpView reloadData];
            //            }
        }
    }
    else if ([tag isEqual:PRODUCT])
    {
        _searchResults = [[NSMutableArray alloc]init];
        _searchResults = [[Store Instance]getAllProduct];
        [self.storeCollectionView reloadData];
    }else if ([tag isEqual:DemandVideo])
    {
        onDemandArray = [[NSMutableArray alloc]init];
        onDemandArray = [[ServiceList Instance]getDemandVideo];
        
        if (onDemandArray.count <= 0) {
            _OnDemandCollectionView.hidden = YES;
        }else{
            _OnDemandCollectionView.hidden = NO;
        }
        [_OnDemandCollectionView reloadData];
    }
    else if([tag  isEqual: GET_ALL_MESSAGES])
    {
        _chatArray = [[NSMutableArray alloc]init];
        _chatArray = [[ChatList Instance]getAllMessage];
        if (_chatArray.count > 0)
        {
            [_tblChatView reloadData];
            NSIndexPath* ip = [NSIndexPath indexPathForRow:_chatArray.count-1 inSection:0];
            [_tblChatView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else if([tag  isEqual: TIMER]){
        [[ActivityIndicator currentIndicator]displayCompleted];
        _videosArray =[[NSMutableArray alloc]init];
        
        float  duraiton = 0;
        ServiceInfo * info = [[ServiceList Instance]getCurrentObject];
        
        [_timer2 invalidate];
        _timer2=nil;
        if (info == nil) {
            
            _timer2 =  [NSTimer scheduledTimerWithTimeInterval:3.0
                                                        target:self
                                                      selector:@selector(backToforeground)
                                                      userInfo:nil
                                                       repeats:YES];
            return;
        }
        
        
        if (info) {
            if (info.videoArray.count <= 0) {
                return;
            }
            _videosArray = info.videoArray;
            
            ////NSLog(@"info produxt array %d",info.productArray.count>0);
            
            
            
            
            if(info.productArray.count>0)
            {
                _profileProductArr = [[NSMutableArray alloc]init];
                _profileProductArr =  info.productArray;
                [self.profileProductCollectionView reloadData];
            }
            
            
            if (_categoryInfo) {
                [self.storeCollectionView reloadData];
                
            }
            
            duraiton =[self timeFromString:info.playtime];
            
            float _total_duration = [self timeFromString:info.total_duration];
            
            
            if (duraiton < _total_duration) {
                
                float temp_duration = 0;
                int temp_index = -1;
                
                float start_at = 0;
                
                Video * vinfo;
                do {
                    temp_index++;
                    
                    vinfo = [_videosArray objectAtIndex:temp_index];
                    
                    start_at = duraiton - temp_duration;
                    temp_duration = temp_duration + [self timeFromString:vinfo.duration];
                    
                } while ([self timeFromString:vinfo.duration] < start_at);
                _current_index = temp_index;
                
                if (start_at < 0)
                {
                    start_at = start_at  * -1;
                }
                _lblTitle.text = [NSString stringWithFormat:@"%@",vinfo.title];
                _lblProvider.text = [NSString stringWithFormat:@"%@",vinfo.provider];
                _txtDescription.text = vinfo.description;
                
                _infoImage.url=[NSURL URLWithString:vinfo.video_img];
                _catId = info.cat_id;
                // Narendra
                [[ServiceList Instance]loadAllVideoDelegate:self];
                // Narendra
                [self.LineUpView reloadData];
                NSLog(@"start_at:%.2f",start_at);
                [self videoPlay:_current_index seekPlayTime:start_at];
            }
        }
        if(sections.count > 0)
        {
            [_LineUpView reloadData];
        }
    }
    else if ([tag isEqual:DEVICEID]){
        NSLog(@"My service");
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.totalCountLbl.hidden = NO;
        self.totalCountLbl.text = [NSString stringWithFormat:@"%@",appDelegate.totalCount];
    }
    
}

- (void) updateVideoInfo:(Video *)info{
    _lblTitle.text = [NSString stringWithFormat:@"%@",info.title];
    _lblProvider.text = [NSString stringWithFormat:@"%@",info.provider];;
    _txtDescription.text = info.description;
    
}
- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}
- (float)timeFromString:(NSString *)str
{
    NSScanner *scn = [NSScanner scannerWithString:str];
    
    int h, m, s;
    [scn scanInt:&h];
    [scn scanString:@":" intoString:NULL];
    [scn scanInt:&m];
    [scn scanString:@":" intoString:NULL];
    [scn scanInt:&s];
    
    return h * 3600 + m * 60 + s;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 5000){
        if (buttonIndex == 0) {
        }
    }else{
        if (buttonIndex == 0) {
            [self loginClicked:nil];
        }
    }
    
}

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:inputDate];
    
    
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


/****************** MY CODE **********************************/

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // [self.myVideoPlayer pauseVideo];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         containerView.hidden=YES;
         UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
         // do whatever
         
         _value=[NSNumber numberWithInt:orientation];
         
         if(_value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] || _value == [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight]){
              _playerDemand.controlStyle = MPMovieControlStyleDefault;
             [self.navigationController setNavigationBarHidden:YES animated:NO];
             
             if (_player==nil)
             {
                 self.playerView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
             }
             
             _player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
             
             [_player setFullscreen:NO animated:YES];
             
             
             if ([_btnOndemand.titleLabel.text isEqual:@"Back"]) {
                 if (_playerDemand==nil)
                 {
                     self.playerView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                 }
                 
                 _playerDemand.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                 
                 [_playerDemand setFullscreen:NO animated:YES];
             }
             
             //             [self articleClose:nil];
             //NSLog(@"landscape");
         }
         else
         {
              _playerDemand.controlStyle = MPMovieControlStyleDefault;
             if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 [_iconBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
                 
                 [self setChatViewAreaShortIPad];
             }
             else
             {
                 [_iconBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
                 [self setChatViewAreaShort];
             }
             
             if ([_btnArticle.imageView.image isEqual:[UIImage imageNamed:@"cart-hover.png"]]  ||
                 [_btnShow.imageView.image isEqual:[UIImage imageNamed:@"showinfo-hover.png"]] ||
                 [_btnStore.imageView.image isEqual:[UIImage imageNamed:@"store-hover.png"]] ||
                 [_btnLineup.imageView.image isEqual:[UIImage imageNamed:@"lineup-hover.png"]])
             {
                 containerView.hidden=YES;
             }
             else if( [_btnChat.imageView.image isEqual:[UIImage imageNamed:@"livechat-hover.png"]]){
                 containerView.hidden=NO;
             }
             
             //NSLog(@"portrait");
             
             if (_player==nil) {
                 if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                 {
                     self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 400);
                 }
                 else
                 {
                     self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 197);
                 }
                 
             }
             
             
             if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 400);
             }
             else{
                 self.playerView.frame=CGRectMake(0, 0,self.playerView.frame.size.width, 197);
             }
             [self.navigationController setNavigationBarHidden:NO animated:NO];
             [_player setFullscreen:NO animated:NO];
             _player.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
             
             if ([_btnOndemand.titleLabel.text isEqual:@"Back"]) {
                 if (_playerDemand==nil) {
                     if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                     {
                         self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 400);
                     }
                     else
                     {
                         self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 197);
                     }
                     
                 }
                 
                 
                 if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                 {
                     self.playerView.frame=CGRectMake(0, 0, self.playerView.frame.size.width, 400);
                 }
                 else{
                     self.playerView.frame=CGRectMake(0, 0,self.playerView.frame.size.width, 197);
                 }
                 [self.navigationController setNavigationBarHidden:NO animated:NO];
                 [_playerDemand setFullscreen:NO animated:NO];
                 _playerDemand.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
             }
             
         }
     }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
}

- (IBAction)chatbackbutton:(id)sender {
    [_txtMessage resignFirstResponder];
}

/*  edit  this method
 
 viewwillappear, viewdidload,add new method viewWillTransitionToSize,moviePlayerPlaybackStateChanged,videoplay
 */

-(void)checkBoxClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    CategoryTableViewCell *cell=(CategoryTableViewCell*)[[sender superview] superview];
    //  NSIndexPath *path =[NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    NSIndexPath *path =[self.LineUpView indexPathForCell:cell];
    _selectedIndex = btn.tag;
    
    if (path.row == _selectedIndex)
    {
        if([cell.btncheckbox.currentImage isEqual:[UIImage imageNamed:@"CheckboxOn.png"]] &&  cnt>0)
        {
            [cell.btncheckbox setImage:[UIImage imageNamed:@"CheckboxOff.png"] forState:UIControlStateNormal];
            _selectedcellindex=-1;
            _Selectedcellsection=-1;
            cnt=0;
        }
        else if(cnt==0)
        {
            [cell.btncheckbox setImage:[UIImage imageNamed:@"CheckboxOn.png"] forState:UIControlStateNormal];
            _selectedcellindex=btn.tag;
            _Selectedcellsection=path.section;
            
            
            // Mare kaik karvu padse
            
            // Asia/Kolkata
            
            NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:_Selectedcellsection];
            NSArray *eventsOnThisDay2 = [sections objectForKey:dateRepresentingThisDay];
            
            
            
            ServiceInfo * info;
            info = [[eventsOnThisDay2 mutableCopy]objectAtIndex:_selectedcellindex];
            
            
            
            [self fireSet:info.dateTime Message:info.category_name];
            cnt++;
            
        }
    }
}

- (IBAction)AddStickerClicked:(id)sender {
    
}

#pragma mark - iPad Code

- (void)setChatViewAreaShortIPad{
    
    self.playerView.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,400);
    
    self.btnLANDSCAPE.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,400);
    
    self.player.view.frame = self.playerView.frame;
    
    _iconBtn.frame =CGRectMake(_iconBtn.frame.origin.x, self.playerView.frame.size.height, _iconBtn.frame.size.width,_iconBtn.frame.size.height);
    
    self.tblChatView.frame =CGRectMake(self.tblChatView.frame.origin.x,self.playerView.frame.size.height + self.iconBtn.frame.size.height, self.tblChatView.frame.size.width,463);
    
    self.showInfoView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width+39);
    
    self.LineUpView.frame = CGRectMake(self.tblChatView.frame.origin.x,self.playerView.frame.size.height + self.iconBtn.frame.size.height, self.tblChatView.frame.size.width,517);
    
    //  self.storeCollectionView.frame = self.tblChatView.frame;
    
    self.cartView.frame = self.showInfoView.frame;
    
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, _iconBtn.frame.origin.y + _iconBtn.frame.size.height, _searchBar.frame.size.width, _searchBar.frame.size.height);
    self.storeCollectionView.frame = CGRectMake(self.playerView.frame.origin.x,_searchBar.frame.origin.y + _searchBar.frame.size.height, self.tblChatView.frame.size.width,self.tblChatView.frame.size.height-13);
    
    self.lblNoItem.frame =CGRectMake(self.lblNoItem.frame.origin.x,self.storeCollectionView.frame.origin.y+5, self.lblNoItem.frame.size.width,self.lblNoItem.frame.size.height);
}

-(void)setChatViewAreaLongIPad{
    
    self.playerView.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,307.0);
    
    self.btnLANDSCAPE.frame =CGRectMake(self.playerView.frame.origin.x,0, self.playerView.frame.size.width,307.0);
    
    self.player.view.frame = self.playerView.frame;
    
    _iconBtn.frame =CGRectMake(_iconBtn.frame.origin.x, self.playerView.frame.size.height, _iconBtn.frame.size.width,_iconBtn.frame.size.height);
    
    _tblChatView.frame =CGRectMake(_tblChatView.frame.origin.x,_iconBtn.frame.size.height + self.playerView.frame.size.height, _tblChatView.frame.size.width,552.0);
    
    self.showInfoView.frame = CGRectMake(self.tblChatView.frame.origin.x, self.tblChatView.frame.origin.y, self.tblChatView.frame.size.width,self.tblChatView.frame.size.width + 38);
    
    self.LineUpView.frame = CGRectMake(_tblChatView.frame.origin.x,_iconBtn.frame.size.height + self.playerView.frame.size.height, _tblChatView.frame.size.width,552.0+45);
    
    // self.storeCollectionView.frame = self.tblChatView.frame;
    
    self.cartView.frame = self.showInfoView.frame;
    
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, _iconBtn.frame.origin.y + _iconBtn.frame.size.height, _searchBar.frame.size.width, _searchBar.frame.size.height);
    
    
    self.storeCollectionView.frame = CGRectMake(self.playerView.frame.origin.x,_searchBar.frame.origin.y + _searchBar.frame.size.height, self.tblChatView.frame.size.width,self.tblChatView.frame.size.height-10);
    self.lblNoItem.frame =CGRectMake(self.lblNoItem.frame.origin.x,self.storeCollectionView.frame.origin.y+5, self.lblNoItem.frame.size.width,self.lblNoItem.frame.size.height);
    
}

-(void)fireSet:(NSDate*)dateStr Message:(NSString *)categoryName{
    
    NSDate *dateToSet = [NSDate dateWithTimeInterval:-60*5 sinceDate:dateStr];
    // NSString *message = [NSString stringWithFormat:@"Hey Currenty playing is %@.",categoryName];
    NSString *message = [NSString stringWithFormat:@"Your Reminder that '%@' will play in 5 mins on UND TV.",categoryName];
    
    UILocalNotification *warningNotification = [[UILocalNotification alloc] init];
    warningNotification.fireDate = dateToSet;
    warningNotification.timeZone = [NSTimeZone systemTimeZone];
    warningNotification.alertBody = message;
    warningNotification.hasAction = NO;
    warningNotification.userInfo = nil;
    warningNotification.repeatInterval = 0;
    warningNotification.applicationIconBadgeNumber = 1;;
    warningNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:warningNotification];
    
}

- (IBAction)BtnClearChatTextClicked:(id)sender {
    _txtMessage.text=@"";
}



#pragma multiline chat

-(void)chatdisplay{
    
    //    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 87, 320, 40)];
    //
    //    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 40)];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, self.view.frame.size.width-80, 40)];
    }
    else
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 40)];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, self.view.frame.size.width-80, 40)];
    }
    containerView.clipsToBounds = YES;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 4;
    textView.returnKeyType = UIReturnKeyDefault; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor clearColor];
    
    // textView.text = @"test\n\ntest";
    // textView.animateHeightChange = NO; //turns off animation
    
    
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"barIcon.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    
    entryImageView.frame = CGRectMake(6, 0, self.view.frame.size.width-80, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIImage *rawBackground = [UIImage imageNamed:@"barIcon.png"];
    
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(6, 0, self.view.frame.size.width-80, 40);
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:entryImageView];
    [containerView addSubview:textView];
    
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-105, 5, 30, 30)];
    [btn addTarget:self action:@selector(keyBoardHide) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"down-black.png"] forState:UIControlStateNormal];
    [containerView addSubview:btn];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"SEND" forState:UIControlStateNormal];
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(messageSent:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)keyBoardHide{
    [self.view endEditing:YES];
}


-(void) keyboardWillShow:(NSNotification *)note{
    
    btn.hidden = NO;
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setChatViewAreaLongIPad];
    }
    else
    {
        [self setChatViewAreaLong];
    }
    
    
    [_iconBtn setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height) ;
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    btn.hidden = YES;
    [_iconBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setChatViewAreaShortIPad];
    }
    else
    {
        [self setChatViewAreaShort];
    }
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height-40;
    }
    else{
        containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height-40;
    }
    
    
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containerView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    return YES;
}

-(NSMutableArray*)sortedBroadcastTime:(NSArray*)sortedtime
{
    //NSLog(@"SORTED TIME");
    
    NSMutableArray *times = [sortedtime mutableCopy];
    
    NSMutableArray *dates=[NSMutableArray new];
    
    NSDateFormatter *dateFormatter=[NSDateFormatter new];
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    for (ServiceInfo *info in times) {
//        if (info.broadcast_time.length == 7) {
//            info.broadcast_time = [NSString stringWithFormat:@"0%@",info.broadcast_time];
//        }
        NSDate *date=[dateFormatter dateFromString:info.broadcast_time];
        if (date== nil) {
            date = [NSDate date];
        }
        [dates addObject:date];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject: descriptor];
    NSArray *reverseOrder = [dates sortedArrayUsingDescriptors:descriptors];
    
    [times removeAllObjects];
    for (NSDate *date in reverseOrder) {
        NSString *string=[dateFormatter stringFromDate:date];
        NSMutableArray *myarray=[sortedtime mutableCopy];
        for (ServiceInfo *info in myarray) {
            if ([info.broadcast_time isEqual:string]) {
                [times addObject:info];
            }
        }
    }
    
    return times;
}



-(void)nextcategoryplay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *CurrentDateString = [formatter stringFromDate:[NSDate date]];
    
    //NSLog(@"NEXT TIME PST %@",CurrentDateString);
    
    if (sections.count>0)
    {
        NSDate *dateRepresentingThisDay = [sortedDays objectAtIndex:0];
        NSArray *eventsOnThisDay2 = [sections objectForKey:dateRepresentingThisDay];
        
        //NSLog(@"event on this day count %lu",(unsigned long)eventsOnThisDay2.count);
        
        NSArray *myarr=[self sortedBroadcastTime:eventsOnThisDay2];
        
        ServiceInfo *info;
        info=[[myarr mutableCopy]objectAtIndex:0];
        //NSLog(@"myarrrrrrrrrrrr");
        if (_player==nil)
        {
            if([info.broadcast_time isEqual:CurrentDateString])
            {
                [[ServiceList Instance]loadAllVideoDelegate:self];
                [[ServiceList Instance]loadMtimerDelegate:self];
                
            }
        }
    }
}

#pragma mark -AttributeDelegate
-(void)attributeSelected:(CartItem *)pa{
    
    if (pa.productAtt.productValue.count <= 0) {
        [[Cart Instance]addCartItemInList:pa];
        _cartArray = [[NSMutableArray alloc]init];
        _cartArray = [Cart Instance].productsInCart;
        [_tblCartView reloadData];
        [self cartTotalXX];
        [[KGModal sharedInstance]hideAnimated:YES];
        return;
    }
    ProductValueView * vv = [ProductValueView initViewProductAttributeInfo:pa Delegate:self];
    [[KGModal sharedInstance]showWithContentView:vv];
}

-(void)valueSelected:(CartItem *)pv{
    [[KGModal sharedInstance]hideAnimated:YES];
    [[Cart Instance]addCartItemInList:pv];
    _cartArray = [[NSMutableArray alloc]init];
    _cartArray = [Cart Instance].productsInCart;
    [_tblCartView reloadData];
    [self cartTotalXX];
}

- (void)showEmailView{
    
    if ([AccountManager Instance].activeAccount == nil) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isShowGetEmailFirstTime"] == false) {
            [UIView animateWithDuration:0.60 animations:^{
                [_viewEmail setHidden:NO];
            }];
        }
    }
}
    
- (void)startTimerForDashboard{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isShowGetEmailFirstTime"] == false) {
        [NSTimer scheduledTimerWithTimeInterval:360 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowEmail" object:nil];
        }];
    }
}

- (IBAction)actionCountryClicked:(id)sender{
    [self filterStore];
}

- (IBAction)actionGenreClicked:(id)sender{
    [self filterStore];
}

- (void)filterStore{
    
    for (ProductInfo *store in _searchResults) {
        NSLog(@"%@",store);
    }
    
}

- (void)hideEmailView{
    [_viewEmail setHidden:YES];
}
    
@end
