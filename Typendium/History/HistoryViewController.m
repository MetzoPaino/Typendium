//
//  HistoryViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "HistoryViewController.h"
#import "UIColor+CustomColors.h"
#import "UIColor+ScrollColor.h"

@import QuartzCore;

@interface HistoryViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *historyPageNames;

@property (weak, nonatomic) IBOutlet UIImageView *image_backgroundColor;



@end

@implementation HistoryViewController {
    
    NSString *_string_currentPage;
}



#pragma mark - View Controller Configuration

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.historyPageNames.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.pageControl.numberOfPages = self.historyPageNames.count;
    self.pageControl.pageIndicatorTintColor = [UIColor typendiumLightGray];

	self.image_backgroundColor.backgroundColor = [UIColor baskvervilleColor];
	
    int i = 0;
    
    NSArray *upArrowsArray = @[@"UpArrow-Baskerville",
                               @"UpArrow-Futura",
                               @"UpArrow-GillSans",
                               @"UpArrow-Palatino",
                               @"UpArrow-TimesNewRoman"];
    
    while (i < self.historyPageNames.count) {
        
        UIView *historyPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [historyPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.historyPageNames objectAtIndex:i]]];
        background.center = CGPointMake(self.view.center.x, self.view.center.y);
        [historyPage addSubview:background];
        
        if (i < self.historyPageNames.count - 1) {
            
            UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
            upArrow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - upArrow.frame.size.height * 2.5);
            [upArrow setBackgroundImage:[UIImage imageNamed:[upArrowsArray objectAtIndex:i]] forState:UIControlStateNormal];
            [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
            
            [historyPage addSubview:upArrow];
            
        } else {
            
            float y =  self.pageControl.center.y - self.view.center.y;
            
            
            UIButton *suggestATypeface = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180, 35)];
            suggestATypeface.center = CGPointMake(self.view.center.x, self.view.center.y + (y / 2));
            
            [suggestATypeface setTitle:@"Suggest a typeface" forState:UIControlStateNormal];
            [suggestATypeface setTitleColor:[UIColor comingSoonColor] forState:UIControlStateNormal];
            
            suggestATypeface.layer.borderWidth = 1.0f;
            suggestATypeface.layer.borderColor = [UIColor comingSoonColor].CGColor;
            suggestATypeface.layer.cornerRadius = 18.0f;
            
            [suggestATypeface addTarget:self action:@selector(suggestATypeface:) forControlEvents:UIControlEventTouchUpInside];
            
            [historyPage addSubview:suggestATypeface];

        }

        [self.scrollView addSubview:historyPage];
        
        i++;
    }
    _string_currentPage = [self assignCurrentPage];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(whatPageIsThis) name:@"WhatHistoryPageIsThis" object:nil];
}

- (NSString *)assignCurrentPage {
    
    NSString *currentPage;
    
    switch (self.pageControl.currentPage) {
        case 0:
            self.pageControl.currentPageIndicatorTintColor = [UIColor baskvervilleColor];
           currentPage = [self.historyPageNames objectAtIndex:0];
            break;
        case 1:
            self.pageControl.currentPageIndicatorTintColor = [UIColor futuraColor];
            currentPage = [self.historyPageNames objectAtIndex:1];
            break;
        case 2:
            self.pageControl.currentPageIndicatorTintColor = [UIColor gillSansColor];
            currentPage = [self.historyPageNames objectAtIndex:2];
            break;
        case 3:
            self.pageControl.currentPageIndicatorTintColor = [UIColor palatinoColor];
            currentPage = [self.historyPageNames objectAtIndex:3];
            break;
        case 4:
            self.pageControl.currentPageIndicatorTintColor = [UIColor timesNewRomanColor];
            currentPage = [self.historyPageNames objectAtIndex:4];
            break;
        case 5:
            self.pageControl.currentPageIndicatorTintColor = [UIColor comingSoonColor];
            currentPage = [self.historyPageNames objectAtIndex:5];
            break;
        default:
            break;
    }
    
    NSDictionary *dictionary;
    
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"History", @"Section",
                  _string_currentPage, @"Page",
                  nil];

    
    return currentPage;
}

- (void)whatPageIsThis {
    
    _string_currentPage = [self assignCurrentPage];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"History", @"Section",
                  _string_currentPage, @"Page",
                  nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ThisPage"
                                                        object:self userInfo:dictionary];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    [self.detectCurrentPageDelegate assignCurrentPage:self
                                       currentSection:@"History"
                                          currentPage:[self assignCurrentPage]];
    
   // _string_currentPage = [self assignCurrentPage];
    
    [self whatPageIsThis];
    
    self.image_backgroundColor.backgroundColor = [UIColor determineScrollColor:self controllerName:@"History" contentOffset:scrollView.contentOffset.x currentPage:self.pageControl.currentPage];

}

- (NSArray *)historyPageNames {
    
    if (!_historyPageNames) {
        _historyPageNames = [[NSArray alloc] initWithObjects: @"Baskerville", @"Futura", @"GillSans", @"Palatino", @"TimesNewRoman", @"ComingSoon", nil];
    }
    
    return _historyPageNames;
}

- (IBAction)upArrow:(id)sender {
        
    [self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:0]];
        
    [self.moveViewsDelegate animateContainerUpwards:self
                                            currentPage:@"History"
                                                newPage:@"Text"];
    
}

- (IBAction)suggestATypeface:(id)sender {
    
    NSString *recipients = @"mailto:MetzoPaino@gmail.com?subject=I Suggest...";
    NSString *body = @"&body=I think you should add ";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
}



@end
