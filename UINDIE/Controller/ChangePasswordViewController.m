//
//  ChangePasswordViewController.m
//  UINDIE
//
//  Created by Savan Shah on 10/1/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Account.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController


+(ChangePasswordViewController *)initViewController{
    ChangePasswordViewController * controller;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
         controller = [[ChangePasswordViewController alloc]initWithNibName:@"ChangePasswordViewController_iPad" bundle:nil];
    }
    else{
        controller = [[ChangePasswordViewController alloc]initWithNibName:@"ChangePasswordViewController" bundle:nil];
       
    }
    return controller;
}



- (IBAction)btnSavePassword:(id)sender {
    
     Account * account =[AccountManager Instance].activeAccount;
    //NSLog(@"new passwd %@",_txtNewPassword.text);
    //NSLog(@"new passwd %@",_txtConfirmPassword.text);
    
     NSString * message = @"";
    if (_txtOldPassword.text.length <= 0) {
        message =@"Please enter Old Password.";
    }
    else if (_txtNewPassword.text.length <= 0) {
        message =@"Please enter New password.";
    }
    else if (_txtConfirmPassword.text.length <= 0) {
        message =@"Please enter confirm password.";
    }
   else if (![_txtNewPassword.text isEqualToString: _txtConfirmPassword.text]) {
        message =@"Password & Confirm Password does not match.";
    }

    if (message.length > 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
   account.password=_txtNewPassword.text;
   [account ChangePasswordWithDelegate:_txtOldPassword.text delegate:self];
}

- (IBAction)closeClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBarHidden= YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)accountAuthenticatedWithAccount:(Account *)account{
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"Password changed successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)accountDidFailAuthentication:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:[error.userInfo objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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


#pragma Portrait mode

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
