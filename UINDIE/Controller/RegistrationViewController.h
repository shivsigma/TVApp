//
//  RegistrationViewController.h
//  UINDIE
//
//  Created by apple on 5/11/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonActionSheet_iPad.h"
#import "Account.h"
#import "URLImageView.h"
#import "ActivityIndicator.h"
#define DOB 1000
#define GENDER 2000

@interface RegistrationViewController : UIViewController<iPadCommonActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,AccountAuthenticateDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    IBOutlet UITextField * txtFirstname;
    IBOutlet UITextField * txtLastname;
    IBOutlet UITextField * txtGender;
    IBOutlet UITextField * txtDateOfBirth;
    IBOutlet UITextField * txtUsername;
    IBOutlet UITextField * txtEmail;
     IBOutlet UITextField * txtState;
     IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtPassword;
    IBOutlet UITextField * txtConfirmPassword;
    NSMutableArray * genderArray;
    IBOutlet UIScrollView * scrollView;
  //  IBOutlet URLImageView * profilePic;
   
}

+ (RegistrationViewController *)initViewController;

@property(nonatomic,retain)IBOutlet URLImageView *profilePicture;
//----- ravinder ----//
@property(nonatomic, retain) id fbUserInfo;
//------------------//
- (IBAction)genderClicked:(id)sender;

- (IBAction)DateOfBirthClicked:(id)sender;

- (IBAction)submitClicked:(id)sender;
- (IBAction)backClicked:(id)sender;

- (IBAction)profilePicClicked:(id)sender;

@end
