//
//  ProductValueView.h
//  UINDIE
//
//  Created by Savan Shah on 7/22/16.
//
//

#import <UIKit/UIKit.h>
#import "AttributeDelegate.h"
#import "ProductAttributeInfo.h"
#import "CartItem.h"

@interface ProductValueView : UIView<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * tableData;
}
@property (nonatomic ,retain) CartItem * productAttInfo;
@property (nonatomic ,assign) id<AttributeDelegate>del;
@property (nonatomic ,retain) IBOutlet UITableView * tblView;
+ (id) initViewProductAttributeInfo:(CartItem *)info Delegate:(id<AttributeDelegate>)delegate;
@end
