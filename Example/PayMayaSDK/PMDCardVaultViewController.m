//
//  PMDCardVaultViewController.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 06/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCardVaultViewController.h"

@interface PMDCardVaultViewController ()

@end

@implementation PMDCardVaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addCardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddCardBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = addCardBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapAddCardBarButtonItem:(id)sender
{
    
}

@end
