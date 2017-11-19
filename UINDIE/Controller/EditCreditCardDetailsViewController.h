//
//  EditCreditCardDetailsViewController.h
//  UINDIE
//
//  Created by Savan Shah on 10/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceList.h"
#import "ActivityIndicator.h"
@interface EditCreditCardDetailsViewController : UIViewController<ModelListLoadedDelegate>
{
    IBOutlet UITextField *_txtCard;
    IBOutlet UITextField *_txtMonth;
    IBOutlet UITextField *_txtYear;
    IBOutlet UITextField *_txtCVV;
}
- (IBAction)btnSaveCreditCardDetails:(id)sender;
- (IBAction)closeClicked:(id)sender;

+(EditCreditCardDetailsViewController *)initViewController;

@end
