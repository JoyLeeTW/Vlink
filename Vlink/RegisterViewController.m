//
//  RegisterViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/10/14.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+PXExtentions.h"
#import "WebViewController.h"

@import Firebase;
@interface RegisterViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkPwTextField;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation RegisterViewController{
    BOOL islogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.checkPwTextField.delegate = self;
    
    [self buildLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    if(islogin){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabVC = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"tab"];
        [self presentViewController:tabVC animated:YES completion:^{}];
    }
}

#pragma marks - build Layout

-(void) buildLayout{
    self.registerButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.registerButton.layer.cornerRadius = 5.0f;
    self.registerButton.clipsToBounds = true;
    
    self.backButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.backButton.layer.cornerRadius = 5.0f;
    self.backButton.clipsToBounds = true;
    
    [self setTextField:self.nameTextField];
    [self setTextField:self.emailTextField];
    [self setTextField:self.passwordTextField];
    [self.passwordTextField setSecureTextEntry:YES];
    [self setTextField:self.checkPwTextField];
    [self.checkPwTextField setSecureTextEntry:YES];
}

- (void) setTextField:(UITextField *)textField{
    textField.layer.cornerRadius = 10.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[UIColor colorFromHexString:@"#ffdc35"] CGColor];
    textField.layer.borderWidth = 1.0f;
}

#pragma marks - IBAction

- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUp:(id)sender {
    NSString *mail = self.emailTextField.text;
    NSString *name = self.nameTextField.text;
    NSString *password = self.passwordTextField.text;
    if([self checkIsEmpty:mail]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Email不得為空" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self checkIsEmpty:name]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"顯示名稱不得為空" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self checkIsEmpty:password]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密碼不得為空" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self checkPasswordStyle:password]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密碼須為英數字6~10碼" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        self.passwordTextField.text = @"";
        self.checkPwTextField.text = @"";
    }else if(![password isEqualToString:self.checkPwTextField.text]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密碼不一致" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        self.passwordTextField.text = @"";
        self.checkPwTextField.text = @"";
    }else{
        [[FIRAuth auth] createUserWithEmail:self.emailTextField.text
                                   password:self.passwordTextField.text
                                 completion:^(FIRAuthDataResult * _Nullable authResult,NSError * _Nullable error) {
                                     NSLog(@"***** [FIRAuth auth].currentUser [%@] ****",[FIRAuth auth].currentUser);
                                     NSString *userID = [FIRAuth auth].currentUser.uid;
                                     [[[[self.ref child:@"userData"] child:userID] child:@"name"] setValue:self.nameTextField.text];
                                     [[[[self.ref child:@"userData"] child:userID] child:@"email"] setValue:self.emailTextField.text];
                                     [[[[self.ref child:@"userData"] child:userID] child:@"type"] setValue:@"1"];
                                     self->islogin = YES;
                                     
                                     // 開問卷
                                     WebViewController *formWebViewController = [[WebViewController alloc] init];
                                     formWebViewController.navigationBarTitle = @"人格特質問卷";
                                     NSString *urlString = [NSString stringWithFormat:@"https://docs.google.com/forms/d/e/1FAIpQLSdXPWlzDuehJaRispEujtTa8GTDCPoV1lPHsy7cKxgLmIRyUQ/viewform?usp=pp_url&entry.1672938002=%@",userID];
                                     formWebViewController.urlString = urlString;
                                     UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:formWebViewController];
                                     
                                     [self presentViewController:navVC animated:YES completion:^{}];
                                     
                                 }];
        
    }
}

- (BOOL)checkIsEmpty:(NSString *)password {
    return !(password && password.length);
}

- (BOOL)checkPasswordStyle:(NSString *)password {
    NSString *regEx = @"[a-zA-Z0-9]{6,10}$";
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if([card evaluateWithObject:password]){
        return NO;
    }
    return YES;
}


# pragma marks - UItextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
