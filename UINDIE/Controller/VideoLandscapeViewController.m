//
//  VideoLandscapeViewController.m
//  UINDIE
//
//  Created by apple on 8/16/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "VideoLandscapeViewController.h"
#import "ActivityIndicator.h"
@interface VideoLandscapeViewController ()

@end

@implementation VideoLandscapeViewController

+(VideoLandscapeViewController *)initViewContoller{
    VideoLandscapeViewController * controller = [[VideoLandscapeViewController alloc]initWithNibName:@"VideoLandscapeViewController" bundle:nil];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backcicked:) name:@"BACKGROUNDTOFORE" object:nil];
    
     playbackDurationSet=NO;
    self.navigationController.navigationBarHidden  = YES;
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            
    [self backToforeground];
    // Do any additional setup after loading the view from its nib.
}
-(void)backcicked:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)backToforeground{
    [activity startAnimating];
    [[ServiceList Instance]loadMtimerDelegate:self];
}
-(void)videoPlay:(int)playindex seekPlayTime:(float)playtime{
    
    if (_videosArray.count > 0) {
        playbackDurationSet=NO;
        [_player.view removeFromSuperview];
        _player = nil;
        
        
        Video * info =[_videosArray objectAtIndex:playindex];
        
        NSURL *url = [NSURL URLWithString:info.url];
        
        _player =  [[MPMoviePlayerController alloc]
                    initWithContentURL:url];
        
        
        //[_player setInitialPlaybackTime:playtime];
        playtimeXX = playtime;
        float finish = [self timeFromString:info.duration];
        
        [_player setEndPlaybackTime:finish];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerDidFinishDemand:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_player];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerPlaybackStateChangedDemand:)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_player];
        
        
        
        _player.view.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
        
        [self.playerView addSubview:_player.view];
        [_player setFullscreen:NO animated:NO];
        
        _player.controlStyle = MPMovieControlStyleNone;
        [_player prepareToPlay];
        [_player play];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player stop];
    _player  = nil;
    [self.playerView removeFromSuperview];
    [activity stopAnimating];
    activity.hidesWhenStopped = YES;
}

-(void) moviePlayerPlaybackStateChanged:(NSNotification*)notification
{
    MPMoviePlayerController* playeraaa = (MPMoviePlayerController*)notification.object;
    switch (playeraaa.playbackState) {
        case MPMoviePlaybackStatePlaying:
            if(!playbackDurationSet){
                [self.player setCurrentPlaybackTime:playtimeXX];
                playbackDurationSet=YES;
            }
                       break;
    }
}
- (void)moviePlayerDidFinish:(NSNotification *)note
{
    if (_current_index < _videosArray.count-1) {
        _current_index++;
        
        [self videoPlay:_current_index seekPlayTime:0];
        
    }else{
        _current_index = 0;
        
        [self backToforeground];
    }
    
}



-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    [activity stopAnimating];
    activity.hidesWhenStopped = YES;

        _videosArray =[[NSMutableArray alloc]init];
        
        float  duraiton = 0;
        ServiceInfo * info = [[ServiceList Instance]getCurrentObject];
        
        if (info) {
            if (info.videoArray.count <= 0) {
                return;
            }
            _videosArray = info.videoArray;
           
            duraiton =[self timeFromString:info.playtime];
            
            float _total_duration = [self timeFromString:info.total_duration];
            
            
            if (duraiton < _total_duration) {
                
                float temp_duration = 0;
                int temp_index = -1;
                
                float start_at = 0;
                
                Video * vinfo;
                do {
                    temp_index++;
                    //NSLog(@"------> temp_index %d",temp_index);
                    vinfo = [_videosArray objectAtIndex:temp_index];
                    
                    start_at = duraiton - temp_duration;
                    temp_duration = temp_duration + [self timeFromString:vinfo.duration];
                    
                } while ([self timeFromString:vinfo.duration] < start_at);
                _current_index = temp_index;
                
                if (start_at < 0) {
                    start_at = start_at  * -1;
                }
                
                //NSLog(@"start_at:%.2f",start_at);
                [self videoPlay:_current_index seekPlayTime:start_at];
            }
        }
    
}
- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}
- (float)timeFromString:(NSString *)str
{
    NSScanner *scn = [NSScanner scannerWithString:str];
    
    int h, m, s;
    [scn scanInt:&h];
    [scn scanString:@":" intoString:NULL];
    [scn scanInt:&m];
    [scn scanString:@":" intoString:NULL];
    [scn scanInt:&s];
    
    return h * 3600 + m * 60 + s;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
