//
//  IntroViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "IntroViewController.h"
#import "MainViewController.h"

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_settings;
@property (weak, nonatomic) IBOutlet UIButton *btn_tutorial;
@property (weak, nonatomic) IBOutlet UIButton *btn_upArrow;

@property (weak, nonatomic) IBOutlet UIImageView *img_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_swipe;

@property (weak, nonatomic) IBOutlet UIImageView *image_background;

@end

@implementation IntroViewController {
    
    NSTimer *_fadeTimer;
}



#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.img_title.alpha = 0;
    self.btn_settings.alpha = 0;
    self.btn_tutorial.alpha = 0;
    self.lbl_swipe.alpha = 0;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    self.btn_upArrow.center = CGPointMake(self.btn_upArrow.center.x, self.view.frame.size.height + self.view.frame.size.height / 2);
    self.img_title.center = CGPointMake(self.img_title.center.x, self.view.frame.size.height);
    self.img_title.alpha = 1;

    [self introAnimation];
    
    _fadeTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(fade:) userInfo:nil repeats:NO];
}

- (void)fade:(NSTimer *)aTimer {
    
    // Forget about timer!
    _fadeTimer = nil;
    
    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.lbl_swipe.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:2.0
                                               delay:5
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              
                                              self.lbl_swipe.alpha = 0;
                                          }
                                          completion:NULL];
                     }];

    
//    Upon every user interaction you just call a method that delays the fade. To do this, delete and re-create the timer. Or change it's fire date:
//        
//        - (void)delayFade {
//            [_fadeTimer setFireDate: [NSDate dateWithTimeIntervalSinceNow: 2.0]];
//        }
//PS: There is no need to explicitly retain the timer. It's retained by the runloop until it fires. After the callback, it will be released anyways. Just make sure you always reset the variable to nil, otherwise your app may crash on an invalid access. If you need to delete the time beofre it fired, call the invalidate method.
}

-(void)introAnimation {
    
    [UIView animateKeyframesWithDuration:2.0
                                   delay:0.0
                                 options:0
                              animations:^ {
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                                      
                                      self.img_title.center = CGPointMake(self.img_title.center.x, self.view.center.y);
                                      
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
                                     
                                      [UIView animateWithDuration:1
                                                            delay:1.75
                                           usingSpringWithDamping:0.75
                                            initialSpringVelocity:0
                                                          options:0
                                                       animations:^{
                                                           
                                                           self.btn_upArrow.center = CGPointMake(self.btn_upArrow.center.x, self.view.frame.size.height - self.btn_upArrow.frame.size.height * 1.5);
                                                           self.btn_tutorial.alpha = 1;
                                                       }
                                                       completion:NULL];
                                  }];
                                  
                              } completion:NULL];
}

- (IBAction)settingsButton:(id)sender {
    
    //    settings.hidden = NO;
    //    settings.userInteractionEnabled = YES;
    //    [self changeShadowColorOnScrollView:settings :YES];
    //    [self.view bringSubviewToFront:settings]; ///////////////////////////REMOVE VIEW
    
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //                         settings.center = CGPointMake(settings.center.x, self.view.frame.size.height/2);
                         self.btn_settings.transform = CGAffineTransformRotate(self.btn_settings.transform, M_PI / 2);
                         [self buttonPressAnimation:sender];
                     }
                     completion:^(BOOL finished){
                         
                         self.btn_settings.transform = CGAffineTransformRotate(self.btn_settings.transform, M_PI * 2);
                         
                         //                         currentViewName.string = @"Settings";
                         //                         viewingTypendiumIntroView = NO;
                         //                         viewingTypendiumMenuScrollView = NO;
                         //                         viewingTypendiumHistoryScrollView = NO;
                         //                         viewingTypendiumIntroView = NO;
                         //                         viewingTypendiumHistoryInfoScrollView = NO;
                         
                     }];
    
    
    
    
    
}

- (void) buttonPress:(UIButton*)button {
    button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    // Do something else
}

// Scale down on button release
- (void) buttonRelease:(UIButton*)button {
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    // Do something else
}

- (IBAction)tutorialButton:(id)sender {
    
    [self.delegate animateContainerUpwards:self
                               currentPage:@"Intro"
                                   newPage:@"Tutorial"];

}

- (IBAction)upArrow:(id)sender {
    
    [self.delegate animateContainerUpwards:self
                               currentPage:@"Intro"
                                   newPage:@"Menu"];
    
}


- (void)buttonPressAnimation:(UIButton *)button {
    
//    [UIView animateWithDuration:0.125
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         
//                         button.transform = CGAffineTransformMakeScale(1.1, 1.1);
//                     }
//                     completion:^(BOOL finished){
//                         [UIView animateWithDuration:0.125
//                                               delay:0
//                                             options:UIViewAnimationOptionCurveLinear
//                                          animations:^{
//                                              
//                                              button.transform = CGAffineTransformMakeScale(1.0, 1.0);
//                                          }
//                                          completion:^(BOOL finished){
//                                          }];
//                     }];
}


@end
