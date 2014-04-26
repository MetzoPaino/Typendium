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

@end

@implementation TextViewController {
    
    NSString *_string_currentPage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(constructPage:) name:@"ConstructPage" object:nil];
    
}

- (void) constructPage:(NSNotification *) notification {
    
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
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - Lazy Loading

- (NSArray *)arr_pageLayout {
    
    if (!_arr_pageLayout) {
        
        TypendiumText *typendiumText = [TypendiumText new];

        if ([_string_currentPage isEqualToString:@"Baskerville"]) {
            
            _arr_pageLayout = typendiumText.arr_baskerville;
            
        } else if ([_string_currentPage isEqualToString:@"Futura"]) {
            
            _arr_pageLayout = typendiumText.arr_futura;

        } else if ([_string_currentPage isEqualToString:@"GillSans"]) {
            
            _arr_pageLayout = typendiumText.arr_gillSans;
            
        } else if ([_string_currentPage isEqualToString:@"Palatino"]) {
            
            _arr_pageLayout = typendiumText.arr_palatino;
            
        } else if ([_string_currentPage isEqualToString:@"TimesNewRoman"]) {
            
            _arr_pageLayout = typendiumText.arr_timesNewRoman;
            
        }
    }
    
    return _arr_pageLayout;
}


@end
