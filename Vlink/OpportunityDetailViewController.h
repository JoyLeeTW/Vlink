//
//  OpportunityDetailViewController.h
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpportunityDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end
