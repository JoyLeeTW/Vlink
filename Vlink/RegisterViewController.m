//
//  RegisterViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/10/14.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+PXExtentions.h"
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

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.checkPwTextField.delegate = self;
    
    [self buildLayout];

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
    self.nameTextField.placeholder = @"Name";
    [self setTextField:self.emailTextField];
    self.emailTextField.placeholder = @"Email";
    [self setTextField:self.passwordTextField];
    self.passwordTextField.placeholder = @"password";
    [self.passwordTextField setSecureTextEntry:YES];
    [self setTextField:self.checkPwTextField];
    self.checkPwTextField.placeholder = @"Enter password again";
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
    if([self.passwordTextField.text isEqualToString:self.checkPwTextField.text]){
        [[FIRAuth auth] createUserWithEmail:self.emailTextField.text
                                   password:self.passwordTextField.text
                                 completion:^(FIRAuthDataResult * _Nullable authResult,NSError * _Nullable error) {
                                     NSString *userID = [FIRAuth auth].currentUser.uid;
                                     [[[[self.ref child:@"userData"] child:userID] child:@"name"] setValue:self.nameTextField.text];
                                     [[[[self.ref child:@"userData"] child:userID] child:@"email"] setValue:self.emailTextField.text];
                                     [[[[self.ref child:@"userData"] child:userID] child:@"type"] setValue:@"1"];
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
    }else{
        // alert
    }
    
}


# pragma marks - UItextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
