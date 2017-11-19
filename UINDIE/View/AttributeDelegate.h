//
//  AttributeDelegate.h
//  UINDIE
//
//  Created by Savan Shah on 7/22/16.
//
//

#import <Foundation/Foundation.h>
@class CartItem;

@protocol AttributeDelegate <NSObject>

- (void) attributeSelected:(CartItem *)pa;

- (void) valueSelected:(CartItem *)pv;

@end
