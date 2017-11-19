//
//  CommonActionSheet_iPad.h
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 12/14/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonActionSheet_iPad;

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@protocol iPadCommonActionSheetDelegate <NSObject>

- (void)actionSheetDoneClickedWithActionSheet:(CommonActionSheet_iPad *)actionSheet;
- (void)actionSheetCancelClickedWithActionSheet:(CommonActionSheet_iPad *)actionSheet;


@end

@interface CommonActionSheet_iPad : UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UIPickerView * _pickerView;
    id<iPadCommonActionSheetDelegate> _delegate;
    UIView *_view;
    int tag;
    IBOutlet UILabel * _lblTitle;
    IBOutlet UIBarButtonItem * _doneBarButton;
    IBOutlet UIBarButtonItem * _cancelBarButton;
    BOOL _isViewOpen;
    IBOutlet UIDatePicker * _datePicker;
    BOOL isFromDatePicker;
    
    
    float hideYPOS;
    float showYPOS;
    float pickerViewWidth;
    
}
@property (nonatomic ,assign) float pickerViewWidth;
@property (nonatomic ,assign) float hideYPOS;
@property (nonatomic ,assign) float showYPOS;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, assign) int tag;
@property (nonatomic ,retain) UILabel * lblTitle;
@property (nonatomic ,retain) UIView * view;
@property (nonatomic ,retain) id<iPadCommonActionSheetDelegate> delegate;
@property (nonatomic ,retain) UIBarButtonItem * doneBarButton;
@property (nonatomic ,retain) UIBarButtonItem * cancelBarButton;
@property (nonatomic ,retain) UIDatePicker * datePicker;
@property (nonatomic ,assign) BOOL isViewOpen;
@property (nonatomic ,assign) BOOL isFromDatePicker;
+ (id)initIPadUIPickerWithTitle:(NSString *)title delegate:(id<iPadCommonActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view;

+ (id)initIPadUIDatePickerWithTitle:(NSString *)title delegate:(id<iPadCommonActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle DatepickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date;

- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

- (IBAction)datePickerSelected:(id)sender;

- (void)show;
- (void)showDatePicker;

@end
