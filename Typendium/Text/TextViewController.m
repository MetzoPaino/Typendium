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
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *dic_typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        NSDictionary *dic_timesNewRoman = [NSDictionary dictionaryWithDictionary:[dic_typendiumText objectForKey:@"TimesNewRoman"]];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.lbl_title.text = [dic_timesNewRoman objectForKey:@"Title"];

        NSArray *xib_paragraph1 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph1 = [xib_paragraph1 objectAtIndex:0];
        paragraph1.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph1"];
       // [paragraph1.txt_paragraph sizeToFit];
        

        
        
        
        
        
        
        
        
        
        NSArray *xib_image1 = [[NSBundle mainBundle] loadNibNamed:@"Image" owner:self options:nil];
        
        Image *image1 = [xib_image1 objectAtIndex:0];
        image1.image.image = [UIImage imageNamed:@"StanleyMorison"];
        
        NSArray *xib_paragraph2 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];

        Paragraph *paragraph2 = [xib_paragraph2 objectAtIndex:0];
        paragraph2.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph2"];

        NSArray *xib_paragraph3 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph3 = [xib_paragraph3 objectAtIndex:0];
        paragraph3.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph3"];

        NSArray *xib_paragraph4 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph4 = [xib_paragraph4 objectAtIndex:0];
        paragraph4.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph4"];

        NSArray *xib_quote1 = [[NSBundle mainBundle] loadNibNamed:@"Quote" owner:self options:nil];
        
        Quote *quote1 = [xib_quote1 objectAtIndex:0];
        quote1.lbl_quote.text = [dic_timesNewRoman objectForKey:@"Quote1"];
        
        
        
        
        NSArray *xib_paragraph5 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph5 = [xib_paragraph5 objectAtIndex:0];
        paragraph5.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph5"];
  
        
        [paragraph5.txt_paragraph.layoutManager ensureLayoutForTextContainer:paragraph5.txt_paragraph.textContainer];
        [paragraph5.txt_paragraph layoutIfNeeded];
        
        CGRect frame =  paragraph5.txt_paragraph.frame;
        UIEdgeInsets inset =  paragraph5.txt_paragraph.contentInset;
        frame.size.height =  paragraph5.txt_paragraph.contentSize.height * 2 + inset.top + inset.bottom;
         paragraph5.txt_paragraph.frame = frame;
        paragraph5.frame = frame;
        
        [paragraph5 layoutSubviews];
        
        _arr_timesNewRoman = [[NSArray alloc] initWithObjects: title, paragraph1, image1, paragraph2, paragraph3, paragraph4, quote1, paragraph5, nil];
    }
    
    return _arr_timesNewRoman;
}

@end
