//
//  IAPHelper.h
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

@class IAPProduct;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

@interface IAPHelper : NSObject

@property (nonatomic) NSMutableDictionary *products;

- (id)initWithProducts:(NSMutableDictionary *)products;
- (void)requestProductsWithCompletionHandler: (RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(IAPProduct *)product;
- (void)restoreCompletedTransactions;
@end
