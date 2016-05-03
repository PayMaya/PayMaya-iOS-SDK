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
#import "PMDVerifyCardViewController.h"
#import "PMSDKLoadingView.h"

@interface PMDCardVaultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) UILabel *noCardsLabel;
@property (nonatomic, strong) UITableView *cardsTableView;
@property (nonatomic, strong) PMSDKLoadingView *loadingView;

@property (nonatomic, strong) NSMutableArray *cardsArray;

@end

@implementation PMDCardVaultViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.loadingView = [[PMSDKLoadingView alloc] initWithFrame:CGRectZero];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.loadingView.alpha = 0.0f;
    [self.view addSubview:self.loadingView];
    
    self.noCardsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noCardsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.noCardsLabel.text = @"There are no vaulted cards yet.";
    self.noCardsLabel.alpha = 0.0f;
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
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_loadingView, _noCardsLabel, _cardsTableView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_loadingView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_loadingView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cardsTableView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cardsTableView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.noCardsLabel attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.noCardsLabel attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_noCardsLabel]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customerID = [[NSUserDefaults standardUserDefaults] stringForKey:@"PayMayaSDKCustomerID"];
    
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *addCardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddCardBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = addCardBarButtonItem;
    
    [self refreshCards];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshCards];
}

- (void)refreshCards
{
    self.loadingView.alpha = 1.0f;
    __weak typeof(self)weakSelf = self;
    [self.apiManager getCardListWithCustomerID:self.customerID successBlock:^(NSDictionary *response) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.cardsArray = nil;
        strongSelf.cardsArray = [@[] mutableCopy];
        for (NSDictionary *cardInfo in response) {
            PMDCard *card = [[PMDCard alloc] init];
            card.tokenIdentifier = cardInfo[@"cardTokenId"];
            card.type = cardInfo[@"cardType"];
            card.maskedPan = cardInfo[@"maskedPan"];
            card.state = cardInfo[@"state"];
            [strongSelf.cardsArray addObject:card];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([strongSelf.cardsArray count] > 0) {
                    strongSelf.cardsTableView.alpha = 1.0f;
                    strongSelf.noCardsLabel.alpha = 0.0f;
                }
                else {
                    strongSelf.cardsTableView.alpha = 0.0f;
                    strongSelf.noCardsLabel.alpha = 1.0f;
                }
                strongSelf.loadingView.alpha = 0.0f;
                [strongSelf.cardsTableView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.loadingView.alpha = 0.0f;
            strongSelf.cardsTableView.alpha = 0.0f;
            strongSelf.noCardsLabel.alpha = 1.0f;
        });
    }];
}

- (void)didTapAddCardBarButtonItem:(id)sender
{
    PMDCardInputViewController *cardInputViewController = [[PMDCardInputViewController alloc] initWithNibName:nil bundle:nil state:PMDCardInputViewControllerStateCardVault paymentInformation:nil];
    cardInputViewController.apiManager = self.apiManager;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMDCard *card = self.cardsArray[indexPath.row];
    
    if ([card.state isEqualToString:@"PREVERIFICATION"]) {
        PMDVerifyCardViewController *verifyCardViewController = [[PMDVerifyCardViewController alloc] initWithCheckoutURL:card.verificationURL redirectUrl:@""];
        verifyCardViewController.title = @"Verify Card";
        UINavigationController *verifyCardNavigationController = [[UINavigationController alloc] initWithRootViewController:verifyCardViewController];
        [self presentViewController:verifyCardNavigationController animated:YES completion:nil];
    }
}

@end
