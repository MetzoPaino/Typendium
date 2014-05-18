//
//  IAPProduct.h
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

@class SKProduct;

@interface IAPProduct : NSObject

- (id)initWithProductIdentifier:(NSString *)productIdentifier;
- (BOOL)allowedToPurchase;

@property (nonatomic, assign) BOOL availableForPurchase;
@property (nonatomic) NSString *productIdentifier;
@property (nonatomic) SKProduct *skProduct;
@property (nonatomic, assign) BOOL purchaseInProgress;
@property (nonatomic, assign) BOOL purchase;
@end
