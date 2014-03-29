//
//  MenuViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2,
                                             self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    
    int i = 0;
    
    while (i < self.menuPageNames.count) {
        
        UIView *menuPage = [[UIView alloc]
                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
        
        [menuPage setTag:i];
        
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.menuPageNames objectAtIndex:i]]];
        [menuPage addSubview:background];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.center.y, 320, 50)];
        title.text = [self.menuPageNames objectAtIndex:i];
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
