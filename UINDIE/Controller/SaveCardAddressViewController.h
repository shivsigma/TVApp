//
//  SaveCardAddressViewController.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/28/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInfo.h"
#import "CardIO.h"
#import "ActivityIndicator.h"
#import "ServiceInfo.h"
#import "ServiceList.h"
#import "ModelListLoadedDelegate.h"

@interface SaveCardAddressViewController : UIViewController<CardIOPaymentViewControllerDelegate,ModelListLoadedDelegate>{
    IBOutlet UILabel * lblCardNo;
    IBOutlet UILabel * lblMmyy;
    IBOutlet UILabel * lblCvv;
    
    IBOutlet UITextField * txtAddress;
    IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtState;
    IBOutlet UITextField * txtZipcode;
   
}


+ (SaveCardAddressViewController *)initViewController;
@property (nonatomic ,retain) CardInfo * info;

- (IBAction)saveClicked:(id)sender;
- (IBAction)scanClicked:(id)sender;

@end
