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
                  @"Info", @"Section",
                  @"References", @"Page",
                  nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConstructInfoTextPage" object:self userInfo:dictionary];
    
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

- (void)constructPage:(NSNotification *) notification {
    
    for (UIView *subview in [self.scrollView subviews]) {
        
        [subview removeFromSuperview];
    }
    
    NSDictionary* userInfo = notification.userInfo;
    
    _string_currentPage = [userInfo objectForKey:@"Page"];
    
    
    long itterator = 0;
    long yPosition = 0;
    
    for (UIView *viewSection in self.arr_pageLayout) {
        
        if (viewSection.tag == 1) {
            
        } else {
            
            if ([_string_currentPage isEqualToString:@"References"]) {
                
                if ([viewSection.restorationIdentifier isEqualToString:@"Book"]) {
                    yPosition += 0;
                } else {
                    yPosition += 20;

                }
                
            } else if ([_string_currentPage isEqualToString:@"SpecialThanks"]) {
                
                yPosition += 40;
                
            } else {
                
                yPosition += 20;

            }
            
        }
        
        viewSection.center = CGPointMake(self.view.center.x, yPosition + viewSection.frame.size.height / 2);
        
        
        [self.scrollView addSubview:viewSection];
        
        yPosition += viewSection.frame.size.height;
        
        itterator++;
        
        
    }
    
    UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 71)];
    
    [upArrow setBackgroundImage:[UIImage imageNamed:_string_upArrow] forState:UIControlStateNormal];
    [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if (screenWidth <= 320) {
        
        yPosition += upArrow.frame.size.height * 1.5;

    } else if (screenWidth <= 375) {
        
        yPosition += upArrow.frame.size.height * 2 ;
        
    } else if (screenWidth <= 414) {
        
        yPosition += upArrow.frame.size.height * 2 ;
        
    } else if (screenWidth >= 768) {
        
        yPosition += upArrow.frame.size.height * 5.575;
        
    }
    
//    if (screenWidth >= 375) {
//        yPosition += upArrow.frame.size.height * 2 ;
//
//        
//    } else {
//        
//        yPosition += upArrow.frame.size.height * 1.5;
//
//    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    upArrow.center = CGPointMake(self.view.center.x,
                                 self.scrollView.contentSize.height - upArrow.center.y);
    [self.scrollView addSubview:upArrow];
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
    TypendiumInfoText *typendiumInfoText = [TypendiumInfoText new];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if ([_string_currentPage isEqualToString:@"References"]) {
        
        _arr_pageLayout = typendiumInfoText.arr_references;
        if (screenWidth <= 320) {
            
            _string_upArrow = @"UpArrow-ReferencesText";
            
        } else if (screenWidth <= 375) {
            
            _string_upArrow = @"UpArrow-ReferencesText_iPhone6";
            
        } else {
            
            _string_upArrow = @"UpArrow-ReferencesText";
        }
        
    } else if ([_string_currentPage isEqualToString:@"AboutUs"]) {
        
        _arr_pageLayout = typendiumInfoText.arr_aboutUs;
        if (screenWidth <= 320) {
            
            _string_upArrow = @"UpArrow-AboutUsText";
            
        } else if (screenWidth <= 375) {
            
            _string_upArrow = @"UpArrow-AboutUsText_iPhone6";
            
        } else {
            
            _string_upArrow = @"UpArrow-AboutUsText";
        }
        
    } else if ([_string_currentPage isEqualToString:@"SpecialThanks"]) {

        _arr_pageLayout = typendiumInfoText.arr_specialThanks;
        if (screenWidth <= 320) {
            
            _string_upArrow = @"UpArrow-SpecialThanksText";
            
        } else if (screenWidth <= 375) {
            
            _string_upArrow = @"UpArrow-SpecialThanksText_iPhone6";
            
        } else {
            
            _string_upArrow = @"UpArrow-SpecialThanksText";
        }
        
    }
    
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
