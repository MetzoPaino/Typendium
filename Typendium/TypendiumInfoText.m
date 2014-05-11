//
//  TypendiumInfoText.m
//  Typendium
//
//  Created by William Robinson on 05/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TypendiumInfoText.h"
#import "Title.h"
#import "Reference.h"
#import "Section.h"

#import "AboutUs.h"

#import "UIColor+CustomColors.h"

@import QuartzCore;
@implementation TypendiumInfoText {
    
    NSDictionary *_typendiumInfoText;
}

- (NSDictionary *)typendiumInfoText : (NSString *)section {
    
    if (!_typendiumInfoText) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"Typendium.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSDictionary *typendiumText = [NSDictionary dictionaryWithDictionary:[plistData objectForKey:@"TypendiumInfoText"]];
        _typendiumInfoText = [NSDictionary dictionaryWithDictionary:[typendiumText objectForKey:section]];
    }
    return _typendiumInfoText;
}

#pragma mark - Configure Page Sections

- (Title *)configureTitle :(Title *)title : (NSString *)name {
    
    NSArray *xib_title = [[NSBundle mainBundle] loadNibNamed:@"Title" owner:self options:nil];
    
    title = [xib_title objectAtIndex:0];
    title.shareButton.hidden = YES;
    title.img_title.image = [UIImage imageNamed:name];
    
    return title;
}

- (Reference *)configureReference :(Reference *)reference :(NSString *)key {
    
   // CGRect frame;
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"Reference" owner:self options:nil];
    reference = [xib_paragraph objectAtIndex:0];
    NSDictionary *referenceText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:key]];
    reference.title.text = [referenceText objectForKey:@"Title"];
    reference.date.text = [referenceText objectForKey:@"Date"];
    reference.author.text = [referenceText objectForKey:@"Author"];
    
    [reference.title sizeToFit];
    
    reference.title.frame = CGRectMake(reference.title.frame.origin.x,
                                       10,
                                       reference.title.frame.size.width,
                                       reference.title.frame.size.height);
    
    reference.author.frame = CGRectMake(reference.author.frame.origin.x,
                                        reference.title.frame.size.height + 15,
                                        reference.author.frame.size.width,
                                        reference.author.frame.size.height);
    
    [reference.author sizeToFit];
    
    float height;
    
    height = reference.title.frame.size.height + 10 + reference.author.frame.size.height + 15;
    
    //frame =  CGRectMake(0, 0, reference.container.frame.size.width, height);

    reference.container.frame = CGRectMake(0, 0, reference.container.frame.size.width, height);
    
    reference.frame = reference.container.frame;
    reference.date.center = CGPointMake(0 + reference.date.frame.size.width / 2, reference.frame.size.height / 2);

    return reference;
}

- (Section *)configureSection :(Section *)section :(NSString *)key {
    
    CGRect frame;
    NSArray *xib_quote = [[NSBundle mainBundle] loadNibNamed:@"Section" owner:self options:nil];
    
    section = [xib_quote objectAtIndex:0];
    NSDictionary *sectionText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:@"Section"]];

    section.title.text = [sectionText objectForKey:key];
//    [section.lbl_quote sizeToFit];
//    frame =   quote.lbl_quote.frame;
//    section.frame = frame;
    
    return section;
}

- (AboutUs *)configureAboutUs :(AboutUs *)aboutUs :(NSString *)key {
    
    CGRect frame;
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"AboutUs" owner:self options:nil];
    aboutUs = [xib_paragraph objectAtIndex:0];
    NSDictionary *aboutUsText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:key]];
    aboutUs.picture.image = [UIImage imageNamed:key];
    
    aboutUs.name.text = [aboutUsText objectForKey:@"Name"];
    aboutUs.links.text = [aboutUsText objectForKey:@"Links"];

//    reference.date.text = [referenceText objectForKey:@"Date"];
//    reference.author.text = [referenceText objectForKey:@"Author"];
//    
//    [reference.title sizeToFit];
//    [reference.author sizeToFit];
//    
//    float height;
//    
//    height = reference.title.frame.size.height + 10 + reference.author.frame.size.height + 40;
//    
//    frame =  CGRectMake(0, 0, reference.container.frame.size.width, height);
//    
//    reference.container.frame = frame;
//    
//    reference.frame = frame;
//    reference.date.center = CGPointMake(0 + reference.date.frame.size.width / 2, reference.frame.size.height / 2);
    
    return aboutUs;
}

#pragma mark - References

- (NSArray *)arr_references {
    
    if (!_arr_references) {
        
        [self typendiumInfoText:@"References"];
        
        Title *title;
        title = [self configureTitle:title :@"ReferencesHeader"];
        
        Section *section1;
        section1 = [self configureSection:section1 :@"Book"];
        
        Reference *reference1;
        reference1 = [self configureReference:reference1 :@"26Letters"];
        
        Reference *reference2;
        reference2 = [self configureReference:reference2 :@"AnatomyOfATypeface"];
        reference2.backgroundColor = [UIColor typendiumLightGray];

        Reference *reference3;
        reference3 = [self configureReference:reference3 :@"TypographyReferenced"];
        
        Reference *reference4;
        reference4 = [self configureReference:reference4 :@"TheElementsOfTypographicStyle"];
        reference4.backgroundColor = [UIColor typendiumLightGray];
        
        Section *section2;
        section2 = [self configureSection:section2 :@"Film"];
        
        Reference *referenceFilm1;
        referenceFilm1 = [self configureReference:referenceFilm1 :@"Helvetica"];
        
        Reference *referenceFilm2;
        referenceFilm2 = [self configureReference:referenceFilm2 :@"Typeface"];
        referenceFilm2.backgroundColor = [UIColor typendiumLightGray];
        
        Reference *referenceFilm3;
        referenceFilm3 = [self configureReference:referenceFilm3 :@"Linotype"];
        
        _arr_references = @[title,
                            section1,
                            reference1,
                            reference2,
                            reference3,
                            reference4,
                            section2,
                            referenceFilm1,
                            referenceFilm2,
                            referenceFilm3];
    }
    
    return _arr_references;
}

#pragma mark - About Us

- (NSArray *)arr_aboutUs {
    
    if (!_arr_aboutUs) {
        
        [self typendiumInfoText:@"AboutUs"];
        
        Title *title;
        title = [self configureTitle:title :@"AboutUsHeader"];
        
        AboutUs *aboutUs1;
        aboutUs1 = [self configureAboutUs:aboutUs1 :@"William"];
        aboutUs1.picture.layer.cornerRadius = aboutUs1.picture.frame.size.width / 2;
        aboutUs1.picture.layer.masksToBounds = YES;
        
        AboutUs *aboutUs2;
        aboutUs2 = [self configureAboutUs:aboutUs2 :@"Robyn"];
        aboutUs2.picture.layer.cornerRadius = aboutUs2.picture.frame.size.width / 2;
        aboutUs2.picture.layer.masksToBounds = YES;
        
        _arr_aboutUs = @[title, aboutUs1, aboutUs2];
    }
    
    return _arr_aboutUs;
}

#pragma mark - Special Thanks

- (NSArray *)arr_specialThanks {
    
    if (!_arr_specialThanks) {
        
        [self typendiumInfoText:@"SpecialThanks"];
        
        Title *title;
        title = [self configureTitle:title :@"SpecialThanksHeader"];
                
        _arr_specialThanks = @[title];
    }
    
    return _arr_specialThanks;
}
@end
