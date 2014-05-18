//
//  IAPProduct.m
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "IAPProduct.h"

@implementation IAPProduct

- (id)initWithProductIdentifier:(NSString *)productIdentifier {
    
    if ((self = [super init])) {
        self.availableForPurchase = NO;
        self.productIdentifier = productIdentifier;
        self.skProduct = nil;
    }
    return self;
}

- (BOOL)allowedToPurchase {
    
    if (!self.availableForPurchase) {
        
        return NO;
        
    }
    
    if (self.purchaseInProgress) {
        
        return NO;
    }
    
    if (self.purchase) {
        
        return NO;
    }
    return YES;
}
@end
