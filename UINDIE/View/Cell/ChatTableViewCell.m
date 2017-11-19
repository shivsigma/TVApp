//
//  ChatTableViewCell.m
//  UINDIE
//
//  Created by apple on 6/14/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewTapped{
    UserInfoView * view = [UserInfoView initView:_info];
    [[KGModal sharedInstance]showWithContentView:view];
}

-(void)SetCellData:(ChatInfo *)feed_data targetedView:(id)ViewControllerObject Atrow:(NSInteger)indexRow
{
    _info = feed_data;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        messageWidth = 768;
    }else{
        
        messageWidth = 298;
    }
    
    _lblMessage.hidden=YES;
    NSString *messageText =[NSString stringWithFormat:@"%@ : %@",feed_data.user_name,feed_data.message];
    CGSize boundingSize = CGSizeMake(messageWidth, 10000000);
    CGSize itemTextSize = [messageText sizeWithFont:[UIFont systemFontOfSize:13]
                                  constrainedToSize:boundingSize
                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    float textHeight = 0.00f;
    if (itemTextSize.height<25)
    {
       textHeight =  itemTextSize.height =25.0;
    }else{
     textHeight = itemTextSize.height;
    }
    
    
    UITextView *messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(10,0,self.contentView.frame.size.width-10, textHeight)];
   
    messageTextview.backgroundColor = [UIColor purpleColor];
    
    [self.contentView addSubview:messageTextview];
    messageTextview.editable=NO;
    
    messageTextview.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped)];
    [messageTextview addGestureRecognizer:gestureRecognizer];
    
    messageTextview.text = messageText;
    messageTextview.scrollEnabled=false;
    
    
    
    
    NSMutableAttributedString * attributedString= [[NSMutableAttributedString alloc] initWithString:messageTextview.text];
    
    
    if([feed_data.user_type  isEqual:@"provider"])
    {
        // [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,feed_data.user_name.length)];
        
        //        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:44 green:104 blue:19 alpha:0.0] range:NSMakeRange(0,feed_data.user_name.length)];
        
        
        NSString *stringColor = @"#2C6813";
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,feed_data.user_name.length)];
        
        
        
    }
    else if([feed_data.user_type  isEqual:@"admin"])
    {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,feed_data.user_name.length)];
    }
    else{
        Account *account=[AccountManager Instance].activeAccount;
        if([feed_data.user_type  isEqual:@"user"] && feed_data.user_id==account.userId)
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,feed_data.user_name.length)];
            
        }
        else
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,feed_data.user_name.length)];
        }
    }

    
//    if([feed_data.messageType  isEqual: ktextByme]){
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,feed_data.user_name.length)];
//    }else{
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,feed_data.user_name.length)];
//    }
//    
    messageTextview.attributedText=attributedString;
    messageTextview.dataDetectorTypes=UIDataDetectorTypeAll;
    messageTextview.textAlignment=NSTextAlignmentLeft;
    messageTextview.font=[UIFont fontWithName:@"Helvetica Neue" size:12.0];
    messageTextview.backgroundColor=[UIColor clearColor];
    
    messageTextview.tag=indexRow;
    messageTextview.scrollEnabled=false;
    
    [messageTextview sizeToFit]; //added
    [messageTextview layoutIfNeeded]; //added
  
    messageTextview.textContainerInset = UIEdgeInsetsZero;
    messageTextview.frame = CGRectMake(messageTextview.frame.origin.x, messageTextview.frame.origin.y, messageTextview.frame.size.width, messageTextview.frame.size.height - 10);
    // Configure the view for the selected state
}

@end
