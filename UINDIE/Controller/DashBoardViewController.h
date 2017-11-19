//
//  DashBoardViewController.h
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelListLoadedDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Video.h"
#import "ServiceInfo.h"
#import "ServiceList.h"
#import "ActivityIndicator.h"
#import "ChatList.h"
#import "ChatInfo.h"
#import "CategoryInfo.h"
#import "ChatTableViewCell.h"
#import "ChatImageTableViewCell.h"
#import "CartTableViewCell.h"
#import "CollectionViewCell.h"
#import "ProductDetailView.h"
#import "KGModal.h"
#import "CreditView.h"
#import "Cart.h"
#import "CartItem.h"
#import "Store.h"
#import "CategoryTableViewCell.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "Uitility.h"
#import "VideoLandscapeViewController.h"
#import "Order.h"
#import "CardInfo.h"
#import "BrainTreeInstance.h"

#import <PassKit/PassKit.h>
#import <PassKit/PKPaymentRequest.h>
#import <PassKit/PKPaymentToken.h>
#import <PassKit/PKPayment.h>
#import <PassKit/PKPaymentAuthorizationViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABRecord.h>
#import <MessageUI/MessageUI.h>
#import "CardListViewController.h"
#import "HPGrowingTextView.h"
#import "BraintreeCreditView.h"
#import "OneTimeViewController.h"
#import "CategoryDetailView.h"
#import "CardIO.h"
#import "UserInfoView.h"
#import "TimeZonePickerView.h"
#import "ProductAttributeView.h"
#import "ProductValueView.h"
#import "AttributeDelegate.h"
#import "ArticleTableViewCell.h"
#import "ArticleView.h"
#import "OnDemandCollectionViewCell.h"
#import "ListViewCallBackDelegate.h"
#import "NewProductDetailView.h"
#import "NewProductCalanderView.h"
@interface DashBoardViewController : UIViewController<ModelListLoadedDelegate,UniversalDelegate,UITableViewDelegate,UITableViewDataSource,CellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,
UIAlertViewDelegate,ProductDelegate,UISearchBarDelegate,PAYDelegate,UITextFieldDelegate,PKPaymentAuthorizationViewControllerDelegate,HPGrowingTextViewDelegate,CardIOPaymentViewControllerDelegate,BrainTreeDel,PAYDelegate,CategoryDetailDelegate,AttributeDelegate,UIWebViewDelegate,ListViewCallBackDelegate,NewProductDelegate>{
    BOOL playbackDurationSet;
    int playtimeXX;
    NSMutableDictionary * sections;
    NSArray * sectionedListContent;
    NSArray * sortedDays;
    NSDateFormatter * sectionDateFormatter;
    NSDateFormatter * sectionDateFormatterMonDay;
    float messageWidth;
    int cnt;
    
    NSInteger _selectedIndex;
    NSInteger _selectedcellindex;
    NSInteger _Selectedcellsection;
    
    
    UIView *containerView;
    HPGrowingTextView *textView;
    UIButton * btn;

    NSMutableArray * list_url;
    UIBarButtonItem * audioControlBarItem;
    UIBarButtonItem *refresh;
    NSMutableArray * articleArray;
    NSMutableArray * onDemandArray;
    Video * demandVideo;
    
}


@property (weak, nonatomic) IBOutlet UILabel *totalCountLbl;

@property (nonatomic ,retain) IBOutlet UIButton * btnCart;
@property (nonatomic ,retain) IBOutlet UIButton * btnStore;
@property (nonatomic ,retain) IBOutlet UIButton * btnChat;
@property (nonatomic ,retain) IBOutlet UIButton * btnShow;
@property (nonatomic ,retain) IBOutlet UIButton * btnLineup;

@property (nonatomic ,retain) IBOutlet URLImageView * infoImage;

@property (nonatomic ,retain) IBOutlet UIView * playerView;
@property (nonatomic ,retain) IBOutlet UIView * OnDemandView;
@property (nonatomic ,retain) IBOutlet UICollectionView * OnDemandCollectionView;

@property (nonatomic ,retain) IBOutlet UISearchBar * searchBar;
@property (nonatomic ,retain) IBOutlet UISearchBar * searchBarOnDemand;
@property (nonatomic ,assign) BOOL islongChatArea;

@property (nonatomic ,retain) IBOutlet UIButton * iconBtn;

@property (nonatomic ,retain) IBOutlet UILabel * lblNoItem;
@property (nonatomic ,retain) IBOutlet UILabel * lblNoItemInfo;

@property (nonatomic ,retain) MPMoviePlayerController * player;
@property (nonatomic ,retain) MPMoviePlayerController * playerDemand;

@property (nonatomic ,retain) NSMutableArray * videosArray;

@property (nonatomic ,assign) int current_index;

@property (nonatomic ,assign) float totalDuration;

@property (nonatomic ,retain) NSTimer * timer;

@property (nonatomic ,retain) IBOutlet UITextField * txtMessage;

@property (nonatomic ,retain) NSMutableArray * chatArray;

@property (nonatomic ,retain) NSMutableArray * cartArray;

@property (nonatomic ,retain) NSMutableArray * categoryArray;

@property (nonatomic ,retain) NSMutableArray * serviceArray;

@property (nonatomic ,retain) NSMutableArray * searchResults;

@property (nonatomic ,retain) IBOutlet UITableView * tblChatView;

@property (nonatomic ,retain) IBOutlet UITableView * tblCartView;


@property (nonatomic ,retain) IBOutlet UITableView * tblArticleView;

@property (nonatomic ,retain) IBOutlet UIView * cartView;

@property (nonatomic ,retain) IBOutlet UIView * showInfoView;

@property (nonatomic ,retain) IBOutlet UITableView * LineUpView;

@property (nonatomic ,retain) IBOutlet UICollectionView * storeCollectionView;

@property (nonatomic ,retain) IBOutlet UICollectionView * profileProductCollectionView;

@property (nonatomic ,retain) NSMutableArray * profileProductArr;

@property (nonatomic ,retain) CategoryInfo * categoryInfo;

@property (nonatomic ,retain) ServiceInfo * serviceInfo;

@property (nonatomic ,assign) int catId;

@property (nonatomic ,retain) Video * videoObj;

@property (nonatomic ,retain) IBOutlet UIButton * login;

@property (nonatomic ,retain) IBOutlet UILabel * lblProvider;
@property (nonatomic ,retain) IBOutlet UITextView * lblTitle;

@property (nonatomic ,retain) IBOutlet UILabel * lblTime;

@property (nonatomic ,retain) IBOutlet UITextView * txtDescription;


@property (nonatomic ,retain) IBOutlet UILabel * lblItem;
@property (nonatomic ,retain) IBOutlet UILabel * lblShipping;
@property (nonatomic ,retain) IBOutlet UILabel * lblTax;
@property (nonatomic ,retain) IBOutlet UILabel * lblTotal;
@property (nonatomic ,retain) IBOutlet UIButton * btnFav;
@property (nonatomic ,retain) IBOutlet UIButton * btnArticle;
@property (nonatomic ,retain) IBOutlet UIButton * btnArticlexxxxx;

@property (nonatomic ,retain) IBOutlet UIButton * btnOndemand;
@property (nonatomic ,retain) IBOutlet UIButton * btnCloseArticle;
@property (nonatomic ,retain) IBOutlet UIButton * btnLANDSCAPE;
@property (weak, nonatomic) IBOutlet UIImageView *countIcon;
@property (nonatomic ,retain) IBOutlet UIButton * btnShare;
@property (nonatomic ,retain) IBOutlet UIView * viewShow;
@property (nonatomic ,retain) IBOutlet UIWebView * webview;
@property (nonatomic ,retain) IBOutlet UISearchBar * articleSearch;
@property (nonatomic ,retain) IBOutlet UIButton * btnGoCart;
@property (nonatomic ,retain) IBOutlet UILabel * lblCount;

@property (weak, nonatomic) IBOutlet UIView *viewEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnGenre;

- (void)categoryTable;
- (IBAction)liveClicked:(id)sender;
- (IBAction)OnDemandClicked:(id)sender;
- (IBAction)articleClicked:(id)sender;
- (IBAction)articleClose:(id)sender;
- (IBAction)landscapeClicked:(id)sender;
- (IBAction)sliderClicked:(id)sender;
- (IBAction)closeArticle:(id)sender;
- (IBAction)messageSent:(id)sender;
- (IBAction)shareActionClicked:(id)sender;
- (IBAction)showInfoClicked:(id)sender;
- (IBAction)addFavClicked:(id)sender;
- (IBAction)liveChatClicked:(id)sender;
- (IBAction)cartClicked:(id)sender;
- (IBAction)storeClicked:(id)sender;
- (IBAction)lineUpClicked:(id)sender;
- (IBAction)addPhotoClicked:(id)sender;
- (IBAction)applePayClicked:(id)sender;
- (IBAction)BrainTreeClicked:(id)sender;
- (IBAction)OneTimeClicked:(id)sender;
- (float)timeFromString:(NSString *)str;
- (void) cartTotal;
- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate;

- (void)backToforeground;
- (void)setChatViewAreaShort;

- (void)setChatViewAreaLong;

@property(nonatomic,retain)NSNumber *value;
- (IBAction)chatbackbutton:(id)sender;

 @property (strong,nonatomic) NSMutableArray *lasttime;
 @property (strong,nonatomic) NSArray *reverseOrder;

- (IBAction)tappedApplePay:(id)sender;
- (IBAction)AddStickerClicked:(id)sender;

@property (nonatomic ,retain) IBOutlet UIButton *backSearchbar;
@property (nonatomic ,retain) IBOutlet UIButton *backSearchbarArticle;

-(void)fireSet:(NSDate*)dateStr Message:(NSString *)categoryName;

@property (weak, nonatomic) IBOutlet UIButton *BtnBraintree;
@property (weak, nonatomic) IBOutlet UIButton *BtnApplepay;
- (IBAction)BtnClearChatTextClicked:(id)sender;


@property (nonatomic ,retain) NSMutableArray * FavVideo;

@property (nonatomic ,retain) NSTimer * timer2;

-(void)categoryTimeZoneTap;


@end
