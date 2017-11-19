//
//  CartTableViewCell.h
//  UINDIE
//
//  Created by apple on 6/22/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "ProductInfo.h"
#import "Uitility.h"
#import "CartItem.h"
@protocol CellDelegate <NSObject>

- (void)cartItemDeleteCartItem:(CartItem *)cartItem;

@end

@interface CartTableViewCell : UITableViewCell{

}
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;
@property (nonatomic ,retain) IBOutlet UILabel * lblTitle;
@property (nonatomic ,retain) IBOutlet UILabel * lblAttribute;
@property (nonatomic ,retain) IBOutlet UILabel * lblQty;
@property (nonatomic ,retain) IBOutlet UILabel * lblDesc;
@property (nonatomic ,retain) IBOutlet UILabel * lblPrice;
@property (nonatomic ,retain) IBOutlet UIView * innerView;

@property (nonatomic ,retain) CartItem * ci;
@property (nonatomic ,retain) id<CellDelegate>delegate;


- (IBAction)addQtyClicked:(id)sender;
- (IBAction)minusQtyClicked:(id)sender;

- (IBAction)deleteProductClicked:(id)sender;

- (void)setCartItem:(CartItem *)cartItem Delegate:(id<CellDelegate>)del;

@end
