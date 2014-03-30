//
//  IntroViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_settings;
@property (weak, nonatomic) IBOutlet UIButton *btn_tutorial;
@property (weak, nonatomic) IBOutlet UIButton *btn_upArrow;

@property (weak, nonatomic) IBOutlet UILabel *lbl_title;

@property (weak, nonatomic) IBOutlet UIImageView *image_background;

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self introAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)introAnimation {
    
    self.btn_upArrow.alpha = 0.15;
    
    [UIView animateWithDuration:0.65
                          delay: 0.5
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
        
                         self.lbl_title.center = CGPointMake(self.lbl_title.center.x, self.view.frame.size.height - (self.lbl_title.frame.size.height * 2.1));
        
                         self.btn_upArrow.center = CGPointMake(self.btn_upArrow.center.x, self.view.frame.size.height - (self.btn_upArrow.frame.size.height * 2.5));
                         
                         self.btn_upArrow.transform = CGAffineTransformMakeScale(1.25, 1.25);

                    }
                     completion:^(BOOL finished){
        
                         [UIView animateWithDuration:0.35
                                               delay: 0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              self.btn_upArrow.center = CGPointMake(self.btn_upArrow.center.x, self.view.frame.size.height - self.btn_upArrow.frame.size.height * 0.8);
                                              self.btn_upArrow.transform = CGAffineTransformMakeScale(1, 1);
                                              self.lbl_title.center = CGPointMake(self.lbl_title.center.x, self.view.frame.size.height - (self.lbl_title.frame.size.height * 2));
                             
                                          }
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:5
                                                                    delay: 4
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                               }
                                                               completion:^(BOOL finished){
                                                               }];
                                          }];
                     }];
    NSLog(@"%f", self.btn_upArrow.center.y);
    
    [UIView animateWithDuration:0.5
                          delay:1.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                            self.btn_settings.alpha = 0.25;
                            self.btn_tutorial.alpha = 0.25;
                     }
                     completion:^(BOOL finished){
                         
                     }];
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
    
    [self buttonPressAnimation:sender];

}

- (IBAction)upArrow:(id)sender {
    
    [self buttonPressAnimation:sender];
    
    //typendiumMenuScrollView.center = CGPointMake(typendiumMenuScrollView.center.x, self.view.frame.size.height);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //self.intro.center = CGPointMake(intro.center.x, 0 - self.view.frame.size.height/2); //This isn't quite right and i don't know why
                         // menu.center = CGPointMake(menu.center.x, self.view.frame.size.height/2);
                     }
                     completion:^(BOOL finished){
                         //   tutorial.userInteractionEnabled = NO;
                         //                         viewingTypendiumIntroView = NO;
                         //                         viewingTypendiumMenuScrollView = YES;
                         //                         currentViewName.string = @"Menu";
                     }];
    
    
    
    
}

- (void)buttonPressAnimation:(UIButton *)button {
    
    [UIView animateWithDuration:0.125
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         button.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.125
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                              button.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
}


@end
