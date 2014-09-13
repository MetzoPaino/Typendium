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
#import "Website.h"

#import "AboutUs.h"
#import "MadeIn.h"
#import "SpecialThanks.h"

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
    title.backgroundColor = [UIColor orangeColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    title.frame = CGRectMake(0, 0, screenWidth, title.frame.size.height);
    
    if ([name isEqualToString:@"ReferencesHeader"]) {
        title.backgroundColor = [UIColor referencesColor];
    } else if ([name isEqualToString:@"AboutUsHeader"]) {
        title.backgroundColor = [UIColor aboutUsColor];
    } else if ([name isEqualToString:@"SpecialThanksHeader"]) {
        title.backgroundColor = [UIColor specialThanksColor];
    }
    
    
    return title;
}

- (Reference *)configureReference :(Reference *)reference :(NSString *)key {
    
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

- (Website *)configureWebsite:(Website *)website : (NSString *) key {
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"Website" owner:self options:nil];
    website = [xib_paragraph objectAtIndex:0];
    website.title.text = key;

    [website.title sizeToFit];
    
    return website;

}
- (Section *)configureSection :(Section *)section :(NSString *)key {
    
    NSArray *xib_quote = [[NSBundle mainBundle] loadNibNamed:@"Section" owner:self options:nil];
    
    section = [xib_quote objectAtIndex:0];
    NSDictionary *sectionText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:@"Section"]];

    section.title.text = [sectionText objectForKey:key];
    
    return section;
}

- (AboutUs *)configureAboutUs :(AboutUs *)aboutUs :(NSString *)key {
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"AboutUs" owner:self options:nil];
    aboutUs = [xib_paragraph objectAtIndex:0];
    NSDictionary *aboutUsText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:key]];
    aboutUs.picture.image = [UIImage imageNamed:key];
    
    aboutUs.name.text = [aboutUsText objectForKey:@"Name"];
    aboutUs.links.text = [aboutUsText objectForKey:@"Links"];
    
    return aboutUs;
}

- (MadeIn *)configureMadeIn :(MadeIn *)madeIn {
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"MadeIn" owner:self options:nil];
    madeIn = [xib_paragraph objectAtIndex:0];
    return madeIn;
}

- (SpecialThanks *)configureSpecialThanks :(SpecialThanks *)specialThanks :(NSString *)key {
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"SpecialThanks" owner:self options:nil];
    specialThanks = [xib_paragraph objectAtIndex:0];
    NSDictionary *specialThanksText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:key]];
    specialThanks.name.text = [specialThanksText objectForKey:@"Name"];
    specialThanks.thanks.text = [specialThanksText objectForKey:@"Description"];
    
    [specialThanks.thanks sizeToFit];
    
    specialThanks.frame = CGRectMake(0, 0, specialThanks.frame.size.width, specialThanks.name.frame.size.height + 6 + specialThanks.thanks.frame.size.height);
    
    return specialThanks;
}

#pragma mark - References

- (NSArray *)arr_references {
    
    if (!_arr_references) {
        
        [self typendiumInfoText:@"References"];
        
        Title *title;
        title = [self configureTitle:title :@"ReferencesHeader"];
        
        Section *section1;
        section1 = [self configureSection:section1 :@"Book"];
        section1.backgroundColor = [UIColor referencesColor];
        section1.restorationIdentifier = @"Book";

        Reference *reference1;
        reference1 = [self configureReference:reference1 :@"FirstPrinciples"];
        
        Reference *reference2;
        reference2 = [self configureReference:reference2 :@"CrystalGoblet"];

        Reference *reference3;
        reference3 = [self configureReference:reference3 :@"BasicTypography"];
        
        Reference *reference4;
        reference4 = [self configureReference:reference4 :@"TallyOfTypes"];
        
        Reference *reference5;
        reference5 = [self configureReference:reference5 :@"26Letters"];
        
        Reference *reference6;
        reference6 = [self configureReference:reference6 :@"EricGill"];
        
        Reference *reference7;
        reference7 = [self configureReference:reference7 :@"AnatomyOfATypeface"];
        
        Reference *reference8;
        reference8 = [self configureReference:reference8 :@"TheBauhausIdea"];
        
        Reference *reference9;
        reference9 = [self configureReference:reference9 :@"TheElementsOfTypographicStyle"];
        
        Reference *reference10;
        reference10 = [self configureReference:reference10 :@"PrintingTypes"];
        
        Reference *reference11;
        reference11 = [self configureReference:reference11 :@"TheCompleteManualOfTypography"];
        
        Reference *reference12;
        reference12 = [self configureReference:reference12 :@"CambridgeUniversity"];
        
        Reference *reference13;
        reference13 = [self configureReference:reference13 :@"Futura"];
        
        Reference *reference14;
        reference14 = [self configureReference:reference14 :@"ModernTypography"];
        
        Reference *reference15;
        reference15 = [self configureReference:reference15 :@"TheSecretHistoryOfLetters"];
        
        Reference *reference16;
        reference16 = [self configureReference:reference16 :@"JustMyType"];
        
        Reference *reference17;
        reference17 = [self configureReference:reference17 :@"JohnBaskerville"];
        
        Reference *reference18;
        reference18 = [self configureReference:reference18 :@"TypographyReferenced"];
        
        Reference *reference19;
        reference19 = [self configureReference:reference19 :@"AnEssayOnTypography"];
        
        Section *section2;
        section2 = [self configureSection:section2 :@"Film"];
        section2.backgroundColor = [UIColor referencesColor];
        
        Reference *referenceFilm1;
        referenceFilm1 = [self configureReference:referenceFilm1 :@"Helvetica"];
        
        Reference *referenceFilm2;
        referenceFilm2 = [self configureReference:referenceFilm2 :@"Typeface"];
        
        Reference *referenceFilm3;
        referenceFilm3 = [self configureReference:referenceFilm3 :@"Linotype"];
        
        Section *websitesSection;
        websitesSection = [self configureSection:websitesSection :@"Websites"];
        websitesSection.backgroundColor = [UIColor referencesColor];
        
        NSArray *websitesArray = [NSArray arrayWithArray:[_typendiumInfoText objectForKey:@"Websites"]];
        
        Website *referenceWebsite1;
        referenceWebsite1 = [self configureWebsite:referenceWebsite1 : [websitesArray objectAtIndex:0]];
        
        Website *referenceWebsite2;
        referenceWebsite2 = [self configureWebsite:referenceWebsite2 : [websitesArray objectAtIndex:1]];
        
        Website *referenceWebsite3;
        referenceWebsite3 = [self configureWebsite:referenceWebsite3 : [websitesArray objectAtIndex:2]];
        
        Website *referenceWebsite4;
        referenceWebsite4 = [self configureWebsite:referenceWebsite4 : [websitesArray objectAtIndex:3]];
        
        Website *referenceWebsite5;
        referenceWebsite5 = [self configureWebsite:referenceWebsite5 : [websitesArray objectAtIndex:4]];
        
        Website *referenceWebsite6;
        referenceWebsite6 = [self configureWebsite:referenceWebsite6 : [websitesArray objectAtIndex:5]];
        
        Website *referenceWebsite7;
        referenceWebsite7 = [self configureWebsite:referenceWebsite7 : [websitesArray objectAtIndex:6]];
        
        Website *referenceWebsite8;
        referenceWebsite8 = [self configureWebsite:referenceWebsite8 : [websitesArray objectAtIndex:7]];
        
        Website *referenceWebsite9;
        referenceWebsite9 = [self configureWebsite:referenceWebsite9 : [websitesArray objectAtIndex:8]];
        
        Website *referenceWebsite10;
        referenceWebsite10 = [self configureWebsite:referenceWebsite10 : [websitesArray objectAtIndex:9]];
        
        Website *referenceWebsite11;
        referenceWebsite11 = [self configureWebsite:referenceWebsite11 : [websitesArray objectAtIndex:10]];
        
        Website *referenceWebsite12;
        referenceWebsite12 = [self configureWebsite:referenceWebsite12 : [websitesArray objectAtIndex:11]];
        
        Website *referenceWebsite13;
        referenceWebsite13 = [self configureWebsite:referenceWebsite13 : [websitesArray objectAtIndex:12]];
        
        Website *referenceWebsite14;
        referenceWebsite14 = [self configureWebsite:referenceWebsite14 : [websitesArray objectAtIndex:13]];
        
        Website *referenceWebsite15;
        referenceWebsite15 = [self configureWebsite:referenceWebsite15 : [websitesArray objectAtIndex:14]];
        
        Website *referenceWebsite16;
        referenceWebsite16 = [self configureWebsite:referenceWebsite16 : [websitesArray objectAtIndex:15]];
        
        Website *referenceWebsite17;
        referenceWebsite17 = [self configureWebsite:referenceWebsite17 : [websitesArray objectAtIndex:16]];
        
        Website *referenceWebsite18;
        referenceWebsite18 = [self configureWebsite:referenceWebsite18 : [websitesArray objectAtIndex:17]];
        
        Website *referenceWebsite19;
        referenceWebsite19 = [self configureWebsite:referenceWebsite19 : [websitesArray objectAtIndex:18]];
        
        Website *referenceWebsite20;
        referenceWebsite20 = [self configureWebsite:referenceWebsite20 : [websitesArray objectAtIndex:19]];
        
        Website *referenceWebsite21;
        referenceWebsite21 = [self configureWebsite:referenceWebsite21 : [websitesArray objectAtIndex:20]];
        
        Website *referenceWebsite22;
        referenceWebsite22 = [self configureWebsite:referenceWebsite22 : [websitesArray objectAtIndex:21]];
        
        Website *referenceWebsite23;
        referenceWebsite23 = [self configureWebsite:referenceWebsite23 : [websitesArray objectAtIndex:22]];
        
        Website *referenceWebsite24;
        referenceWebsite24 = [self configureWebsite:referenceWebsite24 : [websitesArray objectAtIndex:23]];
        
        Website *referenceWebsite25;
        referenceWebsite25 = [self configureWebsite:referenceWebsite25 : [websitesArray objectAtIndex:24]];
        
        Website *referenceWebsite26;
        referenceWebsite26 = [self configureWebsite:referenceWebsite26 : [websitesArray objectAtIndex:25]];
        
        Website *referenceWebsite27;
        referenceWebsite27 = [self configureWebsite:referenceWebsite27 : [websitesArray objectAtIndex:26]];
        
        Website *referenceWebsite28;
        referenceWebsite28 = [self configureWebsite:referenceWebsite28 : [websitesArray objectAtIndex:27]];
        
        Website *referenceWebsite29;
        referenceWebsite29 = [self configureWebsite:referenceWebsite29 : [websitesArray objectAtIndex:28]];
        
        Website *referenceWebsite30;
        referenceWebsite30 = [self configureWebsite:referenceWebsite30 : [websitesArray objectAtIndex:29]];
        
        Website *referenceWebsite31;
        referenceWebsite31 = [self configureWebsite:referenceWebsite20 : [websitesArray objectAtIndex:30]];
        
        Website *referenceWebsite32;
        referenceWebsite32 = [self configureWebsite:referenceWebsite21 : [websitesArray objectAtIndex:31]];
        
        Website *referenceWebsite33;
        referenceWebsite33 = [self configureWebsite:referenceWebsite22 : [websitesArray objectAtIndex:32]];
        
        Website *referenceWebsite34;
        referenceWebsite34 = [self configureWebsite:referenceWebsite23 : [websitesArray objectAtIndex:33]];
        
        Website *referenceWebsite35;
        referenceWebsite35 = [self configureWebsite:referenceWebsite24 : [websitesArray objectAtIndex:34]];
        
        Website *referenceWebsite36;
        referenceWebsite36 = [self configureWebsite:referenceWebsite25 : [websitesArray objectAtIndex:35]];
        
        Website *referenceWebsite37;
        referenceWebsite37 = [self configureWebsite:referenceWebsite26 : [websitesArray objectAtIndex:36]];
        
        Website *referenceWebsite38;
        referenceWebsite38 = [self configureWebsite:referenceWebsite27 : [websitesArray objectAtIndex:37]];
        
        Website *referenceWebsite39;
        referenceWebsite39 = [self configureWebsite:referenceWebsite28 : [websitesArray objectAtIndex:38]];
        
        Website *referenceWebsite40;
        referenceWebsite40 = [self configureWebsite:referenceWebsite29 : [websitesArray objectAtIndex:39]];
        
        Website *referenceWebsite41;
        referenceWebsite41 = [self configureWebsite:referenceWebsite30 : [websitesArray objectAtIndex:40]];
        
        Website *referenceWebsite42;
        referenceWebsite42 = [self configureWebsite:referenceWebsite26 : [websitesArray objectAtIndex:41]];
        
        Website *referenceWebsite43;
        referenceWebsite43 = [self configureWebsite:referenceWebsite27 : [websitesArray objectAtIndex:42]];
        
        Website *referenceWebsite44;
        referenceWebsite44 = [self configureWebsite:referenceWebsite28 : [websitesArray objectAtIndex:43]];
        
        Website *referenceWebsite45;
        referenceWebsite45 = [self configureWebsite:referenceWebsite29 : [websitesArray objectAtIndex:44]];
        
        Website *referenceWebsite46;
        referenceWebsite46 = [self configureWebsite:referenceWebsite30 : [websitesArray objectAtIndex:45]];
        
        Website *referenceWebsite47;
        referenceWebsite47 = [self configureWebsite:referenceWebsite30 : [websitesArray objectAtIndex:46]];
        
        _arr_references = @[title,
                            section1,
                            reference1,
                            reference2,
                            reference3,
                            reference4,
                            reference5,
                            reference6,
                            reference7,
                            reference8,
                            reference9,
                            reference10,
                            reference11,
                            reference12,
                            reference13,
                            reference14,
                            reference15,
                            reference16,
                            reference17,
                            reference18,
                            reference19,
                            section2,
                            referenceFilm1,
                            referenceFilm2,
                            referenceFilm3,
                            websitesSection,
                            referenceWebsite1,
                            referenceWebsite2,
                            referenceWebsite3,
                            referenceWebsite4,
                            referenceWebsite5,
                            referenceWebsite6,
                            referenceWebsite7,
                            referenceWebsite8,
                            referenceWebsite9,
                            referenceWebsite10,
                            referenceWebsite11,
                            referenceWebsite12,
                            referenceWebsite13,
                            referenceWebsite14,
                            referenceWebsite15,
                            referenceWebsite16,
                            referenceWebsite17,
                            referenceWebsite18,
                            referenceWebsite19,
                            referenceWebsite20,
                            referenceWebsite21,
                            referenceWebsite22,
                            referenceWebsite23,
                            referenceWebsite24,
                            referenceWebsite25,
                            referenceWebsite26,
                            referenceWebsite27,
                            referenceWebsite28,
                            referenceWebsite29,
                            referenceWebsite30,
                            referenceWebsite31,
                            referenceWebsite32,
                            referenceWebsite33,
                            referenceWebsite34,
                            referenceWebsite35,
                            referenceWebsite36,
                            referenceWebsite37,
                            referenceWebsite38,
                            referenceWebsite39,
                            referenceWebsite40,
                            referenceWebsite41,
                            referenceWebsite42,
                            referenceWebsite43,
                            referenceWebsite44,
                            referenceWebsite45,
                            referenceWebsite46,
                            referenceWebsite47,

                            ];
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
        
        MadeIn *madeIn1;
        madeIn1 = [self configureMadeIn:madeIn1];
        
        _arr_aboutUs = @[title, aboutUs1, aboutUs2, madeIn1];
    }
    
    return _arr_aboutUs;
}

#pragma mark - Special Thanks

- (NSArray *)arr_specialThanks {
    
    if (!_arr_specialThanks) {
        
        [self typendiumInfoText:@"SpecialThanks"];
        
        Title *title;
        title = [self configureTitle:title :@"SpecialThanksHeader"];
        
        SpecialThanks *specialThanks1;
        specialThanks1 = [self configureSpecialThanks:specialThanks1 :@"MariusIbanez"];
        
        SpecialThanks *specialThanks2;
        specialThanks2 = [self configureSpecialThanks:specialThanks2 :@"MarkFoley"];
        
        SpecialThanks *specialThanks3;
        specialThanks3 = [self configureSpecialThanks:specialThanks3 :@"JosephJackson"];
        
        SpecialThanks *specialThanks4;
        specialThanks4 = [self configureSpecialThanks:specialThanks4 :@"MarkKerby"];
        
        SpecialThanks *specialThanks5;
        specialThanks5 = [self configureSpecialThanks:specialThanks5 :@"SimonWithington"];
        
        SpecialThanks *specialThanks6;
        specialThanks6 = [self configureSpecialThanks:specialThanks6 :@"MattGlover"];
        
        SpecialThanks *specialThanks7;
        specialThanks7 = [self configureSpecialThanks:specialThanks7 :@"RobinsonLibrary"];
        
        SpecialThanks *specialThanks8;
        specialThanks8 = [self configureSpecialThanks:specialThanks8 :@"CityLibrary"];
        
        _arr_specialThanks = @[title,
                               specialThanks1,
                               specialThanks2,
                               specialThanks3,
                               specialThanks4,
                               specialThanks5,
                               specialThanks6,
                               specialThanks7,
                               specialThanks8];
    }
    
    return _arr_specialThanks;
}
@end
