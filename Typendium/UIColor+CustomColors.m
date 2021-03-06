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
        gillSansColor = [UIColor colorWithRed:251.0 / 255.0
                                        green:187.0 / 255.0
                                         blue:35.0 / 255.0
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

#pragma mark - Info Section

+ (UIColor *)referencesColor {
    
    static UIColor *referencesColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        referencesColor = [UIColor colorWithRed:166.0 / 255.0
                                          green:185.0 / 255.0
                                           blue:193.0 / 255.0
                                          alpha:1.0];
    });
    
    return referencesColor;
}

+ (UIColor *)aboutUsColor {
    
    static UIColor *aboutUsColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aboutUsColor = [UIColor colorWithRed:37.0 / 255.0
                                        green:170.0 / 255.0
                                         blue:177.0 / 255.0
                                        alpha:1.0];
    });
    
    return aboutUsColor;
}

+ (UIColor *)specialThanksColor {
    
    static UIColor *specialThanksColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        specialThanksColor = [UIColor colorWithRed:90.0 / 255.0
                                       green:144.0 / 255.0
                                        blue:202.0 / 255.0
                                       alpha:1.0];
    });
    
    return specialThanksColor;
}

+ (UIColor *)contactUsColor {
    
    static UIColor *contactUsColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contactUsColor = [UIColor colorWithRed:136.0 / 255.0
                                          green:128.0 / 255.0
                                           blue:170.0 / 255.0
                                          alpha:1.0];
    });
    
    return contactUsColor;
}

+ (UIColor *)reviewColor {
    
    static UIColor *reviewColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reviewColor = [UIColor colorWithRed:60.0 / 255.0
                                       green:86.0 / 255.0
                                        blue:141.0 / 255.0
                                       alpha:1.0];
    });
    
    return reviewColor;
}
@end
