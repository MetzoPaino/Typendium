//
//  IntroViewController.h
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveViewsDelegate.h"

@interface IntroViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> delegate;

@end
