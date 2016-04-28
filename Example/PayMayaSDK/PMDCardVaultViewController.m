//
//  PMDCardVaultViewController.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 06/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCardVaultViewController.h"
#import "PMDCardInputViewController.h"

@interface PMDCardVaultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) UILabel *noCardsLabel;
@property (nonatomic, strong) UITableView *cardsTableView;

@end

@implementation PMDCardVaultViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.noCardsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noCardsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.noCardsLabel.text = @"There are no vaulted cards yet.";
    [self.view addSubview:self.noCardsLabel];
    
    self.cardsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.cardsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardsTableView.dataSource = self;
    self.cardsTableView.delegate = self;
    self.cardsTableView.alpha = 0.0f;
    [self.cardsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [self.view addSubview:self.cardsTableView];
    
    [self setupLayoutConstraints];
}

- (void)setupLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_noCardsLabel, _cardsTableView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cardsTableView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cardsTableView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.noCardsLabel attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.noCardsLabel attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_noCardsLabel]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customerID = [[NSUserDefaults standardUserDefaults] stringForKey:@"PayMayaSDKCustomerID"];
    
    UIBarButtonItem *addCardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddCardBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = addCardBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.apiManager getCardListWithCustomerID:self.customerID successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapAddCardBarButtonItem:(id)sender
{
    PMDCardInputViewController *cardInputViewController = [[PMDCardInputViewController alloc] initWithNibName:nil bundle:nil state:PMDCardInputViewControllerStateCardVault paymentInformation:nil];
    [self.navigationController pushViewController:cardInputViewController animated:YES];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

@end
