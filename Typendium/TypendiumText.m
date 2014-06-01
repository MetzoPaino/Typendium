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

- (Title *)configureTitle :(Title *)title : (NSString *)name {
    
    NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
    
    title = [xib_title objectAtIndex:0];
    title.img_title.image = [UIImage imageNamed:name];
    
    return title;
}

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
    frame = caption.lbl_caption.frame;
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

- (Image *)configureImage :(Image *)image : (NSString *)name{
    
    NSArray *xib_image = [[NSBundle mainBundle] loadNibNamed:@"Image" owner:self options:nil];
    image = [xib_image objectAtIndex:0];
    image.image.image = [UIImage imageNamed:name];
    
    return image;
}

#pragma mark - Baskerville

- (NSArray *)arr_baskerville {
    
    if (!_arr_baskerville) {
        
        [self typendiumText:@"Baskerville"];
        
        Title *title;
        title = [self configureTitle:title :@"BaskervilleHeader"];
        
        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        Image *image1;
        image1 = [self configureImage:image1 :@"JohnBaskerville"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
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
        
        [self typendiumText:@"Futura"];
        
        Title *title;
        title = [self configureTitle:title :@"FuturaHeader"];

        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        Image *image1;
        image1 = [self configureImage:image1 :@"PaulRenner"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        _arr_futura = @[title,
                        paragraph1,
                        quote1,
                        paragraph2,
                        paragraph3,
                        image1,
                        caption1,
                        paragraph4,
                        paragraph5,
                        paragraph6];
    }
    
    return _arr_futura;
}

#pragma mark - Gill Sans

- (NSArray *)arr_gillSans {
    
    if (!_arr_gillSans) {
        
        NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
        
        Title *title = [xib_title objectAtIndex:0];
        title.img_title.image = [UIImage imageNamed:@"GillSansHeader"];
        
        _arr_gillSans = [[NSArray alloc] initWithObjects: title, nil];
    }
    
    return _arr_gillSans;
}

#pragma mark - Palatino

- (NSArray *)arr_palatino {
    
    if (!_arr_palatino) {
        
        [self typendiumText:@"Palatino"];
        
        Title *title;
        title = [self configureTitle:title :@"PalatinoHeader"];
        
        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Image *image1;
        image1 = [self configureImage:image1 :@"HermannZapf"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        _arr_palatino = @[title,
                        paragraph1,
                        paragraph2,
                        image1,
                        caption1,
                        paragraph3,
                        quote1,
                        paragraph4,
                        paragraph5,
                        paragraph6];    }
    
    return _arr_palatino;
}

#pragma mark - Times New Roman

- (NSArray *)arr_timesNewRoman {
    
    if (!_arr_timesNewRoman) {
        
        [self typendiumText:@"TimesNewRoman"];
        
        Title *title;
        title = [self configureTitle:title :@"TimesNewRomanHeader"];
        
        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        Image *image1;
        image1 = [self configureImage:image1 :@"StanleyMorison"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        _arr_timesNewRoman = @[title,
                               paragraph1,
                               paragraph2,
                               paragraph3,
                               image1,
                               caption1,
                               paragraph4,
                               quote1,
                               paragraph5];
    }
    
    return _arr_timesNewRoman;
}





@end
