//
//  CardListViewController.h
//  UINDIE
//
//  Created by Savan Shah on 10/16/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrainTreeInstance.h"
#import "AddNewCreditCardViewController.h"
#import "ActivityIndicator.h"


@interface CardListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ModelListLoadedDelegate>


@property (nonatomic ,retain) NSMutableArray * cardListArr;
@property (weak, nonatomic) IBOutlet UITableView *tblCreditCard;

+(CardListViewController *)initViewController;

@end
