//
//  NewProductCalanderView.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 18/11/17.
//
//

#import "NewProductCalanderView.h"

@implementation NewProductCalanderView

+ (id)initViewNewProductInfo:(NewProductInfo *)obj Delegate:(id<ListViewCallBackDelegate>)del{
    NewProductCalanderView* view = [[[NSBundle mainBundle] loadNibNamed:@"NewProductCalanderView" owner:nil options:nil] objectAtIndex:0];
    view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
//    view.delegate =del;
//    view.info = obj;
    view.strSelectedDate = [NSDate date];
    [view viewData];
    return view;
}

- (void)viewData{
    // In loadView(Recommended) or viewDidLoad
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
//
//   
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Test if the dayView is from another month than the page
    // Use only in month mode for indicate the day of the previous or next month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_strSelectedDate && [_calendarManager.dateHelper date:_strSelectedDate isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
//     Your method to test if a date have an event for example
//    if([self haveEventForDay:dayView.date]){
//        dayView.dotView.hidden = NO;
//    }
//    else{
//        dayView.dotView.hidden = YES;
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(UIView<JTCalendarDay> *)dayView{
    NSLog(@"%@",dayView.date);
    _strSelectedDate = dayView.date;
    [_calendarManager reload];
    // Animation for the circleView
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

@end
