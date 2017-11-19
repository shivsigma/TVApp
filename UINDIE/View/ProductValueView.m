//
//  ProductValueView.m
//  UINDIE
//
//  Created by Savan Shah on 7/22/16.
//
//

#import "ProductValueView.h"

@implementation ProductValueView

+ (id)initViewProductAttributeInfo:(CartItem *)info Delegate:(id<AttributeDelegate>)delegate{
    ProductValueView * view = [[[NSBundle mainBundle] loadNibNamed:@"ProductValueView" owner:nil options:nil] objectAtIndex:0];
    view.productAttInfo = info;
    view.del = delegate;
    [view initView];
    return view;
}
- (void) initView{
    tableData = [[NSMutableArray alloc]init];
    tableData  = _productAttInfo.productAtt.productValue;
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
    ProductValueInfo * pv = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = pv.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      ProductValueInfo * pvv = [tableData objectAtIndex:indexPath.row];
    
    _productAttInfo.productAtt.pv = pvv;
    if (_del && [_del respondsToSelector:@selector(valueSelected:)]) {
        [_del valueSelected:_productAttInfo];
    }
}
@end
