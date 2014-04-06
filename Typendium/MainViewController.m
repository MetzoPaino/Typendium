//
//  ViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "MainViewController.h"
@class Quartz;

@interface MainViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *con_intro;
@property (weak, nonatomic) IBOutlet UIView *con_menu;
@property (weak, nonatomic) IBOutlet UIView *con_history;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation MainViewController {
    
    BOOL _hasParallaxStarted;
    NSString *_string_currentView;
    float _currentViewYPosition;
    float _higherViewYPosition;
    float _lowerViewYPosition;
}

#define ViewOffset 200

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _string_currentView = @"Intro";
    
    
    
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

}

- (void)layoutViews {
    
    self.con_intro.center = CGPointMake(self.con_intro.center.x, self.view.center.y);
    self.con_menu.center = CGPointMake(self.con_intro.center.x, self.view.center.y + ViewOffset);
    self.con_history.center = CGPointMake(self.con_history.center.x, self.view.center.y + ViewOffset);

    
    
    self.con_intro.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.con_intro.layer.shadowOffset = CGSizeMake(1.0f,1.0f);
    self.con_intro.layer.shadowOpacity = .3f;
    self.con_intro.layer.shadowRadius = 10.0f;
    self.con_intro.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.con_intro.bounds].CGPath;
    
    self.con_menu.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.con_menu.layer.shadowOffset = CGSizeMake(1.0f,1.0f);
    self.con_menu.layer.shadowOpacity = .3f;
    self.con_menu.layer.shadowRadius = 10.0f;
    self.con_menu.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.con_intro.bounds].CGPath;
    
//    anatomy.center = CGPointMake(anatomy.center.x, self.view.frame.size.height/2 + offset);
//    specimens.center = CGPointMake(specimens.center.x, self.view.frame.size.height/2 + offset);
//    history.center = CGPointMake(history.center.x, self.view.frame.size.height/2 + offset);
//    menu.center = CGPointMake(menu.center.x, self.view.frame.size.height/2 + offset);
//    info.center = CGPointMake(info.center.x, self.view.frame.size.height/2 + offset);
}

#pragma mark - Gesture Recognizer

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    NSString *gestureContext;
    UIView *currentView;
    UIView *higherView;
    UIView *lowerView;

    
    if ([_string_currentView isEqualToString:@"Intro"]) {
        currentView = self.con_intro;
        higherView = nil;
        lowerView = self.con_menu;
        
    } else if ([_string_currentView isEqualToString:@"Menu"]) {
        
        currentView = self.con_menu;
        higherView = self.con_intro;
        lowerView = self.con_history;
        
    } else if ([_string_currentView isEqualToString:@"History"]) {
        
        currentView = self.con_history;
        higherView = self.con_menu;
        lowerView = nil;
    }
    
    CGPoint panGestureTranslation = [panGestureRecognizer translationInView:self.view];
    float parallaxCoefficient = ViewOffset / self.view.frame.size.height;

    if (_hasParallaxStarted == NO) {
        
        _hasParallaxStarted = YES;
        _currentViewYPosition = currentView.center.y;
        _higherViewYPosition = higherView.center.y;
        _lowerViewYPosition = lowerView.center.y;

    }
    
    // NEED THIS INFORMATION AT BEGINING OF MOVEMENT, THEN STATIC UNTIL LET GO
//    float introViewYStart = 284;
//    float menuViewYStart = 484;
    
    
    if (panGestureTranslation.y <= 0.0) {
        
       gestureContext = @"Moving Current View Up";
        
        if (![currentView isEqual: self.con_history]) {

            currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + panGestureTranslation.y);
            lowerView.center = CGPointMake(lowerView.center.x, _lowerViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
        }

        
        
        if (self.con_intro.center.y + self.con_intro.center.y >= self.view.frame.size.height/2) {
            [UIView animateWithDuration:1 delay: 0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.view layoutIfNeeded];
                
            }
                             completion:^(BOOL finished){
                             }];
            
        }
        
    } else {
        
        gestureContext = @"Moving Current View Down";
        
        if (![currentView isEqual: self.con_intro]) {
            
            higherView.center = CGPointMake(higherView.center.x, _higherViewYPosition + panGestureTranslation.y);
            currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
        }
        
        
    }
    
    //Should have a check because can happen if you gesture on a page that shouldn't move'
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {

        [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];
    }
}

- (void)parallaxToLocation : (UIView*)currentView : (UIView*) higherView : (UIView*)lowerView : (NSString*)gestureContext {
    
    if ([gestureContext isEqualToString:@"Moving Current View Up"]) {
        
        if (currentView.center.y <= self.view.frame.size.height/2.5) {
            
            // current view was high enough that it will be animated off screen
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 lowerView.center = CGPointMake(lowerView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, -self.view.frame.size.height/2);
                             }
                             completion:^(BOOL finished){
                                 
                                 if ([_string_currentView isEqualToString:@"Intro"]) {
                                     
                                     _string_currentView = @"Menu";

                                 } else if ([_string_currentView isEqualToString:@"Menu"]) {
                                     
                                     _string_currentView = @"History";
                                 }
                                 _hasParallaxStarted = NO;
                             }
             ];
            
        } else {
            
            // current view was not high enough so it will be animated to original position
            
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 currentView.center = CGPointMake(currentView.center.x, self.view.frame.size.height/2);
                                 lowerView.center = CGPointMake(lowerView.center.x, self.view.frame.size.height/2 + ViewOffset);
                             }
                             completion:^(BOOL finished){
                                 
                                 _hasParallaxStarted = NO;
                                 
                             }];
        }
    } else {
        
        if (currentView.center.y + currentView.frame.size.height/2 >= self.view.frame.size.height/4) {
            
            // current view was low enough that it will animate off screen & be replaced with a higher view
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 higherView.center = CGPointMake(higherView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, self.view.frame.size.height/2 + ViewOffset);
                             }
                             completion:^(BOOL finished){

                                 if ([_string_currentView isEqualToString:@"Menu"]) {
                                     
                                     _string_currentView = @"Intro";
                                     
                                 } else if ([_string_currentView isEqualToString:@"History"]) {
                                     
                                     _string_currentView = @"Menu";
                                 }

                                  _hasParallaxStarted = NO;
                             }
             ];
        }
    }
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
                             
                             //self.test.center = CGPointMake(self.test.center.x, 200);
                             
                             
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
