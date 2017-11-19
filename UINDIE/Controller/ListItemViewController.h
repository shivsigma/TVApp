//
//  ListItemViewController.h
//  UINDIE.xcodeproj1
//
//  Created by Nimit Bagadiya on 27/10/17.
//
//

#import <UIKit/UIKit.h>
#import "ListItemTableViewCell.h"
#import "ListViewCallBackDelegate.h"

@interface ListItemViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (weak, nonatomic) IBOutlet UIButton *btnCountry,*btnOther;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *lblCart;
@property (nonatomic ,assign) id<ListViewCallBackDelegate>dd;

+(ListItemViewController *)initViewController:(id<ListViewCallBackDelegate>)del;

- (IBAction)backActionClicked:(id)sender;

@end
