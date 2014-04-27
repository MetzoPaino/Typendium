//
//  TextViewController.m
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TextViewController.h"
#import "TypendiumText.h"
#import "NSString+ShareText.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *arr_pageLayout;

@property (nonatomic, strong) NSArray *objectsToShare;

@end

@implementation TextViewController {
    
    NSString *_string_currentPage;
    NSString *_string_shareText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(constructPage:) name:@"ConstructPage" object:nil];
    [notificationCenter addObserver:self selector:@selector(displayUIActivity:) name:@"DisplayUIActivity" object:nil];


    
    }

- (void) displayUIActivity:(NSNotification *) notification {
    
    UIActivityViewController *controller = [[UIActivityViewController alloc]
                                            initWithActivityItems:@[_string_shareText]
                                            applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}
- (void) constructPage:(NSNotification *) notification {
    
    for(UIView *subview in [self.scrollView subviews]) {
        
        [subview removeFromSuperview];
    }
    
    NSDictionary* userInfo = notification.userInfo;
    
    _string_currentPage = [userInfo objectForKey:@"Page"];
    
    
    long itterator = 0;
    long yPosition = 0;
    
    for (UIView *viewSection in self.arr_pageLayout) {
        
        if (viewSection.tag == 1) {
            
        } else {
            
            yPosition += 20;
            
        }
        
        
        viewSection.center = CGPointMake(self.view.center.x, yPosition + viewSection.frame.size.height / 2);
        
        [self.scrollView addSubview:viewSection];
        
        yPosition += viewSection.frame.size.height;
        
        itterator++;
    }
    
    UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 62)];
    upArrow.center = CGPointMake(self.view.center.x, yPosition + upArrow.frame.size.height * 2.5);
    [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-History"] forState:UIControlStateNormal];
    [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    
    yPosition += upArrow.frame.size.height * 6;
    
    [self.scrollView addSubview:upArrow];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
  //  if (!_arr_pageLayout) {
        
        TypendiumText *typendiumText = [TypendiumText new];

        if ([_string_currentPage isEqualToString:@"Baskerville"]) {
            
            _arr_pageLayout = typendiumText.arr_baskerville;
            _string_shareText = [NSString baskervilleShareText];
            
        } else if ([_string_currentPage isEqualToString:@"Futura"]) {
            
            _arr_pageLayout = typendiumText.arr_futura;
            _string_shareText = [NSString futuraShareText];

        } else if ([_string_currentPage isEqualToString:@"GillSans"]) {
            
            _arr_pageLayout = typendiumText.arr_gillSans;
            _string_shareText = [NSString gillSansShareText];
            
        } else if ([_string_currentPage isEqualToString:@"Palatino"]) {
            
            _arr_pageLayout = typendiumText.arr_palatino;
            _string_shareText = [NSString palatinoShareText];
            
        } else if ([_string_currentPage isEqualToString:@"TimesNewRoman"]) {
            
            _arr_pageLayout = typendiumText.arr_timesNewRoman;
            _string_shareText = [NSString timesNewRomanShareText];
            
        }
   // }
    
    return _arr_pageLayout;
}

- (IBAction)upArrow:(id)sender {
        
//    [self.moveViewsDelegate animateContainerUpwards:self
//                                        currentPage:@"Text"
//                                            newPage:@"History"];
    
    [UIView animateWithDuration:0.5
                                   delay:0.0
                                 options:UIViewAnimationOptionCurveEaseIn
                              animations:^ {

    self.scrollView.contentOffset = CGPointMake(0, 0);
                              } completion:^(BOOL finished) {
                                 [self.moveViewsDelegate animateContainerUpwards:self
                                        currentPage:@"Text"
                                                                              newPage:@"History"];
                              }];
}



@end
