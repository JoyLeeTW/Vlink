//
//  OpportunityDetailViewController.h
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Opportunity.h"
@import Firebase;

@interface OpportunityDetailViewController : UIViewController

@property (nonatomic, strong) Opportunity *oppo;
@property (nonatomic, strong) FIRDatabaseReference *ref;

@end
