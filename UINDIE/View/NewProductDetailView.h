//
//  NewProductDetailView.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 18/11/17.
//
//

#import <UIKit/UIKit.h>
#import "NewProductInfo.h"
#import "URLImageView.h"
#import "Uitility.h"

@protocol NewProductDelegate <NSObject>

- (void) productNext;
@end

@interface NewProductDetailView : UIView<UIGestureRecognizerDelegate>{
    //  ProductInfo * _info;
    id<NewProductDelegate>_delegate;
    IBOutlet UILabel * lblProductName;
    IBOutlet UILabel * lblProductName1;
    IBOutlet UILabel * lblProductAmount;
    IBOutlet URLImageView * _productImage;
    IBOutlet UITextView * txtView;
    IBOutlet UILabel * lblDescription;
    
    int index;
    IBOutlet UILabel * lblCount;
    NSMutableArray * tableData;
    NSMutableArray * tableVALUEData;
    
    IBOutlet UILabel * lblAtt;
    
    IBOutlet UILabel * lblCityGeneric;
    //  int Qty;
    
    
    
    
    NSMutableArray * aaa;
}

@property (nonatomic ,retain) IBOutlet UIPageControl * pageControl;
@property (nonatomic ,retain) URLImageView * productImage;
@property (nonatomic ,retain) id<NewProductDelegate>delegate;
@property (nonatomic ,retain) IBOutlet UITableView * tblView;
@property (nonatomic ,retain) IBOutlet UITableView * tblVALUEView;
@property (nonatomic ,retain) NewProductInfo * info;

//+ (id) initViewProductInfo:(ProductInfo *)obj Delegate:(id<ProductDelegate>)del;

+ (id) initViewCartItem:(NewProductInfo *)obj Delegate:(id<NewProductDelegate>)del;


- (IBAction)addToCartClicked:(id)sender;

- (IBAction)attributeClicked:(id)sender;


- (IBAction)addQtyClicked:(id)sender;
- (IBAction)minusQtyClicked:(id)sender;
-(IBAction)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer;

-(IBAction)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer;

@end
