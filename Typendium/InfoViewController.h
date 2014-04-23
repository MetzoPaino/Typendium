//
//  AboutUsViewController.h
//  Typendium
//
//  Created by William Robinson on 31/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveViewsDelegate.h"
#import "DetectCurrentPageDelegate.h"

@interface InfoViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> moveViewsDelegate;

@property (nonatomic, weak) id <DetectCurrentPageDelegate> detectCurrentPageDelegate;

@end
