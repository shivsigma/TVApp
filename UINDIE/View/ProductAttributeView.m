//
//  ProductAttributeView.m
//  UINDIE
//
//  Created by Savan Shah on 7/22/16.
//
//

#import "ProductAttributeView.h"

@implementation ProductAttributeView

+ (id)initViewProductInfo:(CartItem *)info Delegate:(id<AttributeDelegate>)delegate{
    ProductAttributeView * view = [[[NSBundle mainBundle] loadNibNamed:@"ProductAttributeView" owner:nil options:nil] objectAtIndex:0];
    view.del = delegate;
    view.productInfo = info;
    [view initView];
    return view;
}
- (void) initView{
    tableData = [[NSMutableArray alloc]init];
    tableData  = _productInfo.product.productAttributes;
    [_tblView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    ProductAttributeInfo * info = [tableData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = info.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductAttributeInfo * info = [tableData objectAtIndex:indexPath.row];
    _productInfo.productAtt = info;
    if (_del && [_del respondsToSelector:@selector(attributeSelected:)]) {
        [_del attributeSelected:_productInfo];
    }
    
}
@end
