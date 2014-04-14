//
//  MenuViewController.h
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@protocol currentPageDelegate <NSObject>

- (void)setCurrentPage : (NSString*)viewName;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id <currentPageDelegate> delegate;

@end
