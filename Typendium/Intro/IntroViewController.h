//
//  IntroViewController.h
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"

@class IntroViewController;

@protocol UpArrowActionDelegate <NSObject>

- (void)animateContainerUpwards: (IntroViewController *)controller currentPage: (NSString *)currentPage newPage: (NSString *)newPage;

@end

@interface IntroViewController : UIViewController //<PlayTutorialDelegate>

@property (nonatomic, weak) id <UpArrowActionDelegate> delegate;

@end
