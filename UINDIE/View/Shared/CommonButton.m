//
//  CommonButton.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/3/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CommonButton.h"

@implementation CommonButton

-(void)awakeFromNib{
    self.layer.cornerRadius = 2; // this value vary as per your desire
    self.clipsToBounds = YES;
    [self setBackgroundColor:[UIColor blueColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //[self setTitleColor:w forState:]
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
