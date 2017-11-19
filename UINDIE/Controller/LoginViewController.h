//
//  LoginViewController.h
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "ActivityIndicator.h"
#import "RegistrationViewController.h"


@interface LoginViewController : UIViewController<AccountAuthenticateDelegate,UITextFieldDelegate,ModelListLoadedDelegate>{
    NSString * _userName;
    IBOutlet UITextField * _txtUsername;
    IBOutlet UITextField * _txtPassword;
}
@property (nonatomic ,retain) NSString * userName;
@property (nonatomic ,retain) UITextField * txtUsername;
@property (nonatomic ,retain) UITextField * txtPassword;

+ (LoginViewController *)initViewControlller:(NSString *)username;

- (IBAction)forgotPassword:(id)sender;

- (IBAction)facebookClicked:(id)sender;

- (IBAction)googlePlusClicked:(id)sender;

- (IBAction)loginClicked:(id)sender;

- (IBAction)signUpClicked:(id)sender;

- (IBAction)closeClicked:(id)sender;




@end
