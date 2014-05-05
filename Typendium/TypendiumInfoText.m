//
//  TypendiumInfoText.m
//  Typendium
//
//  Created by William Robinson on 05/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TypendiumInfoText.h"
#import "Title.h"

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
    title.img_title.image = [UIImage imageNamed:name];
    
    return title;
}

#pragma mark - References

- (NSArray *)arr_references {
    
    if (!_arr_references) {
        
        [self typendiumInfoText:@"References"];
        
        Title *title;
        title = [self configureTitle:title :@"ReferencesHeader"];
        
        _arr_references = @[title];
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
