//
//  OnDemandCollectionViewCell.h
//  UINDIE.xcodeproj1
//
//  Created by Narendra Mistri on 08/10/17.
//
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"
#import "Video.h"
#import "Uitility.h"
@interface OnDemandCollectionViewCell : UICollectionViewCell
@property (nonatomic ,retain) IBOutlet UILabel * lblTitle;
@property (nonatomic ,retain) IBOutlet URLImageView * imgView;


- (void) setData:(Video *)video;

@end
