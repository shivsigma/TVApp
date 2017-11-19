//
//  OneTimeViewController.m
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 12/1/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "OneTimeViewController.h"

@interface OneTimeViewController ()

@end

@implementation OneTimeViewController

@synthesize info=_info;

+ (OneTimeViewController *)initViewController{
    OneTimeViewController * controller;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    controller = [[OneTimeViewController alloc]initWithNibName:@"OneTimeViewControllerIPad" bundle:nil];
    }else{
    controller = [[OneTimeViewController alloc]initWithNibName:@"OneTimeViewController" bundle:nil];
    }

    //
    return controller;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    lblProductAmount.text = [Uitility getCurrencyStringFromAmount:[Cart Instance].cartTotal+ 0.00];
    
    //shipmentView.hidden = YES;
    txtAddress.hidden = NO;
    txtCity.hidden = NO;
    txtState.hidden = NO;
    txtZipcode.hidden = NO;
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
    
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 720.0);
    
    
    [CardIOUtilities preload];
    
    _info = [[CardInfo alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddressInfo"];
    if (data) {
        NSDictionary* json = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (json) {
            
            if ([json objectForKey:@"City"]) {
                txtCity.text = [json objectForKey:@"City"];
            }
            if ([json objectForKey:@"Address"]) {
                txtAddress.text = [json objectForKey:@"Address"];
            }
            if ([json objectForKey:@"State"]) {
                txtCity.text = [json objectForKey:@"City"];
            }
            if ([json objectForKey:@"ZipCode"]) {
                txtZipcode.text = [json objectForKey:@"ZipCode"];
            }
            if ([json objectForKey:@"ShipAddress"]) {
                txtShipAddress.text = [json objectForKey:@"ShipAddress"];
            }
            if ([json objectForKey:@"ShipCity"]) {
                txtShipCity.text = [json objectForKey:@"ShipCity"];
            }
            if ([json objectForKey:@"ShipState"]) {
                txtShipState.text = [json objectForKey:@"ShipState"];
            }
            if ([json objectForKey:@"ShipZipCode"]) {
                txtShipZipcode.text = [json objectForKey:@"ShipZipCode"];
            }
            if ([json objectForKey:@"CVV"]) {
                cvv = [json objectForKey:@"CVV"];
            }
            if ([json objectForKey:@"MM"]) {
                MM = [json objectForKey:@"MM"];
            }
            if ([json objectForKey:@"YY"]) {
                yy = [json objectForKey:@"YY"];
            }
            if ([json objectForKey:@"CardNumber"]) {
                cardNumber = [json objectForKey:@"CardNumber"];
            }
            
            if (cardNumber) {
                
                NSString *lastFourChar = [cardNumber substringFromIndex:[cardNumber length] - 4];
                
                lblCardNo.text = [NSString stringWithFormat:@"XXXX XXXX XXXX %@",lastFourChar];
                
                // lblCardNo.text = info.redactedCardNumber;
                lblMmyy.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)MM,cvv];
                lblCvv.text = [NSString stringWithFormat:@"%@",cvv];
                
            }
        }
    }
}

-(void)scanClicked:(id)sender{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.hideCardIOLogo = YES;
    
    [self presentViewController:scanViewController animated:YES completion:nil];
}

-(void)ModelListLoadedSuccessfullyTag:(NSString*)tag{
   }
-(void)ModelListLoadFailWithError:(NSString *)error{
    
    
}
- (void)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        lblAddressType.text = @"BILLING ADDRESS";
        
      //  shipmentView.hidden = YES;
        txtAddress.hidden = NO;
        txtCity.hidden = NO;
        txtState.hidden = NO;
        txtZipcode.hidden = NO;
        
        
    }
    else{
        lblAddressType.text = @"SHIPMENT ADDRESS";
       //  shipmentView.hidden = NO;
        txtAddress.hidden = YES;
        txtCity.hidden = YES;
        txtState.hidden = YES;
        txtZipcode.hidden = YES;
        
        
        //toggle the correct view to be visible
    }
}

-(void)saveClicked:(id)sender{
    _info.street_address = txtAddress.text;
    _info.city = txtCity.text;
    _info.state = txtState.text;
    _info.postalcode = txtZipcode.text;
    
//    if (isSaveAndPayment) {
//        [[ServiceList Instance]EditCreditCardInfo:_info Delegate:self];
//    }
    
    
    
    
    NSString * message =@"";
    if (_orderInfo.number.length <= 0  || _orderInfo.month.length <= 0  ||_orderInfo.year.length <= 0)
    {
        message =@"Please fill up credit card information";
    }
    if (txtAddress.text.length <= 0)
    {
        message =@"Please enter the Billing Address.";
    }else if (txtCity.text.length <= 0)
    {
        message =@"Please enter the Billing City.";
    }
    else if (txtState.text.length <= 0)
    {
        message =@"Please enter the Billing State.";
    }else if (txtZipcode.text.length <= 0)
    {
        message =@"Please enter the Billing Zip Code.";
    }else if (txtShipAddress.text.length <= 0)
    {
        message =@"Please enter the Shipment Address.";
    }else if (txtShipCity.text.length <= 0)
    {
        message =@"Please enter the Shipment City.";
    }
    else if (txtShipState.text.length <= 0)
    {
        message =@"Please enter the Shipment State.";
    }else if (txtShipZipcode.text.length <= 0)
    {
        message =@"Please enter the Shipment Zip Code.";
    }
    
    if (message.length>0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (isSaveAndPayment) {
        [[ServiceList Instance]EditCreditCardInfo:_info Delegate:self];
    }
   
    _orderInfo.billing_add = txtAddress.text;
    _orderInfo.city = txtCity.text;
    _orderInfo.state = txtState.text;
    _orderInfo.postal_code = txtZipcode.text;
    
    _orderInfo.amount =[Cart Instance].cartTotal+ 0.00;
    
   
    _orderInfo.quantity = [NSString stringWithFormat:@"%d",[Cart Instance].ci.qty];
    
    
    _orderInfo.ShipingBilling_add = txtShipAddress.text;
    _orderInfo.ShipingCity = txtShipCity.text;
    _orderInfo.ShipingState = txtShipState.text;
    _orderInfo.ShipingPostal_code = txtShipZipcode.text;
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [_orderInfo postOrderDelegate:self];
    
    
}

- (IBAction) Addressflip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on) {
        txtShipAddress.text =txtAddress.text;
        txtShipCity.text =txtCity.text;;
        txtShipState.text =txtState.text;;
        txtShipZipcode.text =txtZipcode.text;;
    }else{
        txtShipAddress.text =@"";
        txtShipCity.text =@"";
        txtShipState.text =@"";
        txtShipZipcode.text =@"";
    }
    
    
    //NSLog(@"%@", onoff.on ? @"On" : @"Off");
}

- (IBAction) flip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on) {
        isSaveAndPayment = YES;
    }else{
        isSaveAndPayment = NO;
    }
    
    
    //NSLog(@"%@", onoff.on ? @"On" : @"Off");
}
-(void)DataAddedSuccessfully:(NSString *)message{
    [[ActivityIndicator currentIndicator]displayCompleted];
    lblCardNo.text =@"XXXX XXXX XXXX XXXX";
    lblMmyy.text = @"00/00";
    lblCvv.text =@"000";
    
    txtAddress.text =@"";
    txtCity.text =@"";
    txtState.text =@"";
    txtZipcode.text =@"";
    
    txtShipAddress.text =@"";
    txtShipCity.text =@"";
    txtShipState.text =@"";
    txtShipZipcode.text =@"";
    
    if (isSaveAndPayment) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Payment & Save card Sucessfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
 
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Payment Sucessfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        

    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)DataAddFailedWithError:(NSString *)error{
[[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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
    
    
    
    cardNumber = info.cardNumber;
    yy = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    MM = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    cvv = info.cvv;
    
    
    NSString *code = [yy substringFromIndex: [yy length] - 2];
    
    NSString *lastFourChar = [info.redactedCardNumber substringFromIndex:[info.redactedCardNumber length] - 4];
    
    
    lblCardNo.text = [NSString stringWithFormat:@"XXXX XXXX XXXX %@",lastFourChar];
    
   // lblCardNo.text = info.redactedCardNumber;
    lblMmyy.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)info.expiryMonth,code];
    lblCvv.text = [NSString stringWithFormat:@"%@",info.cvv];
    
    _info.cardNumber = info.cardNumber;
    _info.month = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    _info.year = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    
    _info.cvv = info.cvv;
    _orderInfo = [[Order alloc]init];
    _orderInfo.number = info.cardNumber;
    _orderInfo.month =[NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    _orderInfo.year =[NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    _orderInfo.cvv = info.cvv;
    
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionContinueShopping:(id)sender{
    
    NSMutableDictionary *dictInfo = [NSMutableDictionary new];
    [dictInfo setObject:cardNumber forKey:@"CardNumber"];
    [dictInfo setObject:yy forKey:@"YY"];
    [dictInfo setObject:MM forKey:@"MM"];
    [dictInfo setObject:cvv forKey:@"CVV"];
    [dictInfo setObject:txtCity.text forKey:@"City"];
    [dictInfo setObject:txtAddress.text forKey:@"Address"];
    [dictInfo setObject:txtState.text forKey:@"State"];
    [dictInfo setObject:txtZipcode.text forKey:@"ZipCode"];
    [dictInfo setObject:txtShipAddress.text forKey:@"ShipAddress"];
    [dictInfo setObject:txtShipCity.text forKey:@"ShipCity"];
    [dictInfo setObject:txtShipState.text forKey:@"ShipState"];
    [dictInfo setObject:txtShipZipcode.text forKey:@"ShipZipCode"];
    
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:dictInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"AddressInfo"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
