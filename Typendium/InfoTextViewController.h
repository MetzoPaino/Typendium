//
//  AboutUsViewController.h
//  Typendium
//
//  Created by William Robinson on 01/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveViewsDelegate.h"

@interface InfoTextViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> moveViewsDelegate;

@end
