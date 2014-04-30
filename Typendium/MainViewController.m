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
@property (weak, nonatomic) IBOutlet UIView *con_text;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation MainViewController {
    
    BOOL _hasParallaxStarted;
    BOOL _hasConstructedText;
    BOOL _isTextContainerAtTop;
    
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
	_string_currentPage = @"Intro";
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:self.panGesture];
    self.panGesture.delegate = self;

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(assignThisPage:) name:@"ThisPage" object:nil];
    [notificationCenter addObserver:self selector:@selector(atTopOfText:) name:@"AtTopOfText" object:nil];
    [notificationCenter addObserver:self selector:@selector(notAtTopOfText:) name:@"NotAtTopOfText" object:nil];

}

- (void)viewDidLayoutSubviews {
    
    [self layoutViews];

}

- (void)layoutViews {
    
    self.con_intro.center = CGPointMake(self.con_intro.center.x, self.view.center.y);
    self.con_menu.center = CGPointMake(self.con_intro.center.x, self.view.center.y + ViewOffset);
    self.con_history.center = CGPointMake(self.con_history.center.x, self.view.center.y + ViewOffset);
    self.con_info.center = CGPointMake(self.con_info.center.x, self.view.center.y + ViewOffset);
    self.con_text.center = CGPointMake(self.con_text.center.x, self.view.center.y + ViewOffset);
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
    
}

- (void) assignThisPage:(NSNotification *) notification {
    
    NSDictionary* userInfo = notification.userInfo;
    
    _string_currentPage = [userInfo objectForKey:@"Page"];
    
}

- (void) atTopOfText:(NSNotification *) notification {
    
    _isTextContainerAtTop = YES;
    NSLog(@"AT TOP");
    
}

- (void) notAtTopOfText:(NSNotification *) notification {
    

    _isTextContainerAtTop = NO;
    NSLog(@"NOT AT TOP");
    
}


#pragma mark - Gesture Recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([_string_currentSection isEqualToString:@"Text"]) {
        
        NSLog(@"HELLO HELLO ");
        return YES;

        return _isTextContainerAtTop;

    }
    
    return NO;
}

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
        
        if (!_hasConstructedText && ![_string_currentPage isEqualToString:@"ComingSoon"]) {
            
            [self postTextToConstruct];
        }

        currentView = self.con_history;
        higherView = self.con_menu;
        lowerView = self.con_text;
        
    } else if ([_string_currentSection isEqualToString:@"Info"]) {
        
        currentView = self.con_info;
        higherView = self.con_menu;
        lowerView = nil;
        
    } else if  ([_string_currentSection isEqualToString:@"Tutorial"]){
        
        currentView = self.con_tutorial;
        higherView = nil;
        lowerView = self.con_intro;
        
    } else if  ([_string_currentSection isEqualToString:@"Text"]){
        
        currentView = self.con_text;
        higherView = self.con_history;
        lowerView = nil;
        
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
    NSLog(@"%f", panGestureTranslation.y);
    
    if (panGestureTranslation.y <= 0.0) {
        
       gestureContext = @"Moving Current View Up";
        
        if (![currentView isEqual: self.con_text] && ![_string_currentPage isEqualToString:@"ComingSoon"]) {

            currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + panGestureTranslation.y);
            lowerView.center = CGPointMake(lowerView.center.x, _lowerViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
            
        }
        
        higherView.center = CGPointMake(higherView.center.x, _higherViewYPosition);
//        if (self.con_intro.center.y + self.con_intro.center.y >= self.view.frame.size.height/2) {
//            [UIView animateWithDuration:1 delay: 0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.view layoutIfNeeded];
//                
//            }
//                             completion:^(BOOL finished){
//                             }];
//            
//        }
        
        
        // Check the text view, when moving up and down fast the history page can get stuck
        
    } else {
        
        gestureContext = @"Moving Current View Down";
        
        if ([currentView isEqual:self.con_intro]) {
             NSLog(@"Intro");
        }
        
        if ([currentView isEqual:self.con_tutorial]) {
            NSLog(@"Tutorial");
        }
        
        if ([currentView isEqual: self.con_intro] ||  [currentView isEqual: self.con_tutorial]) {
            
            currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition);

        }
        
        if (![currentView isEqual: self.con_intro] && ![currentView isEqual: self.con_tutorial]) {
            
            NSLog(@"INSIDE");
            
            if ([currentView isEqual: self.con_text]) {
                
                if (_isTextContainerAtTop) {
                    
                    higherView.center = CGPointMake(higherView.center.x, _higherViewYPosition + panGestureTranslation.y);
                    currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                    lowerView.center = CGPointMake(lowerView.center.x, _lowerViewYPosition);
                }
                

                
            } else {
                
                
                higherView.center = CGPointMake(higherView.center.x, _higherViewYPosition + panGestureTranslation.y);
                currentView.center = CGPointMake(currentView.center.x, _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                lowerView.center = CGPointMake(lowerView.center.x, _lowerViewYPosition);
            }
            

            
        } else {
            
            gestureContext = @"Don't Move";
        }
    }
    
    //Should have a check because can happen if you gesture on a page that shouldn't move'
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        if ([currentView isEqual:self.con_text]) {
            
            if (_isTextContainerAtTop) {
                [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];

            }
            
        } else {
            
            [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];

        }

    }
}

#pragma mark - Parallax To Location

/**
 *  Parallax To Location
 *
 *  @param currentView    <#currentView description#>
 *  @param higherView     <#higherView description#>
 *  @param lowerView      <#lowerView description#>
 *  @param gestureContext <#gestureContext description#>
 */

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
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatMenuPageIsThis"
                                                                                         object:self];
                                     

                                 } else if ([_string_currentSection isEqualToString:@"Menu"]) {
                                     
                                     if ([_string_currentPage isEqualToString:@"History"]) {
                                         
                                         _string_currentSection = @"History";
                                         
                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatHistoryPageIsThis"
                                                                                             object:self];
                                         
                                     } else if ([_string_currentPage isEqualToString:@"Info"]) {
                                         
                                         _string_currentSection = @"Info";
                                     }
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Tutorial"]) {
                                     
                                     _string_currentSection = @"Intro";
                                     
                                 } else if ([_string_currentSection isEqualToString:@"History"]) {
                                     
                                     _string_currentSection = @"Text";
                                     
                                     
                                     
                                     _hasConstructedText = NO;
                                     
                                 }
                                 
                                 _hasParallaxStarted = NO;
                                // currentView.layer.shadowOpacity = 0;
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
    } else if ([gestureContext isEqualToString:@"Moving Current View Down"] || [gestureContext isEqualToString:@"Tutorial Button Pressed"] || [gestureContext isEqualToString:@"Text Arrow Pressed"]) {
        
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
                                     
                                     _hasConstructedText = NO;
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatMenuPageIsThis"
                                                                                         object:self];
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Intro"]) {
                                     
                                     _string_currentSection = @"Tutorial";
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Text"]) {
                                     
                                     NSLog(@"HERE!!!!!");
                                     
                                     _string_currentSection = @"History";
                                     
                                     _hasConstructedText = NO;
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatHistoryPageIsThis"
                                                                                         object:self];
                                     
                                 }
                                 
                                  _hasParallaxStarted = NO;
                                 higherView.layer.shadowOpacity = 0;
                             }
             ];
        }
    }
    NSLog(@"Current Section: %@ / Current Page: %@", _string_currentSection, _string_currentPage);
}

#pragma mark - Animate Container Delegate

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
    
    if ([currentPage isEqualToString:@"History"]) {
        
        gestureContext = @"Up Arrow Pressed";
        
        currentView = self.con_history;
        higherView = self.con_menu;
        lowerView = self.con_text;

        if (!_hasConstructedText) {
            
            [self postTextToConstruct];
        }
    }
    
    if ([currentPage isEqualToString:@"Text"] && [newPage isEqualToString:@"History"]) {
        
        gestureContext = @"Text Arrow Pressed";
        currentView = self.con_text;
        higherView = self.con_history;
        lowerView = nil;
        
        _hasConstructedText = NO;
    }
    
    [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];
    

}

#pragma mark - Post Text To Construct

- (void) postTextToConstruct {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatHistoryPageIsThis"
                                                        object:self];
    NSDictionary *dictionary;
    
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      @"History", @"Section",
                      _string_currentPage, @"Page",
                      nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ConstructPage"
     object:self userInfo:dictionary];
    
    _hasConstructedText = YES;
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
    
    if ([segue.identifier isEqualToString:@"Text"]) {
        
        TextViewController *controller = (TextViewController *) [segue destinationViewController];
        controller.moveViewsDelegate = self;
        
    }
}

#pragma mark - Assign Current Page Delegate

- (void)assignCurrentPage:(UIViewController *)controller currentSection:(NSString *)currentSection currentPage:(NSString *)currentPage {
	
    _string_currentSection = currentSection;
	_string_currentPage = currentPage;
    
    NSLog(@"%@ %@", _string_currentSection, _string_currentPage);
}

@end
