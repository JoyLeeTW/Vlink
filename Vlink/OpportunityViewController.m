//
//  OpportunityViewController.m
//  Vink
//
//  Created by Joy Lee on 2018/9/17.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "OpportunityViewController.h"
#import "OpportunityCellTableViewCell.h"
#import "UIColor+PXExtentions.h"
#import "OpportunityDetailViewController.h"
@import Firebase;

@interface OpportunityViewController ()
@property (strong, nonatomic) FIRDatabaseReference *idRef;
@property (strong, nonatomic) FIRDatabaseReference *chanceRef;

@property (strong, nonatomic) NSMutableArray *recommendArray;
@property (strong, nonatomic) NSMutableArray *timestampArray;
@end

@implementation OpportunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Vlink";
    self.tabBarController.tabBar.barTintColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.tabBarController.tabBar.tintColor = [UIColor blackColor];
    if (@available(iOS 10.0, *)) {
        self.tabBarController.tabBar.unselectedItemTintColor = [UIColor grayColor];
    }
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
    
    _OpportunitytableView.delegate = self;
    _OpportunitytableView.dataSource = self;
    
    self.recommendArray = [[NSMutableArray alloc] init];
    self.timestampArray = [[NSMutableArray alloc] init];

    // get user value
    self.idRef = [[[[FIRDatabase database] reference] child:@"userData"] child:[FIRAuth auth].currentUser.uid];
    [self.idRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // get chancd data
        self.chanceRef = [[[FIRDatabase database] reference] child:@"opportunity"];
        FIRDatabaseQuery *query = [[self.chanceRef queryOrderedByChild:@"type"] queryEqualToValue:snapshot.value[@"type"]];
        [query observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSDictionary *dict = snapshot.value;
            for(NSString *key in dict.allKeys){
                Opportunity *opportunity = [Opportunity setWithTitle:dict[key][@"title"] organization:dict[key][@"organization"] startTime:dict[key][@"startTime"] endTime:dict[key][@"location"] location:dict[key][@"location"] amount:dict[key][@"amount"] remaining:dict[key][@"remaining"] type:[dict[key][@"type"] integerValue] introduction:dict[key][@"introduction"]];
                [self.recommendArray addObject:opportunity];
            }
            [self.OpportunitytableView reloadData];
        }];

    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
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
    cell.categoryView.layer.cornerRadius = 10;
    cell.categoryView.layer.masksToBounds = true;
    cell.categoryView.backgroundColor = [UIColor whiteColor]; //[UIColor colorFromHexString:@"#ffdc35"];
    
    if(indexPath.section == 0){
        cell.backgroundColor = [UIColor colorFromHexString:@"#fffefa"];
        Opportunity *oppo = self.recommendArray[indexPath.row];
        cell.titleLabel.text = oppo.title;
        cell.organizationLabel.text = oppo.organization;
        cell.timeLabel.text = oppo.startTime;
        cell.positionLabel.text = oppo.location;
        cell.totalPeopleLabel.text = [NSString stringWithFormat:@"活動人數：%@", oppo.amount];
        cell.remainingLabel.text = [NSString stringWithFormat:@"需求人數：%@", oppo.remaining];
        NSString *typeName;
        switch (oppo.type) {
            case OPPORTUNITYTYPE_OUT_COM:
                typeName = @"戶外陪伴類";
                break;
            case OPPORTUNITYTYPE_IN_COM:
                typeName = @"關懷陪伴類";
                break;
            case OPPORTUNITYTYPE_OUT_ALN:
                typeName = @"綠色環保類";
                break;
            case OPPORTUNITYTYPE_IN_ALN:
                typeName = @"行政/藝術類";
                break;
        }
        cell.categoryLabel.text = typeName;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recommendArray count];
}

# pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    //Set the background color of the View
    view.tintColor = [UIColor grayColor];
}

#pragma mark - IBAction

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.OpportunitytableView indexPathForSelectedRow];
    OpportunityDetailViewController *vc = [segue destinationViewController];
    [vc setOppo:self.recommendArray[indexPath.row]];
}

@end
