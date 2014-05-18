//
//  TYPEIAPHelper.m
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "TYPEIAPHelper.h"
#import "IAPProduct.h"
//#import "TYPEContentController.h"
@import StoreKit;

@implementation TYPEIAPHelper

- (id)init {
    
    IAPProduct *unlockTypendium = [[IAPProduct alloc] initWithProductIdentifier:@"com.Robinson.Typendium.Unlock"];
    NSMutableDictionary *products = [@{unlockTypendium.productIdentifier: unlockTypendium}
                                     mutableCopy];
    if ((self = [super initWithProducts:products])) {
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UnlockTypendium"
                                                            object:self];
    }
    return self;
}

+ (TYPEIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static TYPEIAPHelper *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}

- (void)provideContentForProductIdentifier: (NSString *)productIdentifier {
    
    if ([productIdentifier isEqualToString:@"com.Robinson.Typendium.Unlock"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"com.Robinson.Typendium.Unlock"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)notifyStatusForProduct:(IAPProduct *)product string:(NSString *)string {
    
    NSString *message = [NSString stringWithFormat:@"%@: %@", product.skProduct.localizedTitle, string];
    NSLog(@"%@", message);
}

@end
