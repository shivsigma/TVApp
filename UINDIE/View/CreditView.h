//
//  CreditView.h
//  UINDIE
//
//  Created by apple on 9/3/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Uitility.h"
#import "Order.h"


@protocol PAYDelegate <NSObject>

- (void) orderData:(Order *)order;

@end
@interface CreditView : UIView<UITextFieldDelegate>{
    id<PAYDelegate>_delegate;
    IBOutlet UILabel * lblProductAmount;
    IBOutlet UILabel * txtCardNum;
    IBOutlet UILabel * txtMMdd;
    IBOutlet UILabel * txtcvv;
    IBOutlet UILabel * lblAddressType;
    IBOutlet UITextField * txtPostalCode;
    IBOutlet UITextField * txtStreetAddress;
    IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtState;
    
    IBOutlet UIScrollView *scrollView;
    
    NSString * cardAddress;
    NSString * cardCityAddress;
    NSString * cardZipCode;
    NSString * cardState;
    
    NSString * ShipmentAddress;
    NSString * ShipmentCityAddress;
    NSString * ShipmentZipCode;
    NSString * ShipmentState;

    
    IBOutlet UISegmentedControl * segmentControl;
}

@property (nonatomic ,retain) id<PAYDelegate>delegate;
@property (nonatomic ,retain) Order * orderInfo;
+ (id) initViewOrder:(Order *)order Delegate:(id<PAYDelegate>)del;

- (IBAction)payClicked:(id)sender;
- (IBAction)segmentSwitch:(id)sender;
@end
