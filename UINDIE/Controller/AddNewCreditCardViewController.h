//
//  AddNewCreditCardViewController.h
//  UINDIE
//
//  Created by Savan Shah on 10/16/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIndicator.h"
#import "ServiceList.h"
@interface AddNewCreditCardViewController : UIViewController<ModelListLoadedDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *_txtCard;
    IBOutlet UITextField *_txtMonth;
    IBOutlet UITextField *_txtYear;
    IBOutlet UITextField *_txtCVV;
    IBOutlet UITextField *_txtStreetAddress;
    IBOutlet UITextField *_txtCity;
    IBOutlet UITextField *_txtState;
    IBOutlet UITextField *_txtZipCode;

    IBOutlet UIScrollView *scrollview;
}
- (IBAction)btnSaveCreditCardDetails:(id)sender;

+(AddNewCreditCardViewController *)initViewController;

@end
