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
    
   
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.menuPageNames.count;
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];

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

- (void)setCurrentPage: (NSString *)pageName {
    
    MainViewController *main = [[MainViewController alloc]init];
    self.delegate = main;
    
    if ([self.delegate respondsToSelector:@selector(animateContainerUpwards:)]) {
        [self.delegate setCurrentPage:pageName];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    //self.currentPage = page;
    
    
    if (page == 0) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor historyColor];
        [self setCurrentPage:@"History"];
    }
    
    if (page == 1) {
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor infoColor];
        [self setCurrentPage:@"Info"];
    }
    
    self.image.alpha = (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
    
    self.image2.alpha = 1 - (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
    
    if (scrollView.contentOffset.x < 320)
    {
        // Load content 1
    }
    else if (scrollView.contentOffset.x >= 320)
    {
        // Load content 2
    }
}

- (NSArray *)menuPageNames {
    
    if (!_menuPageNames) {
        _menuPageNames = [[NSArray alloc] initWithObjects: @"History", @"Info", nil];
    }
    
    return _menuPageNames;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Adjust scroll view content size, set background colour and turn on paging



// Generate content for our scroll view using the frame height and width as the reference point



@end
