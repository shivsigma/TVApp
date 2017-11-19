//
//  NewProductCalanderView.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 18/11/17.
//
//

#import <UIKit/UIKit.h>
#import "NewProductInfo.h"
#import "ListViewCallBackDelegate.h"
//#import <JTCalendar/JTCalendar.h>
//Narendra
@interface NewProductCalanderView : UIView
//<JTCalendarDelegate>
@property (nonatomic ,retain) id<ListViewCallBackDelegate> delegate;
@property (nonatomic ,retain) NewProductInfo * info;
@property (nonatomic ,retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic ,retain) IBOutlet UIView * calContainnerView;
//@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
//@property (strong, nonatomic) JTCalendarManager *calendarManager;
//@property (nonatomic ,retain) NSDate * dateSelected;

+ (id) initViewNewProductInfo:(NewProductInfo *)obj Delegate:(id<ListViewCallBackDelegate>)del;

@end
