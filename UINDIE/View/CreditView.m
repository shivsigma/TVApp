//
//  CreditView.m
//  UINDIE
//
//  Created by apple on 9/3/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CreditView.h"
#import "CardInfo.h"
@implementation CreditView


+ (id)initViewOrder:(Order *)order Delegate:(id<PAYDelegate>)del{
    CreditView* categoryView;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"CreditView" owner:nil options:nil] objectAtIndex:0];
    }
    else
    {
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"CreditView" owner:nil options:nil] objectAtIndex:0];
    }

    categoryView.orderInfo = order;
    categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, categoryView.frame.size.height);
    categoryView.delegate =del;
    [categoryView viewData];
    return categoryView;
}

- (void)viewData{
    
    cardAddress =@"";
    cardCityAddress =@"";
    cardState = @"";
    cardZipCode =@"";
    
    
    ShipmentAddress =@"";
    ShipmentCityAddress =@"";
    ShipmentState =@"";
    ShipmentZipCode =@"";
    
    
    lblAddressType.text = @"Card Address";
     scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,503.0);

    lblProductAmount.text = [Uitility getCurrencyStringFromAmount:[Cart Instance].cartTotal+ 0.00];
    
    txtCardNum.text = [NSString stringWithFormat:@"CardNumber : %@",_orderInfo.HideNumber];
    
    NSString * yy = _orderInfo.year;
    NSString *code = [yy substringFromIndex: [yy length] - 2];
    
    txtMMdd.text = [NSString stringWithFormat:@"Exp : %@/%@",_orderInfo.month,code];
    txtcvv.text = [NSString stringWithFormat:@"CVV : %@",_orderInfo.cvv];

}

- (void)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        lblAddressType.text = @"Card Address";
        
        ShipmentAddress = txtStreetAddress.text;
        ShipmentCityAddress = txtCity.text;
        ShipmentState = txtState.text;
        ShipmentZipCode = txtPostalCode.text;
        
        txtStreetAddress.text = cardAddress;
        txtCity.text = cardCityAddress;
        txtState.text = cardState;
        txtPostalCode.text = cardZipCode;
        
    }
    else{
        lblAddressType.text = @"Shipment Address";
        
        cardAddress = txtStreetAddress.text;
        cardCityAddress = txtCity.text;
        cardState = txtState.text;
        cardZipCode = txtPostalCode.text;
        
        
        txtStreetAddress.text = ShipmentAddress;
        txtCity.text = ShipmentCityAddress;
        txtState.text = ShipmentState;
        txtPostalCode.text = ShipmentZipCode;
        
        //toggle the correct view to be visible
    }
}

- (void)payClicked:(id)sender{
    NSString * message =@"";
    if (cardAddress.length <= 0)
    {
        message =@"Please enter Card Street address";
    }else if (cardCityAddress.length <= 0)
    {
        message =@"Please enter Card city";
    }
    else if (cardState.length <= 0)
    {
        message =@"Please enter Card state";
    }else if (cardZipCode.length <= 0)
    {
        message =@"Please enter Card postal code";
    }else if (cardAddress.length <= 0)
    {
        message =@"Please enter Shipment Street address";
    }else if (ShipmentAddress.length <= 0)
    {
        message =@"Please enter Shipment city";
    }
    else if (ShipmentState.length <= 0)
    {
        message =@"Please enter Shipment state";
    }else if (ShipmentZipCode.length <= 0)
    {
        message =@"Please enter Shipment postal code";
    }
    
    if (message.length>0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSInteger selectedSegment = segmentControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        cardAddress =txtStreetAddress.text;
        cardCityAddress =txtCity.text;
        cardState = txtState.text;
        cardZipCode =txtPostalCode.text;
    }else{
        ShipmentAddress =txtStreetAddress.text;
        ShipmentCityAddress =txtCity.text;
        ShipmentState =txtState.text;
        ShipmentZipCode =txtPostalCode.text;
    }
    
    _orderInfo.billing_add = cardAddress;
    _orderInfo.city = cardCityAddress;
    _orderInfo.state = cardState;
    _orderInfo.postal_code = cardZipCode;
    
    
    _orderInfo.ShipingBilling_add = ShipmentAddress;
    _orderInfo.ShipingCity = ShipmentCityAddress;
    _orderInfo.ShipingState = ShipmentState;
    _orderInfo.ShipingPostal_code = ShipmentZipCode;
    [_delegate orderData:_orderInfo];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
