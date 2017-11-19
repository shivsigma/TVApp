//
//  btnLoginBottom.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/12/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "btnLoginBottom.h"

@implementation btnLoginBottom

-(void)awakeFromNib{
    self.layer.cornerRadius = 15; // this value vary as per your desire
    self.clipsToBounds = YES;
    [self setBackgroundColor:[UIColor redColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //[self setTitleColor:w forState:]
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}


@end
