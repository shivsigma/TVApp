//
//  NewProductDetailView.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 18/11/17.
//
//

#import "NewProductDetailView.h"

@implementation NewProductDetailView

@synthesize delegate=_delegate;



+(id)initViewCartItem:(NewProductInfo *)obj Delegate:(id<NewProductDelegate>)del{
    NewProductDetailView* categoryView = [[[NSBundle mainBundle] loadNibNamed:@"NewProductDetailView" owner:nil options:nil] objectAtIndex:0];
    categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, categoryView.frame.size.height);
    categoryView.delegate =del;
    categoryView.info = obj;
    [categoryView viewData];
    return categoryView;
    
}

- (void)viewData{
    
    lblProductAmount.text = [Uitility getCurrencyStringFromAmount:[_info.product_price floatValue]];
    lblProductName.text = _info.product_title;
    lblProductName1.text = _info.product_title;
    lblCityGeneric.text = [NSString stringWithFormat:@"%@ , %@",_info.generename , _info.countryname];
    
//    _pageControl.numberOfPages = _info.images.count;
    
    if (_info.product_desc) {
         txtView.text = _info.product_desc;
    }
    
   
    index = 0;
    _pageControl.currentPage = index;
     _productImage.url = [NSURL URLWithString:_info.product_img];
    // Qty = 1;
    
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
//    if (index < _info.images.count-1) {
//        index++;
//        _productImage.url = [NSURL URLWithString:[_info.images objectAtIndex:index]];
//    }
    
    _pageControl.currentPage = index;
    //Do what you want here
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
//    if (index > 0) {
//        index--;
//        _productImage.url = [NSURL URLWithString:[_info.images objectAtIndex:index]];
//    }
    _pageControl.currentPage = index;
    //Do what you want here
}
-(void)addToCartClicked:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(productNext)]){
        [_delegate productNext];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
