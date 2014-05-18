//
//  UnlockViewController.m
//  Typendium
//
//  Created by William Robinson on 18/05/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

#import "UnlockViewController.h"

#import "TYPEIAPHelper.h"
#import "IAPProduct.h"
@import StoreKit;

@interface UnlockViewController () <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *unlockButton;

@end

@implementation UnlockViewController {
    
    NSTimer *_fadeTimer;
    NSArray *_products;
    NSNumberFormatter *_priceFormatter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.unlockButton.layer.borderWidth = 1.0f;
    self.unlockButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.unlockButton.layer.cornerRadius = 18.0f;
}

#pragma mark - Actions

- (IBAction)upArrow:(id)sender {
    
    [self.delegate animateContainerUpwards:self
                               currentPage:@"Unlock"
                                   newPage:@"Intro"];
    
}

- (IBAction)unlockTypendium:(id)sender {
    
    _products = nil;
    [[TYPEIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        
        if (success) {
            _products = products;
            
            
            IAPProduct *product = [_products firstObject];
            UILabel *label = [UILabel new];
            label.text = product.skProduct.localizedTitle;
            NSLog(@"%@", label.text);
            
            UIAlertView *alertView;
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
                
                alertView = [[UIAlertView alloc] initWithTitle:product.skProduct.localizedTitle
                                                       message:product.skProduct.localizedDescription
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Redeem", nil];
                alertView.tag = 1;
                
            } else {
                
                alertView = [[UIAlertView alloc] initWithTitle:product.skProduct.localizedTitle
                                                       message:product.skProduct.localizedDescription
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Buy", nil];
                alertView.tag = 2;
            }
            
            
            
            [alertView show];
        }
    }];
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == ![alertView cancelButtonIndex]) {
        
        if (alertView.tag == 1) {
            
            [[TYPEIAPHelper sharedInstance] restoreCompletedTransactions];
            
        } else {
            
            [[TYPEIAPHelper sharedInstance] buyProduct:[_products firstObject]];

        }
    }
}

@end
