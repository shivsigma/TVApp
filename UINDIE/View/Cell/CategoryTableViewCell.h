//
//  CategoryTableViewCell.h
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic ,retain) IBOutlet UILabel * lblName;
@property (nonatomic ,retain) IBOutlet UILabel * lblTime;
@property (nonatomic ,retain) IBOutlet UILabel * lblPlaying;
@property (weak, nonatomic) IBOutlet UIButton *btncheckbox;

@end
