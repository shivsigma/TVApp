//
//  OnDemandCollectionViewCell.m
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 08/10/17.
//
//

#import "OnDemandCollectionViewCell.h"

@implementation OnDemandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)prepareForReuse {
    _imgView.image = nil;
    
    [super prepareForReuse];
}
- (void)setData:(Video *)video{
    _lblTitle.text = video.title;
    _imgView.url = [NSURL URLWithString:video.video_img];
    NSLog(@"==========>%@",video.video_img);
//    _imgView.image = [Uitility getThumbnailFromVideo:video.url];
}

@end
