//
//  FavoriteDetailView.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/22/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavouriteInfo.h"
#import "URLImageView.h"
#import "ServiceList.h"
#import "LinkInfo.h"
@interface FavoriteDetailView : UIView<UITableViewDelegate,UITableViewDataSource,ModelListLoadedDelegate>

@property (nonatomic ,retain) FavouriteInfo * info;
@property (nonatomic ,retain) IBOutlet UILabel * lblTitle;
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;
@property(nonatomic,retain)IBOutlet UITextView *lblDescription;
@property (nonatomic ,retain) IBOutlet UILabel * lblProfilename;
@property (nonatomic ,retain) IBOutlet UITableView * tblView;
@property (nonatomic ,retain) NSMutableArray * arr;


+(id)initViewFavouriteInfo:(FavouriteInfo *)fv;

@end
