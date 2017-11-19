//
//  ProfileViewController.h
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "Account.h"
#import "AccountManager.h"
#import "ActivityIndicator.h"
#import "ChangePasswordViewController.h"
#import "LoginViewController.h"
#import "KGModal.h"
#import "EditCreditCardDetailsViewController.h"
#import "FevoriteTableViewCell.h"
#import "CardListViewController.h"

#import "ServiceList.h"
#import "FavoriteDetailView.h"
#import "SaveCardAddressViewController.h"
#import <MessageUI/MessageUI.h>

@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AccountAuthenticateDelegate,ModelListLoadedDelegate,FevoriteCellDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic ,retain) IBOutlet UILabel * lblUsername;
@property (nonatomic ,retain) IBOutlet UILabel * lblLocation;
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;
@property (nonatomic ,retain) IBOutlet UITableView * tblView;

- (IBAction)LogoutClick:(id)sender;

+ (ProfileViewController *)initViewController;

///// my code****

- (IBAction)btnUpdatePhoto:(id)sender ;
- (IBAction)btnSelectPhoto:(id)sender;

@property (nonatomic ,retain) UIImage *profileImage;
- (IBAction)ChangePasswordClicked:(id)sender;
- (IBAction)AccountDeactivateClick:(id)sender;
 @property (nonatomic ,retain) NSMutableArray * FavVideo;

- (IBAction)EditCreditCardClicked:(id)sender;
- (IBAction)CreditCardListClicked:(id)sender;

@end
