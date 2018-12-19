//
//  ProfileViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/10/14.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIColor+PXExtentions.h"
#import "LoginViewController.h"
#import "WebViewController.h"
@import Firebase;

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *catagoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation ProfileViewController{
    NSArray *categoryArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{@"NSForegroundColorAttributeName": [UIColor blueColor]} forState:UIControlStateNormal] ;
    
    categoryArray = @[@"戶外活動類", @"關懷陪伴類", @"行政/藝術類", @"綠色環保類"];
    self.navigationItem.title = @"Vlink";
    
    self.ref = [[FIRDatabase database] reference];
    
    self.testButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.testButton.layer.cornerRadius = 10.f;
    self.testButton.layer.masksToBounds = YES;
    
    self.logoutButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.logoutButton.layer.cornerRadius = 10.f;
    self.logoutButton.layer.masksToBounds = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSLog(@"***** userID [%@] ******", userID);
    [[[self.ref child:@"userData"] child:userID] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSLog(@"***** [%@] *****", snapshot);
        self.nameLabel.text = snapshot.value[@"name"];
        self.emailLabel.text = snapshot.value[@"email"];
        NSString *categoryTypeString = snapshot.value[@"type"];
        if(categoryTypeString){
            self.catagoryLabel.text = self->categoryArray[[categoryTypeString intValue]];
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - IBAction

- (IBAction)takeForm:(id)sender {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    // 開問卷
    WebViewController *formWebViewController = [[WebViewController alloc] init];
    formWebViewController.navigationBarTitle = @"人格特質問卷";
    NSString *urlString = [NSString stringWithFormat:@"https://docs.google.com/forms/d/e/1FAIpQLSdXPWlzDuehJaRispEujtTa8GTDCPoV1lPHsy7cKxgLmIRyUQ/viewform?usp=pp_url&entry.1672938002=%@",userID];
    formWebViewController.urlString = urlString;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:formWebViewController];
    [self presentViewController:navVC animated:YES completion:^{}];
}

- (IBAction)logout:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }else{
        NSLog(@"***** viewControllers [%@] *****", self.navigationController.viewControllers);
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *vc = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:vc animated:YES completion:^{}];
    }
}

@end
