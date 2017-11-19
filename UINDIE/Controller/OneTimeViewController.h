//
//  OneTimeViewController.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 12/1/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardInfo.h"
#import "CardIO.h"
#import "ActivityIndicator.h"
#import "ServiceInfo.h"
#import "ServiceList.h"
#import "ModelListLoadedDelegate.h"
#import "Order.h"
#import "Uitility.h"
@interface OneTimeViewController : UIViewController<CardIOPaymentViewControllerDelegate,ModelListLoadedDelegate,UniversalDelegate>{
    IBOutlet UILabel * lblCardNo;
    IBOutlet UILabel * lblMmyy;
    IBOutlet UILabel * lblCvv;
    
    IBOutlet UITextField * txtAddress;
    IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtState;
    IBOutlet UITextField * txtZipcode;
    IBOutlet UISegmentedControl * segmentControl;
    IBOutlet UILabel * lblProductAmount;
    IBOutlet UIView * shipmentView;
    IBOutlet UITextField * txtShipAddress;
    IBOutlet UITextField * txtShipCity;
    IBOutlet UITextField * txtShipState;
    IBOutlet UITextField * txtShipZipcode;
    IBOutlet UILabel * lblAddressType;
    
    NSString * cardNumber;
    NSString * MM;
    NSString * yy;
    NSString * cvv;
    BOOL isSaveAndPayment;
    IBOutlet UIScrollView * scrollView;
    
    
}

@property (nonatomic ,retain) Order * orderInfo;
- (IBAction)segmentSwitch:(id)sender;

+ (OneTimeViewController *)initViewController;

@property (nonatomic ,retain) CardInfo * info;

- (IBAction)saveClicked:(id)sender;
- (IBAction)scanClicked:(id)sender;

@end
