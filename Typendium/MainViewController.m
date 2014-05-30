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
@property (weak, nonatomic) IBOutlet UIView *con_tutorial;
@property (weak, nonatomic) IBOutlet UIView *con_unlock;

@property (weak, nonatomic) IBOutlet UIView *con_menu;

@property (weak, nonatomic) IBOutlet UIView *con_history;
@property (weak, nonatomic) IBOutlet UIView *con_text;

@property (weak, nonatomic) IBOutlet UIView *con_info;
@property (weak, nonatomic) IBOutlet UIView *con_infoText;


@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation MainViewController {
    
    BOOL _hasParallaxStarted;
    BOOL _hasConstructedText;
    BOOL _hasConstructedInfoText;
    
    BOOL _isTextContainerAtTop;
    BOOL _isInfoTextContainerAtTop;

    
    NSString *_string_currentSection;
	NSString *_string_currentPage;
    
    float _currentViewYPosition;
    float _higherViewYPosition;
    float _lowerViewYPosition;
    
    UIView *_currentView;
    UIView *_higherView;
    UIView *_lowerView;
  
	UIView *_viewUnderUnlock;

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
    [notificationCenter addObserver:self selector:@selector(atTopOfText:) name:@"NotAtTopOfText" object:nil];
    
    [notificationCenter addObserver:self selector:@selector(atTopOfText:) name:@"AtTopOfInfoText" object:nil];
    [notificationCenter addObserver:self selector:@selector(atTopOfText:) name:@"NotAtTopOfInfoText" object:nil];

}

- (void)viewDidLayoutSubviews {
    
    [self layoutViews];

}

- (void)layoutViews {
    
    // Place views
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.con_intro.frame = screenRect;
    self.con_intro.center = CGPointMake(self.con_intro.center.x, self.view.center.y);
    
    self.con_tutorial.frame = screenRect;
    self.con_tutorial.center = CGPointMake(self.con_tutorial.center.x, -self.view.frame.size.height/2);
    
    self.con_unlock.frame = screenRect;
    self.con_unlock.center = CGPointMake(self.con_unlock.center.x, -self.view.frame.size.height/2);
    
    self.con_menu.frame = screenRect;
    self.con_menu.center = CGPointMake(self.con_intro.center.x, self.view.center.y + ViewOffset);
    
    self.con_history.frame = screenRect;
    self.con_history.center = CGPointMake(self.con_history.center.x, self.view.center.y + ViewOffset);
    
    self.con_text.frame = screenRect;
    self.con_text.center = CGPointMake(self.con_text.center.x, self.view.center.y + ViewOffset);

    self.con_info.frame = screenRect;
    self.con_info.center = CGPointMake(self.con_info.center.x, self.view.center.y + ViewOffset);
    
    self.con_infoText.frame = screenRect;
    self.con_infoText.center = CGPointMake(self.con_infoText.center.x, self.view.center.y + ViewOffset);

    
    // Add shadows to views that need them
    
    NSArray *shadowsArray = @[self.con_tutorial,
                              self.con_unlock,
                              self.con_intro,
                              self.con_menu,
                              self.con_history,
                              self.con_info];
    
    for (UIView *view in shadowsArray) {
        
        view.layer.shadowColor = [[UIColor blackColor] CGColor];
        view.layer.shadowOffset = CGSizeMake(1.0f,1.0f);
        view.layer.shadowOpacity = 0.0f;
        view.layer.shadowRadius = 10.0f;
        view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    }
}

#pragma mark - Observer Messages

- (void) assignThisPage:(NSNotification *) notification {
    
    NSDictionary* userInfo = notification.userInfo;
    
    _string_currentPage = [userInfo objectForKey:@"Page"];
    
}

- (void) atTopOfText:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"AtTopOfText"]) {
        
        _isTextContainerAtTop = YES;

    } else if ([notification.name isEqualToString:@"NotAtTopOfText"]) {
			
        
        _isTextContainerAtTop = NO;
        
    }
    
    if ([notification.name isEqualToString:@"AtTopOfInfoText"]) {
        
        _isInfoTextContainerAtTop = YES;
        
    } else if ([notification.name isEqualToString:@"NotAtTopOfInfoText"]) {
        
        _isInfoTextContainerAtTop = NO;
        
    }
}

#pragma mark - Gesture Recognizer Delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([_string_currentSection isEqualToString:@"Text"] || [_string_currentSection isEqualToString:@"InfoText"]) {
        
        return YES;

    }
    return NO;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    NSString *gestureContext;

    if (!_hasParallaxStarted) {
        
        if ([_string_currentSection isEqualToString:@"Intro"]) {
            
            _currentView = self.con_intro;
            _higherView = nil;
            _lowerView = self.con_menu;
        }
        
        if ([_string_currentSection isEqualToString:@"Menu"]) {
            
            _currentView = self.con_menu;
            _higherView = self.con_intro;
            
            if ([_string_currentPage isEqualToString:@"History"]) {
                
                self.con_history.hidden = NO;
                self.con_text.hidden = NO;
                
                self.con_info.hidden = YES;
                self.con_infoText.hidden = YES;
                
                _lowerView = self.con_history;
                
            } else {
                
                self.con_history.hidden = YES;
                self.con_text.hidden = YES;
                
                self.con_info.hidden = NO;
                self.con_infoText.hidden = NO;
                
                _lowerView = self.con_info;
            }
        }
        
        if ([_string_currentSection isEqualToString:@"History"]) {
            
            if (!_hasConstructedText &&
                ![_string_currentPage isEqualToString:@"ComingSoon"]) {
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
                    
                    [self postTextToConstruct];
                    
                } else if (![_string_currentPage isEqualToString:@"GillSans"] &&
                           ![_string_currentPage isEqualToString:@"Palatino"] &&
                           ![_string_currentPage isEqualToString:@"TimesNewRoman"]) {
                    
                    [self postTextToConstruct];
                }
            }
            
            _currentView = self.con_history;
            _higherView = self.con_menu;
            _lowerView = self.con_text;
            
        }
        
        if  ([_string_currentSection isEqualToString:@"Text"]){
            
            _currentView = self.con_text;
            _higherView = self.con_history;
            _lowerView = nil;
            
        }
        
        if ([_string_currentSection isEqualToString:@"Info"]) {
            
            if (!_hasConstructedInfoText &&
                ![_string_currentPage isEqualToString:@"ContactUs"] &&
                ![_string_currentPage isEqualToString:@"Review"]) {
                
                [self postInfoTextToConstruct];
            }
            
            _currentView = self.con_info;
            _higherView = self.con_menu;
            _lowerView = self.con_infoText;
            
            
        }
        
        if  ([_string_currentSection isEqualToString:@"InfoText"]){
            
            _currentView = self.con_infoText;
            _higherView = self.con_info;
            _lowerView = nil;
            
        }
       
        if  ([_string_currentSection isEqualToString:@"Tutorial"]){
            
            _currentView = self.con_tutorial;
            _higherView = nil;
            _lowerView = self.con_intro;
            
        }
        
        if  ([_string_currentSection isEqualToString:@"Unlock"]){
            
            _currentView = self.con_unlock;
            _higherView = nil;
            _lowerView = _viewUnderUnlock;
            
        }
    }
    
    CGPoint panGestureTranslation = [panGestureRecognizer translationInView:self.view];
    float parallaxCoefficient = ViewOffset / self.view.frame.size.height;

    if (_hasParallaxStarted == NO) {
        
        _hasParallaxStarted = YES;
        _currentViewYPosition = _currentView.center.y;
        _higherViewYPosition = _higherView.center.y;
        _lowerViewYPosition = _lowerView.center.y;
        _currentView.layer.shadowOpacity = 0.3f;

    }
    
    if (panGestureTranslation.y <= 0.0) {
        
        _currentView.layer.shadowOpacity = 0.3f;
        
       gestureContext = @"Moving Current View Up";
        
        if (![_currentView isEqual: self.con_text] &&
            ![_currentView isEqual: self.con_infoText] &&
            ![_string_currentPage isEqualToString:@"ComingSoon"] &&
            ![_string_currentPage isEqualToString:@"ContactUs"] &&
            ![_string_currentPage isEqualToString:@"Review"]) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
                
                _currentView.center = CGPointMake(_currentView.center.x, _currentViewYPosition + panGestureTranslation.y);
                _lowerView.center = CGPointMake(_lowerView.center.x, _lowerViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                
            } else if (![_string_currentPage isEqualToString:@"GillSans"] &&
                       ![_string_currentPage isEqualToString:@"Palatino"] &&
                       ![_string_currentPage isEqualToString:@"TimesNewRoman"]) {
                
                _currentView.center = CGPointMake(_currentView.center.x, _currentViewYPosition + panGestureTranslation.y);
                _lowerView.center = CGPointMake(_lowerView.center.x, _lowerViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
            }


            
        }
        
        _higherView.center = CGPointMake(_higherView.center.x, _higherViewYPosition);
        
        // Check the text view, when moving up and down fast the history page can get stuck
        
    } else {
        
        _higherView.layer.shadowOpacity = 0.3f;
        
        gestureContext = @"Moving Current View Down";
        
        if ([_currentView isEqual: self.con_intro] ||
            [_currentView isEqual: self.con_tutorial] ||
            [_currentView isEqual: self.con_unlock]) {
            
            _currentView.center = CGPointMake(_currentView.center.x, _currentViewYPosition);

        }
        
        if (![_currentView isEqual: self.con_intro] &&
            ![_currentView isEqual: self.con_tutorial] &&
            ![_currentView isEqual: self.con_unlock]) {
            
            if ([_currentView isEqual: self.con_text]) {
                
                if (_isTextContainerAtTop) {
                    
                    _higherView.center = CGPointMake(_higherView.center.x,
                                                     _higherViewYPosition + panGestureTranslation.y);
                    _currentView.center = CGPointMake(_currentView.center.x,
                                                      _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                    _lowerView.center = CGPointMake(_lowerView.center.x,
                                                    _lowerViewYPosition);
                    
                }
            
            } else if ([_currentView isEqual:self.con_infoText]) {
                
                if (_isInfoTextContainerAtTop) {
                    
                    _higherView.center = CGPointMake(_higherView.center.x,
                                                     _higherViewYPosition + panGestureTranslation.y);
                    _currentView.center = CGPointMake(_currentView.center.x,
                                                      _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                    _lowerView.center = CGPointMake(_lowerView.center.x,
                                                    _lowerViewYPosition);
                    
                }
                
            } else {
                
                _higherView.center = CGPointMake(_higherView.center.x,
                                                 _higherViewYPosition + panGestureTranslation.y);
                _currentView.center = CGPointMake(_currentView.center.x,
                                                  _currentViewYPosition + (panGestureTranslation.y * parallaxCoefficient));
                _lowerView.center = CGPointMake(_lowerView.center.x,
                                                _lowerViewYPosition);
            }
            
        } else {
            
            gestureContext = @"Don't Move";
        }
    }
    
    //Should have a check because can happen if you gesture on a page that shouldn't move'
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        if ([_currentView isEqual:self.con_text]) {
            
            if (_isTextContainerAtTop) {
                [self parallaxToLocation :  _currentView : _higherView : _lowerView : gestureContext];

            }
            
        } else if ([_currentView isEqual:self.con_infoText]) {
            
            if (_isInfoTextContainerAtTop) {
                
                [self parallaxToLocation :  _currentView : _higherView : _lowerView : gestureContext];
            }
            
        } else {
            
            [self parallaxToLocation :  _currentView : _higherView : _lowerView : gestureContext];

        }
    }
}

#pragma mark - Parallax To Location

- (void)parallaxToLocation : (UIView*)currentView : (UIView*) higherView : (UIView*)lowerView : (NSString*)gestureContext {
    
    NSLog(@"Start Section: %@ / Start Page: %@", _string_currentSection, _string_currentPage);

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
                                 
                                 if ([_string_currentSection isEqualToString:@"Tutorial"]) {
                                     
                                     _string_currentSection = @"Intro";
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"StopTutorial"
                                                                                         object:self];
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Unlock"]) {
                                   
																	 if (lowerView == self.con_intro) {
																		 
																		 _string_currentSection = @"Intro";
																		 
																	 } else {
																		 
                                     _string_currentSection = @"History";
																	 }
                                   
                                 }  else if ([_string_currentSection isEqualToString:@"Intro"]) {
                                     
                                     _string_currentSection = @"Menu";
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatMenuPageIsThis"
                                                                                         object:self];
                                     

                                 }   else if ([_string_currentSection isEqualToString:@"Menu"]) {
                                     
                                     if ([_string_currentPage isEqualToString:@"History"]) {
                                         
                                         _string_currentSection = @"History";
                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatHistoryPageIsThis"
                                                                                             object:self];
                                         
                                     } else if ([_string_currentPage isEqualToString:@"Info"]) {
                                         
                                         _string_currentSection = @"Info";
                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatInfoPageIsThis"
                                                                                             object:self];
                                     }
                                     
                                 } else if ([_string_currentSection isEqualToString:@"History"]) {
                                     
                                     _string_currentSection = @"Text";
                                     _hasConstructedText = NO;
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Info"]) {
                                     
                                     _string_currentSection = @"InfoText";
                                     _hasConstructedInfoText = NO;

                                 }
                                 
                                 _hasParallaxStarted = NO;
                                 currentView.layer.shadowOpacity = 0;
                                 NSLog(@"Current Section: %@ / Current Page: %@", _string_currentSection, _string_currentPage);

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
                                 NSLog(@"End Section: %@ / End Page: %@", _string_currentSection, _string_currentPage);

                             }
             ];
        }
        
    } else if ([gestureContext isEqualToString:@"Moving Current View Down"] ||
               [gestureContext isEqualToString:@"Tutorial Button Pressed"] ||
               [gestureContext isEqualToString:@"Unlock Button Pressed"] ||
               [gestureContext isEqualToString:@"Text Arrow Pressed"]) {
        
        if (currentView.center.y + currentView.frame.size.height/2 >= self.view.frame.size.height/4 ||
            [gestureContext isEqualToString:@"Tutorial Button Pressed"] ||
            [gestureContext isEqualToString:@"Unlock Button Pressed"]) {
            
            // current view was low enough that it will animate off screen & be replaced with a higher view
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 higherView.center = CGPointMake(higherView.center.x, self.view.frame.size.height/2);
                                 currentView.center = CGPointMake(currentView.center.x, self.view.frame.size.height/2 + ViewOffset);
                             }
                             completion:^(BOOL finished){
                                 
                                 if ([_string_currentSection isEqualToString:@"Intro"] &&
                                     [gestureContext isEqualToString:@"Tutorial Button Pressed"]) {
                                     
                                     _string_currentSection = @"Tutorial";
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"StartTutorial"
                                                                                         object:self];
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Intro"] &&
                                            [gestureContext isEqualToString:@"Unlock Button Pressed"]) {
                                     
                                     _string_currentSection = @"Unlock";
																	 
                                     
                                 } else if ([_string_currentSection isEqualToString:@"Menu"]) {
                                     
                                     _string_currentSection = @"Intro";
                                     
                                     
                                 } else if ([_string_currentSection isEqualToString:@"History"] || [_string_currentSection isEqualToString:@"Info"]) {
                                   
																	 if ([gestureContext isEqualToString:@"Unlock Button Pressed"]) {
																		 _string_currentSection = @"Unlock";
																		 [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatUnlockPageIsThis"
                                                                                         object:self];

																	 } else {
																		 
																		 _string_currentSection = @"Menu";
                                     _hasConstructedText = NO;
                                     _hasConstructedInfoText = NO;
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatMenuPageIsThis"
                                                                                         object:self];
																		 
																	 }

                                     
                                 } else if ([_string_currentSection isEqualToString:@"Text"]) {
                                                                          
                                     _string_currentSection = @"History";
                                     _hasConstructedText = NO;
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatHistoryPageIsThis"
                                                                                         object:self];
                                     
                                 } else if ([_string_currentSection isEqualToString:@"InfoText"]) {
                                     
                                     _string_currentSection = @"Info";
                                     _hasConstructedInfoText = NO;

                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatInfoPageIsThis"
                                                                                         object:self];
                                     
                                 }
                                 
                                  _hasParallaxStarted = NO;
                                 higherView.layer.shadowOpacity = 0;
                                 NSLog(@"End Section: %@ / End Page: %@", _string_currentSection, _string_currentPage);

                             }
             
             ];
        }
    }
    
}

#pragma mark - Assign Views

- (NSArray *)assignViews:(UIView *)currentView higherView:(UIView *)higherView lowerView:(UIView *)lowerView {
    
    NSArray *viewsArray;
    

    
    return viewsArray;
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
    
    if ([currentPage isEqualToString:@"Intro"] && [newPage isEqualToString:@"Unlock"]) {
        
        gestureContext = @"Unlock Button Pressed";
        currentView = self.con_intro;
        higherView = self.con_unlock;
        lowerView = nil;
			_viewUnderUnlock = currentView;
    }
    
    
    if ([currentPage isEqualToString:@"Tutorial"] && [newPage isEqualToString:@"Intro"]) {
        
        gestureContext = @"Up Arrow Pressed";
        currentView = self.con_tutorial;
        higherView = nil;
        lowerView = self.con_intro;
    }
    
    if ([currentPage isEqualToString:@"Unlock"]) {
        
        gestureContext = @"Up Arrow Pressed";
        currentView = self.con_unlock;
        higherView = nil;
        lowerView = _viewUnderUnlock;
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
    
    if ([currentPage isEqualToString:@"History"] && [newPage isEqualToString:@"Text"]) {
        
        gestureContext = @"Up Arrow Pressed";
        
        currentView = self.con_history;
        higherView = self.con_menu;
        lowerView = self.con_text;

        if (!_hasConstructedText) {
            
            [self postTextToConstruct];
        }
    }
    
    if ([currentPage isEqualToString:@"History"] && [newPage isEqualToString:@"Unlock"]) {
        
        gestureContext = @"Unlock Button Pressed";
        currentView = self.con_history;
        higherView = self.con_unlock;
        lowerView = nil;
				_viewUnderUnlock = currentView;
    }
    
    if ([currentPage isEqualToString:@"Text"] && [newPage isEqualToString:@"History"]) {
        
        gestureContext = @"Text Arrow Pressed";
        currentView = self.con_text;
        higherView = self.con_history;
        lowerView = nil;
        
        _hasConstructedText = NO;
    }
    
    if ([currentPage isEqualToString:@"Info"]) {
        
        gestureContext = @"Up Arrow Pressed";
        
        currentView = self.con_info;
        higherView = self.con_menu;
        lowerView = self.con_infoText;
        
        if (!_hasConstructedInfoText) {
            
            [self postInfoTextToConstruct];
        }
    }
    
    if ([currentPage isEqualToString:@"InfoText"] && [newPage isEqualToString:@"Info"]) {
        
        gestureContext = @"Text Arrow Pressed";
        currentView = self.con_infoText;
        higherView = self.con_info;
        lowerView = nil;
        
        _hasConstructedInfoText = NO;
    }
		

    [self parallaxToLocation :  currentView : higherView : lowerView : gestureContext];
}

#pragma mark - Post Text To Construct

- (void)postTextToConstruct {
    
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

- (void)postInfoTextToConstruct {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhatInfoPageIsThis"
                                                        object:self];
    NSDictionary *dictionary;
    
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"Info", @"Section",
                  _string_currentPage, @"Page",
                  nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConstructInfoTextPage"
                                                        object:self userInfo:dictionary];
    
    _hasConstructedInfoText = YES;
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
    
    if ([segue.identifier isEqualToString:@"Unlock"]) {
        
        UnlockViewController *controller = (UnlockViewController *) [segue destinationViewController];
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
    
    if ([segue.identifier isEqualToString:@"InfoText"]) {
        
        InfoTextViewController *controller = (InfoTextViewController *) [segue destinationViewController];
        controller.moveViewsDelegate = self;
        
    }
}

#pragma mark - Assign Current Page Delegate

- (void)assignCurrentPage:(UIViewController *)controller currentSection:(NSString *)currentSection currentPage:(NSString *)currentPage {
	
	_string_currentSection = currentSection;
	_string_currentPage = currentPage;
	
	if ([_string_currentSection isEqualToString:@"Unlock"]) {
		_string_currentPage = @"Unlock";

	}
    
	NSLog(@"%@ %@", _string_currentSection, _string_currentPage);
}

@end
