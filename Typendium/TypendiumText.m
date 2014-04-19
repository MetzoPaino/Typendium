//
//  TimesNewRoman.m
//  Typendium
//
//  Created by William Robinson on 05/04/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TypendiumText.h"
#import "Paragraph.h"
#import "Title.h"
#import "Image.h"
#import "Quote.h"

@implementation TypendiumText

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
         [paragraph1 sizeToFit];
        
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
        
        CGRect frame =  paragraph1.txt_paragraph.frame;
        UIEdgeInsets inset =  paragraph5.txt_paragraph.contentInset;
        [paragraph1.txt_paragraph sizeToFit];

        frame.size.height =  paragraph1.txt_paragraph.contentSize.height;
        paragraph1.txt_paragraph.frame = frame;
        paragraph1.frame = frame;
        paragraph1.txt_paragraph.frame = frame;
        [paragraph1.txt_paragraph constraintsAffectingLayoutForAxis:YES];
        paragraph1.txt_paragraph.backgroundColor = [UIColor orangeColor];
        paragraph1.frame = CGRectMake(0, 0, 320, frame.size.height / 2);
        
        NSLog(@"%@", paragraph5.txt_paragraph.text);
        
        [paragraph5 layoutSubviews];
        
        _arr_timesNewRoman = [[NSArray alloc] initWithObjects: title, paragraph1, image1, paragraph2, paragraph3, paragraph4, quote1, paragraph5, nil];
    }
    
    return _arr_timesNewRoman;
}

- (NSArray *)arr_baskerville {
    
    if (!_arr_baskerville) {
        
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
        
        _arr_baskerville = [[NSArray alloc] initWithObjects: title, nil];
    }
    
    return _arr_baskerville;
}



@end
