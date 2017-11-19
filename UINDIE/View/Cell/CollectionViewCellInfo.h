//
//  CollectionViewCell.h
//  UINDIE
//
//  Created by apple on 6/17/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "ProductInfo.h"
@interface CollectionViewCellInfo : UICollectionViewCell{
    IBOutlet URLImageView * _productImage;
    IBOutlet UILabel* _lblProductName;
    IBOutlet UILabel* _lblProductPrice;

}
@property (nonatomic ,retain)URLImageView * productImage;
@property (nonatomic ,retain)UILabel* lblProductName;
@property (nonatomic ,retain)UILabel* lblProductPrice;

- (void) setDataProductInfo:(ProductInfo *)pro;

@end
