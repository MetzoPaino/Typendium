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
    
    NSMutableString *text = [_typendiumText objectForKey:key];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    UIFont *avenierBook =[UIFont fontWithName:@"Avenir-Book" size:20.0f];
    [attributedText addAttribute:NSFontAttributeName value:avenierBook range:NSMakeRange(0, attributedText.length)];
    
    NSString *italicStart = @"<italic>";

    NSRange range1 = [text rangeOfString:italicStart];
    
    // If range is 0 then there is no need for italics
    if (range1.length) {
        
        [self addItalicsTo:attributedText withInitialRange:range1 usingGenericText:text];

    }

    paragraph.txt_paragraph.attributedText = attributedText;
    
    [paragraph.txt_paragraph sizeToFit];
    frame =  paragraph.txt_paragraph.frame;
    paragraph.frame = frame;
    
    return paragraph;
}

- (NSMutableAttributedString *)addItalicsTo: (NSMutableAttributedString *)attributedText withInitialRange: (NSRange)range1 usingGenericText: (NSMutableString *) text {
    
    NSString *italicStart = @"<italic>";
    NSString *italicEnd = @"</italic>";
    
    // Create a string from the end of <italic>
    NSString *substring1 = [text substringFromIndex:NSMaxRange(range1)];
    
    // Get the range of </italic> from the whole text so that it can be removed
    NSRange range2 = [text rangeOfString:italicEnd];
    
    // Use the substring to get the range up to </italic> so that we know how much to italicise
    NSRange range3 = [substring1 rangeOfString:italicEnd];
    
    // Now we have the ranges, remove the instances of <italics> & </italics>
    [[attributedText mutableString] replaceOccurrencesOfString:italicEnd withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(range2.location, range2.length)];
    [[attributedText mutableString] replaceOccurrencesOfString:italicStart withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(range1.location, range1.length)];
    
    // Add the italics attribute from the first character after <italics> to the last character before </italics>
    UIFont *avenirBookOblique = [UIFont fontWithName:@"Avenir-BookOblique" size:20.0f];
    [attributedText addAttribute:NSFontAttributeName value:avenirBookOblique range:NSMakeRange(range1.location, range3.location)];
    
    text = [NSMutableString stringWithString:[attributedText string]];
    
    range1 = [text rangeOfString:italicStart];
    
    if (range1.length) {
        
        [self addItalicsTo:attributedText withInitialRange:range1 usingGenericText:text];

    }

    return attributedText;
}

- (Caption *)configureCaption :(Caption *)caption :(NSString *)key {
    
    CGRect frame;
    NSArray *xib_caption = [[NSBundle mainBundle] loadNibNamed:@"Caption" owner:self options:nil];
    
    caption = [xib_caption objectAtIndex:0];
    caption.lbl_caption.text = [_typendiumText objectForKey:key];
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
        
        UIView *image2 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 169)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Q & G"]];
        [image2 addSubview:imageView2];
        
        Caption *caption2;
        caption2 = [self configureCaption:caption2 :@"Caption2"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        UIView *image3 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 208)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Baskerville Photo"]];
        [image3 addSubview:imageView3];
        
        Caption *caption3;
        caption3 = [self configureCaption:caption2 :@"Caption3"];
        
        Paragraph *paragraph7;
        paragraph7 = [self configureParagraph:paragraph7 :@"Paragraph7"];
        
        Paragraph *paragraph8;
        paragraph8 = [self configureParagraph:paragraph8 :@"Paragraph8"];
        
        Paragraph *paragraph9;
        paragraph9 = [self configureParagraph:paragraph9 :@"Paragraph9"];
        
        Paragraph *paragraph10;
        paragraph10 = [self configureParagraph:paragraph10 :@"Paragraph10"];
        
        UIView *image4 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 310)];
        UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Press"]];
        [image4 addSubview:imageView4];
        
        Caption *caption4;
        caption4 = [self configureCaption:caption1 :@"Caption4"];
        
        Paragraph *paragraph11;
        paragraph11 = [self configureParagraph:paragraph11 :@"Paragraph11"];
        
        Paragraph *paragraph12;
        paragraph12 = [self configureParagraph:paragraph12 :@"Paragraph12"];
        
        UIView *specimen = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 497)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BaskervilleSpecimen"]];
        [specimen addSubview:image];
        specimen.restorationIdentifier = @"Specimen";

        _arr_baskerville = @[title,
                             paragraph1,
                             image1,
                             caption1,
                             paragraph2,
                             paragraph3,
                             image2,
                             caption2,
                             paragraph4,
                             paragraph5,
                             paragraph6,
                             image3,
                             caption3,
                             paragraph7,
                             paragraph8,
                             paragraph9,
                             paragraph10,
                             image4,
                             caption4,
                             paragraph11,
                             paragraph12,
                             specimen];
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
        
        Image *image1;
        image1 = [self configureImage:image1 :@"PaulRenner"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        UIView *image2 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 64)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FuturaOriginal"]];
        [image2 addSubview:imageView2];
        image2.restorationIdentifier = @"FuturaOld";
        
        Caption *caption2;
        caption2 = [self configureCaption:caption2 :@"Caption2"];

        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        UIView *image3 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 187)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Blackletter comparison"]];
        [image3 addSubview:imageView3];
        
        Caption *caption3;
        caption3 = [self configureCaption:caption3 :@"Caption3"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        UIView *image4 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 89)];
        UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"O comparison"]];
        [image4 addSubview:imageView4];
        
        Caption *caption4;
        caption4 = [self configureCaption:caption4 :@"Caption4"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        Paragraph *paragraph7;
        paragraph7 = [self configureParagraph:paragraph7 :@"Paragraph7"];
        
        UIView *specimen = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 497)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FuturaSpecimen"]];
        [specimen addSubview:image];
        specimen.restorationIdentifier = @"Specimen";

        _arr_futura = @[title,
                        paragraph1,
                        image1,
                        caption1,
                        paragraph2,
                        paragraph3,
                        image2,
                        caption2,
                        paragraph4,
                        image3,
                        caption3,
                        paragraph5,
                        image4,
                        caption4,
                        paragraph6,
                        paragraph7,
                        specimen];
    }
    
    return _arr_futura;
}

#pragma mark - Gill Sans

- (NSArray *)arr_gillSans {
    
    if (!_arr_gillSans) {
        
        [self typendiumText:@"Gill Sans"];
        
        Title *title;
        title = [self configureTitle:title :@"GillSansHeader"];
        
        Paragraph *paragraph1;
        paragraph1 = [self configureParagraph:paragraph1 :@"Paragraph1"];
        
        Image *image1;
        image1 = [self configureImage:image1 :@"EricGill"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        UIView *image2 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 266)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Prospero & Ariel"]];
        [image2 addSubview:imageView2];
        
        Caption *caption2;
        caption2= [self configureCaption:caption2 :@"Caption2"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        UIView *image3 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 214)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AllIsGold"]];
        [image3 addSubview:imageView3];
        
        Caption *caption3;
        caption3 = [self configureCaption:caption3 :@"Caption3"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        UIView *image4 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 218)];
        UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gill Sans Spectacles"]];
        [image4 addSubview:imageView4];
        
        Caption *caption4;
        caption4 = [self configureCaption:caption4 :@"Caption4"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        UIView *image5 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 195)];
        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Thin to bold"]];
        [image5 addSubview:imageView5];

        Caption *caption5;
        caption5 = [self configureCaption:caption5 :@"Caption5"];
        
        Paragraph *paragraph7;
        paragraph7 = [self configureParagraph:paragraph7 :@"Paragraph7"];
        
        UIView *specimen = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 497)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GillSansSpecimen"]];
        [specimen addSubview:image];
        specimen.restorationIdentifier = @"Specimen";

        _arr_gillSans = @[title,
                          paragraph1,
                          image1,
                          caption1,
                          paragraph2,
                          paragraph3,
                          image2,
                          caption2,
                          paragraph4,
                          image3,
                          caption3,
                          paragraph5,
                          image4,
                          caption4,
                          paragraph6,
                          image5,
                          caption5,
                          paragraph7,
                          specimen];
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
        
        Image *image1;
        image1 = [self configureImage:image1 :@"HermannZapf"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        UIView *image2 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 180)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Open Counter"]];
        [image2 addSubview:imageView2];
        
        Caption *caption2;
        caption2 = [self configureCaption:caption2 :@"Caption2"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        UIView *image3 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 88)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Interrorbang"]];
        [image3 addSubview:imageView3];
        
        Caption *caption3;
        caption3 = [self configureCaption:caption3 :@"Caption3"];
        
        Paragraph *paragraph7;
        paragraph7 = [self configureParagraph:paragraph7 :@"Paragraph7"];
        
        Paragraph *paragraph8;
        paragraph8 = [self configureParagraph:paragraph7 :@"Paragraph8"];
        
        UIView *specimen = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 497)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PalatinoSpecimen"]];
        [specimen addSubview:image];
        specimen.restorationIdentifier = @"Specimen";

        _arr_palatino = @[title,
                          paragraph1,
                          image1,
                          caption1,
                          paragraph2,
                          paragraph3,
                          paragraph4,
                          paragraph5,
                          image2,
                          caption2,
                          paragraph6,
                          image3,
                          caption3,
                          paragraph7,
                          paragraph8,
                          specimen];
    }
    
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
        
        Image *image1;
        image1 = [self configureImage:image1 :@"StanleyMorison"];
        
        Caption *caption1;
        caption1 = [self configureCaption:caption1 :@"Caption1"];
        
        Paragraph *paragraph2;
        paragraph2 = [self configureParagraph:paragraph2 :@"Paragraph2"];
        
        Paragraph *paragraph3;
        paragraph3 = [self configureParagraph:paragraph3 :@"Paragraph3"];
        
        UIView *image2 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 240)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pelican Press"]];
        [image2 addSubview:imageView2];
        
        Caption *caption2;
        caption2 = [self configureCaption:caption2 :@"Caption2"];
        
        Paragraph *paragraph4;
        paragraph4 = [self configureParagraph:paragraph4 :@"Paragraph4"];
        
        Quote *quote1;
        quote1 = [self configureQuote:quote1 :@"Quote1"];
        
        Paragraph *paragraph5;
        paragraph5 = [self configureParagraph:paragraph5 :@"Paragraph5"];
        
        Paragraph *paragraph6;
        paragraph6 = [self configureParagraph:paragraph6 :@"Paragraph6"];
        
        Paragraph *paragraph7;
        paragraph7 = [self configureParagraph:paragraph7 :@"Paragraph7"];
        
        Paragraph *paragraph8;
        paragraph8 = [self configureParagraph:paragraph8 :@"Paragraph8"];
        
        Paragraph *paragraph9;
        paragraph9 = [self configureParagraph:paragraph9 :@"Paragraph9"];
        
        UIView *image3 = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 240)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TheTimes"]];
        [image3 addSubview:imageView3];
        
        Caption *caption3;
        caption3 = [self configureCaption:caption3 :@"Caption3"];
        
        Paragraph *paragraph10;
        paragraph10 = [self configureParagraph:paragraph10 :@"Paragraph10"];
        
        Paragraph *paragraph11;
        paragraph11 = [self configureParagraph:paragraph11 :@"Paragraph11"];
        
        UIView *specimen = [[UIView alloc] initWithFrame:CGRectMake(180, 0, 320, 497)];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TimesNewRomanSpecimen"]];
        [specimen addSubview:image];
        specimen.restorationIdentifier = @"Specimen";
        _arr_timesNewRoman = @[title,
                               paragraph1,
                               image1,
                               caption1,
                               paragraph2,
                               paragraph3,
                               image2,
                               caption2,
                               paragraph4,
                               paragraph5,
                               paragraph6,
                               paragraph7,
                               paragraph8,
                               paragraph9,
                               image3,
                               caption3,
                               paragraph10,
                               paragraph11,
                               specimen];
    }
    
    return _arr_timesNewRoman;
}





@end
