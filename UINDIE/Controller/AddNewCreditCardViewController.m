//
//  AddNewCreditCardViewController.m
//  UINDIE
//
//  Created by Savan Shah on 10/16/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "AddNewCreditCardViewController.h"

@interface AddNewCreditCardViewController ()

@end

@implementation AddNewCreditCardViewController

+(AddNewCreditCardViewController *)initViewController
{
    AddNewCreditCardViewController * controller;
     if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
     controller= [[AddNewCreditCardViewController alloc]initWithNibName:@"AddNewCreditCardViewControllerIPad" bundle:nil];
     }
     else
     {
    controller= [[AddNewCreditCardViewController alloc]initWithNibName:@"AddNewCreditCardViewController" bundle:nil];
     }
    return controller;
}



- (IBAction)btnSaveCreditCardDetails:(id)sender {
    
    
    NSString * message = @"";
    if (_txtCard.text.length <= 0) {
        message =@"Please enter the Card Number.";
    }
    else if (_txtMonth.text.length <= 0) {
        message =@"Please enter the Month.";
    }
    else if (_txtYear.text.length <= 0) {
        message =@"Please enter the Year.";
    }
    else if (_txtCVV.text.length<=0) {
        message =@"Please enter the CVV Number.";
    }
    
    if (_txtStreetAddress.text.length <= 0) {
        message =@"Please enter the Street Address.";
    }
    else if (_txtCity.text.length <= 0) {
        message =@"Please enter the City.";
    }
    else if (_txtState.text.length <= 0) {
        message =@"Please enter the State.";
    }
    else if (_txtZipCode.text.length<=0) {
        message =@"Please enter the Zip Code.";
    }
    
    
    
    if (message.length > 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
//    [[ServiceList Instance]EditCreditCardInfo:_txtCard.text month:_txtMonth.text year:_txtYear.text cvv:_txtCVV.text Address:_txtStreetAddress.text City:_txtCity.text state:_txtState.text zipcode:_txtZipCode.text Delegate:self];
}

- (IBAction)closeClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    if ([tag isEqual:EDIT_CREDITCARD])
    {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"credit card added successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 17, 17);
    [backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;
    // Do any additional setup after loading the view from its nib.
    
     scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,770.0);
}

-(void)backClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
