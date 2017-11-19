//
//  ChatImageTableViewCell.h
//  UINDIE
//
//  Created by apple on 6/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
@interface ChatImageTableViewCell : UITableViewCell{
    IBOutlet UILabel * _lblMessage;
    IBOutlet URLImageView * _imgView;
}
@property (nonatomic ,retain) UILabel * lblMessage;
@property (nonatomic ,retain) URLImageView * imgView;

@end
