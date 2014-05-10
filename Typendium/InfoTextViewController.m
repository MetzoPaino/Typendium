//
//  AboutUsViewController.m
//  Typendium
//
//  Created by William Robinson on 01/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "InfoTextViewController.h"
#import "TypendiumInfoText.h"

@interface InfoTextViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic) NSArray *arr_pageLayout;

@end

@implementation InfoTextViewController {
    
    NSString *_string_currentPage;
    NSString *_string_shareText;
    NSString *_string_upArrow;
    
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(constructPage:) name:@"ConstructInfoTextPage" object:nil];
    
    self.scrollView.bounces = NO;
    
    NSDictionary *dictionary;
    
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"History", @"Section",
                  @"References", @"Page",
                  nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConstructInfoTextPage"
     object:self userInfo:dictionary];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.05
                                             target:self
                                           selector:@selector(checkIfAtTopTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSRunLoopCommonModes];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             3000);
}

- (void)checkIfAtTopTimer {
    
    if (self.scrollView.contentOffset.y <= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AtTopOfInfoText" object:self];
        
    } else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotAtTopOfInfoText" object:self];
        
    }
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
    
    UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    upArrow.center = CGPointMake(self.view.center.x, yPosition + upArrow.frame.size.height * 2.5);
    
    [upArrow setBackgroundImage:[UIImage imageNamed:_string_upArrow] forState:UIControlStateNormal];
    [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    
    upArrow.backgroundColor = [UIColor orangeColor];
    yPosition += upArrow.frame.size.height * 6;
    
    [self.scrollView addSubview:upArrow];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
    TypendiumInfoText *typendiumInfoText = [TypendiumInfoText new];
    
    if ([_string_currentPage isEqualToString:@"References"]) {
        
        _arr_pageLayout = typendiumInfoText.arr_references;
//        _string_shareText = [NSString baskervilleShareText];
        _string_upArrow = @"UpArrow-BaskervilleText";
        
    } else if ([_string_currentPage isEqualToString:@"AboutUs"]) {
        
        _arr_pageLayout = typendiumInfoText.arr_aboutUs;
        //_string_shareText = [NSString futuraShareText];
        _string_upArrow = @"UpArrow-FuturaText";
        
    }// else if ([_string_currentPage isEqualToString:@"GillSans"]) {
//
//        _arr_pageLayout = typendiumText.arr_gillSans;
//        _string_shareText = [NSString gillSansShareText];
//        _string_upArrow = @"UpArrow-GillSansText";
//        
//    } else if ([_string_currentPage isEqualToString:@"Palatino"]) {
//        
//        _arr_pageLayout = typendiumText.arr_palatino;
//        _string_shareText = [NSString palatinoShareText];
//        _string_upArrow = @"UpArrow-PalatinoText";
//        
//    } else if ([_string_currentPage isEqualToString:@"TimesNewRoman"]) {
//        
//        _arr_pageLayout = typendiumText.arr_timesNewRoman;
//        _string_shareText = [NSString timesNewRomanShareText];
//        _string_upArrow = @"UpArrow-TimesNewRomanText";
//        
//        //     }
//    }
    
    return _arr_pageLayout;
}

- (IBAction)upArrow:(id)sender {
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         
                         self.scrollView.contentOffset = CGPointMake(0, 0);
                         
                     } completion:^(BOOL finished) {
                         
                         [self.moveViewsDelegate animateContainerUpwards:self
                                                             currentPage:@"InfoText"
                                                                 newPage:@"Info"];
                     }
     ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y == 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AtTopOfInfoText" object:self];
        
    } else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotAtTopOfInfoText" object:self];
        
    }
}

@end
