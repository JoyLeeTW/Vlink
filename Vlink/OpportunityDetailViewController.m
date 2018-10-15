//
//  OpportunityDetailViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "OpportunityDetailViewController.h"
#import "UIColor+PXExtentions.h"

@interface OpportunityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@end

@implementation OpportunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Opportunity"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(back:)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem animated:YES];
    
    // 類別的圓角
    self.categoryView.layer.cornerRadius = 10;
    self.categoryView.layer.masksToBounds = true;
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _categoryView.frame.size.width, _categoryView.frame.size.height)];
    categoryLabel.text = @"戶外陪伴類";
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.categoryView addSubview:categoryLabel];
    self.categoryView.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
//    self.categoryView.layer.borderWidth = 1;
//    self.categoryView.layer.borderColor = [[UIColor blackColor]CGColor];
    
    [self setLabel:self.titleLabel];
    [self setLabel:self.organizationLabel];
    [self setLabel:self.timeLabel];
    [self setLabel:self.positionLabel];
    [self setLabel:self.amountLabel];
    [self setLabel:self.remainingLabel];

    self.contentTextView.layer.cornerRadius = 10.0f;
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.backgroundColor = [UIColor colorFromHexString:@"#fff4c2"];
    
    self.joinButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.joinButton.layer.cornerRadius = 10.0f;
    self.joinButton.layer.masksToBounds = YES;
//    self.joinButton.layer.borderWidth = 1;
//    self.joinButton.layer.borderColor = [[UIColor blackColor]CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setLabel:(UILabel *)label {
    label.layer.cornerRadius = 10.0f;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [[UIColor colorFromHexString:@"#ffdc35"] CGColor];
    label.layer.borderWidth = 1.0f;
}

#pragma mark - IBAction

- (IBAction)apply:(id)sender {
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
