//
//  SaveCardAddressViewController.m
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/28/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "SaveCardAddressViewController.h"

@interface SaveCardAddressViewController ()

@end

@implementation SaveCardAddressViewController
@synthesize info=_info;

+ (SaveCardAddressViewController *)initViewController{
    SaveCardAddressViewController * controller ;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    controller = [[SaveCardAddressViewController alloc]initWithNibName:@"SaveCardAddressViewControllerIPad" bundle:nil];
    }else{
    controller = [[SaveCardAddressViewController alloc]initWithNibName:@"SaveCardAddressViewController" bundle:nil];
    }
    
    return controller;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
}

- (void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo120.png"]];
    [imagev setContentMode:UIViewContentModeScaleAspectFit];
    imagev.frame = CGRectMake(0, 0, 80, 49);
    self.navigationItem.titleView = imagev;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 13, 23);
    [backButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.backBarButtonItem = back;
    
    
    [CardIOUtilities preload];
    
    _info = [[CardInfo alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)scanClicked:(id)sender{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.hideCardIOLogo = YES;
    
    [self presentViewController:scanViewController animated:YES completion:nil];
}

-(void)ModelListLoadedSuccessfullyTag:(NSString*)tag{
    [[ActivityIndicator currentIndicator]displayCompleted];
    lblCardNo.text =@"XXXX XXXX XXXX XXXX";
    lblMmyy.text = @"00/00";
    lblCvv.text =@"000";
    
    txtAddress.text =@"";
    txtCity.text =@"";
    txtState.text =@"";
    txtZipcode.text =@"";
    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Card saved Sucessfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
}
-(void)ModelListLoadFailWithError:(NSString *)error{
[[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)saveClicked:(id)sender{
    NSString * message =@"";
    if (_info.cardNumber.length <= 0) {
        message = @"Please enter the Card Number.";
    }else if (_info.month.length <= 0){
        message = @"Please enter the Card Month.";
    }else if (_info.year.length <= 0){
        message = @"Please enter the Card Year.";
    }else if (_info.cvv.length <= 0){
        message = @"Please enter the Card CVV.";
    }else if (txtAddress.text.length <= 0){
        message = @"Please enter the Billing Address.";
    }else if (txtCity.text.length <= 0){
        message = @"Please enter the Billing City.";
    }else if (txtState.text.length <= 0){
        message = @"Please enter the Billing State.";
    }else if (txtZipcode.text.length <= 0){
        message = @"Please enter the Billing Zip Code.";
    }
    
    if (message.length > 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    _info.street_address = txtAddress.text;
    _info.city = txtCity.text;
    _info.state = txtState.text;
    _info.postalcode = txtZipcode.text;
    
    [[ActivityIndicator currentIndicator]displayActivity:@"Card Saving..."];
    [[ServiceList Instance]EditCreditCardInfo:_info Delegate:self];

    
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
    
    NSString * yy = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    NSString *code = [yy substringFromIndex: [yy length] - 2];
    
    NSString *lastFourChar = [info.redactedCardNumber substringFromIndex:[info.redactedCardNumber length] - 4];
    
    
    lblCardNo.text = [NSString stringWithFormat:@"XXXX XXXX XXXX %@",lastFourChar];
    lblMmyy.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)info.expiryMonth,code];
    lblCvv.text = [NSString stringWithFormat:@"%@",info.cvv];
    
    _info.cardNumber = info.cardNumber;
    _info.month = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    _info.year = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    
    _info.cvv = info.cvv;
   

    [scanViewController dismissViewControllerAnimated:YES completion:nil];
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

@end
