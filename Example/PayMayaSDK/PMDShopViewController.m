//
//  PMDShopViewController.m
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 31/10/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import "PMDShopViewController.h"
#import "PMDShopTableViewCell.h"
#import "PMDProduct.h"
#import "PMDAddToCartViewController.h"
#import "PMDCartViewController.h"

@interface PMDShopViewController () <UITableViewDataSource, UITableViewDelegate, PMDShopTableViewCellDelegate, PMDAddToCartViewControllerDelegate>

@property (nonatomic, strong) UITableView *shopTableView;
@property (nonatomic, strong) NSArray *productsArray;
@property (nonatomic, strong) NSMutableArray *boughtProductsArray;

@end

@implementation PMDShopViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        PMDProduct *bagProduct = [[PMDProduct alloc] init];
        bagProduct.code = @"pmd_bag";
        bagProduct.image = [UIImage imageNamed:@"bag"];
        bagProduct.name = @"Bag";
        bagProduct.itemDescription = @"Black leather shoulder bag";
        bagProduct.amount = @349.99;
        bagProduct.currency = @"PHP";
        
        PMDProduct *shoesProduct = [[PMDProduct alloc] init];
        shoesProduct.code = @"pmd_shoes";
        shoesProduct.image = [UIImage imageNamed:@"shoes"];
        shoesProduct.name = @"Rubber Shoes";
        shoesProduct.itemDescription = @"Neon-colored running shoes";
        shoesProduct.amount = @1299.34;
        shoesProduct.currency = @"PHP";
        
        PMDProduct *necklaceProduct = [[PMDProduct alloc] init];
        necklaceProduct.code = @"pmd_necklace";
        necklaceProduct.image = [UIImage imageNamed:@"necklace"];
        necklaceProduct.name = @"Necklace";
        necklaceProduct.itemDescription = @"Elegant necklace with pendant";
        necklaceProduct.amount = @2999.00;
        necklaceProduct.currency = @"PHP";
        
        self.productsArray = @[bagProduct, shoesProduct, necklaceProduct];
        self.boughtProductsArray = [[NSMutableArray alloc] initWithArray:@[]];
    }
    return self;
}

- (void)loadView
{
    self.shopTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.shopTableView.backgroundColor = [UIColor clearColor];
    self.shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopTableView.separatorInset = UIEdgeInsetsZero;
    self.shopTableView.delegate = self;
    self.shopTableView.dataSource = self;
    self.shopTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.shopTableView registerClass:[PMDShopTableViewCell class] forCellReuseIdentifier:[PMDShopTableViewCell reuseIdentifier]];
    self.view = self.shopTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Cart" style:UIBarButtonItemStylePlain target:self action:@selector(didTapViewCart:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)didTapViewCart:(id)sender
{
    PMDCartViewController *cartViewController = [[PMDCartViewController alloc] initWithBoughtProductsArray:self.boughtProductsArray];
    [self.navigationController pushViewController:cartViewController animated:YES];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PMDShopTableViewCell height];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMDShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PMDShopTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(PMDShopTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    PMDProduct *product = (PMDProduct *)self.productsArray[indexPath.row];
    [cell bindWithProduct:product];
    cell.delegate = self;
}

#pragma mark - PMDShopTableViewCellDelegate

- (void)shopTableViewCellDidTapBuy:(PMDShopTableViewCell *)shopTableViewCell withProduct:(PMDProduct *)product
{
    PMDAddToCartViewController *addToCartViewController = [[PMDAddToCartViewController alloc] initWithNibName:nil bundle:nil product:product];
    addToCartViewController.delegate = self;
    [self.navigationController pushViewController:addToCartViewController animated:YES];
}

#pragma mark - PMDAddToCartVIewControllerDelegate

- (void)addToCartViewController:(PMDAddToCartViewController *)addToCartViewController didAddProductToCart:(PMDProduct *)product quantity:(NSNumber *)quantity
{
    for (NSMutableDictionary *boughtProduct in self.boughtProductsArray) {
        if ([boughtProduct[@"code"] isEqualToString:product.code]) {
            boughtProduct[@"quantity"] = @([boughtProduct[@"quantity"] intValue] + [quantity intValue]);
            return;
        }
    }
    NSMutableDictionary *productDict = [[NSMutableDictionary alloc] initWithDictionary:
                                        @{@"code" : product.code,
                                            @"product" : product,
                                            @"quantity" : quantity}];
    [self insertObject:productDict inBoughtProductsArrayAtIndex:self.boughtProductsArray.count];
}

- (void) insertObject:(id)anObject inBoughtProductsArrayAtIndex:(NSUInteger)index
{
    [self.boughtProductsArray insertObject:anObject atIndex:index];
}

- (void) removeObjectFromBoughtProductsArrayAtIndex:(NSUInteger)index
{
    [self.boughtProductsArray removeObjectAtIndex:index];
}

@end
