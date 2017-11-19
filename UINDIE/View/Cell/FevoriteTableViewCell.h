//
//  FevoriteTableViewCell.h
//  UINDIE
//
//  Created by Savan Shah on 10/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "FavouriteInfo.h"
@protocol FevoriteCellDelegate <NSObject>
- (void)FevoriteDeleteFevoriteItem:(FavouriteInfo *)FavouriteItem;
@end

@interface FevoriteTableViewCell : UITableViewCell
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblFevorite;
@property (nonatomic ,retain) FavouriteInfo * fi;
@property (nonatomic ,retain) id<FevoriteCellDelegate>delegate;

- (void)setFevoriteItem:(FavouriteInfo *)FevItem Delegate:(id<FevoriteCellDelegate>)del;
- (IBAction)btnDeleteFevorite:(id)sender;

@end
