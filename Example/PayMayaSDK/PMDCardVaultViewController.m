//
//  PMDCardVaultViewController.m
//  PayMayaSDK
//
//  Created by Elijah Cayabyab on 06/04/2016.
//  Copyright © 2016 PayMaya Philippines, Inc. All rights reserved.
//

#import "PMDCardVaultViewController.h"
#import "PMDCardInputViewController.h"
#import "PMDCard.h"
#import "PMDCardTableViewCell.h"

@interface PMDCardVaultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) UILabel *noCardsLabel;
@property (nonatomic, strong) UITableView *cardsTableView;

@property (nonatomic, strong) NSArray *cardsArray;

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
    [self.cardsTableView registerClass:[PMDCardTableViewCell class] forCellReuseIdentifier:[PMDCardTableViewCell reuseIdentifier]];
    self.cardsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cardsTableView.rowHeight = UITableViewAutomaticDimension;
    self.cardsTableView.estimatedRowHeight = 200.0;
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
    
    PMDCard *card1 = [[PMDCard alloc] init];
    card1.tokenIdentifier = @"crd_6LmZsA3V2Cypjp4242";
    card1.type = @"master-card";
    card1.maskedPan = @"1234";
    card1.state = @"PREVERIFICATION";
    
    PMDCard *card2 = [[PMDCard alloc] init];
    card2.tokenIdentifier = @"crd_6LmZsA3V2Cypjp4243";
    card2.type = @"visa";
    card2.maskedPan = @"2345";
    card2.state = @"PREVERIFICATION";
    
    PMDCard *card3 = [[PMDCard alloc] init];
    card3.tokenIdentifier = @"crd_6LmZsA3V2Cypjp4244";
    card3.type = @"master-card";
    card3.maskedPan = @"3456";
    card3.state = @"VERIFIED";
    
    self.cardsArray = @[card1, card2, card3];
    
    self.customerID = [[NSUserDefaults standardUserDefaults] stringForKey:@"PayMayaSDKCustomerID"];
    
    self.navigationController.navigationBar.translucent = NO;
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
    
    if ([self.cardsArray count] > 0) {
        self.cardsTableView.alpha = 1.0;
    }
    [self.cardsTableView reloadData];
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
    PMDCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PMDCardTableViewCell reuseIdentifier] forIndexPath:indexPath];
    PMDCard *card = self.cardsArray[indexPath.row];
    [cell bindWithCard:card];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PMDCardTableViewCell height];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cardsArray count];
}

@end
