//
//  LoginViewController.m
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userName=_userName;
@synthesize txtPassword=_txtPassword;
@synthesize txtUsername=_txtUsername;

+ (LoginViewController *)initViewControlller:(NSString *)username{
    LoginViewController *controller = nil;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    controller =[[LoginViewController alloc]initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }else{
    controller =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    }
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden= YES;
   // _txtUsername.text = @"savan.php@gmail.com";
    //_txtPassword.text = @"456789";

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loggedInRedirected) name:@"kLoginRedirect" object:nil];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = back;
    
    // Do any additional setup after loading the view from its nib.
}


#pragma IBAction

-(void)forgotPassword:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:@"Please enter email"
                                                   delegate:self
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[ServiceList Instance]forgotPassowrdEmail:[alertView textFieldAtIndex:0].text delegate:self];
}
-(void)closeClicked:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginClicked:(id)sender{
   // NSMutableArray * tt = [[NSMutableArray alloc]init];
   // [tt objectAtIndex:12];

    NSString * message =@"";
    if (_txtUsername.text.length <= 0) {
        message =@"Please enter the Email.";
    }else if (_txtPassword.text.length <= 0) {
        message =@"Please enter the Password.";
    }
    
  /*  NSUserDefaults *Tokendefaults=[NSUserDefaults standardUserDefaults];
    NSString *deviceToken=[Tokendefaults objectForKey:@"deviceToken"];
    */
    
    Account * account = [[Account alloc]init];
    account.username = _txtUsername.text;
    account.password = _txtPassword.text;
    
    if (message.length>0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [account authenticatedWithUserName:_txtUsername.text andPassword:@"" withDelegate:self];
    //[account authenticatedWithUserName:@"" andPassword:@"" anddevicetoken:deviceToken anddeviceType:@"ios" withDelegate:self];
}

-(void)googlePlusClicked:(id)sender{
    
}
//----- ravinder -----//
- (IBAction)facebookClicked:(id)sender {
    
    FBSDKLoginManager *login= [[FBSDKLoginManager alloc] init];
    
    if (![UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
        login.loginBehavior = FBSDKLoginBehaviorWeb;
    }
    
    [login logInWithReadPermissions:@[@"email",@"user_birthday",@"user_location",@"user_hometown"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error=%@",error);
         }
         else if (result.isCancelled)
         {
             NSLog(@"Error=%@",error);
         }
         else
         {
             if ([result.grantedPermissions containsObject:@"email"])
             {
                 [self fetchUserInfo];
             }
             else
             {
                 NSLog(@"Error=%@",error);
             }
         }
     }];

}

-(void) fetchUserInfo{
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, first_name, last_name, name, email, gender, age_range, picture.type(large), cover, birthday, location, hometown, photos"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 //                 NSLog(@"First_Name = %@",result[@"first_name"]);
                 //                 NSLog(@"Last_Name = %@",result[@"last_name"]);
                 //                 NSLog(@"Full_Name = %@",result[@"name"]);
                 //                 NSLog(@"Email = %@",result[@"Email"]);
                 NSLog(@"Gender = %@",result[@"gender"]);
                 // NSLog(@"DOB = %@",result[@"birthday"]);
                 //                 NSLog(@"Profile_PicUrl = %@",result[@"picture"][@"data"][@"url"]);
                 //                 NSLog(@"ID = %@",result[@"id"]);
                 [[ActivityIndicator currentIndicator]displayCompleted];
                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 appDelegate.isLoginFromFB = YES;
                 [self signUpClicked:result];
                 
             }
             else
             {
                 NSLog(@"Error =%@",error);
             }
         }];
    }
    
    
}
//-------------//


-(void)signUpClicked:(id)sender{
    RegistrationViewController * controller =[RegistrationViewController initViewController];
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    navigationController.navigationBar.translucent  = NO;
    controller.fbUserInfo = sender;
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
- (void) loggedInRedirected{
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)accountAuthenticatedWithAccount:(Account*) account{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [AccountManager Instance].activeAccount = account;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
   // [account updateDeviceToken];
}

-(void)accountDidFailAuthentication:(NSError*) error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    NSString * alert_error = [error.userInfo objectForKey:@"message"];
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"The email and password you entered don't match." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    if ([tag isEqual:FORGOT])
    {
       
    }
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)forgotPasswordWithMessage:(NSString *)message{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///////////////////

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = NO;
    
    [self supportedInterfaceOrientations];
    
    [self shouldAutorotate:UIInterfaceOrientationPortrait];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
