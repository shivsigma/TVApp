//
//  FavDetailCellTableViewCell.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 17/09/17.
//
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
@interface FavDetailCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet URLImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
