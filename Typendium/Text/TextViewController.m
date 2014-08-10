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

@interface TextViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic) NSArray *arr_pageLayout;

@property (nonatomic) NSArray *objectsToShare;

@end

@implementation TextViewController {
    
    NSString *_string_currentPage;
    NSString *_string_shareText;
    NSString *_string_upArrow;
    
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(constructPage:)
                               name:@"ConstructPage"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(displayUIActivity:)
                               name:@"DisplayUIActivity"
                             object:nil];
    
    self.scrollView.bounces = NO;
    
    NSDictionary *dictionary;
    
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"History", @"Section",
                  @"Baskerville", @"Page",
                  nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConstructPage"
                                                        object:self
                                                      userInfo:dictionary];

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.05
                                             target:self
                                           selector:@selector(updateElapsedTimeLabel)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSRunLoopCommonModes];
}

- (void)displayUIActivity:(NSNotification *) notification {
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[_string_shareText]
                                                                             applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypeMessage,
                                         UIActivityTypeMail];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)updateElapsedTimeLabel {
    
   // NSLog(@"Y : %f", self.scrollView.contentOffset.y);
    
    if (self.scrollView.contentOffset.y <= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AtTopOfText" object:self];
        
    } else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotAtTopOfText" object:self];
        
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
        
            yPosition += 20;
            
        }
        
        
        viewSection.center = CGPointMake(self.view.center.x, yPosition + viewSection.frame.size.height / 2);
        

        [self.scrollView addSubview:viewSection];
        
        yPosition += viewSection.frame.size.height;
        
        itterator++;
        
        
    }
    
    UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 71)];
    
    [upArrow setBackgroundImage:[UIImage imageNamed:_string_upArrow] forState:UIControlStateNormal];
    [upArrow addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    
    yPosition += upArrow.frame.size.height * 1;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    upArrow.center = CGPointMake(self.view.center.x,
                                 self.scrollView.contentSize.height - upArrow.center.y);
    [self.scrollView addSubview:upArrow];
    
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
  //  if (!_arr_pageLayout) {
        
        TypendiumText *typendiumText = [TypendiumText new];

        if ([_string_currentPage isEqualToString:@"Baskerville"]) {
            
            _arr_pageLayout = typendiumText.arr_baskerville;
            _string_shareText = [NSString baskervilleShareText];
            _string_upArrow = @"UpArrow-BaskervilleText";
            
        } else if ([_string_currentPage isEqualToString:@"Futura"]) {
            
            _arr_pageLayout = typendiumText.arr_futura;
            _string_shareText = [NSString futuraShareText];
            _string_upArrow = @"UpArrow-FuturaText";

        } else if ([_string_currentPage isEqualToString:@"GillSans"]) {
            
            _arr_pageLayout = typendiumText.arr_gillSans;
            _string_shareText = [NSString gillSansShareText];
            _string_upArrow = @"UpArrow-GillSansText";
            
        } else if ([_string_currentPage isEqualToString:@"Palatino"]) {
            
            _arr_pageLayout = typendiumText.arr_palatino;
            _string_shareText = [NSString palatinoShareText];
            _string_upArrow = @"UpArrow-PalatinoText";
            
        } else if ([_string_currentPage isEqualToString:@"TimesNewRoman"]) {
            
            _arr_pageLayout = typendiumText.arr_timesNewRoman;
            _string_shareText = [NSString timesNewRomanShareText];
            _string_upArrow = @"UpArrow-TimesNewRomanText";
            
   //     }
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
                                                             currentPage:@"Text"
                                                                 newPage:@"History"];
                     }
     ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y == 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AtTopOfText" object:self];
        
    } else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotAtTopOfText" object:self];

    }
}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    
//    NSLog(@"DECELERATING");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotAtTopOfText" object:self];
//}

@end
