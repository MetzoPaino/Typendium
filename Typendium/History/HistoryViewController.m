//
//  HistoryViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *historyPageNames;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;

@end

@implementation HistoryViewController {
    

}



#pragma mark - View Controller Configuration

- (void)viewDidLoad {
    
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
        
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//        title.center = CGPointMake(self.view.center.x, self.view.frame.size.height - title.frame.size.height * 2);
//        title.text = [self.historyPageNames objectAtIndex:i];
//        title.textAlignment = NSTextAlignmentCenter;
//        title.font = [UIFont systemFontOfSize:28];
//        [historyPage addSubview:title];
        
        UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
        upArrow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - upArrow.frame.size.height * 2.5);
        [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-White"] forState:UIControlStateNormal];
        [historyPage addSubview:upArrow];
        
        [self.scrollView addSubview:historyPage];
        
        i++;
    }
    self.image4.hidden = YES;
    self.image5.hidden = YES;
    self.image6.hidden = YES;
}

float lerp(float v0, float v1, float t) {
    
	return v0+(v1-v0)*t;
    
};

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIColor *color_baskerville = [UIColor colorWithRed:232/255 green:202/255 blue:164/255 alpha:1];
    UIColor *color_futura = [UIColor colorWithRed:219/255 green:37/255 blue:58/255 alpha:1];
    UIColor *color_gillSans = [UIColor colorWithRed:240/255 green:167/255 blue:72/255 alpha:1];
    UIColor *color_palatino = [UIColor colorWithRed:250/255 green:92/255 blue:90/255 alpha:1];
    UIColor *color_timesNewRoman = [UIColor colorWithRed:251/255 green:130/255 blue:102/255 alpha:1];
    UIColor *color_comingSoon = [UIColor colorWithRed:131/255 green:120/255 blue:120/255 alpha:1];

    NSArray *array_color = [[NSArray alloc] initWithObjects:color_baskerville, color_futura, color_gillSans, color_palatino, color_timesNewRoman, color_comingSoon, nil];

    int colorIndex1 = (int)scrollView.contentOffset.x % 320;
	int colorIndex2 = ((int)scrollView.contentOffset.x % 320) + 1;
    
    NSLog(@"index 1 %d / index 2 %d", colorIndex1, colorIndex2);
    
    if (colorIndex1 <= array_color.count && colorIndex2 <= array_color.count) {
        
        UIColor *color1 = [array_color objectAtIndex:colorIndex1];
        UIColor *color2 = [array_color objectAtIndex:colorIndex2];
        
        CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
        CGFloat red2 = 0.0, green2 = 0.0, blue2 = 0.0, alpha2 = 0.0;
        
       
        
        [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
        [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
        
         NSLog(@"red1 %f / green1 %f", red1, green1);
        
        float temp = scrollView.contentOffset.x;
        
        float t = fmod(temp, 320) / 320;
        
        float r = lerp(red1, red2, t);
        float g = lerp(green1, green2, t);
        float b = lerp(blue1, blue2, t);
        
        self.image1.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    }

    
    
    
    
    



    
    
//    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
//        
//    } else {
//        // < iOS 5
//        const CGFloat *components = CGColorGetComponents(color.CGColor);
//        red = components[0];
//        green = components[1];
//        blue = components[2];
//        alpha = components[3];
//    }
//    
//    // This is a non-RGB color
//    if(CGColorGetNumberOfComponents(color.CGColor) == 2) {
//        CGFloat hue;
//        CGFloat saturation;
//        CGFloat brightness;
//        [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
//        
//    }
    
    
    
    //const CGFloat* colors = CGColorGetComponents( curView.backgroundColor.CGColor );

    
//    
//    self.image1.alpha = (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
//    self.image2.alpha = 1 - (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
//    self.image3.alpha = 2 - (scrollView.contentOffset.x / scrollView.contentSize.width) * 2;
//    
//    
//    NSLog(@"Image 1 %f", self.image1.alpha);
//    NSLog(@"Image 2 %f", self.image2.alpha);
//    NSLog(@"Image 3 %f", self.image3.alpha);
//
//    if (scrollView.contentOffset.x <= 320) {
//        
//        self.image2.alpha = (scrollView.contentOffset.x / 320);
//        self.image1.alpha = 1 - (scrollView.contentOffset.x / 320);
//        self.image3.alpha = 0;
//    }
//    else if (scrollView.contentOffset.x >= 321 && scrollView.contentOffset.x >= 540) {
//        
//        self.image2.alpha = (scrollView.contentOffset.x / 540);
//        self.image3.alpha = 1 - (scrollView.contentOffset.x / 540);
//    }

    
    
//    NSArray *array = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], nil];
//    
//	int colorIndex1 = (int)scrollView.contentOffset.x % 320;
//	
//	int colorIndex2 = ((int)scrollView.contentOffset.x % 320) + 1;
//	
//	UIColor *color1 = [array objectAtIndex:colorIndex1];
//	UIColor *color2 = [array objectAtIndex:colorIndex2];
//    
//	float temp = scrollView.contentOffset.x;
//	
//	float t = fmod(temp, 320) / 320;
//	
//	float r = lerp(color1, color2, t);
//	
//	NSLog(@"%f", t);
//	NSLog(@"%i", colorIndex1);
//	NSLog(@"%i", colorIndex2);

}

- (NSArray *)historyPageNames {
    
    if (!_historyPageNames) {
        _historyPageNames = [[NSArray alloc] initWithObjects: @"Baskerville", @"Futura", @"GillSans", @"Palatino", @"TimesNewRoman", @"ComingSoon", nil];
    }
    
    return _historyPageNames;
}


@end
