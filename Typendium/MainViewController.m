//
//  ViewController.m
//  Typendium
//
//  Created by William Robinson on 29/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () 

@property (weak, nonatomic) IBOutlet UIView *con_intro;
@property (weak, nonatomic) IBOutlet UIView *con_menu;





@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.intro.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    //UINavigationController *navigationController = segue.destinationViewController;
    // 2
    //IntroViewController *controller = [IntroViewController new];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    TPPolicyMasterViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"WealthPlatformPolicy"];
    
    
    IntroViewController *i = [[IntroViewController alloc]init];
    i.delegate=self;
    [i setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)animateContainerUpwards:(NSString *)viewName {
    
    NSLog(@"OLD %f", self.con_intro.center.y);
    
       self.con_intro.alpha = 0.6;
    self.con_intro.backgroundColor = [UIColor redColor];
    
    if ([viewName isEqualToString:@"Intro"]) {
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.con_intro.center = CGPointMake(self.con_intro.center.x, 200);
                             
                             self.con_intro.frame = CGRectMake(0, 0, 200, 200);
                             self.con_intro.alpha = 0.6;
                             
//                             belowView.center = CGPointMake(belowView.center.x, self.view.frame.size.height/2 + offset);
                         }
                         completion:^(BOOL finished){
                             self.con_intro.hidden = YES;
                             [self.con_intro layoutIfNeeded];
                             [self.view layoutIfNeeded];
                             NSLog(@"BANG %f", self.con_intro.center.y);
                         }];
    }
}

@end
