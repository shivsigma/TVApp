//
//  ListItemTableViewCell.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 15/11/17.
//
//

#import "ListItemTableViewCell.h"

@implementation ListItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setInfo:(NewProductInfo *)info{
    _lblTitle.text = info.product_title;
    _lblPrice.text = [Uitility getCurrencyStringFromAmount:[info.product_price floatValue]];
    _lblDes.text = [NSString stringWithFormat:@"%@ , %@",info.generename,info.countryname];
    _imgView.url =[NSURL URLWithString:info.product_img];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
