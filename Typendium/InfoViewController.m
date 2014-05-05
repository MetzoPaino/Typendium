//
//  AboutUsViewController.m
//  Typendium
//
//  Created by William Robinson on 31/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "InfoViewController.h"
#import "UIColor+CustomColors.h"
#import "UIColor+ScrollColor.h"

@interface InfoViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *image_backgroundColor;

@property (strong, nonatomic) NSArray *infoPageNames;

@end

@implementation InfoViewController {
    
    NSString *_string_currentPage;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.infoPageNames.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
    self.pageControl.pageIndicatorTintColor = [UIColor typendiumLightGray];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(whatPageIsThis) name:@"WhatInfoPageIsThis" object:nil];
}

- (void)viewDidLayoutSubviews {
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.infoPageNames.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    int i = 0;
    
    while (i < self.infoPageNames.count) {
        
        UIView *infoPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [infoPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.infoPageNames objectAtIndex:i]]];
        background.center = CGPointMake(self.view.center.x, self.view.center.y);
        
        [infoPage addSubview:background];
        
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
        [infoPage addSubview:upArrow];
        
        
        [self.scrollView addSubview:infoPage];
        
        i++;
    }
    

}

- (NSString *)assignCurrentPage {
    
    NSString *currentPage;
    
    switch (self.pageControl.currentPage) {
        case 0:
            self.pageControl.currentPageIndicatorTintColor = [UIColor baskvervilleColor];
            currentPage = [self.infoPageNames objectAtIndex:0];
            break;
        case 1:
            self.pageControl.currentPageIndicatorTintColor = [UIColor futuraColor];
            currentPage = [self.infoPageNames objectAtIndex:1];
            break;
        case 2:
            self.pageControl.currentPageIndicatorTintColor = [UIColor gillSansColor];
            currentPage = [self.infoPageNames objectAtIndex:2];
            break;
        case 3:
            self.pageControl.currentPageIndicatorTintColor = [UIColor palatinoColor];
            currentPage = [self.infoPageNames objectAtIndex:3];
            break;
        case 4:
            self.pageControl.currentPageIndicatorTintColor = [UIColor timesNewRomanColor];
            currentPage = [self.infoPageNames objectAtIndex:4];
            break;
        case 5:
            self.pageControl.currentPageIndicatorTintColor = [UIColor comingSoonColor];
            currentPage = [self.infoPageNames objectAtIndex:5];
            break;
        default:
            break;
    }
    
    return currentPage;
}

#pragma mark - Observer

- (void)whatPageIsThis {
    
    _string_currentPage = [self assignCurrentPage];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Info", @"Section",
                                _string_currentPage, @"Page",
                                nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ThisPage"
                                                        object:self userInfo:dictionary];
}

#pragma mark - Lazy Loading

- (NSArray *)infoPageNames {
    
    if (!_infoPageNames) {
        _infoPageNames = [[NSArray alloc] initWithObjects: @"References", @"AboutUs", nil];
    }
    
    return _infoPageNames;
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;    
    
    if (page == 0) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:0]];
        
    }
    
    if (page == 1) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor infoColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:1]];
    }
    
     self.image_backgroundColor.backgroundColor = [UIColor determineScrollColor:self contentOffset:scrollView.contentOffset.x currentPage:self.pageControl.currentPage];
}

#pragma mark - Action

- (IBAction)upArrow:(id)sender {
    
    if (self.pageControl.currentPage == 0) {
        
        [self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:0]];
        
        [self.moveViewsDelegate animateContainerUpwards:self
                                            currentPage:@"Info"
                                                newPage:@"InfoText"];
        
    }
}

@end
