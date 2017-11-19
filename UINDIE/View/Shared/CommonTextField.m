//
//  CommonTextField.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/3/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField

-(void)awakeFromNib{
    self.layer.cornerRadius=2.0f;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[UIColor colorWithRed:138.0/255.0 green:194.0/255.0 blue:182.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth= 1.0f;
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    int leftMargin = 5;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int leftMargin = 5;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

@end
