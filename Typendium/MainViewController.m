//
//  ViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *con_intro;
@property (weak, nonatomic) IBOutlet UIView *con_menu;


@property (weak, nonatomic) IBOutlet UIView *test;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@end

@implementation MainViewController {
    
    BOOL _hasParallaxStarted;
}

#define ViewOffset 200

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.intro.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    //UINavigationController *navigationController = segue.destinationViewController;
    // 2
    //IntroViewController *controller = [IntroViewController new];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    TPPolicyMasterViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"WealthPlatformPolicy"];
    
    
    IntroViewController *i = [[IntroViewController alloc]init];
    i.delegate=self;
    [i setDelegate:self];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:self.panGesture];
    self.panGesture.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [self layoutViews];
    float introViewYStart = self.con_intro.center.y;

    NSLog(@"introViewYStart %f", introViewYStart);

}

- (void)layoutViews {
    
    self.con_intro.center = CGPointMake(self.con_intro.center.x, self.view.center.y);
    self.con_menu.center = CGPointMake(self.con_intro.center.x, self.view.center.y + ViewOffset);
    
    
//    anatomy.center = CGPointMake(anatomy.center.x, self.view.frame.size.height/2 + offset);
//    specimens.center = CGPointMake(specimens.center.x, self.view.frame.size.height/2 + offset);
//    history.center = CGPointMake(history.center.x, self.view.frame.size.height/2 + offset);
//    menu.center = CGPointMake(menu.center.x, self.view.frame.size.height/2 + offset);
//    info.center = CGPointMake(info.center.x, self.view.frame.size.height/2 + offset);
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    NSString *gestureContext;
    
    CGPoint panGestureTranslation = [panGestureRecognizer translationInView:self.view];
    float parallaxCoefficient = ViewOffset / self.view.frame.size.height;

    if (_hasParallaxStarted == NO) {
        
        _hasParallaxStarted = YES;
    }
    
    // NEED THIS INFORMATION AT BEGINING OF MOVEMENT, THEN STATIC UNTIL LET GO
    float introViewYStart = 284;
    float menuViewYStart = 484;
    
    
    if (panGestureTranslation.y <= 0.0) {
        
       gestureContext = @"Moving Current View Up";
        
        self.con_intro.center = CGPointMake(self.con_intro.center.x, introViewYStart + panGestureTranslation.y);
        self.con_menu.center = CGPointMake(self.con_menu.center.x, menuViewYStart + (panGestureTranslation.y * parallaxCoefficient ));
        
        
        if (self.con_intro.center.y + self.con_intro.center.y >= self.view.frame.size.height/2) {
            [UIView animateWithDuration:1 delay: 0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.view layoutIfNeeded];
                
            }
                             completion:^(BOOL finished){
                             }];
            
        }
        
    } else {
        
    }
    
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {

            [self parallaxToLocation :  self.con_intro : self.con_menu : gestureContext];
    }

    
  
}

- (void)parallaxToLocation : (UIView*)currentView : (UIView*)otherView : (NSString*)gestureContext {
    
    if ([gestureContext isEqualToString:@"Moving Current View Up"]) {
        
        if (currentView.center.y <= self.view.frame.size.height/2.5) {
            
            // current view was high enough that it will be animated off screen
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 otherView.center = CGPointMake(otherView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, -self.view.frame.size.height/2);
                             }
                             completion:^(BOOL finished){
                             }];
            
        } else {
            
            // current view was not high enough so it will be animated to original position
            
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 currentView.center = CGPointMake(currentView.center.x, self.view.frame.size.height/2);
                                 otherView.center = CGPointMake(otherView.center.x, self.view.frame.size.height/2 + ViewOffset);
                             }
                             completion:^(BOOL finished){
                             }];
        }
    }
}

- (IBAction)move:(id)sender {
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.test.center = CGPointMake(self.test.center.x, 200);
                         
                }
                     completion:^(BOOL finished){

                     }];
}


- (void)animateContainerUpwards:(NSString *)viewName {
    
    NSLog(@"OLD %f", self.con_intro.center.y);
       self.con_intro.alpha = 0.6;
    [self.con_intro removeFromSuperview];
    
    self.con_intro.backgroundColor = [UIColor redColor];
    self.con_intro.center = CGPointMake(self.con_intro.center.x, 200);
    [self.con_intro updateConstraintsIfNeeded];

    if ([viewName isEqualToString:@"Intro"]) {
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.test.center = CGPointMake(self.test.center.x, 200);
                             
                             
                             self.con_intro.center = CGPointMake(self.con_intro.center.x, 200);
                             
//                             belowView.center = CGPointMake(belowView.center.x, self.view.frame.size.height/2 + offset);
                         }
                         completion:^(BOOL finished){
                             [self updateViewConstraints];
                             [self.con_intro updateConstraintsIfNeeded];
                             [self.con_intro removeFromSuperview];

                             NSLog(@"BANG %f", self.con_intro.center.y);
                         }];
    }
}

@end
