//
//  WelcomeViewController.h
//  UINDIE.xcodeproj1
//
//  Created by Nimit Bagadiya on 27/10/17.
//
//

#import <UIKit/UIKit.h>
#import "ListViewCallBackDelegate.h"
@interface WelcomeViewController : UIViewController
@property (nonatomic ,assign) id<ListViewCallBackDelegate>del;
+(WelcomeViewController *)initViewController:(id<ListViewCallBackDelegate>)dd;

@end
