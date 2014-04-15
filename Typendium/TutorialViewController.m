//
//  TutorialViewController.m
//  Typendium
//
//  Created by William Robinson on 15/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image_tutorial;
@end

@implementation TutorialViewController {
    
    NSMutableArray *_tutorialFrames;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSMutableString *tutorialFrame = [[NSMutableString alloc] initWithFormat: @"TutorialFrame-"];
    
    _tutorialFrames = [[NSMutableArray alloc] init];
    
    for (long l = 0; l < 192; l++) {
        
        NSString *frameNumber = [NSMutableString stringWithFormat:@"TutorialFrames-%04ld", l];
        
        UIImage *frame = [UIImage imageNamed:frameNumber];
        
        [_tutorialFrames addObject:frame];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    UIImageView *tutorialAnimation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tutorialAnimation.animationImages = _tutorialFrames;
    tutorialAnimation.animationDuration = 3;
    
    [self.view addSubview:tutorialAnimation];
    [tutorialAnimation startAnimating];
}

@end
