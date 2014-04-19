//
//  TextViewController.m
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TextViewController.h"
#import "TypendiumText.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *arr_pageLayout;
@property (strong, nonatomic) NSArray *arr_timesNewRoman;

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    long itterator = 0;
    long yPosition = 0;
    
    for (UIView *viewSection in self.arr_pageLayout) {
        
        yPosition += 20;
        
        viewSection.center = CGPointMake(self.view.center.x, yPosition + viewSection.frame.size.height / 2);
        
        [self.scrollView addSubview:viewSection];
        
        yPosition += viewSection.frame.size.height;
        
        itterator++;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    self.scrollView.showsVerticalScrollIndicator = NO;

}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
    if (!_arr_pageLayout) {
        
        TypendiumText *timesNewRoman = [TypendiumText new];

        _arr_pageLayout = timesNewRoman.arr_timesNewRoman;

    }
    
    return _arr_pageLayout;
}
@end
