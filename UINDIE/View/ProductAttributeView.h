//
//  ProductAttributeView.h
//  UINDIE
//
//  Created by Savan Shah on 7/22/16.
//
//

#import <UIKit/UIKit.h>
#import "AttributeDelegate.h"
#import "ProductAttributeInfo.h"
#import "ProductValueInfo.h"
#import "CartItem.h"

@interface ProductAttributeView : UIView<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * tableData;
}

@property (nonatomic ,assign) id<AttributeDelegate>del;
@property (nonatomic ,retain) IBOutlet UITableView * tblView;
@property (nonatomic ,retain) CartItem * productInfo;

+ (id) initViewProductInfo:(CartItem *)info Delegate:(id<AttributeDelegate>)delegate;

@end
