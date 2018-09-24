//
//  OpportunityViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "OpportunityViewController.h"
#import "OpportunityCellTableViewCell.h"

@interface OpportunityViewController ()

@end

@implementation OpportunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Vink";

    _OpportunitytableView.delegate = self;
    _OpportunitytableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    OpportunityCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.timeLabel.text = @"11:00";
    cell.backgroundColor = [UIColor yellowColor];
    
    cell.categoryView.layer.cornerRadius = 10;
    cell.categoryView.layer.masksToBounds = true;
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.categoryView.frame.size.width, cell.categoryView.frame.size.height)];
    categoryLabel.text = @"公益類";
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [cell.categoryView addSubview:categoryLabel];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

# pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

//- (CGFloat)tableView:(UITableView *)tableView


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}


- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}
 */

@end
