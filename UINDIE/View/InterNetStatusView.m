//
//  InterNetStatusView.m
//  UINDIE
//
//  Created by Savan Shah on 6/27/16.
//
//

#import "InterNetStatusView.h"

@implementation InterNetStatusView
+ (id)initView{
    InterNetStatusView * categoryView = [[[NSBundle mainBundle] loadNibNamed:@"InterNetStatusView" owner:nil options:nil] objectAtIndex:0];
    return categoryView;
}


-(void)OKClicked:(id)sender{
    [[KGModal sharedInstance]hideAnimated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
