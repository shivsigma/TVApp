//
//  CategoryDetailView.h
//  UINDIE
//
//  Created by Narendra Mistri on 12/23/15.
//  Copyright © 2015 NARENDRA MISTRI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceInfo.h"
#import "KGModal.h"
#import "Uitility.h"
@protocol CategoryDetailDelegate <NSObject>

- (void) yesCategoryClicked;

@end

@interface CategoryDetailView : UIView

@property (nonatomic ,retain) ServiceInfo * info;

@property (nonatomic ,retain) IBOutlet UITextView * txtView;
@property (nonatomic ,retain) IBOutlet UILabel * lblTitle;
@property (nonatomic ,retain) IBOutlet UIButton * yesBtn;
@property (nonatomic ,retain) IBOutlet UIButton * noBtn;

@property (nonatomic ,assign) id<CategoryDetailDelegate>delegate;
- (IBAction)yesClicked:(id)sender;
- (IBAction)noClicked:(id)sender;

+(id)initViewCategoryDetailView:(ServiceInfo *)fv isNowPlay:(BOOL)isnowPlaying Delegate:(id<CategoryDetailDelegate>)del;

- (void) initView;
@end
