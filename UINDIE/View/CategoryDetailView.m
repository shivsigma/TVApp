//
//  CategoryDetailView.m
//  UINDIE
//
//  Created by Narendra Mistri on 12/23/15.
//  Copyright © 2015 NARENDRA MISTRI. All rights reserved.
//

#import "CategoryDetailView.h"

@implementation CategoryDetailView


+ (id)initViewCategoryDetailView:(ServiceInfo *)fv isNowPlay:(BOOL)isnowPlaying Delegate:(id<CategoryDetailDelegate>)del{
    
    CategoryDetailView * categoryView = [[[NSBundle mainBundle] loadNibNamed:@"CategoryDetailView" owner:nil options:nil] objectAtIndex:0];
    if (isnowPlaying) {
      categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, 122);
    }else{
    categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, 197);
    }
    
    categoryView.delegate = del;
    categoryView.info = fv;
    [categoryView initView];
    return categoryView;
}

-(void)initView{
    _lblTitle.text = _info.category_name;
    _txtView.text = _info.CateDescription;
    
    
    NSString * timeZone = [Uitility getStringValueForKey:kTimeZoneSelected];
    if (![timeZone isEqual:@"PST"]) {
    self.frame = CGRectMake(0, 0, self.frame.size.width, 122);
    }
    
    
    
    
}

-(void)yesClicked:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(yesCategoryClicked)]) {
        [_delegate yesCategoryClicked];
    }
     [[KGModal sharedInstance]hideAnimated:YES];
}
-(void)noClicked:(id)sender{
    [[KGModal sharedInstance]hideAnimated:YES];;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
