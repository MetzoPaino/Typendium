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

+ (UIColor *)typendiumLightGray {
    
    static UIColor *typendiumLightGray;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        typendiumLightGray = [UIColor colorWithRed:210.0 / 255.0
                                       green:211.0 / 255.0
                                        blue:214.0 / 255.0
                                       alpha:1.0];
    });
    
    return typendiumLightGray;
}

#pragma mark - Menu Colors
#pragma mark -

+ (UIColor *)historyColor {
    
    static UIColor *historyColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        historyColor = [UIColor colorWithRed:250.0 / 255.0
                                       green:55.0 / 255.0
                                        blue:58.0 / 255.0
                                       alpha:1.0];
    });
    
    
    

    
    
    
    return historyColor;
}

+ (UIColor *)infoColor {
    
    static UIColor *infoColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoColor = [UIColor colorWithRed:24.0 / 255.0
                                       green:125.0 / 255.0
                                        blue:202.0 / 255.0
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
        baskvervilleColor = [UIColor colorWithRed:235.0 / 255.0
                                            green:204.0 / 255.0
                                             blue:174.0 / 255.0
                                            alpha:1.0];
    });
    
    return baskvervilleColor;
}

+ (UIColor *)futuraColor {
    
    static UIColor *futuraColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        futuraColor = [UIColor colorWithRed:224.0 / 255.0
                                      green:32.0 / 255.0
                                       blue:61.0 / 255.0
                                      alpha:1.0];
    });
    
    return futuraColor;
}

+ (UIColor *)gillSansColor {
    
    static UIColor *gillSansColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gillSansColor = [UIColor colorWithRed:254.0 / 255.0
                                        green:185.0 / 255.0
                                         blue:73.0 / 255.0
                                        alpha:1.0];
    });
    
    return gillSansColor;
}

+ (UIColor *)timesNewRomanColor {
    
    static UIColor *timesNewRomanColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timesNewRomanColor = [UIColor colorWithRed:151.0 / 255.0
                                             green:125.0 / 255.0
                                              blue:126.0 / 255.0
                                             alpha:1.0];
    });
    
    return timesNewRomanColor;
}

+ (UIColor *)palatinoColor {
    
    static UIColor *palatinoColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        palatinoColor = [UIColor colorWithRed:254.0 / 255.0
                                        green:114.0 / 255.0
                                         blue:104.0 / 255.0
                                        alpha:1.0];
    });
    
    return palatinoColor;
}

+ (UIColor *)comingSoonColor {
    
    static UIColor *comingSoonColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comingSoonColor = [UIColor colorWithRed:202.0 / 255.0
                                          green:193.0 / 255.0
                                           blue:190.0 / 255.0
                                          alpha:1.0];
    });

    return comingSoonColor;
}
@end
