//
//  UIColor+ScrollColor.m
//  Typendium
//
//  Created by William Robinson on 22/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "UIColor+ScrollColor.h"
#import "UIColor+CustomColors.h"

@implementation UIColor (ScrollColor)
	
	CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
	CGFloat red2 = 0.0, green2 = 0.0, blue2 = 0.0, alpha2 = 0.0;

	float r;
	float g;
	float b;

/**
 *  This function is creating a value between two different values. Should probably only be used between 0 and 1
 *
 *  @param v0 Start value
 *  @param v1 End value
 *  @param t  Percentage between the two values
 *
 *  @return The given percentage between v1 & v1
 */

float lerp(float v0, float v1, float t) {
    
	return v0+(v1-v0)*t;
    
};

/**
 *  <#Description#>
 *
 *  @param controller    Current View Controller, needed to determine which array of colors to use
 *  @param contentOffset Scroll View's content offset for the X axis
 *  @param currentPage   <#currentPage description#>
 *
 *  @return <#return value description#>
 */

+ (UIColor *)determineScrollColor: (UIViewController *)controller contentOffset: (float)contentOffset currentPage:(long)currentPage {

	float viewWidth = controller.view.frame.size.width;
	
	NSArray *array_color = @[[UIColor baskvervilleColor],
							 [UIColor futuraColor],
							 [UIColor gillSansColor],
							 [UIColor palatinoColor],
							 [UIColor timesNewRomanColor],
							 [UIColor comingSoonColor]];
	
	int colorIndex1;
	int colorIndex2;
	
	colorIndex1 = (int)contentOffset / viewWidth;
	colorIndex2 = ((int)contentOffset / viewWidth) + 1;
    
    if (colorIndex1 <= array_color.count && colorIndex2 < array_color.count) {
        
        UIColor *color1 = [array_color objectAtIndex:colorIndex1];
        UIColor *color2 = [array_color objectAtIndex:colorIndex2];
        
        red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
        red2 = 0.0, green2 = 0.0, blue2 = 0.0, alpha2 = 0.0;
        
        [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
        [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
        
        if ((currentPage == 0 && contentOffset > 0) || currentPage > 0) {
			
			float temp = contentOffset;
			
			float t = fmod(temp, viewWidth) / viewWidth;
			
			r = lerp(red1, red2, t);
			g = lerp(green1, green2, t);
			b = lerp(blue1, blue2, t);
		}
    }
	
	if (r == 0 && g == 0 && b == 0) {
		
		return [array_color firstObject];
	}

	return [UIColor colorWithRed:r green:g blue:b alpha:1.0];

}
@end
