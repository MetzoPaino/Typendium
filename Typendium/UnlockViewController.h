//
//  UnlockViewController.h
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveViewsDelegate.h"

@interface UnlockViewController : UIViewController

@property (nonatomic, weak) id <MoveViewsDelegate> delegate;

@end
