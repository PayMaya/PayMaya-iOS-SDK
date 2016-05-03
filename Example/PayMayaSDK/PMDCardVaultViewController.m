//
//  PMSDKCardVaultViewController.m
//  PayMayaSDKDemo
//
//  Copyright (c) 2016 PayMaya Philippines, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PMDCardVaultViewController.h"
#import "PMDCardInputViewController.h"
#import "PMDCard.h"
#import "PMDCardTableViewCell.h"
#import "PMDVerifyCardViewController.h"
#import "PMDActivityIndicatorView.h"

@interface PMDCardVaultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) UILabel *noCardsLabel;
@property (nonatomic, strong) UITableView *cardsTableView;
@property (nonatomic, strong) PMDActivityIndicatorView *loadingView;

@property (nonatomic, strong) NSMutableArray *cardsArray;

@end

@implementation PMDCardVaultViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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
    
    self.loadingView = [[PMDActivityIndicatorView alloc] initWithFrame:CGRectZero label:@"Loading"];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.loadingView.alpha = 0.0f;
    [self.view addSubview:self.loadingView];
    
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
    
//    if ([card.state isEqualToString:@"PREVERIFICATION"]) {
//        PMDVerifyCardViewController *verifyCardViewController = [[PMDVerifyCardViewController alloc] initWithCheckoutURL:card.verificationURL redirectUrl:self.apiManager.baseUrl];
//        verifyCardViewController.title = @"Verify Card";
//        UINavigationController *verifyCardNavigationController = [[UINavigationController alloc] initWithRootViewController:verifyCardViewController];
//        [self presentViewController:verifyCardNavigationController animated:YES completion:nil];
//    }
}

@end
