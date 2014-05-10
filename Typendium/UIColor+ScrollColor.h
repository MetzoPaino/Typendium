//
//  UIColor+ScrollColor.h
//  Typendium
//
//  Created by William Robinson on 22/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ScrollColor)

+ (UIColor *)determineScrollColor: (UIViewController *)controller controllerName: (NSString *)controllerName contentOffset: (float)contentOffset currentPage: (long)currentPage;

@end
