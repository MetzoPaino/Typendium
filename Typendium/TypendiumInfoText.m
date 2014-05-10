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
#import "UIColor+CustomColors.h"

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
    
    CGRect frame;
    
    NSArray *xib_paragraph = [[NSBundle mainBundle] loadNibNamed:@"Reference" owner:self options:nil];
    reference = [xib_paragraph objectAtIndex:0];
    NSDictionary *referenceText = [NSDictionary dictionaryWithDictionary:[_typendiumInfoText objectForKey:key]];
    reference.title.text = [referenceText objectForKey:@"Title"];
    reference.date.text = [referenceText objectForKey:@"Date"];
    reference.author.text = [referenceText objectForKey:@"Author"];
    
    [reference.title sizeToFit];
    [reference.author sizeToFit];
    
    float height;
    
    height = reference.title.frame.size.height + 10 + reference.author.frame.size.height + 40;
    
    frame =  CGRectMake(0, 0, reference.container.frame.size.width, height);

    reference.container.frame = frame;
    
    reference.frame = frame;
    reference.date.center = CGPointMake(0 + reference.date.frame.size.width / 2, reference.frame.size.height / 2);

    return reference;
}

#pragma mark - References

- (NSArray *)arr_references {
    
    if (!_arr_references) {
        
        [self typendiumInfoText:@"References"];
        
        Title *title;
        title = [self configureTitle:title :@"ReferencesHeader"];
        
        Reference *reference1;
        reference1 = [self configureReference:reference1 :@"AnatomyOfATypeface"];
        
        Reference *reference2;
        reference2 = [self configureReference:reference1 :@"TypographyReferenced"];
        reference2.backgroundColor = [UIColor typendiumLightGray];
        
        _arr_references = @[title, reference1, reference2];
    }
    
    return _arr_references;
}

#pragma mark - About Us

- (NSArray *)arr_aboutUs {
    
    if (!_arr_aboutUs) {
        
        [self typendiumInfoText:@"AboutUs"];
        
        Title *title;
        title = [self configureTitle:title :@"AboutUsHeader"];
        
        _arr_aboutUs = @[title];
    }
    
    return _arr_aboutUs;
}
@end
