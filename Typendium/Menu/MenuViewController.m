//
//  MenuViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+CustomColors.h"
#import "MainViewController.h"

@interface MenuViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (strong, nonatomic) NSArray *menuPageNames;



@end

@implementation MenuViewController {
    
    NSString *_string_currentPage;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.menuPageNames.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
    self.pageControl.pageIndicatorTintColor = [UIColor typendiumLightGray];

    _string_currentPage = [self assignCurrentPage];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(whatPageIsThis) name:@"WhatMenuPageIsThis" object:nil];
}

- (NSString *)assignCurrentPage {
    
    NSString *currentPage;
    
    switch (self.pageControl.currentPage) {
        case 0:
            self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
            currentPage = [self.menuPageNames objectAtIndex:0];
            break;
        case 1:
            self.pageControl.currentPageIndicatorTintColor = [UIColor infoColor];
            currentPage = [self.menuPageNames objectAtIndex:1];
            break;
        default:
            break;
    }
    return currentPage;
}

- (void)viewDidLayoutSubviews {
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.menuPageNames.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    int i = 0;
    
    while (i < self.menuPageNames.count) {
        
        UIView *menuPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [menuPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.menuPageNames objectAtIndex:i]]];
        background.center = CGPointMake(self.view.center.x, self.view.center.y);

        [menuPage addSubview:background];
        
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//        title.center = CGPointMake(self.view.center.x, self.view.frame.size.height - title.frame.size.height * 2);
//        title.text = [self.menuPageNames objectAtIndex:i];
//        title.textAlignment = NSTextAlignmentCenter;
//        title.font = [UIFont systemFontOfSize:28];
//        [menuPage addSubview:title];
        
        UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
        upArrow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - upArrow.frame.size.height * 1.5);
        [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-Red"] forState:UIControlStateNormal];

        } else {
            [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-Blue"] forState:UIControlStateNormal];

        }
        [menuPage addSubview:upArrow];
        
        
        [self.scrollView addSubview:menuPage];
        
        i++;
    }
}

- (void)whatPageIsThis {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Menu", @"Section",
                                _string_currentPage, @"Page",
                                nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ThisPage"
     object:self userInfo:dictionary];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    [self.detectCurrentPageDelegate assignCurrentPage:self
                                       currentSection:@"Menu"
                                          currentPage:[self assignCurrentPage]];
    
//    if (page == 0) {
//        
//        self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
//		[self.detectCurrentPageDelegate assignCurrentPage:self
//										   currentSection:@"Menu"
//											  currentPage:@"History"];
//
//    }
//    
//    if (page == 1) {
//        
//        self.pageControl.currentPageIndicatorTintColor = [UIColor infoColor];
//		[self.detectCurrentPageDelegate assignCurrentPage:self
//										   currentSection:@"Menu"
//											  currentPage:@"Info"];
//    }
    
    self.image.alpha = (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
    
    self.image2.alpha = 1 - (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
}

- (NSArray *)menuPageNames {
    
    if (!_menuPageNames) {
        _menuPageNames = [[NSArray alloc] initWithObjects: @"History", @"Info", nil];
    }
    
    return _menuPageNames;
}

- (IBAction)upArrow:(id)sender {
    
    if (self.pageControl.currentPage == 0) {
        
        [self.moveViewsDelegate animateContainerUpwards:self
                                   currentPage:@"Menu"
                                       newPage:@"History"];
        
    } else {
        
        [self.moveViewsDelegate animateContainerUpwards:self
                                   currentPage:@"Menu"
                                       newPage:@"Info"];
    }
    
    

}

@end
