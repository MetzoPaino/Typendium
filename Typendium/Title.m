//
//  Title.m
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "Title.h"

@implementation Title {
    
    NSArray *objectsToShare;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}

- (IBAction)share:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayUIActivity" object:self];

}

@end
