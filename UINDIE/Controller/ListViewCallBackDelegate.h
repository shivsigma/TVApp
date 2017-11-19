//
//  ListViewCallBackDelegate.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 18/11/17.
//
//

#import <Foundation/Foundation.h>
@class NewProductInfo;
@protocol ListViewCallBackDelegate <NSObject>

- (void)ListViewDelegate:(NewProductInfo *)info;

@end
