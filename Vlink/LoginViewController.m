//
//  LoginViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+PXExtentions.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

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
@property (weak, nonatomic) IBOutlet UIButton *forgetPWButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

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
    self.loginRegisterButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];

    
    self.forgetPWButton.layer.cornerRadius = 5.0f;
    self.forgetPWButton.clipsToBounds = true;
    self.forgetPWButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];

    
    self.registerButton.layer.cornerRadius = 5.0f;
    self.registerButton.clipsToBounds = true;
    self.registerButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
}

#pragma mark - IBAction

- (IBAction)pressLoginButton:(id)sender {
}



@end
