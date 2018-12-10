//
//  LoginViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+PXExtentions.h"
@import Firebase;
@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *emailLineView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordLineView;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPWButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.emailTextField.text = @"moom913@gmail.com";
    self.passwordTextField.text = @"qqqqqq";
    
}

#pragma mark - layout
- (void)layout {
    [self.emailView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mail"]]];
    [self.passwordView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"password"]]];
    
    self.emailTextField.placeholder = @"Email";
    self.passwordTextField.placeholder = @"Password";
    [self.passwordTextField setSecureTextEntry:YES];
    
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
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text
                           password:self.passwordTextField.text
                         completion:^(FIRAuthDataResult * _Nullable authResult,NSError * _Nullable error) {
                             NSLog(@"***** authResult [%@] error [%@] *****", authResult, error);
                             if(error){
                                 switch(error.code){
                                     case 17009:{
                                         // 密碼錯誤
                                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密碼錯誤" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
                                         [alert addAction:okAction];
                                         UIAlertAction *updatePasswordAction = [UIAlertAction actionWithTitle:@"忘記密碼" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                                             [[FIRAuth auth] sendPasswordResetWithEmail:self.emailTextField.text
                                                                             completion:^(NSError * _Nullable error) {
                                                                                 if(error){
                                                                                     UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"重設密碼失敗，請關閉APP重試" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                                                     UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
                                                                                     [alert2 addAction:confirmAction];
                                                                                 }
                                                                                 UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"重設密碼成功，請檢查信箱信件" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                                                 UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
                                                                                 [alert2 addAction:confirmAction];
                                                                                 [self presentViewController:alert2 animated:YES completion:nil];
                                                                             }];
                                         }];
                                         [alert addAction:updatePasswordAction];
                                         [self presentViewController:alert animated:YES completion:nil];
                                         break;
                                     }
                                     case 17011:{
                                         // 帳號錯誤
                                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"帳號錯誤" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
                                         [alert addAction:okAction];
                                         [self presentViewController:alert animated:YES completion:nil];
                                         break;
                                     }
                                 }
                             }else{
                                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                 UITabBarController *tabVC = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"tab"];
                                 
                                 NSLog(@"***** userID [%@]", authResult.user.uid);
                                 
                                 [self presentViewController:tabVC animated:YES completion:^{}];
                             }
                             
                         }];
}


# pragma marks - UItextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
