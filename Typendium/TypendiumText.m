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
#import "Caption.h"
#import "Quote.h"

@implementation TypendiumText {
    
    NSDictionary *_typendiumText;
}

- (NSDictionary *)typendiumText : (NSString *)section {
    
    if (!_typendiumText) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        _typendiumText = [NSDictionary dictionaryWithDictionary:[typendiumText objectForKey:section]];
    }
    return _typendiumText;
}

#pragma mark - Configure Page Sections

- (Paragraph *)configureParagraph :(Paragraph *)paragraph :(NSString *)key {
    
    CGRect frame;

    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
    paragraph = [xib_paragraph objectAtIndex:0];
    
    paragraph.txt_paragraph.text = [_typendiumText objectForKey:key];
    [paragraph.txt_paragraph sizeToFit];
    frame =  paragraph.txt_paragraph.frame;
    paragraph.frame = frame;
    
    return paragraph;
}

- (Caption *)configureCaption :(Caption *)caption :(NSString *)key {
    
    CGRect frame;
    NSArray *xib_caption = [[NSBundle mainBundle] loadNibNamed:@"Caption" owner:self options:nil];
    
    caption = [xib_caption objectAtIndex:0];
    caption.lbl_caption.text = [_typendiumText objectForKey:@"Caption1"];
    [caption.lbl_caption sizeToFit];
    frame =   caption.lbl_caption.frame;
    caption.frame = frame;
    
    return caption;
}

- (Quote *)configureQuote :(Quote *)quote :(NSString *)key {
    
    CGRect frame;
    NSArray *xib_quote = [[NSBundle mainBundle] loadNibNamed:@"Quote" owner:self options:nil];

    quote = [xib_quote objectAtIndex:0];
    quote.lbl_quote.text = [_typendiumText objectForKey:@"Quote1"];
    [quote.lbl_quote sizeToFit];
    frame =   quote.lbl_quote.frame;
    quote.frame = frame;
    
    return quote;
}

#pragma mark - Baskerville

- (NSArray *)arr_baskerville {
    
    if (!_arr_baskerville) {
        
        [self typendiumText:@"Baskerville"];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"BaskervilleHeader"];
        
        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        NSArray *xib_image1 = [[NSBundle mainBundle] loadNibNamed:@"Image" owner:self options:nil];
        
        Image *image1 = [xib_image1 objectAtIndex:0];
        image1.image.image = [UIImage imageNamed:@"JohnBaskerville"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph1 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph1 :@"Paragraph3"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph1 :@"Paragraph4"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph1 :@"Paragraph5"];
        
        _arr_baskerville = @[title,
                             paragraph1,
                             image1,
                             caption1,
                             paragraph2,
                             paragraph3,
                             paragraph4,
                             quote1,
                             paragraph5];
    }
    
    return _arr_baskerville;
}

#pragma mark - Futura

- (NSArray *)arr_futura {
    
    if (!_arr_futura) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *dic_typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        NSDictionary *dic_timesNewRoman = [NSDictionary dictionaryWithDictionary:[dic_typendiumText objectForKey:@"TimesNewRoman"]];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"FuturaHeader"];
        
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
        
        _arr_futura = [[NSArray alloc] initWithObjects: title, nil];
    }
    
    return _arr_futura;
}

#pragma mark - Gill Sans

- (NSArray *)arr_gillSans {
    
    if (!_arr_gillSans) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *dic_typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        NSDictionary *dic_timesNewRoman = [NSDictionary dictionaryWithDictionary:[dic_typendiumText objectForKey:@"TimesNewRoman"]];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"GillSansHeader"];
        
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
        
        _arr_gillSans = [[NSArray alloc] initWithObjects: title, nil];
    }
    
    return _arr_gillSans;
}

#pragma mark - Palatino

- (NSArray *)arr_palatino {
    
    if (!_arr_palatino) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *dic_typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        NSDictionary *dic_timesNewRoman = [NSDictionary dictionaryWithDictionary:[dic_typendiumText objectForKey:@"TimesNewRoman"]];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"PalatinoHeader"];
        
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
        
        _arr_palatino = [[NSArray alloc] initWithObjects: title, nil];
    }
    
    return _arr_palatino;
}

#pragma mark - Times New Roman

- (NSArray *)arr_timesNewRoman {
    
    if (!_arr_timesNewRoman) {
        
        CGRect frame;
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *dic_typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumText"]];
        NSDictionary *dic_timesNewRoman = [NSDictionary dictionaryWithDictionary:[dic_typendiumText objectForKey:@"TimesNewRoman"]];
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"TimesNewRomanHeader"];
        
        NSArray *xib_paragraph1 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph1 = [xib_paragraph1 objectAtIndex:0];
        paragraph1.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph1"];
        [paragraph1.txt_paragraph sizeToFit];
        frame =  paragraph1.txt_paragraph.frame;
        paragraph1.frame = frame;
        
        NSArray *xib_image1 = [[NSBundle mainBundle] loadNibNamed:@"Image" owner:self options:nil];
        
        Image *image1 = [xib_image1 objectAtIndex:0];
        image1.image.image = [UIImage imageNamed:@"StanleyMorison"];
        
        NSArray *xib_caption1 = [[NSBundle mainBundle] loadNibNamed:@"Caption" owner:self options:nil];
        
        Caption *caption1 = [xib_caption1 objectAtIndex:0];
        caption1.lbl_caption.text = [dic_timesNewRoman objectForKey:@"Caption1"];
        [caption1.lbl_caption sizeToFit];
        frame =   caption1.lbl_caption.frame;
        caption1.frame = frame;

        NSArray *xib_paragraph2 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph2 = [xib_paragraph2 objectAtIndex:0];
        paragraph2.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph2"];
        [paragraph2.txt_paragraph sizeToFit];
        frame =  paragraph2.txt_paragraph.frame;
        paragraph2.frame = frame;
        
        NSArray *xib_paragraph3 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph3 = [xib_paragraph3 objectAtIndex:0];
        paragraph3.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph3"];
        [paragraph3.txt_paragraph sizeToFit];
        frame =  paragraph3.txt_paragraph.frame;
        paragraph3.frame = frame;
        
        NSArray *xib_paragraph4 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph4 = [xib_paragraph4 objectAtIndex:0];
        paragraph4.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph4"];
        [paragraph4.txt_paragraph sizeToFit];
        frame =  paragraph4.txt_paragraph.frame;
        paragraph4.frame = frame;
        
        NSArray *xib_quote1 = [[NSBundle mainBundle] loadNibNamed:@"Quote" owner:self options:nil];
        
        Quote *quote1 = [xib_quote1 objectAtIndex:0];
        quote1.lbl_quote.text = [dic_timesNewRoman objectForKey:@"Quote1"];
        [quote1.lbl_quote sizeToFit];
        frame =   quote1.lbl_quote.frame;
        quote1.frame = frame;
        
        NSArray *xib_paragraph5 = [[NSBundle mainBundle] loadNibNamed:@"Paragraph" owner:self options:nil];
        
        Paragraph *paragraph5 = [xib_paragraph5 objectAtIndex:0];
        paragraph5.txt_paragraph.text = [dic_timesNewRoman objectForKey:@"Paragraph5"];
        [paragraph5.txt_paragraph sizeToFit];
        frame =  paragraph5.txt_paragraph.frame;
        paragraph5.frame = frame;
        
        _arr_timesNewRoman = [[NSArray alloc] initWithObjects: title, paragraph1, image1, caption1, paragraph2, paragraph3, paragraph4, quote1, paragraph5, nil];
    }
    
    return _arr_timesNewRoman;
}





@end
