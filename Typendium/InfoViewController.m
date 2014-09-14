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

@import StoreKit;

@interface InfoViewController () <UIScrollViewDelegate, SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *image_backgroundColor;

@property (strong, nonatomic) NSArray *infoPageNames;

@end

@implementation InfoViewController {
    
    NSString *_string_currentPage;
    BOOL _configuredScrollView;

}

#define upArrowButtonGap 20

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.infoPageNames.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor referencesColor];
    self.pageControl.pageIndicatorTintColor = [UIColor typendiumLightGray];
    
    self.image_backgroundColor.backgroundColor = [UIColor referencesColor];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(whatPageIsThis) name:@"WhatInfoPageIsThis" object:nil];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (_configuredScrollView == NO) {
        _configuredScrollView = YES;
        [self configureScrollView];
    }
}

- (void)configureScrollView {
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.infoPageNames.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    int i = 0;
    
    NSArray *upArrowsArray = @[@"UpArrow-References",
                               @"UpArrow-AboutUs",
                               @"UpArrow-SpecialThanks"];
    
    while (i < self.infoPageNames.count) {
        
        UIView *infoPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [infoPage setTag:i];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        UIImageView *background;
        
        if (screenWidth == 375) {
            
            NSString *iPhone6 = [NSString stringWithFormat:@"%@_iPhone6", [self.infoPageNames objectAtIndex:i]];
            background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iPhone6]];
            
        } else {
            background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.infoPageNames objectAtIndex:i]]];
        }
        
        background.center = CGPointMake(self.view.center.x, self.view.center.y);
        [infoPage addSubview:background];
        
        if (i < 3) {
            
            UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
            upArrow.center = CGPointMake(self.view.center.x,
                                         self.view.frame.size.height - upArrowButtonGap);
            if (self.view.bounds.size.height < 568) {
                upArrow.center = CGPointMake(upArrow.center.x, upArrow.center.y - 88);
            }
            [upArrow setBackgroundImage:[UIImage imageNamed:[upArrowsArray objectAtIndex:i]] forState:UIControlStateNormal];
            [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
            
            [infoPage addSubview:upArrow];
            
        } else if (i == 3) {
            
            float y =  self.pageControl.center.y - self.view.center.y;
            
            UIButton *contactUs = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            contactUs.center = CGPointMake(self.view.center.x, self.view.center.y + (y / 2));
            
            contactUs.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20];
            [contactUs setTitle:@"Contact Us" forState:UIControlStateNormal];
            [contactUs setTitleColor:[UIColor contactUsColor] forState:UIControlStateNormal];
            
            contactUs.layer.borderWidth = 1.0f;
            contactUs.layer.borderColor = [UIColor contactUsColor].CGColor;
            contactUs.layer.cornerRadius = 18.0f;
            
            [contactUs addTarget:self action:@selector(contactUs:) forControlEvents:UIControlEventTouchUpInside];
            
            [infoPage addSubview:contactUs];
            
        } else if (i == 4) {
            
            float y =  self.pageControl.center.y - self.view.center.y;
            
            UIButton *review = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            review.center = CGPointMake(self.view.center.x, self.view.center.y + (y / 2));
            
            review.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20];
            [review setTitle:@"Review Typendium" forState:UIControlStateNormal];
            
            
            [review setTitleColor:[UIColor reviewColor] forState:UIControlStateNormal];
            
            review.layer.borderWidth = 1.0f;
            review.layer.borderColor = [UIColor reviewColor].CGColor;
            review.layer.cornerRadius = 18.0f;
            
            [review addTarget:self action:@selector(review:) forControlEvents:UIControlEventTouchUpInside];
            
            [infoPage addSubview:review];
        }
        
        [self.scrollView addSubview:infoPage];
        
        i++;
    }
    _string_currentPage = [self assignCurrentPage];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.height <= iPhoneHeight480) {
        self.image_backgroundColor.frame = CGRectMake(0,
                                                      0,
                                                      self.image_backgroundColor.frame.size.width,
                                                      screenRect.size.height / 2);
        self.pageControl.center = CGPointMake(self.pageControl.center.x, self.pageControl.center.y - 88);
    }
}

- (NSString *)assignCurrentPage {
    
    NSString *currentPage;
    
    switch (self.pageControl.currentPage) {
        case 0:
            self.pageControl.currentPageIndicatorTintColor = [UIColor referencesColor];
            currentPage = [self.infoPageNames objectAtIndex:0];
            break;
        case 1:
            self.pageControl.currentPageIndicatorTintColor = [UIColor aboutUsColor];
            currentPage = [self.infoPageNames objectAtIndex:1];
            break;
        case 2:
            self.pageControl.currentPageIndicatorTintColor = [UIColor referencesColor];
            currentPage = [self.infoPageNames objectAtIndex:2];
            break;
        case 3:
            self.pageControl.currentPageIndicatorTintColor = [UIColor aboutUsColor];
            currentPage = [self.infoPageNames objectAtIndex:3];
            break;
        case 4:
            self.pageControl.currentPageIndicatorTintColor = [UIColor aboutUsColor];
            currentPage = [self.infoPageNames objectAtIndex:4];
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
        _infoPageNames = @[@"References",
                           @"AboutUs",
                           @"SpecialThanks",
                           @"ContactUs",
                           @"Review"];
    }
    
    return _infoPageNames;
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;    
    
    if (page == 0) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor referencesColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:0]];
        
    }
    
    if (page == 1) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor aboutUsColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:1]];
    }
    
    if (page == 2) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor specialThanksColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:2]];
    }
    
    if (page == 3) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor contactUsColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:3]];
    }
    
    if (page == 4) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor reviewColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"Info"
											  currentPage:[self.infoPageNames objectAtIndex:4]];
    }
    
    self.image_backgroundColor.backgroundColor = [UIColor determineScrollColor:self controllerName:@"Info" contentOffset:scrollView.contentOffset.x currentPage:self.pageControl.currentPage];
}

#pragma mark - Actions

- (IBAction)upArrow:(id)sender {
    
    [self.detectCurrentPageDelegate assignCurrentPage:self
                                       currentSection:@"Info"
                                          currentPage:[self.infoPageNames firstObject]];
        
    [self.moveViewsDelegate animateContainerUpwards:self
                                        currentPage:@"Info"
                                            newPage:@"InfoText"];
}

- (IBAction)contactUs:(id)sender {
    
    NSString *recipients = @"mailto:MetzoPaino@gmail.com?subject=";
    NSString *body = @"&body=";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
}

// TEETHING ID 537689173
// TYPENDIUM ID 769408374

- (IBAction)review:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.com/apps/typendium"]];
    
//    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"537689173" forKey:SKStoreProductParameterITunesItemIdentifier];
//    
//    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
//    productViewController.delegate = self;
//    [productViewController loadProductWithParameters:parameters completionBlock:NULL];
//    [self presentViewController:productViewController animated:YES completion:nil];
    
}

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
