//
//  VideoLandscapeViewController.h
//  UINDIE
//
//  Created by apple on 8/16/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceList.h"
#import "ServiceInfo.h"
#import "ModelListLoadedDelegate.h"
#import <MediaPlayer/MediaPlayer.h>


@interface VideoLandscapeViewController : UIViewController<ModelListLoadedDelegate,UINavigationControllerDelegate>{
    BOOL playbackDurationSet;
    int _current_index;
    float playtimeXX;
    IBOutlet UIActivityIndicatorView * activity;
}
@property (nonatomic ,retain) MPMoviePlayerController * player;
@property (nonatomic ,retain) IBOutlet UIView * playerView;
@property (nonatomic ,retain) NSMutableArray * videosArray;
+ (VideoLandscapeViewController *)initViewContoller;

- (IBAction)backcicked:(id)sender;



@end
