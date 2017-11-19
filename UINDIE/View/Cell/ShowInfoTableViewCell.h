//
//  ShowInfoTableViewCell.h
//  Vinly
//
//  Created by apple on 2/20/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowInfoTableViewCell : UITableViewCell{
    IBOutlet UILabel * _lblLeftTitle;
    IBOutlet UILabel * _lblRightTitle;
}

@property (nonatomic ,retain) UILabel * lblLeftTitle;
@property (nonatomic ,retain) UILabel * lblRightTitle;

@end
