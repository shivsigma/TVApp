//
//  BraintreeCreditView.m
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/15/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "BraintreeCreditView.h"

@implementation BraintreeCreditView

+ (id)initViewOrder:(Order *)order Delegate:(id<BrainTreeDel>)del{
    BraintreeCreditView* categoryView;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"BraintreeCreditView" owner:nil options:nil] objectAtIndex:0];
    }
    else
    {
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"BraintreeCreditView" owner:nil options:nil] objectAtIndex:0];
    }
    
    categoryView.orderInfo = order;
    categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, categoryView.frame.size.height);
    categoryView.delegate =del;
    [categoryView viewData];
    return categoryView;
}

- (void)viewData{
    arSelectedRows = [[NSMutableArray alloc]init];
   // shipmentView.hidden = YES;
    
    //lblAddressType.text = @"BILLING ADDRESS";
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,646.0);
    
    lblProductAmount.text = [Uitility getCurrencyStringFromAmount:[Cart Instance].cartTotal+ 0.00];
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[BrainTreeInstance Instance]GETAllCardsDetails:self];
    
}

- (void)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    
   // shipmentView.hidden = YES;
    
    if (selectedSegment == 0) {
        
        lblAddressType.text = @"BILLING ADDRESS";
        
       
        
    }
    else{
        lblAddressType.text = @"SHIPMENT ADDRESS";
       // shipmentView.hidden = NO;
        
        
        //toggle the correct view to be visible
    }
}

- (IBAction) Addressflip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on) {
        txtShipPostalCode.text = txtPostalCode.text;
        txtShipStreetAddress.text = txtStreetAddress.text;;
        txtShipCity.text = txtCity.text;;
        txtShipState.text = txtState.text;;
    }else{
        txtShipPostalCode.text = @"";
        txtShipStreetAddress.text = @"";
        txtShipCity.text = @"";
        txtShipState.text = @"";
    }
    
    
    //NSLog(@"%@", onoff.on ? @"On" : @"Off");
}
- (void)payClicked:(id)sender{
    
    if ([AccountManager Instance].activeAccount == nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Login to Support Great Music" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([Cart Instance].productsInCart.count <= 0) {
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:alertTitle message:@"Support Great Music: Add an Item" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString * message =@"";
    
    if (selected.token.length <= 0 ) {
        message =@"Please select your Credit Card.";
    }else if (txtStreetAddress.text.length <= 0)
    {
        message =@"Please enter the Billing Address.";
    }else if (txtCity.text.length <= 0)
    {
        message =@"Please enter the Billing City.";
    }
    else if (txtState.text.length <= 0)
    {
        message =@"Please enter the Billing State.";
    }else if (txtPostalCode.text.length <= 0)
    {
        message =@"Please enter the Billing Zip Code.";
    }else if (txtShipStreetAddress.text.length <= 0)
    {
        message =@"Please enter the Shipment Address.";
    }else if (txtShipCity.text.length <= 0)
    {
        message =@"Please enter the Shipment City.";
    }
    else if (txtShipState.text.length <= 0)
    {
        message =@"Please enter the Shipment State.";
    }else if (txtShipPostalCode.text.length <= 0)
    {
        message =@"Please enter the Shipment Zip Code.";
    }

    
    if (message.length>0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    

    _orderInfo.billing_add = txtStreetAddress.text;
    _orderInfo.city = txtCity.text;
    _orderInfo.state = txtState.text;
    _orderInfo.postal_code = txtPostalCode.text;
    
    
    _orderInfo.ShipingBilling_add = txtShipStreetAddress.text;
    _orderInfo.ShipingCity = txtShipCity.text;
    _orderInfo.ShipingState = txtShipState.text;
    _orderInfo.ShipingPostal_code = txtShipPostalCode.text;
    
    _orderInfo.token = selected.token;
    [_delegate BrainTreeorderData:_orderInfo];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    //Do anything you want for cell here
    if([arSelectedRows containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    GetCardsInfo * feed_data=[_cardListArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = feed_data.exp_date;
    NSString *lastFourChar = [feed_data.card substringFromIndex:[feed_data.card length] - 4];
    cell.textLabel.text= [NSString stringWithFormat:@"**** **** **** %@",lastFourChar];
    
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tblCreditCard deselectRowAtIndexPath:indexPath animated:YES];
    arSelectedRows = [[NSMutableArray alloc]init];
    [tableView reloadData];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arSelectedRows addObject:indexPath];
    }

    selected=[_cardListArr objectAtIndex:indexPath.row];
    
    txtStreetAddress.text = selected.add;
    txtCity.text = selected.city;
    txtState.text = selected.state;
    txtPostalCode.text = selected.zip;
    
//    for (int i=0; i<[self.cardListArr count]; i++) {
//            // whenever we reach the cell we have selected, let's change its accessoryType and its colour
//            if (i == indexPath.row)
//            {
//                // that's the row we have selected, let's update its
//                UITableViewCell *cell = [self.tblCreditCard cellForRowAtIndexPath:indexPath];
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                cell.textLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//            }
//            // if it isn't the cell we have selected, let's change it back to boring dark colour and no accessoryType
//            else {
//                UITableViewCell *cell = [self.tblCreditCard cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//                cell.accessoryType = UITableViewCellAccessoryNone;
//                cell.textLabel.textColor = [UIColor darkTextColor];
//            }
//        }
//
//    
    
    
}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    [[ActivityIndicator currentIndicator]displayCompleted];
    if ([tag isEqual:GET_CARDS]) {
        _cardListArr=[[NSMutableArray alloc]init];
        _cardListArr=[[BrainTreeInstance Instance]getCardArr];
        [self.tblCreditCard reloadData];
    }
    
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
