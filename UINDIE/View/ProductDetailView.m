//
//  ProductDetailView.m
//  UINDIE
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ProductDetailView.h"

@implementation ProductDetailView
//@synthesize info=_info;
@synthesize delegate=_delegate;



+(id)initViewCartItem:(CartItem *)obj Delegate:(id<ProductDelegate>)del{
    ProductDetailView* categoryView;
    
    if (obj.product.productAttributes.count <= 0){
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailView" owner:nil options:nil] objectAtIndex:0];
    }
    else
    {
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"ProductAttributeDetailView" owner:nil options:nil] objectAtIndex:0];
    }
    categoryView.cItem = obj;
    categoryView.frame = CGRectMake(0, 0, categoryView.frame.size.width, categoryView.frame.size.height);
    categoryView.delegate =del;
    [categoryView viewData];
    return categoryView;

}

- (void)viewData{
  
    tableData = [[NSMutableArray alloc]init];
    tableData  = _cItem.product.productAttributes;
    [_tblView reloadData];
    
    tableVALUEData = [[NSMutableArray alloc]init];
    [_tblVALUEView reloadData];
    
    aaa = [[NSMutableArray alloc]init];
   // [self updateData];
    
    
     lblProductAmount.text = [Uitility getCurrencyStringFromAmount:(_cItem.product.product_price)*_cItem.qty];
    lblProductName.text = _cItem.product.product_title;
    if (_cItem.product.product_title.length <= 0) {
        lblProductName.text =@"Product title";
    }
    
    _pageControl.numberOfPages = _cItem.product.productImageArr.count;
    
    txtView.text = _cItem.product.product_desc;
    index = 0;
    _pageControl.currentPage = index;
    if (_cItem.product.productImageArr.count > 0) {
        _productImage.url = [NSURL URLWithString:[_cItem.product.productImageArr objectAtIndex:0]];
    }
   // Qty = 1;
    
    lblCount.text = [NSString stringWithFormat:@"%d",_cItem.qty];
}

-(void)addQtyClicked:(id)sender{
    _cItem.qty ++;
    aaa = [[NSMutableArray alloc]init];
    lblCount.text = [NSString stringWithFormat:@"%d",_cItem.qty];
   // lblProductAmount.text = [Uitility getCurrencyStringFromAmount:(_cItem.product.product_price + _cItem.product.product_tax) * _cItem.qty];
    
     lblProductAmount.text = [Uitility getCurrencyStringFromAmount:(_cItem.product.product_price) * _cItem.qty];
}

-(void)minusQtyClicked:(id)sender{
    
    if (_cItem.qty > 1) {
        _cItem.qty --;
        lblCount.text = [NSString stringWithFormat:@"%d",_cItem.qty];
//        lblProductAmount.text = [Uitility getCurrencyStringFromAmount:(_cItem.product.product_price + _cItem.product.product_tax) * _cItem.qty];
        
        lblProductAmount.text = [Uitility getCurrencyStringFromAmount:(_cItem.product.product_price) * _cItem.qty];

    }
    
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (index < _cItem.product.productImageArr.count-1) {
        index++;
        _productImage.url = [NSURL URLWithString:[_cItem.product.productImageArr objectAtIndex:index]];
    }
    
    _pageControl.currentPage = index;
    //Do what you want here
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (index > 0) {
        index--;
        _productImage.url = [NSURL URLWithString:[_cItem.product.productImageArr objectAtIndex:index]];
    }
     _pageControl.currentPage = index;
    //Do what you want here
}
-(void)addToCartClicked:(id)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(productAddToCart:)]){
        [_delegate productAddToCart:_cItem];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblView) {
        return tableData.count;
    }
    return tableVALUEData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblView) {
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        ProductAttributeInfo * info = [tableData objectAtIndex:indexPath.row];
        
        cell.textLabel.text = info.name;
        return cell;
    }
    static NSString *simpleTableIdentifier = @"SimpleTableItemSSS";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    ProductValueInfo * pv = [tableVALUEData objectAtIndex:indexPath.row];
    cell.textLabel.text = pv.name;
    return cell;
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _tblView) {
        ProductAttributeInfo * info = [tableData objectAtIndex:indexPath.row];
        _cItem.productAtt = info;
        //[aaa addObject:info.name];
        
        tableVALUEData = [[NSMutableArray alloc]init];
        tableVALUEData  = info.productValue;
       
        [_tblVALUEView reloadData];
    }else{
        ProductValueInfo * pvv = [tableVALUEData objectAtIndex:indexPath.row];
         [aaa addObject:pvv.name];
        _cItem.productAtt.pv = pvv;
    }
    [self updateData];
    
}

- (void) updateData{
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:aaa];
    NSArray *arrayWithoutDuplicates = [orderedSet array];
    
    lblAtt.text = [arrayWithoutDuplicates componentsJoinedByString:@" , "];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
