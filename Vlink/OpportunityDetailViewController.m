//
//  OpportunityDetailViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "OpportunityDetailViewController.h"

@interface OpportunityDetailViewController ()

@end

@implementation OpportunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Opportunity"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(back:)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem animated:YES];
    
    
    self.categoryView.layer.cornerRadius = 10;
    self.categoryView.layer.masksToBounds = true;
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _categoryView.frame.size.width, _categoryView.frame.size.height)];
    categoryLabel.text = @"公益類";
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.categoryView addSubview:categoryLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction

- (IBAction)apply:(id)sender {
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
