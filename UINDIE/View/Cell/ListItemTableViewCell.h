//
//  ListItemTableViewCell.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 15/11/17.
//
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "NewProductInfo.h"
#import "Uitility.h"
@interface ListItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet URLImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDes;

- (void) setInfo:(NewProductInfo *) info;

@end
