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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *upArrow;
@property (weak, nonatomic) IBOutlet UILabel *infoText;
@property (weak, nonatomic) IBOutlet UIButton *redeemButton;
@property (weak, nonatomic) IBOutlet UIImageView *img_background;

@end

@implementation UnlockViewController {
    
	NSTimer *_fadeTimer;
	NSArray *_products;
	NSNumberFormatter *_priceFormatter;
	NSString *_string_currentPage;
    NSString *typendiumPrice;
}

#pragma mark - View Controller Configuration

- (void)viewDidLoad {
	
	[super viewDidLoad];
	self.unlockButton.layer.borderWidth = 1.0f;
	self.unlockButton.layer.borderColor = [UIColor whiteColor].CGColor;
	self.unlockButton.layer.cornerRadius = 18.0f;
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(whatPageIsThis) name:@"WhatUnlockPageIsThis" object:nil];
    [notificationCenter addObserver:self selector:@selector(unlockTypendiumNotification:) name:@"UnlockTypendium" object:nil];
    [notificationCenter addObserver:self selector:@selector(typendiumPrice:) name:@"TypendiumPrice" object:nil];
    [notificationCenter addObserver:self selector:@selector(purchaseFailed:) name:@"PurchaseFailed" object:nil];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
        [self.unlockButton setTitle:@"Redeem Typendium" forState:UIControlStateNormal];
        self.redeemButton.hidden = YES;

    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (screenWidth == 375) {
        self.img_background.image = [UIImage imageNamed:@"Unlock_iPhone6"];
    }
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    if (self.view.bounds.size.height < 568) {
        self.upArrow.center = CGPointMake(self.upArrow.center.x, self.upArrow.center.y);
    }
}

- (void)whatPageIsThis {
	
	_string_currentPage = @"Unlock";
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
															@"Menu", @"Section",
															_string_currentPage, @"Page",
															nil];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ThisPage"
																											object:self userInfo:dictionary];
}

#pragma mark - IBActions

- (IBAction)upArrow:(id)sender {
  
    [self.delegate animateContainerUpwards:self
                               currentPage:@"Unlock"
                                   newPage:@"Intro"];
    
}

- (IBAction)unlockTypendium:(id)sender {
    
    _products = nil;
    
    [self.activityIndicator startAnimating];
    self.unlockButton.hidden = YES;
    self.upArrow.hidden = YES;
    self.redeemButton.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisableInteraction"
                                                        object:self];
    [[TYPEIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        
        if (success) {
            _products = products;
            
            
            IAPProduct *product = [_products firstObject];
            UILabel *label = [UILabel new];
            label.text = product.skProduct.localizedTitle;
            NSLog(@"%@", label.text);
            
            UIAlertView *alertView;
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.Robinson.Typendium.Unlock"]) {
                
                 NSString *message = [NSString stringWithFormat:@"%@ %@", product.skProduct.localizedDescription, typendiumPrice];
                
                alertView = [[UIAlertView alloc] initWithTitle:product.skProduct.localizedTitle
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Redeem", nil];
                alertView.tag = 1;
                
            } else {
                
                NSString *message = [NSString stringWithFormat:@"%@ %@", product.skProduct.localizedDescription, typendiumPrice];
                
                alertView = [[UIAlertView alloc] initWithTitle:product.skProduct.localizedTitle
                                                       message:message
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

- (IBAction)redeemTypendium:(id)sender {
    
    [[TYPEIAPHelper sharedInstance] restoreCompletedTransactions];
    
    
//    [[TYPEIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
//
//    }];
    
    
//    [[TYPEIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == ![alertView cancelButtonIndex]) {
        
        if (alertView.tag == 1) {
            
            [[TYPEIAPHelper sharedInstance] restoreCompletedTransactions];
            
        } else {
            
            [[TYPEIAPHelper sharedInstance] buyProduct:[_products firstObject]];

        }
    } else {
        
        [self.activityIndicator stopAnimating];
        self.unlockButton.hidden = NO;
        self.upArrow.hidden = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableInteraction"
                                                            object:self];
    }

}

- (void)typendiumPrice:(NSNotification *) notificiation {
    
    NSDictionary *notificationDictionary = notificiation.userInfo;
    typendiumPrice = [notificationDictionary objectForKey:@"TypendiumPrice"];
    
    self.infoText.text = [NSString stringWithFormat:@"%@ %@ %@", @"By purchasing Typendium for", typendiumPrice, @"you will gain access to all locked content, as well as any content released in the future." ];
    

    
}

- (void)unlockTypendiumNotification:(NSNotification *) notification {
    
    [self.activityIndicator stopAnimating];
    self.unlockButton.hidden = NO;
    self.upArrow.hidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableInteraction"
                                                        object:self];
    [self.unlockButton setTitle:@"Redeem Typendium" forState:UIControlStateNormal];
    self.redeemButton.hidden = YES;
}

- (void)purchaseFailed:(NSNotification *) notification {
    
    [self.activityIndicator stopAnimating];
    self.unlockButton.hidden = NO;
    self.upArrow.hidden = NO;
    self.redeemButton.hidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableInteraction"
                                                        object:self];
    
}
@end
