//
//  ProductDetailView.h
//  UINDIE
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"
#import "URLImageView.h"
#import "Uitility.h"
#import "Uitility.h"
#import "CartItem.h"
#import "ProductAttributeInfo.h"
#import "ProductValueInfo.h"
@protocol ProductDelegate <NSObject>

- (void) productAddToCart:(CartItem *)info;

@end

@interface ProductDetailView : UIView<UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource>{
  //  ProductInfo * _info;
    id<ProductDelegate>_delegate;
    IBOutlet UILabel * lblProductName;
    IBOutlet UILabel * lblProductAmount;
    IBOutlet URLImageView * _productImage;
    IBOutlet UITextView * txtView;
    IBOutlet UILabel * lblDescription;

    int index;
    IBOutlet UILabel * lblCount;
    NSMutableArray * tableData;
    NSMutableArray * tableVALUEData;
    
    IBOutlet UILabel * lblAtt;
  //  int Qty;
    
    NSMutableArray * aaa;
}
@property (nonatomic ,retain) IBOutlet UIPageControl * pageControl;
@property (nonatomic ,retain) URLImageView * productImage;
//@property (nonatomic ,retain)ProductInfo * info;
@property (nonatomic ,retain) id<ProductDelegate>delegate;
@property (nonatomic ,retain) CartItem * cItem;

@property (nonatomic ,retain) IBOutlet UITableView * tblView;
@property (nonatomic ,retain) IBOutlet UITableView * tblVALUEView;

//+ (id) initViewProductInfo:(ProductInfo *)obj Delegate:(id<ProductDelegate>)del;

+ (id) initViewCartItem:(CartItem *)obj Delegate:(id<ProductDelegate>)del;


- (IBAction)addToCartClicked:(id)sender;

- (IBAction)attributeClicked:(id)sender;


- (IBAction)addQtyClicked:(id)sender;
- (IBAction)minusQtyClicked:(id)sender;
-(IBAction)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer;

-(IBAction)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer;

@end
