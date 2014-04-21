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

@property (weak, nonatomic) AVPlayer *avPlayer;
@property (weak, nonatomic) AVPlayerLayer *avPlayerLayer;

@end

@implementation TutorialViewController {
    
    NSMutableArray *_tutorialFrames;
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self avPlayer];
}

- (AVPlayer *)avPlayer {
    
    if (!_avPlayer) {
        
        NSURL *url = [[NSBundle mainBundle]
                        URLForResource: @"TypendiumTutorial" withExtension:@"mp4"];
        _avPlayer = [AVPlayer playerWithURL:url];
        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
        
        _avPlayerLayer.frame = self.view.layer.bounds;
        [self.view.layer addSublayer: _avPlayerLayer];
        [self.view bringSubviewToFront:self.btn_startTutorial];

        _avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[_avPlayer currentItem]];
    }
    return _avPlayer;
}

- (IBAction)playTutorial:(id)sender {
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{

                         self.btn_startTutorial.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){

                         [self.avPlayer play];
                     }];
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

@end
