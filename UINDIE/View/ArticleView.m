//
//  ArticleView.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra on 7/23/17.
//
//

#import "ArticleView.h"

@implementation ArticleView
+ (id)initView{
    ArticleView*  categoryView = [[[NSBundle mainBundle] loadNibNamed:@"ArticleView" owner:nil options:nil] objectAtIndex:0];
    return categoryView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
