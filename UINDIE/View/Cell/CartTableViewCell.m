//
//  CartTableViewCell.m
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCartItem:(CartItem *)cartItem Delegate:(id<CellDelegate>)del {
    _ci = cartItem;
    _delegate =del;
    _lblTitle.text = cartItem.product.product_title;
    if (cartItem.productAtt) {
         _lblAttribute.text = cartItem.productAtt.name;
    }
    if (cartItem.productAtt.pv){
        _lblAttribute.text = [_lblAttribute.text stringByAppendingFormat:@",%@",cartItem.productAtt.pv.name];
    }
   
    _lblQty.hidden = YES;
    
    self.innerView.layer.cornerRadius = 1.0;
    self.innerView.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
    self.innerView.layer.borderWidth = 1.0;
    
    if (cartItem.qty > 1)
    {
        _lblQty.hidden = NO;
        _lblQty.text = [NSString stringWithFormat:@"%d",cartItem.qty];
    }
    
    _lblQty.layer.cornerRadius = 8;
    _lblQty.clipsToBounds = YES;
    
    if (cartItem.product.productImageArr.count > 0) {
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 6;
        _imgView.url = [NSURL URLWithString:[cartItem.product.productImageArr objectAtIndex:0]];
    }
  //  _lblPrice.text = [Uitility getCurrencyStringFromAmount:(cartItem.product.product_price + cartItem.product.product_tax)*cartItem.qty];
    
     _lblPrice.text = [Uitility getCurrencyStringFromAmount:(cartItem.product.product_price)*cartItem.qty];
    _lblDesc.text = cartItem.product.product_desc;
}
-(void)addQtyClicked:(id)sender{
    
    
}

-(void)minusQtyClicked:(id)sender{

}

-(void)deleteProductClicked:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(cartItemDeleteCartItem:)]) {
        [_delegate cartItemDeleteCartItem:_ci];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
