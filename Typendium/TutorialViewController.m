//
//  TutorialViewController.m
//  Typendium
//
//  Created by William Robinson on 15/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TutorialViewController.h"

@import MediaPlayer;
@import AVFoundation;

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_startTutorial;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@end

@implementation TutorialViewController {
    
    NSMutableArray *_tutorialFrames;
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _tutorialFrames = [[NSMutableArray alloc] init];
//    
//    for (long l = 0; l < 540; l++) {
//        
//        NSString *frameNumber = [NSMutableString stringWithFormat:@"TutorialFrames-%04ld", l];
//        
//        UIImage *frame = [UIImage imageNamed:frameNumber];
//        
//        [_tutorialFrames addObject:frame];
//    }
//    UIImageView *tutorialAnimation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    tutorialAnimation.animationImages = _tutorialFrames;
//    tutorialAnimation.animationDuration = 14;
//    
//    [self.view addSubview:tutorialAnimation];
    //[tutorialAnimation startAnimating];
    

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"TypendiumTutorial" ofType:@"mp4"];
//    NSURL *url = [NSURL URLWithString:
//                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
//    _moviePlayer =  [[MPMoviePlayerController alloc]
//                     initWithContentURL:url];
//    _moviePlayer.contentURL =[NSURL fileURLWithPath:path];
//    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    [self.view addSubview:_moviePlayer.view];
    
        NSURL *url = [NSURL URLWithString:
                      @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
    NSURL *MyURL = [[NSBundle mainBundle]
                    URLForResource: @"TypendiumTutorial" withExtension:@"mp4"];
    
    
    _avPlayer = [AVPlayer playerWithURL:MyURL];
    _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    
    _avPlayerLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer: _avPlayerLayer];
    [self.view bringSubviewToFront:self.btn_startTutorial];

}

- (IBAction)playTutorial:(id)sender {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TypendiumTutorial" ofType:@"mp4"];
    
//    MPMoviePlayerController *myPlayer = [[MPMoviePlayerController alloc] init];
//    myPlayer.shouldAutoplay = YES;
//    myPlayer.repeatMode = MPMovieRepeatModeOne;
//    myPlayer.fullscreen = YES;
//    myPlayer.movieSourceType = MPMovieSourceTypeFile;
//    myPlayer.scalingMode = MPMovieScalingModeAspectFit;
//    myPlayer.contentURL =[NSURL fileURLWithPath:path];
//    [self.view addSubview:myPlayer.view];
//    [myPlayer play];
    
//    NSURL *url = [NSURL URLWithString:
//                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
//
//    
//    _moviePlayer =  [[MPMoviePlayerController alloc]
//                     initWithContentURL:url];
//    _moviePlayer.contentURL =[NSURL fileURLWithPath:path];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:_moviePlayer];
//    
//    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    _moviePlayer.shouldAutoplay = YES;
//    [self.view addSubview:_moviePlayer.view];
  //  [_moviePlayer setFullscreen:YES animated:YES];
    [_avPlayer play];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}

@end
