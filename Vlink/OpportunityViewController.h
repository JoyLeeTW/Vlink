//
//  OpportunityViewController.h
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpportunityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *OpportunitytableView;

@end

