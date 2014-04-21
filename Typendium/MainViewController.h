//
//  ViewController.h
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "MenuViewController.h"
#import "InfoViewController.h"
#import "TutorialViewController.h"

@class MainViewController;

@protocol PlayTutorialDelegate <NSObject>

- (void)playTutorialMovie: (MainViewController *)controller;
- (void)stopTutorialMovie: (MainViewController *)controller;

@end

@interface MainViewController : UIViewController <UpArrowActionDelegate, currentPageDelegate>

@property (nonatomic, weak) id <PlayTutorialDelegate> delegate;

@end
