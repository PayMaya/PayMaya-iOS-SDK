//
//  PMDCartViewController.m
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

#import "PMDCartViewController.h"
#import "PMDCartItemTableViewCell.h"
#import "PMDCartTableHeaderView.h"
#import "PMDShopViewController.h"
#import "PMDUtilities.h"
#import "PMDUserInformationViewController.h"

@interface PMDCartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UITableView *itemsTableView;
@property (nonatomic, strong) UILabel *subtotalLabel;
@property (nonatomic, strong) UILabel *shippingFeeLabel;
@property (nonatomic, strong) UILabel *taxLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UIButton *continueButton;

@property (nonatomic, strong) NSMutableArray *boughtProductsArray;
@property (nonatomic, strong) NSNumber *subtotal;
@property (nonatomic, strong) NSNumber *shippingFee;
@property (nonatomic, strong) NSNumber *tax;
@property (nonatomic, strong) NSNumber *total;

@end

@implementation PMDCartViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.subtotal = @(0);
        self.shippingFee = @(0);
        self.tax = @(0);
        self.total = @(0);
    }
    return self;
}

- (instancetype)initWithBoughtProductsArray:(NSMutableArray *)boughtProductsArray
{
    self = [self initWithNibName:nil bundle:nil];
    if (!self) return nil;
    self.boughtProductsArray = boughtProductsArray;
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    self.scrollViewContentView = [[UIView alloc] init];
    self.scrollViewContentView.backgroundColor = [UIColor clearColor];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentView];
    
    self.itemsTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.itemsTableView.backgroundColor = [UIColor clearColor];
    self.itemsTableView.estimatedRowHeight = 50.0;
    self.itemsTableView.rowHeight = UITableViewAutomaticDimension;
    self.itemsTableView.delegate = self;
    self.itemsTableView.dataSource = self;
    self.itemsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.itemsTableView registerClass:[PMDCartItemTableViewCell class] forCellReuseIdentifier:[PMDCartItemTableViewCell reuseIdentifier]];
    [self.scrollViewContentView addSubview:self.itemsTableView];
    
    self.subtotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtotalLabel.text = [NSString stringWithFormat:@"Subtotal: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.subtotal]];
    self.subtotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.subtotalLabel];
    
    self.shippingFeeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.shippingFeeLabel.text = [NSString stringWithFormat:@"Shipping Fee: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.shippingFee]];
    self.shippingFeeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.shippingFeeLabel];

    self.taxLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.taxLabel.text = [NSString stringWithFormat:@"Tax: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.tax]];
    self.taxLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.taxLabel];
    
    self.totalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalLabel.text = [NSString stringWithFormat:@"Total: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.total]];
    self.totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.totalLabel];
    
    self.continueButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.continueButton.enabled = YES;
    self.continueButton.layer.cornerRadius = 3.0f;
    self.continueButton.layer.borderWidth = 0.5f;
    self.continueButton.clipsToBounds = YES;
    self.continueButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.continueButton addTarget:self action:@selector(continueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewContentView addSubview:self.continueButton];
    
    [self setUpInitialValues];
    [self setUpLayoutConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Cart";
}

- (void)setUpInitialValues
{
    self.subtotal = @(0);
    for (NSMutableDictionary *productDict in self.boughtProductsArray) {
        NSNumber *perItemTotal = @([((PMDProduct *)productDict[@"product"]).amount doubleValue]*[productDict[@"quantity"] doubleValue]);
        self.subtotal = @([self.subtotal doubleValue] + [perItemTotal doubleValue]);
        productDict[@"totalAmount"] = perItemTotal;
    }
    self.subtotalLabel.text = [NSString stringWithFormat:@"Subtotal: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.subtotal]];
    self.shippingFee = @([self.subtotal doubleValue] * .1);
    self.shippingFeeLabel.text = [NSString stringWithFormat:@"Shipping Fee: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.shippingFee]];
    self.tax = @([self.subtotal doubleValue] * .12);
    self.taxLabel.text = [NSString stringWithFormat:@"Tax: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.tax]];
    self.total = @([self.subtotal doubleValue] + [self.shippingFee doubleValue] + [self.tax doubleValue]);
    self.totalLabel.text = [NSString stringWithFormat:@"Total: PHP %@", [[PMDUtilities currencyFormatter] stringFromNumber:self.total]];
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(
                                                                   _scrollView,
                                                                   _scrollViewContentView,
                                                                   _itemsTableView,
                                                                   _subtotalLabel,
                                                                   _shippingFeeLabel,
                                                                   _taxLabel,
                                                                   _totalLabel,
                                                                   _continueButton
                                                                   );
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollViewContentView(==_scrollView)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollViewContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_itemsTableView(200)]-[_subtotalLabel]-[_shippingFeeLabel]-[_taxLabel]-[_totalLabel]-30-[_continueButton]-30-|" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_itemsTableView]-|" options:NSLayoutFormatAlignAllTrailing metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_subtotalLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_shippingFeeLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_taxLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_totalLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
     [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_continueButton(150)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.continueButton attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.itemsTableView reloadData];
}

- (void)continueButtonClicked:(id)sender
{
    if ([self.boughtProductsArray count]  > 0) {
        NSDictionary *cartInformationDictionary = @{@"products" : self.boughtProductsArray,
                                                                                    @"subtotal" : self.subtotal,
                                                                                    @"shippingFee" : self.shippingFee,
                                                                                    @"tax" : self.tax,
                                                                                    @"total" : self.total
                                                                                    };
        
        PMDUserInformationViewController *userInformationViewController = [[PMDUserInformationViewController alloc] initWithNibName:nil bundle:nil cartInformation:cartInformationDictionary];
        [self.navigationController pushViewController:userInformationViewController animated:YES];
    }
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PMDCartTableHeaderView *headerView = [[PMDCartTableHeaderView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.boughtProductsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMDCartItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PMDCartItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(PMDCartItemTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    PMDProduct *product = (PMDProduct *)self.boughtProductsArray[indexPath.row][@"product"];
    [cell bindWithProduct:product withQuantity:(NSNumber *)self.boughtProductsArray[indexPath.row][@"quantity"]];
}

@end
