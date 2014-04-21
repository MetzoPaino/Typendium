//
//  TutorialViewController.h
//  Typendium
//
//  Created by William Robinson on 15/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveViewsDelegate.h"

//@class IntroViewController;
//
//@protocol UpArrowActionDelegate <NSObject>
//
//- (void)animateContainerUpwards: (TutorialViewController *)controller currentPage: (NSString *)currentPage newPage: (NSString *)newPage;
//
//@end

@interface TutorialViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> delegate;

@end
