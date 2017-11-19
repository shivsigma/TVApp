//
//  TimeZonePickerView.h
//  UINDIE
//
//  Created by Savan Shah on 4/20/16.
//
//

#import <UIKit/UIKit.h>
#import "Uitility.h"
#import "KGModal.h"
@interface TimeZonePickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray * arr;
}
@property (nonatomic,retain) IBOutlet UIPickerView * pickerView;
@property (nonatomic ,retain) NSString * timeZone;

+(id)initView;

-(IBAction)saveClicked:(id)sender;
@end
