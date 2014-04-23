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
@property (weak, nonatomic) IBOutlet UIView *con_info;
@property (weak, nonatomic) IBOutlet UIView *con_tutorial;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property (retain, nonatomic) TutorialViewController *leftController;

@end

@implementation MainViewController {
    
    BOOL _hasParallaxStarted;
    
    NSString *_string_currentSection;
	NSString *_string_currentPage;
    
    float _currentViewYPosition;
    float _higherViewYPosition;
    float _lowerViewYPosition;
}

#define ViewOffset 200

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _string_currentSection = @"Intro";
	_string_currentPage = @"History";

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
    self.con_info.center = CGPointMake(self.con_info.center.x, self.view.center.y + ViewOffset);
    self.con_tutorial.center = CGPointMake(self.con_tutorial.center.x, -self.view.frame.size.height/2);
    
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
    
   // NSLog(@"CURRENT PAGE %l", );
    
    if ([_string_currentSection isEqualToString:@"Intro"]) {
        
        currentView = self.con_intro;
        higherView = nil;
        lowerView = self.con_menu;
        
    } else if ([_string_currentSection isEqualToString:@"Menu"]) {
        
        if ([_string_currentPage isEqualToString:@"History"]) {
            
            self.con_history.hidden = NO;
            self.con_info.hidden = YES;

            currentView = self.con_menu;
            higherView = self.con_intro;
            lowerView = self.con_history;
            
        } else {
            
            self.con_history.hidden = YES;
            self.con_info.hidden = NO;
            
            currentView = self.con_menu;
            higherView = self.con_intro;
            lowerView = self.con_info;
        }
 
        
    } else if ([_string_currentSection isEqualToString:@"History"]) {

        currentView = self.con_history;
        higherView = self.con_menu;
        lowerView = nil;
        
    } else if ([_string_currentSection isEqualToString:@"Info"]) {
        
        currentView = self.con_info;
        higherView = self.con_menu;
        lowerView = nil;
        
    } else if  ([_string_currentSection isEqualToString:@"Tutorial"]){
        
        currentView = self.con_tutorial;
        higherView = nil;
        lowerView = self.con_intro;
        
    }
    
    CGPoint panGestureTranslation = [panGestureRecognizer translationInView:self.view];
    float parallaxCoefficient = ViewOffset / self.view.frame.size.height;

    if (_hasParallaxStarted == NO) {
        
        _hasParallaxStarted = YES;
        _currentViewYPosition = currentView.center.y;
        _higherViewYPosition = higherView.center.y;
        _lowerViewYPosition = lowerView.center.y;
        currentView.layer.shadowOpacity = 0.3f;

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
        
        if (![currentView isEqual: self.con_intro] && ![currentView isEqual: self.con_tutorial]) {
            
            higherView.center = CGPointMake(higherView.center.x, _higherViewYPosition + panGestureTranslation.y);
            currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
            
        } else {
            
            gestureContext = @"Don't Move";
        }
    }
    
    //Should have a check because can happen if you gesture on a page that shouldn't move'
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {

        [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];
    }
}

- (void)parallaxToLocation : (UIView*)currentView : (UIView*) higherView : (UIView*)lowerView : (NSString*)gestureContext {
    
    if ([gestureContext isEqualToString:@"Moving Current View Up"] || [gestureContext isEqualToString:@"Up Arrow Pressed"]) {
        
        if (currentView.center.y <= self.view.frame.size.height/2.5 || [gestureContext isEqualToString:@"Up Arrow Pressed"]) {
            
            // current view was high enough that it will be animated off screen
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 lowerView.center = CGPointMake(lowerView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, -self.view.frame.size.height/2);
                             }
                             completion:^(BOOL finished){
                                 
                                 if ([_string_currentSection isEqualToString:@"Intro"]) {
                                     
                                     _string_currentSection = @"Menu";

                                 } else if ([_string_currentSection isEqualToString:@"Menu"]) {
                                     
                                     if ([_string_currentPage isEqualToString:@"History"]) {
                                         
                                         _string_currentSection = @"History";
                                         
                                     } else if ([_string_currentPage isEqualToString:@"Info"]) {
                                         
                                         _string_currentSection = @"Info";
                                     }
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Tutorial"]) {
                                     
                                     _string_currentSection = @"Intro";
                                 }
                                 _hasParallaxStarted = NO;
                                 currentView.layer.shadowOpacity = 0;
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
    } else if ([gestureContext isEqualToString:@"Moving Current View Down"] || [gestureContext isEqualToString:@"Tutorial Button Pressed"] ) {
        
        if (currentView.center.y + currentView.frame.size.height/2 >= self.view.frame.size.height/4 || [gestureContext isEqualToString:@"Tutorial Button Pressed"]) {
            
            // current view was low enough that it will animate off screen & be replaced with a higher view
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 higherView.center = CGPointMake(higherView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, self.view.frame.size.height/2 + ViewOffset);
                             }
                             completion:^(BOOL finished){

                                 if ([_string_currentSection isEqualToString:@"Menu"]) {
                                     
                                     _string_currentSection = @"Intro";
                                     
                                 } else if ([_string_currentSection isEqualToString:@"History"] || [_string_currentSection isEqualToString:@"Info"]) {
                                     
                                     _string_currentSection = @"Menu";
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Intro"]) {
                                     
                                     _string_currentSection = @"Tutorial";
                                     
                                 }
                                  _hasParallaxStarted = NO;
                                 higherView.layer.shadowOpacity = 0;
                             }
             ];
        }
    }
}

//- (void)setCurrentPage:(NSString *)viewName {
////    
////    if (viewName) {
////        _string_currentView = viewName;
////
////    }
////    NSLog(@"%@", _string_currentView);
//}

- (void)animateContainerUpwards:(IntroViewController *)controller currentPage:(NSString *)currentPage newPage:(NSString *)newPage {
    
    NSString *gestureContext;
    UIView *currentView;
    UIView *higherView;
    UIView *lowerView;
    
    if ([currentPage isEqualToString:@"Intro"] && [newPage isEqualToString:@"Menu"]) {
        
        gestureContext = @"Up Arrow Pressed";
        currentView = self.con_intro;
        higherView = nil;
        lowerView = self.con_menu;
    }
    
    if ([currentPage isEqualToString:@"Intro"] && [newPage isEqualToString:@"Tutorial"]) {
        
        gestureContext = @"Tutorial Button Pressed";
        currentView = self.con_intro;
        higherView = self.con_tutorial;
        lowerView = nil;
    }
    
    if ([currentPage isEqualToString:@"Tutorial"] && [newPage isEqualToString:@"Intro"]) {
        
        gestureContext = @"Up Arrow Pressed";
        currentView = self.con_tutorial;
        higherView = nil;
        lowerView = self.con_intro;
    }
    
    if ([currentPage isEqualToString:@"Menu"]) {
        
        gestureContext = @"Up Arrow Pressed";
		
		if ([_string_currentPage isEqualToString:@"History"]) {
			
            self.con_history.hidden = NO;
            self.con_info.hidden = YES;
            
			currentView = self.con_menu;
			higherView = self.con_intro;
			lowerView = self.con_history;
			
		} else if ([_string_currentPage isEqualToString:@"Info"]) {
			
            self.con_history.hidden = YES;
            self.con_info.hidden = NO;
            
			currentView = self.con_menu;
			higherView = self.con_intro;
			lowerView = self.con_info;
		}

    }
    
    [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];
    
}

#pragma mark - Segue
#pragma mark -

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Intro"]) {

        IntroViewController *controller = (IntroViewController *) [segue destinationViewController];
        controller.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"Menu"]) {
        
        MenuViewController *controller = (MenuViewController *) [segue destinationViewController];
        controller.moveViewsDelegate = self;
		controller.detectCurrentPageDelegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"Tutorial"]) {
        
        TutorialViewController *controller = (TutorialViewController *) [segue destinationViewController];
        controller.delegate = self;

    }
    
    if ([segue.identifier isEqualToString:@"History"]) {
        
        HistoryViewController *controller = (HistoryViewController *) [segue destinationViewController];
        controller.moveViewsDelegate = self;
		controller.detectCurrentPageDelegate = self;
        
    }
    
    if ([segue.identifier isEqualToString:@"Info"]) {
        
        InfoViewController *controller = (InfoViewController *) [segue destinationViewController];
        controller.moveViewsDelegate = self;
		controller.detectCurrentPageDelegate = self;
        
    }
}

- (void)assignCurrentPage:(UIViewController *)controller currentSection:(NSString *)currentSection currentPage:(NSString *)currentPage {
	
    _string_currentSection = currentSection;
	_string_currentPage = currentPage;
    
    NSLog(@"%@ %@", _string_currentSection, _string_currentPage);
}

@end
