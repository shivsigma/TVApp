//
//  BraintreeCreditView.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/15/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BrainTreeInstance.h"
#import "ActivityIndicator.h"
#import "Uitility.h"

@protocol BrainTreeDel <NSObject>

- (void) BrainTreeorderData:(Order *)order;

@end

@interface BraintreeCreditView : UIView<UITableViewDataSource,UITableViewDelegate,ModelListLoadedDelegate>{
    id<BrainTreeDel>_delegate;
    IBOutlet UILabel * lblProductAmount;
    IBOutlet UILabel * txtCardNum;
    IBOutlet UILabel * txtMMdd;
    IBOutlet UILabel * txtcvv;
    IBOutlet UILabel * lblAddressType;
    IBOutlet UITextField * txtPostalCode;
    IBOutlet UITextField * txtStreetAddress;
    IBOutlet UITextField * txtCity;
    IBOutlet UITextField * txtState;
    GetCardsInfo * selected;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIView * shipmentView;
    
    IBOutlet UITextField * txtShipPostalCode;
    IBOutlet UITextField * txtShipStreetAddress;
    IBOutlet UITextField * txtShipCity;
    IBOutlet UITextField * txtShipState;

    NSMutableArray * arSelectedRows;
    
    IBOutlet UISegmentedControl * segmentControl;
}

@property (nonatomic ,retain) id<BrainTreeDel>delegate;
@property (nonatomic ,retain) NSMutableArray * cardListArr;
@property (weak, nonatomic) IBOutlet UITableView *tblCreditCard;
@property (nonatomic ,retain) Order * orderInfo;
+ (id) initViewOrder:(Order *)order Delegate:(id<BrainTreeDel>)del;

- (IBAction)payClicked:(id)sender;
- (IBAction)segmentSwitch:(id)sender;

@end
