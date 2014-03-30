//
//  HistoryViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *historyPageNames;

@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.historyPageNames.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    int i = 0;
    
    while (i < self.historyPageNames.count) {
        
        UIView *historyPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [historyPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.historyPageNames objectAtIndex:i]]];
        background.center = CGPointMake(self.view.center.x, self.view.center.y);
        [historyPage addSubview:background];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        title.center = CGPointMake(self.view.center.x, self.view.frame.size.height - title.frame.size.height * 2);
        title.text = [self.historyPageNames objectAtIndex:i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:28];
        [historyPage addSubview:title];
        
        UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
        upArrow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - upArrow.frame.size.height * 2.5);
        [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-Black"] forState:UIControlStateNormal];
        [historyPage addSubview:upArrow];
        
        [self.scrollView addSubview:historyPage];
        
        i++;
    }
}

- (NSArray *)historyPageNames {
    
    if (!_historyPageNames) {
        _historyPageNames = [[NSArray alloc] initWithObjects: @"Baskerville", @"Futura", @"GillSans", @"Helvetica", @"Palatino", @"TimesNewRoman", nil];
    }
    
    return _historyPageNames;
}


@end
