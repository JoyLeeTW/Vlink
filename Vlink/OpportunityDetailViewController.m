//
//  OpportunityDetailViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "OpportunityDetailViewController.h"
#import "UIColor+PXExtentions.h"
#import "OpportunityViewController.h"

@interface OpportunityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *starTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@end

@implementation OpportunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Vlink";
    
    // 類別的圓角
    self.categoryView.layer.cornerRadius = 10;
    self.categoryView.layer.masksToBounds = true;
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _categoryView.frame.size.width, _categoryView.frame.size.height)];
    switch (self.oppo.type) {
        case 0:
            categoryLabel.text = @"戶外活動類";
            break;
        case 1:
            categoryLabel.text = @"關懷陪伴類";
            break;
        case 2:
            categoryLabel.text = @"行政/藝術類";
            break;
        case 3:
            categoryLabel.text = @"綠色環保類";
            break;
    }
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.categoryView addSubview:categoryLabel];
    self.categoryView.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    
    [self setLabel:self.titleLabel];
    [self setLabel:self.organizationLabel];
    [self setLabel:self.starTimeLabel];
    [self setLabel:self.endTimeLabel];
    [self setLabel:self.positionLabel];
    [self setLabel:self.amountLabel];
    [self setLabel:self.remainingLabel];

    self.contentTextView.layer.cornerRadius = 10.0f;
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.backgroundColor = [UIColor colorFromHexString:@"#fff4c2"];
    
    self.joinButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.joinButton.layer.cornerRadius = 10.0f;
    self.joinButton.layer.masksToBounds = YES;

    self.titleLabel.text = self.oppo.title;
    self.organizationLabel.text = self.oppo.organization;
    self.starTimeLabel.text = self.oppo.startTime;
    self.endTimeLabel.text = self.oppo.endTime;
    self.positionLabel.text = self.oppo.location;
    self.amountLabel.text = [NSString stringWithFormat:@"活動人數：%@", self.oppo.amount];
    self.remainingLabel.text = [NSString stringWithFormat:@"需求人數：%@", self.oppo.remaining];
    self.contentTextView.text = self.oppo.introduction;
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
    self.joinButton.backgroundColor = [UIColor colorFromHexString:@"#ff7735"];
    self.joinButton.titleLabel.text = @"已參加";
    
    int amout = [self.oppo.remaining intValue];
    NSString *remaining = [NSString stringWithFormat:@"%ld", (long)amout-1];
    NSLog(@"***** ref [%@] oppoID [%@] *****", self.ref, self.oppo.oppo_id);
    [[[self.ref child:self.oppo.oppo_id] child:@"remaining"] setValue:remaining];
    self.remainingLabel.text = [NSString stringWithFormat:@"活動人數：%@", remaining];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    NSLog(@"***** self.navigationController.viewControllers [%@] *****", self.navigationController.viewControllers);
        [self.navigationController popViewControllerAnimated:YES];
}


@end
