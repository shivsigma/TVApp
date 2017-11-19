//
//  ChatTableViewCell.h
//  UINDIE
//
//  Created by apple on 6/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatInfo.h"
#import "UserInfoView.h"
#import "KGModal.h"

@interface ChatTableViewCell : UITableViewCell{
   IBOutlet UILabel * _lblMessage;
    float messageWidth;
}
@property (nonatomic ,retain) UILabel * lblMessage;
@property (nonatomic)ChatInfo * info;

-(void)SetCellData:(ChatInfo *)feed_data targetedView:(id)ViewControllerObject Atrow:(NSInteger)indexRow;

- (void)textViewTapped;

@end
