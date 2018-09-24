//
//  LoginViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *logoView;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *nameLineView;

@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UIView *emailLineView;

@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UIView *passwordLineView;

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - layout
- (void)layout {
    self.loginRegisterButton.layer.cornerRadius = 5.0f;
    self.loginRegisterButton.clipsToBounds = true;
    
    self.fbLoginButton.layer.cornerRadius = 5.0f;
    self.fbLoginButton.clipsToBounds = true;
}

#pragma mark - IBAction

- (IBAction)pressLoginButton:(id)sender {
}



@end
