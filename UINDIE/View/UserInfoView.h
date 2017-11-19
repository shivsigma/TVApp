//
//  UserInfoView.h
//  UINDIE
//
//  Created by Savan Shah on 4/20/16.
//
//

#import <UIKit/UIKit.h>
#import "ChatInfo.h"
#import "URLImageView.h"

@interface UserInfoView : UIView{
    IBOutlet URLImageView * profileImage;
    IBOutlet UILabel * lblFLname;
    IBOutlet UILabel * lblEmail;
}
@property (nonatomic ,retain) ChatInfo * chatInfo;
+(id)initView:(ChatInfo *)chat;
@end
