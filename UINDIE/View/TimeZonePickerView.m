//
//  TimeZonePickerView.m
//  UINDIE
//
//  Created by Savan Shah on 4/20/16.
//
//

#import "TimeZonePickerView.h"

@implementation TimeZonePickerView

+(id)initView{
    TimeZonePickerView * view;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        view = [[[NSBundle mainBundle] loadNibNamed:@"TimeZonePickerView" owner:nil options:nil] objectAtIndex:0];
    }else{
        view = [[[NSBundle mainBundle] loadNibNamed:@"TimeZonePickerView" owner:nil options:nil] objectAtIndex:0];
    }
    [view initView];
    return view;
}

- (void)initView{
    arr = [[NSMutableArray alloc]init];
    [arr addObject:@"Pacific Standard Time (PST)"];
    [arr addObject:@"Central Standard Time (CST)"];
    [arr addObject:@"Eastern Pacific Time (EPT)"];
}
-(void)saveClicked:(id)sender{
    if ([_timeZone isEqual:@"Eastern Pacific Time (EPT)"]) {
        [Uitility saveStringValue:@"EPT" ForKey:kTimeZoneSelected];
        // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    }else if ([_timeZone isEqual:@"Central Standard Time (CST)"]){
        [Uitility saveStringValue:@"CST" ForKey:kTimeZoneSelected];
        // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    }else{
        [Uitility saveStringValue:@"PST" ForKey:kTimeZoneSelected];
        //[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
        // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Los_Angeles"]];
    }

    [[NSNotificationCenter defaultCenter]postNotificationName:@"TimeZonePickerView" object:nil];
    
    
    [[KGModal sharedInstance]hideAnimated:YES];
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"UINDIE" message:@"We are working on this task." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return arr.count;//Or, return as suitable for you...normally we use array for dynamic
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * str = [arr objectAtIndex:row];
    return str;//Or, your suitable title; like Choice-a, etc.
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString * selectedRowString = [arr objectAtIndex:row];
    _timeZone = selectedRowString;
//    NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayColors objectAtIndex:row], row);
    
    
}
@end
