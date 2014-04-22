//
//  DetectCurrentPageDelegate.h
//  Typendium
//
//  Created by William Robinson on 21/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DetectCurrentPageDelegate <NSObject>

- (void)assignCurrentPage: (UIViewController *)controller currentSection: (NSString *)currentSection currentPage: (NSString *)currentPage;

@end
