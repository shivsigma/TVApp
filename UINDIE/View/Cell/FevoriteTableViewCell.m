//
//  FevoriteTableViewCell.m
//  UINDIE
//
//  Created by Savan Shah on 10/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "FevoriteTableViewCell.h"

@implementation FevoriteTableViewCell

- (void)setFevoriteItem:(FavouriteInfo *)FevItem Delegate:(id<FevoriteCellDelegate>)del {
    _fi = FevItem;
    _delegate =del;
    _lblFevorite.text = FevItem.video_title;
    _imgView.url = [NSURL URLWithString:FevItem.video_img];
}

-(void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)btnDeleteFevorite:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(FevoriteDeleteFevoriteItem:)])
    {
        [_delegate FevoriteDeleteFevoriteItem:_fi];
    }
}
@end
