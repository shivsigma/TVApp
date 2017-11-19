//
//  UserInfoView.m
//  UINDIE
//
//  Created by Savan Shah on 4/20/16.
//
//

#import "UserInfoView.h"

@implementation UserInfoView

+(id)initView:(ChatInfo *)chat{
    UserInfoView * view;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    view = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView_iPad" owner:nil options:nil] objectAtIndex:0];
    }else{
    view = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:nil options:nil] objectAtIndex:0];
    }
    view.chatInfo = chat;
    [view initView];
    return view;
}

- (void)initView{
    profileImage.url = [NSURL URLWithString:_chatInfo.profile_pic];
    lblFLname.text = [NSString stringWithFormat:@"%@",_chatInfo.first_name.uppercaseString];
    lblEmail.text = [NSString stringWithFormat:@"%@, %@",_chatInfo.city.uppercaseString,_chatInfo.state.uppercaseString];
}

@end
