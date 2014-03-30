//
//  TextViewController.m
//  Typendium
//
//  Created by William Robinson on 30/03/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TextViewController.h"
#import "Paragraph.h"
#import "Title.h"
#import "Image.h"
#import "Quote.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *arr_pageLayout;
@property (strong, nonatomic) NSArray *arr_timesNewRoman;

@end

@implementation TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Paragraph *paragraph = [Paragraph new];
    
//    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
//
//    
//    Paragraph * paragraph = [xib objectAtIndex:0];
    
    long itterator = 0;
    long yPosition = 0;
    
    NSLog(@"%@", self.arr_pageLayout);
    
    for (UIView *viewSection in self.arr_pageLayout) {
        
        yPosition += 20;
        
        viewSection.center = CGPointMake(self.view.center.x, yPosition + viewSection.frame.size.height / 2);
        
        [self.scrollView addSubview:viewSection];
        
        yPosition += viewSection.frame.size.height;
        
        itterator++;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             yPosition);
    self.scrollView.showsVerticalScrollIndicator = NO;

}

- (void)viewDidLayoutSubviews {
    
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
//                                             self.scrollView.frame.size.height * self.arr_pageLayout.count);
    //self.scrollView.pagingEnabled = YES;
    
    
//    int i = 0;
//
//    while (i < self.menuPageNames.count) {
//        
//        UIView *menuPage = [[UIView alloc]
//                            initWithFrame:CGRectMake(((self.scrollView.frame.size.width)*i), 0,
//                                                     (self.scrollView.frame.size.width), self.scrollView.frame.size.height)];
//        
//        [menuPage setTag:i];
//        
//        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.menuPageNames objectAtIndex:i]]];
//        [menuPage addSubview:background];
//        
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//        title.center = CGPointMake(self.view.center.x, self.view.frame.size.height - title.frame.size.height / 1.5);
//        title.text = [self.menuPageNames objectAtIndex:i];
//        title.textAlignment = NSTextAlignmentCenter;
//        [menuPage addSubview:title];
//        
//        UIButton *upArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 15)];
//        upArrow.center = CGPointMake(self.view.center.x, self.view.frame.size.height - upArrow.frame.size.height * 0.8);
//        
//        [upArrow setBackgroundImage:[UIImage imageNamed:@"UpArrow-Black"] forState:UIControlStateNormal];
//        [menuPage addSubview:upArrow];
//        
//        
//        [self.scrollView addSubview:menuPage];
//        
//        i++;
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)arr_pageLayout {
    
    if (!_arr_pageLayout) {
        
        _arr_pageLayout = self.arr_timesNewRoman;
    }
    
    return _arr_pageLayout;
}

- (NSArray *)arr_timesNewRoman {
    
    if (!_arr_timesNewRoman) {
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        
        NSArray *xib_paragraph1 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph1 = [xib_paragraph1 objectAtIndex:0];
        
        NSArray *xib_image1 = [[NSBundle mainBundle] loadNibNamed:@"Image" owner:self options:nil];
        
        Image *image1 = [xib_image1 objectAtIndex:0];
        image1.image.image = [UIImage imageNamed:@"StanleyMorison"];
        
        NSArray *xib_paragraph2 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];

        Paragraph *paragraph2 = [xib_paragraph2 objectAtIndex:0];

        NSArray *xib_paragraph3 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph3 = [xib_paragraph3 objectAtIndex:0];

        NSArray *xib_paragraph4 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph4 = [xib_paragraph4 objectAtIndex:0];
        
        NSArray *xib_quote1 = [[NSBundle mainBundle] loadNibNamed:@"Quote" owner:self options:nil];
        
        Paragraph *quote1 = [xib_quote1 objectAtIndex:0];
        
        NSArray *xib_paragraph5 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph5 = [xib_paragraph5 objectAtIndex:0];
        
        _arr_timesNewRoman = [[NSArray alloc] initWithObjects: title, paragraph1, image1, paragraph2, paragraph3, paragraph4, quote1, paragraph5, nil];
    }
    
    return _arr_timesNewRoman;
}

@end
