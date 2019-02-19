//
//  PMDCardInputViewController.m
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

#import "PMDCardInputViewController.h"
#import "PMDActivityIndicatorView.h"
#import "PMDVerifyCardViewController.h"
#import "PMDCustomer.h"
#import "CardIO.h"

@interface PMDCardInputViewController () <UIPickerViewDataSource, UIPickerViewDelegate, PayMayaPaymentsDelegate, PMDVerifyCardViewControllerDelegate,  CardIOPaymentViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UIImageView *cardImageView;
@property (nonatomic, strong) UITextField *cardNumberTextField;
@property (nonatomic, strong) UITextField *expiryMonthTextField;
@property (nonatomic, strong) UIPickerView *expiryMonthPickerView;
@property (nonatomic, strong) UITextField *expiryYearTextField;
@property (nonatomic, strong) UIPickerView *expiryYearPickerView;
@property (nonatomic, strong) UITextField *cvvTextField;
@property (nonatomic, strong) UIButton *scanCardButton;
@property (nonatomic, strong) UIButton *generateTokenButton;
@property (nonatomic, strong) UILabel *paymentTokenLabel;
@property (nonatomic, strong) UITextField *paymentTokenTextField;
@property (nonatomic, strong) UIButton *duplicateTokenButton;

@property (nonatomic, strong) NSDateFormatter *yearDateFormatter;
@property (nonatomic, strong) PMDActivityIndicatorView *activityIndicatorView;

@property (nonatomic) PMDCardInputViewControllerState state;
@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) NSDictionary *paymentInformation;

@end

@implementation PMDCardInputViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil state:(PMDCardInputViewControllerState)state paymentInformation:(NSDictionary *)paymentInformation
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.state = state;
        self.paymentInformation = paymentInformation;
        NSData *customerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"PayMayaSDKCustomer"];
        PMDCustomer *customer = [NSKeyedUnarchiver unarchiveObjectWithData:customerData];
        self.customerID = customer.identifier;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.yearDateFormatter = [[NSDateFormatter alloc] init];
        [self.yearDateFormatter setDateFormat:@"yyyy"];
    });
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    self.activityIndicatorView = [[PMDActivityIndicatorView alloc] initWithFrame:CGRectZero label:@"Processing"];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.alpha = 0.0f;
    [self.view addSubview:self.activityIndicatorView];
    
    self.scrollViewContentView = [[UIView alloc] init];
    self.scrollViewContentView.backgroundColor = [UIColor clearColor];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentView];
    
    self.cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card"]];
    self.cardImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollViewContentView addSubview:self.cardImageView];
    
    self.cardNumberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.cardNumberTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.cardNumberTextField.borderStyle = UITextBorderStyleLine;
    self.cardNumberTextField.layer.borderWidth = 1;
    self.cardNumberTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.cardNumberTextField.placeholder = @"Card Number";
    [self.scrollViewContentView addSubview:self.cardNumberTextField];
    
    self.expiryMonthTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.expiryMonthTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.expiryMonthTextField.borderStyle = UITextBorderStyleLine;
    self.expiryMonthTextField.layer.borderWidth = 1;
    self.expiryMonthTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.expiryMonthTextField.placeholder = @"Exp. Month";
    [self.scrollViewContentView addSubview:self.expiryMonthTextField];
    
    self.expiryMonthPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.expiryMonthPickerView.showsSelectionIndicator = YES;
    self.expiryMonthPickerView.dataSource = self;
    self.expiryMonthPickerView.delegate = self;
    self.expiryMonthPickerView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    self.expiryMonthTextField.inputView = self.expiryMonthPickerView;
    
    self.expiryYearTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.expiryYearTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.expiryYearTextField.borderStyle = UITextBorderStyleLine;
    self.expiryYearTextField.layer.borderWidth = 1;
    self.expiryYearTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.expiryYearTextField.placeholder = @"Exp. Year";
    [self.scrollViewContentView addSubview:self.expiryYearTextField];
    
    self.expiryYearPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.expiryYearPickerView.showsSelectionIndicator = YES;
    self.expiryYearPickerView.dataSource = self;
    self.expiryYearPickerView.delegate = self;
    self.expiryYearPickerView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    self.expiryYearTextField.inputView = self.expiryYearPickerView;
    
    self.cvvTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.cvvTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.cvvTextField.borderStyle = UITextBorderStyleLine;
    self.cvvTextField.layer.borderWidth = 1;
    self.cvvTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.cvvTextField.placeholder = @"CVC";
    self.cvvTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollViewContentView addSubview:self.cvvTextField];
    
    self.scanCardButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.scanCardButton.enabled = YES;
    self.scanCardButton.layer.cornerRadius = 3.0f;
    self.scanCardButton.layer.borderWidth = 0.5f;
    self.scanCardButton.clipsToBounds = YES;
    self.scanCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scanCardButton setTitle:@"Scan Card" forState:UIControlStateNormal];
    [self.scanCardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.scanCardButton addTarget:self action:@selector(scanCardButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewContentView addSubview:self.scanCardButton];
    
    NSString *generateTokenButtonTitle = (self.state == PMDCardInputViewControllerStatePayments) ? @"Pay" : @"Vault Card";
    
    self.generateTokenButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.generateTokenButton.enabled = YES;
    self.generateTokenButton.layer.cornerRadius = 3.0f;
    self.generateTokenButton.layer.borderWidth = 0.5f;
    self.generateTokenButton.clipsToBounds = YES;
    self.generateTokenButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.generateTokenButton setTitle:generateTokenButtonTitle forState:UIControlStateNormal];
    [self.generateTokenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.generateTokenButton addTarget:self action:@selector(generateTokenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewContentView addSubview:self.generateTokenButton];
    
    if (self.state == PMDCardInputViewControllerStatePayments) {
        self.paymentTokenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.paymentTokenLabel.translatesAutoresizingMaskIntoConstraints  = NO;
        self.paymentTokenLabel.text = @"Generated Token";
        self.paymentTokenLabel.hidden = YES;
        [self.scrollViewContentView addSubview:self.paymentTokenLabel];
        
        self.paymentTokenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.paymentTokenTextField.translatesAutoresizingMaskIntoConstraints = NO;
        self.paymentTokenTextField.borderStyle = UITextBorderStyleLine;
        self.paymentTokenTextField.layer.borderWidth = 1;
        self.paymentTokenTextField.layer.borderColor = [[UIColor grayColor] CGColor];
        self.paymentTokenTextField.hidden = YES;
        [self.scrollViewContentView addSubview:self.paymentTokenTextField];
        
        self.duplicateTokenButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.duplicateTokenButton.hidden= YES;
        self.duplicateTokenButton.layer.cornerRadius = 3.0f;
        self.duplicateTokenButton.layer.borderWidth = 0.5f;
        self.duplicateTokenButton.clipsToBounds = YES;
        self.duplicateTokenButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.duplicateTokenButton setTitle:@"Copy" forState:UIControlStateNormal];
        [self.duplicateTokenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.duplicateTokenButton addTarget:self action:@selector(duplicateTokenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewContentView addSubview:self.duplicateTokenButton];
    }
    
    self.cardNumberTextField.text = @"5123456789012346";
    self.expiryMonthTextField.text = @"05";
    self.expiryYearTextField.text = @"2017";
    self.cvvTextField.text = @"111";
    
    [self setUpLayoutConstraints];
}

- (void)setUpLayoutConstraints
{
    NSMutableDictionary *viewsDictionary = [NSDictionaryOfVariableBindings(
                                                                   _activityIndicatorView,
                                                                   _scrollView,
                                                                   _scrollViewContentView,
                                                                   _cardImageView,
                                                                   _cardNumberTextField,
                                                                   _expiryMonthTextField,
                                                                   _expiryYearTextField,
                                                                   _cvvTextField,
                                                                   _scanCardButton,
                                                                   _generateTokenButton
                                                                   ) mutableCopy];
    
    if (self.state == PMDCardInputViewControllerStatePayments) {
        [viewsDictionary addEntriesFromDictionary:NSDictionaryOfVariableBindings(_paymentTokenLabel,
                                                                                 _paymentTokenTextField,
                                                                                 _duplicateTokenButton)];
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_activityIndicatorView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_activityIndicatorView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollViewContentView(==_scrollView)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollViewContentView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewsDictionary]];
    
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cardNumberTextField]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_scanCardButton(200)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_expiryMonthTextField(_cvvTextField)]-[_expiryYearTextField(_cvvTextField)]-[_cvvTextField(_cvvTextField)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cardImageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scanCardButton attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_generateTokenButton(200)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.generateTokenButton attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    
    if (self.state == PMDCardInputViewControllerStatePayments) {
        [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_cardImageView]-30-[_cardNumberTextField]-[_expiryMonthTextField]-30-[_scanCardButton]-[_generateTokenButton]" options:0 metrics:nil views:viewsDictionary]];
        [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_generateTokenButton]-30-[_paymentTokenLabel]-[_paymentTokenTextField]-[_duplicateTokenButton]-|" options:0 metrics:nil views:viewsDictionary]];
        [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_paymentTokenTextField]-|" options:0 metrics:nil views:viewsDictionary]];
        [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_duplicateTokenButton(200)]" options:0 metrics:nil views:viewsDictionary]];
        [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.duplicateTokenButton attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
        [self.scrollViewContentView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.paymentTokenLabel attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    }
    else
    {
        [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_cardImageView]-30-[_cardNumberTextField]-[_expiryMonthTextField]-30-[_scanCardButton]-[_generateTokenButton]-|" options:0 metrics:nil views:viewsDictionary]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [CardIOUtilities preload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterForKeyboardNotifications];
}

- (void)scanCardButtonClicked:(id)sender
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.hideCardIOLogo = YES;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (void)generateTokenButtonClicked:(id)sender
{
    [self.view endEditing:YES];
    self.navigationItem.hidesBackButton = YES;
    self.generateTokenButton.enabled = NO;
    [UIView animateWithDuration:0.2f animations:^{
        self.activityIndicatorView.alpha = 1.0f;
    }];
    NSString *cardNumber = self.cardNumberTextField.text;
    NSString *expiryMonth = self.expiryMonthTextField.text;
    NSString *expiryYear = self.expiryYearTextField.text;
    NSString *cvc = self.cvvTextField.text;
    PMSDKCard *card = [[PMSDKCard alloc] initWithStringCardNumber:cardNumber
                                                      expiryMonth:expiryMonth
                                                       expiryYear:expiryYear
                                                              cvc:cvc];
    [[PayMayaSDK sharedInstance] createPaymentTokenFromCard:card delegate:self];
}

- (void)duplicateTokenButtonClicked:(id)sender
{
    NSLog(@"Copy token to clipboard.");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.paymentTokenTextField.text;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Token Copied"
                                                                   message:@"Payment token copied to clipboard."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - PayMayaPaymentsDelegate

- (void)createPaymentTokenDidFinishWithResult:(PMSDKPaymentTokenResult *)result
{
    NSString *paymentTokenStatus;
    
    if (result.status == PMSDKPaymentTokenStatusCreated) {
        paymentTokenStatus = @"Created";
    }
    
    if (self.state == PMDCardInputViewControllerStatePayments) {
        [self executePaymentWithPaymentToken:result.paymentToken];
    }
    else if (self.state == PMDCardInputViewControllerStateCardVault) {
        [self vaultCardWithPaymentToken:result.paymentToken];
    }
}

- (void)executePaymentWithPaymentToken:(PMSDKPaymentToken *)paymentToken
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.paymentTokenTextField.text = paymentToken.identifier;
        self.paymentTokenLabel.hidden = NO;
        self.paymentTokenTextField.hidden = NO;
        self.duplicateTokenButton.hidden = NO;
    });
    
    [self.apiManager executePaymentWithPaymentToken:paymentToken.identifier
                                 paymentInformation:self.paymentInformation
                                       successBlock:^(id response) {
       dispatch_async(dispatch_get_main_queue(), ^{
           self.navigationItem.hidesBackButton = NO;
           self.generateTokenButton.enabled = YES;
           self.activityIndicatorView.alpha = 0.0f;
           
           UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Payment Successful"
                                                                          message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {}];
           [alert addAction:defaultAction];
           [self presentViewController:alert animated:YES completion:nil];
       });
    } failureBlock:^(NSError *error) {
       NSLog(@"Error: %@", error);
       dispatch_async(dispatch_get_main_queue(), ^{
           UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Payment Error"
                                                                          message:error.userInfo[NSLocalizedDescriptionKey]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {}];
           [alert addAction:defaultAction];
           [self presentViewController:alert animated:YES completion:nil];
           
           self.navigationItem.hidesBackButton = NO;
           self.generateTokenButton.enabled = YES;
           self.activityIndicatorView.alpha = 0.0f;
       });
    }];
}

- (void)vaultCardWithPaymentToken:(PMSDKPaymentToken *)paymentToken
{
    __weak typeof(self)weakSelf = self;
    [self.apiManager vaultCardWithPaymentTokenID:paymentToken.identifier
                                      customerID:self.customerID
    successBlock:^(NSDictionary *response) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSString *key = [NSString stringWithFormat:@"%@_VERIFICATION_URL", response[@"cardTokenId"]];
        [[NSUserDefaults standardUserDefaults] setObject:response[@"verificationUrl"] forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           strongSelf.navigationItem.hidesBackButton = NO;
           strongSelf.generateTokenButton.enabled = YES;
           strongSelf.activityIndicatorView.alpha = 0.0f;
           
           UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Card Vault Successful"
                                                                          message:@"Card is successfully vaulted. Please verify card use it for payment."
                                                                   preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               PMDVerifyCardViewController *verifyCardViewController = [[PMDVerifyCardViewController alloc] initWithCheckoutURL:response[@"verificationUrl"] redirectUrl:self.apiManager.baseUrl];
               verifyCardViewController.title = @"Verify Card";
               verifyCardViewController.delegate = strongSelf;
               UINavigationController *verifyCardNavigationController = [[UINavigationController alloc] initWithRootViewController:verifyCardViewController];
               [strongSelf presentViewController:verifyCardNavigationController animated:YES completion:nil];
           }];
           [alert addAction:defaultAction];
           [strongSelf presentViewController:alert animated:YES completion:nil];
       });
   } failureBlock:^(NSError *error) {
       NSLog(@"Error: %@", error);
       __strong typeof(weakSelf)strongSelf = weakSelf;
       dispatch_async(dispatch_get_main_queue(), ^{
           UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Card Vault Error"
                                                                          message:error.userInfo[NSLocalizedDescriptionKey]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {}];
           [alert addAction:defaultAction];
           [strongSelf presentViewController:alert animated:YES completion:nil];
           
           strongSelf.navigationItem.hidesBackButton = NO;
           strongSelf.generateTokenButton.enabled = YES;
           strongSelf.activityIndicatorView.alpha = 0.0f;
       });
   }];
}

- (void)createPaymentTokenDidFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationItem.hidesBackButton = NO;
        self.generateTokenButton.enabled = YES;
        self.activityIndicatorView.alpha = 0.0f;
        NSLog(@"Error: %@", error);
    });
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numRows = 0;
    if (pickerView == self.expiryMonthPickerView) {
        numRows = 12;
    }
    else if (pickerView == self.expiryYearPickerView) {
        numRows = 50;
    }
    return numRows;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *text = @"";
    if (pickerView == self.expiryMonthPickerView) {
        text = [NSString stringWithFormat:@"%02ld", row+1];
    }
    else if (pickerView == self.expiryYearPickerView) {
        NSString *yearString = [self.yearDateFormatter stringFromDate:[NSDate date]];
        text = [NSString stringWithFormat:@"%02ld", [yearString intValue]+row];
    }
    return text;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.expiryMonthPickerView) {
        self.expiryMonthTextField.text = [NSString stringWithFormat:@"%02ld", row+1];
    }
    else if (pickerView == self.expiryYearPickerView) {
        NSString *yearString = [self.yearDateFormatter stringFromDate:[NSDate date]];
        self.expiryYearTextField.text = [NSString stringWithFormat:@"%02ld", [yearString intValue]+row];
    }
}

#pragma mark - Keyboard Handling Methods

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, keyboardSize.height + 10, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - PMDVerifyCardViewControllerDelegate

- (void)verifyCardViewControllerDidFinishCardVerification:(PMDVerifyCardViewController *)verifyCardViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Card IO delegates

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    // Use the card info...
    self.cardNumberTextField.text = info.cardNumber;
    self.expiryMonthTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)info.expiryMonth];
    self.expiryYearTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)info.expiryYear];
    self.cvvTextField.text = info.cvv;
    
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
