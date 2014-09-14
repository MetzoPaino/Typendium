//
//  TutorialViewController.m
//  Typendium
//
//  Created by William Robinson on 15/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TutorialViewController.h"

@import AVFoundation;

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_startTutorial;
@property (weak, nonatomic) IBOutlet UIButton *btn_upArrow;

@property (weak, nonatomic) AVPlayer *avPlayer;
@property (weak, nonatomic) AVPlayerLayer *avPlayerLayer;

@end

@implementation TutorialViewController

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self avPlayer];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(startTutorial:) name:@"StartTutorial" object:nil];
    [notificationCenter addObserver:self selector:@selector(stopTutorial:) name:@"StopTutorial" object:nil];

}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    if (self.view.bounds.size.height < 568) {
        self.btn_upArrow.center = CGPointMake(self.btn_upArrow.center.x, self.btn_upArrow.center.y);
    }
}

- (void)startTutorial:(NSNotification *) notification {
    
    [self.avPlayer play];
}

- (void)stopTutorial:(NSNotification *) notification {
    
    [self.avPlayer pause];
    [self.avPlayer seekToTime:kCMTimeZero];

}

- (AVPlayer *)avPlayer {
    
    if (!_avPlayer) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource: @"TypendiumTutorial" withExtension:@"mp4"];
        _avPlayer = [AVPlayer playerWithURL:url];
        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
        
        _avPlayerLayer.frame = self.view.layer.bounds;
        
      //  _avPlayerLayer.frame = CGRectMake(10, 10, self.view.layer.bounds.size.width - 20, self.view.bounds.size.height - 20);
        
        [self.view.layer addSublayer: _avPlayerLayer];
        [self.view bringSubviewToFront:self.btn_startTutorial];
        [self.view bringSubviewToFront:self.btn_upArrow];
       // self.btn_upArrow.center = CGPointMake(self.view.center.x, 545);

        _avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[_avPlayer currentItem]];
    }
    return _avPlayer;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.btn_startTutorial.alpha = 1;
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self.avPlayer pause];
                         AVPlayerItem *p = [notification object];
                         [p seekToTime:kCMTimeZero];
                     }];

}

#pragma mark - Actions

- (IBAction)playTutorial:(id)sender {
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.btn_startTutorial.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self.avPlayer play];
                     }];
}

- (IBAction)upArrow:(id)sender {
    
    [self.delegate animateContainerUpwards:self
                               currentPage:@"Tutorial"
                                   newPage:@"Intro"];
    
}

@end
