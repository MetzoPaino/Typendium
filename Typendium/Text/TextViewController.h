//
//  TextViewController.h
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"
#import "MoveViewsDelegate.h"

@interface TextViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> moveViewsDelegate;

@end
