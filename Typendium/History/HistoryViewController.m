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
    self.pageControl.currentPageIndicatorTintColor = [UIColor baskvervilleColor];
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
        }

        [self.scrollView addSubview:historyPage];
        
        i++;
    }
    _string_currentPage = [self assignCurrentPage];
}

- (NSString *)assignCurrentPage {
    
    NSString *currentPage;
    
    switch (self.pageControl.currentPage) {
        case 0:
        self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
           currentPage = [self.historyPageNames objectAtIndex:0];
            break;
        case 1:
            currentPage = [self.historyPageNames objectAtIndex:1];
            break;
        case 2:
            currentPage = [self.historyPageNames objectAtIndex:2];
            break;
        case 3:
            currentPage = [self.historyPageNames objectAtIndex:3];
            break;
        case 4:
            currentPage = [self.historyPageNames objectAtIndex:4];
            break;
        case 5:
            currentPage = [self.historyPageNames objectAtIndex:5];
            break;
        case 6:
            currentPage = [self.historyPageNames objectAtIndex:6];
            break;
        case 7:
            currentPage = [self.historyPageNames objectAtIndex:7];
            break;
        default:
            break;
    }
    return currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
	
    if (page == 0) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor baskvervilleColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:0]];
    }
    
    if (page == 1) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor futuraColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:1]];
    }
    
    if (page == 2) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor gillSansColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:2]];
    }
    
    if (page == 3) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor palatinoColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:3]];
    }
    
    if (page == 4) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor timesNewRomanColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:4]];
    }
    
    if (page == 5) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor comingSoonColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:5]];
    }
    
    if (page == 6) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:6]];
    }
    
    if (page == 7) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor infoColor];
		[self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:7]];
    }
    
	
	self.image_backgroundColor.backgroundColor = [UIColor determineScrollColor:self contentOffset:scrollView.contentOffset.x currentPage:self.pageControl.currentPage];
	
//	NSArray *array_color = @[[UIColor baskvervilleColor],
//							 [UIColor futuraColor],
//							 [UIColor gillSansColor],
//							 [UIColor palatinoColor],
//							 [UIColor timesNewRomanColor],
//							 [UIColor comingSoonColor]];
//
//	int colorIndex1;
//	int colorIndex2;
//	
//	colorIndex1 = (int)scrollView.contentOffset.x / 320;
//	colorIndex2 = ((int)scrollView.contentOffset.x / 320) + 1;
//    
//    if (colorIndex1 <= array_color.count && colorIndex2 < array_color.count) {
//        
//        UIColor *color1 = [array_color objectAtIndex:colorIndex1];
//        UIColor *color2 = [array_color objectAtIndex:colorIndex2];
//        
//        CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
//        CGFloat red2 = 0.0, green2 = 0.0, blue2 = 0.0, alpha2 = 0.0;
//        
//        [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
//        [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
//        
//        if (self.pageControl.currentPage == 0 && self.scrollView.contentOffset.x > 0) {
//			
//			float temp = scrollView.contentOffset.x;
//			
//			float t = fmod(temp, 320) / 320;
//						
//			float r = lerp(red1, red2, t);
//			float g = lerp(green1, green2, t);
//			float b = lerp(blue1, blue2, t);
//						
//			self.image_backgroundColor.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//			
//		} else if (self.pageControl.currentPage > 0) {
//			
//			float temp = scrollView.contentOffset.x;
//			
//			float t = fmod(temp, 320) / 320;
//						
//			float r = lerp(red1, red2, t);
//			float g = lerp(green1, green2, t);
//			float b = lerp(blue1, blue2, t);
//						
//			self.image_backgroundColor.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//		}
//    }
}

- (NSArray *)historyPageNames {
    
    if (!_historyPageNames) {
        _historyPageNames = [[NSArray alloc] initWithObjects: @"Baskerville", @"Futura", @"GillSans", @"Palatino", @"TimesNewRoman", @"ComingSoon", nil];
    }
    
    return _historyPageNames;
}

- (IBAction)upArrow:(id)sender {
    
    if (self.pageControl.currentPage == 0) {
        
        [self.detectCurrentPageDelegate assignCurrentPage:self
										   currentSection:@"History"
											  currentPage:[self.historyPageNames objectAtIndex:0]];
        
        [self.moveViewsDelegate animateContainerUpwards:self
                                            currentPage:@"History"
                                                newPage:@"Baskerville"];
        
    } else {
        
        [self.moveViewsDelegate animateContainerUpwards:self
                                            currentPage:@"History"
                                                newPage:@"Futura"];
    }
    
    
    
}


@end
