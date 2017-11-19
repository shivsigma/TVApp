//
//  ChangePasswordViewController.h
//  UINDIE
//
//  Created by Savan Shah on 10/1/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountManager.h"
#import "ActivityIndicator.h"
@interface ChangePasswordViewController : UIViewController<AccountAuthenticateDelegate>

{
    IBOutlet UITextField *_txtOldPassword;
    IBOutlet UITextField *_txtNewPassword;
    IBOutlet UITextField *_txtConfirmPassword;
}



+ (ChangePasswordViewController *)initViewController;
- (IBAction)btnSavePassword:(id)sender;
- (IBAction)closeClicked:(id)sender;

@end
