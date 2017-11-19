//
//  CollectionViewCell.m
//  UINDIE
//
//  Created by apple on 6/17/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//
#import "Uitility.h"
#import "CollectionViewCellInfo.h"

@implementation CollectionViewCellInfo
@synthesize lblProductName=_lblProductName;
@synthesize productImage=_productImage;
@synthesize lblProductPrice=_lblProductPrice;

- (void)awakeFromNib {
    // Initialization code
}


-(void)setDataProductInfo:(ProductInfo *)pro{
    if (pro.productImageArr.count > 0) {
        self.productImage.url = [NSURL URLWithString:[pro.productImageArr objectAtIndex:0]];
    }
    
    self.lblProductName.text = pro.product_title;
    
    self.lblProductPrice.text = [Uitility getCurrencyStringFromAmount:pro.product_price];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    //self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.layer.borderWidth = 1.0;
}
@end
