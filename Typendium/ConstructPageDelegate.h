//
//  ConstructPageDelegate.h
//  Typendium
//
//  Created by William Robinson on 25/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConstructPageDelegate <NSObject>

- (void)constructPageDelegate: (UIViewController *)controller currentSection: (NSString *)currentSection currentPage: (NSString *)currentPage;

@end
