//
//  JCSigninView.m
//  JourneyCapture
//
//  Created by Chris Sloey on 26/02/2014.
//  Copyright (c) 2014 FCD. All rights reserved.
//

#import "JCSigninView.h"
#import "JCSigninViewModel.h"
#import "JCTextField.h"

@implementation JCSigninView

- (id)initWithViewModel:(JCSigninViewModel *)signinViewModel
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _viewModel = signinViewModel;
    
    //Blue bit
    _profileBackgroundView = [UIView new];
    [_profileBackgroundView setBackgroundColor:[UIColor jc_blueColor]];
    _profileBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_profileBackgroundView];
    
    _loadingView = [JCLoadingView new];
    _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [_profileBackgroundView addSubview:_loadingView];
    
    // Email
    _emailFieldLabel = [UILabel new];
    _emailFieldLabel.text = @"Email Address";
    _emailFieldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_emailFieldLabel];

    _emailField = [JCTextField new];
    _emailField.userInteractionEnabled = YES;
    _emailField.borderStyle = UITextBorderStyleRoundedRect;
    _emailField.placeholder = @"Your Email";
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailField.translatesAutoresizingMaskIntoConstraints = NO;
    RAC(_viewModel, email) = _emailField.rac_textSignal;
    [self addSubview:_emailField];
    RACChannelTo(_viewModel, emailError) = RACChannelTo(_emailField, error);

    // Password
    _passwordFieldLabel = [UILabel new];
    _passwordFieldLabel.text = @"Password";
    _passwordFieldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_passwordFieldLabel];
    
    _passwordField = [JCTextField new];
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.secureTextEntry = YES;
    _passwordField.placeholder = @"Your Password";
    _passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    RAC(_viewModel, password) = _passwordField.rac_textSignal;
    [self addSubview:_passwordField];
    RACChannelTo(_viewModel, passwordError) = RACChannelTo(_passwordField, error);
    
    _signinButton = [UIButton new];
    _signinButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_signinButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [_signinButton setBackgroundColor:[UIColor jc_buttonGreenColor]];
    [_signupButton setTintColor:[UIColor whiteColor]];
    _signinButton.layer.masksToBounds = YES;
    _signinButton.layer.cornerRadius = 4.0f;
    [self addSubview:_signinButton];
    
    _signupButton = [UIButton new];
    _signupButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_signupButton setTintColor:[UIColor whiteColor]];
    [_signupButton setBackgroundColor:[UIColor jc_blueColor]];
    [_signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    _signupButton.layer.masksToBounds = YES;
    _signupButton.layer.cornerRadius = 4.0f;
    [self addSubview:_signupButton];

    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    int padding = 15;
    int labelPadding = 2;
    
    [_profileBackgroundView autoRemoveConstraintsAffectingView];
    [_profileBackgroundView autoSetDimension:ALDimensionHeight toSize:213.0f];
    [_profileBackgroundView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:0];
    [_profileBackgroundView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:0];
    [_profileBackgroundView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:0];
    
    [_loadingView autoRemoveConstraintsAffectingView];
    [_loadingView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_profileBackgroundView withOffset:150];
    [_loadingView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [_emailFieldLabel autoRemoveConstraintsAffectingView];
    [_emailFieldLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_emailFieldLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:padding];
    [_emailFieldLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_profileBackgroundView withOffset:padding];

    [_emailField autoRemoveConstraintsAffectingView];
    [_emailField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_emailField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-padding];
    [_emailField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_emailFieldLabel withOffset:labelPadding];
    [_emailField layoutError];
    
    [_passwordFieldLabel autoRemoveConstraintsAffectingView];
    [_passwordFieldLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_passwordFieldLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-padding];
    [_passwordFieldLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_emailField withOffset:padding];

    [_passwordField autoRemoveConstraintsAffectingView];
    [_passwordField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_passwordField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_passwordFieldLabel withOffset:labelPadding];
    [_passwordField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-padding];
    [_passwordField layoutError];

    [_signinButton autoRemoveConstraintsAffectingView];
    [_signinButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_signinButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-padding];
    [_signinButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_passwordField withOffset:padding];
    
    [_signupButton autoRemoveConstraintsAffectingView];
    [_signupButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:padding];
    [_signupButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-padding];
    [_signupButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_signinButton withOffset:padding];
    
    [super layoutSubviews];
}

@end
