//
//  UIColor+CustomColors.m
//  Typendium
//
//  Created by robyn nevison on 13/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

#pragma mark - Generic Colors

+ (UIColor *)textColor {
    
    static UIColor *textColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textColor = [UIColor colorWithRed:241.0 / 255.0
                                       green:241.0 / 255.0
                                        blue:241.0 / 255.0
                                       alpha:1.0];
    });
    
    return textColor;
}

#pragma mark - Menu Colors
#pragma mark -

+ (UIColor *)historyColor {
    
    static UIColor *historyColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        historyColor = [UIColor colorWithRed:241.0 / 255.0
                                       green:241.0 / 255.0
                                        blue:241.0 / 255.0
                                       alpha:1.0];
    });
    
    
    

    
    
    
    return historyColor;
}

+ (UIColor *)infoColor {
    
    static UIColor *infoColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoColor = [UIColor colorWithRed:241.0 / 255.0
                                       green:241.0 / 255.0
                                        blue:241.0 / 255.0
                                       alpha:1.0];
    });
    
    return infoColor;
}

#pragma mark - History Colors
#pragma mark -

+ (UIColor *)baskvervilleColor {
    
    static UIColor *baskvervilleColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baskvervilleColor = [UIColor colorWithRed:232.0 / 255.0
                                            green:202.0 / 255.0
                                             blue:164.0 / 255.0
                                            alpha:1.0];
    });
    
    return baskvervilleColor;
}

+ (UIColor *)futuraColor {
    
    static UIColor *futuraColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        futuraColor = [UIColor colorWithRed:219.0 / 255.0
                                      green:37.0 / 255.0
                                       blue:58.0 / 255.0
                                      alpha:1.0];
    });
    
    return futuraColor;
}

+ (UIColor *)gillSansColor {
    
    static UIColor *gillSansColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gillSansColor = [UIColor colorWithRed:240.0 / 255.0
                                        green:167.0 / 255.0
                                         blue:72.0 / 255.0
                                        alpha:1.0];
    });
    
    return gillSansColor;
}

+ (UIColor *)timesNewRomanColor {
    
    static UIColor *timesNewRomanColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timesNewRomanColor = [UIColor colorWithRed:251.0 / 255.0
                                             green:130.0 / 255.0
                                              blue:102.0 / 255.0
                                             alpha:1.0];
    });
    
    return timesNewRomanColor;
}

+ (UIColor *)palatinoColor {
    
    static UIColor *palatinoColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        palatinoColor = [UIColor colorWithRed:251.0 / 255.0
                                        green:130.0 / 255.0
                                         blue:102.0 / 255.0
                                        alpha:1.0];
    });
    
    return palatinoColor;
}

+ (UIColor *)comingSoonColor {
    
    static UIColor *comingSoonColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comingSoonColor = [UIColor colorWithRed:131.0 / 255.0
                                          green:120.0 / 255.0
                                           blue:120.0 / 255.0
                                          alpha:1.0];
    });

    return comingSoonColor;
}
@end
