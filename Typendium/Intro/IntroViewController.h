//
//  IntroViewController.h
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@protocol UpArrowActionDelegate <NSObject>

- (void)animateContainerUpwards : (NSString*)viewName;

@end

@interface IntroViewController : UIViewController

@property (nonatomic, weak) id <UpArrowActionDelegate> delegate;

-(void)check;
@end
