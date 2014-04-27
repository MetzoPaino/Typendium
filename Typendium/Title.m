//
//  Title.m
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "Title.h"

//@property (nonatomic, strong) NSArray *objectsToShare;

@implementation Title {
    
    NSArray *objectsToShare;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)share:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayUIActivity" object:self];

}

@end
