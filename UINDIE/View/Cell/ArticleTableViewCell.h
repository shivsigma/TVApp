//
//  ArticleTableViewCell.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra on 7/23/17.
//
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"

@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic ,retain) IBOutlet UILabel * lblTitle;
@property (nonatomic ,retain) IBOutlet UILabel * lblDate;
@property (nonatomic ,retain) IBOutlet UILabel * lblSource;
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;
@property (nonatomic ,retain) IBOutlet UIImageView * imgNew;
@end
