//
//  MoveViewsDelegate.h
//  Typendium
//
//  Created by William Robinson on 21/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoveViewsDelegate <NSObject>

- (void)animateContainerUpwards: (UIViewController *)controller currentPage: (NSString *)currentPage newPage: (NSString *)newPage;

@end
