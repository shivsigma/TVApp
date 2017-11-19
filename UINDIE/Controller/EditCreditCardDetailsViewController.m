//
//  EditCreditCardDetailsViewController.m
//  UINDIE
//
//  Created by Savan Shah on 10/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "EditCreditCardDetailsViewController.h"

@interface EditCreditCardDetailsViewController ()

@end

@implementation EditCreditCardDetailsViewController


+(EditCreditCardDetailsViewController *)initViewController{
    EditCreditCardDetailsViewController * controller;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        controller= [[EditCreditCardDetailsViewController alloc]initWithNibName:@"EditCreditCardDetailsViewController_iPad" bundle:nil];
    }
    else
    {
        controller= [[EditCreditCardDetailsViewController alloc]initWithNibName:@"EditCreditCardDetailsViewController" bundle:nil];
    }
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden= YES;
    // Do any additional setup after loading the view from its nib.
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


- (IBAction)btnSaveCreditCardDetails:(id)sender {
    
    
    NSString * message = @"";
    if (_txtCard.text.length <= 0) {
        message =@"Please enter card Number";
    }
    else if (_txtMonth.text.length <= 0) {
        message =@"Please enter Month";
    }
    else if (_txtYear.text.length <= 0) {
        message =@"Please enter year";
    }
    else if (_txtCVV.text.length<=0) {
        message =@"Please enter CVV number";
    }
    
    if (message.length > 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
   // [[ServiceList Instance]EditCreditCardInfo:_txtCard.text month:_txtMonth.text year:_txtYear.text cvv:_txtCVV.text Delegate:self];
}

- (IBAction)closeClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    if ([tag isEqual:EDIT_CREDITCARD])
    {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"Card saved successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}


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
