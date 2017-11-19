//
//  CollectionViewCell.m
//  UINDIE
//
//  Created by apple on 6/17/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//
#import "Uitility.h"
#import "CollectionViewCell.h"

@implementation CollectionViewCell
@synthesize lblProductName=_lblProductName;
@synthesize productImage=_productImage;
@synthesize lblProductPrice=_lblProductPrice;

- (void)awakeFromNib {
    // Initialization code
}


-(void)setDataProductInfo:(NewProductInfo *)pro{
     self.productImage.url = [NSURL URLWithString:pro.product_img];
    
    self.lblProductName.text = pro.product_title;
    
    self.lblProductPrice.text = [Uitility getCurrencyStringFromAmount:[pro.product_price floatValue]];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    //self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.layer.borderWidth = 1.0;
}
@end
