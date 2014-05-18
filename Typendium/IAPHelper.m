//
//  IAPHelper.m
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "IAPHelper.h"
#import "IAPProduct.h"
@import StoreKit;
// 2
@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation IAPHelper {
    SKProductsRequest *_productsRequest;
    RequestProductsCompletionHandler _completionHandler;
}

- (id)initWithProducts:(NSMutableDictionary *)products {
    
    if ((self = [super init])) {
        _products = products;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    _completionHandler = [completionHandler copy];
    
    NSMutableSet *productIdentifiers = [NSMutableSet setWithCapacity:_products.count];
    for (IAPProduct *product in _products.allValues) {
        product.availableForPurchase = NO;
        [productIdentifiers addObject:product.productIdentifier];
    }
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

#pragma mark - SKProductsRequest Delegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray *skProducts = response.products;
    for (SKProduct *skProduct in skProducts) {
        IAPProduct *product = _products[skProduct.productIdentifier];
        product.skProduct = skProduct;
        product.availableForPurchase = YES;
        
        
//        NSLog(@"Found product: %@ %@ %0.2f",
//              skProduct.productIdentifier,
//              skProduct.localizedTitle,
//              skProduct.price.floatValue);
    }
    for (NSString *invalidProductIdentifier in response.invalidProductIdentifiers) {
        IAPProduct *product = _products[invalidProductIdentifier];
        product.availableForPurchase = NO;
        NSLog(@"Invalid product identifier, removing: %@", invalidProductIdentifier);
    }
    
    NSMutableArray *availableProducts = [NSMutableArray array];
    for (IAPProduct *product in _products.allValues) {
        if (product.availableForPurchase) {
            [availableProducts addObject:product];
        }
        
        _completionHandler(YES, availableProducts);
        _completionHandler = nil;
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(FALSE, nil);
    _completionHandler = nil;
}

- (void)buyProduct:(IAPProduct *)product {
    
    NSAssert(product.allowedToPurchase, @"Unable to unlock Typendium at this time");
    NSLog(@"Buying %@...", product.productIdentifier);
    product.purchaseInProgress = YES;
    SKPayment *payment = [SKPayment paymentWithProduct:product.skProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"completeTransaction...");
    [self provideContentForTransaction:transaction productIdentifier:transaction.payment.productIdentifier];
    
}

- (void)restoreTransaction: (SKPaymentTransaction *)transaction {
    
    NSLog(@"restoreTransaction");
    [self provideContentForTransaction:transaction productIdentifier:transaction.originalTransaction.payment.productIdentifier];
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    IAPProduct *product = _products[transaction.payment.productIdentifier];
    [self notifyStatusForProductIdentifier:transaction.payment.productIdentifier string:@"Purchase failed."];
    product.purchaseInProgress = NO;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)notifyStatusForProductIdentifier: (NSString *)productIdentifier string: (NSString *)string {
    
    IAPProduct *product = _products[productIdentifier];
    [self notifyStatusForProduct:product string:string];
    
}

- (void)notifyStatusForProduct: (IAPProduct *)product string:(NSString *)string {
    NSString * message = [NSString stringWithFormat:@"%@: %@",
                          product.skProduct.localizedTitle, string];
    NSLog(@"%@", message);
}

- (void)provideContentForTransaction:(SKPaymentTransaction *)transaction productIdentifier:(NSString *)productIdentifier {
    
    IAPProduct *product = _products[productIdentifier];
    [self provideContentForProductIdentifier:productIdentifier];
    [self notifyStatusForProductIdentifier:productIdentifier string:@"Purchase complete!"];
    
    product.purchaseInProgress = NO;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
}

- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}

@end