//
//  PMDAddToCartViewController.m
//  PayMayaSDKDemo
//
//  Created by Elijah Cayabyab on 01/11/2015.
//  Copyright © 2015 Elijah Joshua Cayabyab. All rights reserved.
//

#import "PMDAddToCartViewController.h"
#import "PMDUtilities.h"

@interface PMDAddToCartViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UILabel *productDescriptionLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIView *productQuantityView;
@property (nonatomic, strong) UILabel *productQuantityLabel;
@property (nonatomic, strong) UITextField *productQuantityValueTextField;
@property (nonatomic, strong) UIButton *addItemButton;
@property (nonatomic, strong) UIButton *removeItemButton;
@property (nonatomic, strong) UIButton *addToCartButton;

@property (nonatomic, strong) PMDProduct *product;

@end

@implementation PMDAddToCartViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil product:(PMDProduct *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.product = product;
    }
    return self;
}

- (void)loadView {
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
    
    self.productImageView = [[UIImageView alloc] initWithImage:self.product.image];
    self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.productImageView];
    
    self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productNameLabel.text = self.product.name;
    self.productNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.productNameLabel];
    
    self.productDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productDescriptionLabel.text = self.product.itemDescription;
    self.productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.productDescriptionLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.product.currency, [[PMDUtilities currencyFormatter] stringFromNumber:self.product.amount]];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.priceLabel];
    
    self.separatorView = [[UIView alloc] initWithFrame:CGRectZero];
    self.separatorView.backgroundColor = [UIColor blackColor];
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.separatorView];
    
    self.productQuantityView = [[UIView alloc] initWithFrame:CGRectZero];
    self.productQuantityView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.productQuantityView];
    
    self.productQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productQuantityLabel.text = @"No. of items: ";
    self.productQuantityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.productQuantityView addSubview:self.productQuantityLabel];
    
    self.productQuantityValueTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.productQuantityValueTextField.text = @"0";
    self.productQuantityValueTextField.enabled = NO;
    self.productQuantityValueTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.productQuantityView addSubview:self.productQuantityValueTextField];
    
    self.addItemButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.addItemButton.enabled = YES;
    self.addItemButton.layer.cornerRadius = 3.0f;
    self.addItemButton.layer.borderWidth = 0.5f;
    self.addItemButton.clipsToBounds = YES;
    self.addItemButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addItemButton setTitle:@"+" forState:UIControlStateNormal];
    [self.addItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addItemButton addTarget:self action:@selector(addItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.productQuantityView addSubview:self.addItemButton];
    
    self.removeItemButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.removeItemButton.enabled = YES;
    self.removeItemButton.layer.cornerRadius = 3.0f;
    self.removeItemButton.layer.borderWidth = 0.5f;
    self.removeItemButton.clipsToBounds = YES;
    self.removeItemButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.removeItemButton setTitle:@"-" forState:UIControlStateNormal];
    [self.removeItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.removeItemButton addTarget:self action:@selector(removeItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.productQuantityView addSubview:self.removeItemButton];
    
    self.addToCartButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.addToCartButton.enabled = YES;
    self.addToCartButton.layer.cornerRadius = 3.0f;
    self.addToCartButton.layer.borderWidth = 0.5f;
    self.addToCartButton.clipsToBounds = YES;
    self.addToCartButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addToCartButton setTitle:@"Add To Cart" forState:UIControlStateNormal];
    [self.addToCartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addToCartButton addTarget:self action:@selector(addToCartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewContentView addSubview:self.addToCartButton];

    [self setUpLayoutConstraints];
}

- (void)setUpLayoutConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(
                                                                   _scrollView,
                                                                   _scrollViewContentView,
                                                                   _productImageView,
                                                                   _productNameLabel,
                                                                   _productDescriptionLabel,
                                                                   _priceLabel,
                                                                   _separatorView,
                                                                   _productQuantityView,
                                                                   _productQuantityLabel,
                                                                   _productQuantityValueTextField,
                                                                   _addItemButton,
                                                                   _removeItemButton,
                                                                   _addToCartButton
                                                                   );
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollViewContentView(==_scrollView)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollViewContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.productImageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_productImageView(200)]-20-[_productNameLabel]-[_productDescriptionLabel]-25-[_priceLabel]-25-[_separatorView(2)]-25-[_productQuantityView]-[_addToCartButton]-20-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_separatorView]-|" options:0 metrics:nil views:viewsDictionary]];
     [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_productQuantityView]-|" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_addToCartButton(150)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.productQuantityView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_productQuantityLabel]-[_productQuantityValueTextField]->=0-[_addItemButton]-[_removeItemButton]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    [self.productQuantityView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_addItemButton]-|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add To Cart";
}

- (void)addItemButtonClicked:(id)sender
{
    NSNumber *quantity = [[PMDUtilities decimalNumberFormatter] numberFromString:self.productQuantityValueTextField.text];
    self.productQuantityValueTextField.text = [@([quantity intValue] + 1) stringValue];
}

- (void)removeItemButtonClicked:(id)sender
{
    NSNumber *quantity = [[PMDUtilities decimalNumberFormatter] numberFromString:self.productQuantityValueTextField.text];
    if ([quantity intValue] > 0) {
        self.productQuantityValueTextField.text = [@([quantity intValue] - 1) stringValue];
    }
}

- (void)addToCartButtonClicked:(id)sender
{
    NSNumber *quantity = [[PMDUtilities decimalNumberFormatter] numberFromString:self.productQuantityValueTextField.text];
    NSString *message = [NSString stringWithFormat:@"Successfully added %@ item(s) to cart", quantity];
    if ([quantity intValue] > 0) {
        if ([self.delegate respondsToSelector:@selector(addToCartViewController:didAddProductToCart:quantity:)]) {
            [self.delegate addToCartViewController:self didAddProductToCart:self.product quantity:quantity];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add To Cart Successful"
                                                                                            message:message
                                                                                            delegate:self
                                                                              cancelButtonTitle:@"OK"
                                                                              otherButtonTitles:nil];
            [alertView show];
        }
    }
    self.productQuantityValueTextField.text = @"0";
}

@end
