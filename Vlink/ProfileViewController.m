//
//  ProfileViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/10/14.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIColor+PXExtentions.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Vlink";
    
    self.testButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.testButton.layer.cornerRadius = 10.f;
    self.testButton.layer.masksToBounds = YES;
    //NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@">"];
    
    //[self.testButton setAttributedTitle:attributedString forState:UIControlStateNormal];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
