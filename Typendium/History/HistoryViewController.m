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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    
    int i = 0;
    
    while (i < self.historyPageNames.count) {
        
        UIView *menuPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [menuPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.historyPageNames objectAtIndex:i]]];
        [menuPage addSubview:background];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.center.y, 320, 50)];
        title.text = [self.historyPageNames objectAtIndex:i];
        title.textAlignment = NSTextAlignmentCenter;
        [menuPage addSubview:title];
        
        UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(menuPage.frame.size.width / 2, 400, 44, 15)];
        [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-Black"] forState:UIControlStateNormal];
        [menuPage addSubview:upArrow];
        
        [self.scrollView addSubview:menuPage];
        
        i++;
    }
}

- (void)viewDidLayoutSubviews {
    
    
}

- (NSArray *)historyPageNames {
    
    if (!_historyPageNames) {
        _historyPageNames = [[NSArray alloc] initWithObjects: @"Baskerville", @"Futura", @"GillSans", @"Helvetica", @"Palatino", @"TimesNewRoman", nil];
    }
    
    return _historyPageNames;
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

@end
