//
//  AddOpportunityViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/9/24.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "AddOpportunityViewController.h"
#import "UIColor+PXExtentions.h"
@import Firebase;

@interface AddOpportunityViewController () <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *organizationTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *startTimePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *endTimePickerView;
@property (weak, nonatomic) IBOutlet UITextView *detailContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation AddOpportunityViewController{
    NSArray *categoryPickerArray;
    NSArray *yearArray;
    NSArray *monthArray;
    NSArray *dateArray;
    NSArray *hourArray;
    NSArray *minuteArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{@"NSForegroundColorAttributeName": [UIColor blueColor]} forState:UIControlStateNormal] ;
    
    self.ref = [[[FIRDatabase database] reference] child:@"opportunity"];
    
    categoryPickerArray = @[@"戶外活動類", @"關懷陪伴類", @"行政/藝術類", @"綠色環保類"];
    yearArray = @[@"2018", @"2019", @"2020"];
    monthArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    dateArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",@"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
    hourArray = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",@"21", @"22", @"23", @"24" ];
    minuteArray = @[@"00", @"05", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55"];
    
    self.categoryPickerView.delegate = self;
    self.categoryPickerView.dataSource = self;
    
    self.startTimePickerView.delegate = self;
    self.startTimePickerView.dataSource = self;
    
    self.endTimePickerView.delegate = self;
    self.endTimePickerView.dataSource = self;

    self.navigationItem.title = @"Vlink";
    
    [self setTextField:self.titleTextField placeholder:@"活動名稱"];
    [self setTextField:self.organizationTextField placeholder:@"發起團體"];
    [self setTextField:self.locationTextField placeholder:@"活動地點"];
    [self setTextField:self.amountTextField placeholder:@"參與人數"];
    [self.amountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    self.addButton.layer.cornerRadius = 10.0f;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.addButton.titleLabel.textColor = [UIColor blackColor];
    
    self.detailContentTextView.delegate = self;
    self.detailContentTextView.layer.cornerRadius = 10.0f;
    self.detailContentTextView.layer.masksToBounds = YES;
    self.detailContentTextView.backgroundColor = [UIColor colorFromHexString:@"#fff4c2"];
    self.detailContentTextView.text = @"簡述一下工作內容吧～";
    
}


#pragma mark - IBAction

- (IBAction)AddOpportunity:(id)sender {
    
    NSLog(@"[%ld]", (long)[self.categoryPickerView selectedRowInComponent:0]);
    
    NSString *category = [self.categoryPickerView.delegate pickerView:self.categoryPickerView titleForRow:[self.categoryPickerView selectedRowInComponent:0] forComponent:0];
    NSString *startDateString = [NSString stringWithFormat:@"%@-%02d-%02d %@:%@"
                           ,[self.startTimePickerView.delegate pickerView:self.startTimePickerView titleForRow:[self.startTimePickerView selectedRowInComponent:0] forComponent:0]
                           ,[[self.startTimePickerView.delegate pickerView:self.startTimePickerView titleForRow:[self.startTimePickerView selectedRowInComponent:1] forComponent:1] intValue]
                           ,[[self.startTimePickerView.delegate pickerView:self.startTimePickerView titleForRow:[self.startTimePickerView selectedRowInComponent:2] forComponent:2] intValue]
                           ,[self.startTimePickerView.delegate pickerView:self.startTimePickerView titleForRow:[self.startTimePickerView selectedRowInComponent:3] forComponent:3]
                           ,[self.startTimePickerView.delegate pickerView:self.startTimePickerView titleForRow:[self.startTimePickerView selectedRowInComponent:4] forComponent:4]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *starDate = [dateFormat dateFromString:startDateString];
    NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    NSLog(@"starDate [%@] > [%@] > [%@]", startDateString, starDate, timestamp);
    NSString *endDate = [NSString stringWithFormat:@"%@%02d%02d %@:%@:00"
                           ,[self.endTimePickerView.delegate pickerView:self.endTimePickerView titleForRow:[self.endTimePickerView selectedRowInComponent:0] forComponent:0]
                           ,[[self.endTimePickerView.delegate pickerView:self.endTimePickerView titleForRow:[self.endTimePickerView selectedRowInComponent:1] forComponent:1] intValue]
                           ,[[self.endTimePickerView.delegate pickerView:self.endTimePickerView titleForRow:[self.endTimePickerView selectedRowInComponent:2] forComponent:2] intValue]
                           ,[self.endTimePickerView.delegate pickerView:self.endTimePickerView titleForRow:[self.endTimePickerView selectedRowInComponent:3] forComponent:3]
                           ,[self.endTimePickerView.delegate pickerView:self.endTimePickerView titleForRow:[self.endTimePickerView selectedRowInComponent:4] forComponent:4]];
    
    // if(所有值都不為空)
    FIRDatabaseReference *autoIdRef = [self.ref childByAutoId];
    [[[self.ref child:autoIdRef.key] child:@"type"] setValue:category];
    [[[self.ref child:autoIdRef.key] child:@"title"] setValue:self.titleTextField.text];
    [[[self.ref child:autoIdRef.key] child:@"location"] setValue:self.locationTextField.text];
    [[[self.ref child:autoIdRef.key] child:@"organization"] setValue:self.organizationTextField.text];
    [[[self.ref child:autoIdRef.key] child:@"startTime"] setValue:startDateString];
    [[[self.ref child:autoIdRef.key] child:@"endTime"] setValue:endDate];
    [[[self.ref child:autoIdRef.key] child:@"timestamp"] setValue:timestamp];
    [[[self.ref child:autoIdRef.key] child:@"amount"] setValue:self.amountTextField.text];
    [[[self.ref child:autoIdRef.key] child:@"remaining"] setValue:self.amountTextField.text];
    [[[self.ref child:autoIdRef.key] child:@"introduction"] setValue:self.detailContentTextView.text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.tabBarController setSelectedIndex:0];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma marks - UITextViewDelegate

- (void) setTextField:(UITextField *)textField placeholder:(NSString *)placeholderString{
    textField.delegate = self;
    textField.layer.cornerRadius = 10.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[UIColor colorFromHexString:@"#ffdc35"] CGColor];
    textField.layer.borderWidth = 1.0f;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderString attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"簡述一下工作內容吧～"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"簡述一下工作內容吧～";
    }
    [textView resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mrak - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma marks - PickerView

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    switch (pickerView.tag) {
        case 1:{
            return 1;
            break;
        }
        case 2:{
            //startTime
            return 5;
            break;
        }
        case 3:{
            //endTime
            return 5;
            break;
        }
        default:{
            return 0;
            break;
        }
    }
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:{
            return [categoryPickerArray count];
            break;
        }
        case 2:{
            //startTime
            switch (component) {
                case 0:
                    return [yearArray count];
                case 1:
                    return [monthArray count];
                case 2:
                    return [dateArray count];
                case 3:
                    return [hourArray count];
                case 4:
                    return [minuteArray count];
            }
        }
        case 3:{
            //endTime
            switch (component) {
                case 0:
                    return [yearArray count];
                case 1:
                    return [monthArray count];
                case 2:
                    return [dateArray count];
                case 3:
                    return [hourArray count];
                case 4:
                    return [minuteArray count];
            }
        }
        default:{
            return 0;
            break;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (pickerView.tag){
        case 1:
            //return categoryPickerArray[row];
            return [NSString stringWithFormat:@"%ld", (long)row];
            break;
        case 2:{
            switch (component){
                case 0:
                    return yearArray[row];
                case 1:
                    return monthArray[row];
                case 2:
                    return dateArray[row];
                case 3:
                    return hourArray[row];
                case 4:
                    return minuteArray[row];
            }
        }
        case 3:{
            switch (component) {
                case 0:
                    return yearArray[row];
                case 1:
                    return monthArray[row];
                case 2:
                    return dateArray[row];
                case 3:
                    return hourArray[row];
                case 4:
                    return minuteArray[row];
            }
        }
        default:{
            return NULL;
            break;
        }
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width-30, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    switch (pickerView.tag) {
        case 1:
            titleLabel.text = categoryPickerArray[row];
            break;
        case 2:{
            switch (component) {
                case 0:
                    titleLabel.text = [NSString stringWithFormat:@"%@", yearArray[row]];
                    break;
                case 1:
                    titleLabel.text = [NSString stringWithFormat:@"%@月",monthArray[row]];
                    break;
                case 2:
                    titleLabel.text = [NSString stringWithFormat:@"%@日",dateArray[row]];
                    break;
                case 3:
                    titleLabel.text = [NSString stringWithFormat:@"%@ :",hourArray[row]];
                    break;
                case 4:
                    titleLabel.text = [NSString stringWithFormat:@"%@",minuteArray[row]];
                    break;
            }
        }
        case 3:{
            switch (component) {
                case 0:
                    titleLabel.text = [NSString stringWithFormat:@"%@年",yearArray[row]];
                    break;
                case 1:
                    titleLabel.text = [NSString stringWithFormat:@"%@月",monthArray[row]];
                    break;
                case 2:
                    titleLabel.text = [NSString stringWithFormat:@"%@日",dateArray[row]];
                    break;
                case 3:
                    titleLabel.text = [NSString stringWithFormat:@"%@ :",hourArray[row]];
                    break;
                case 4:
                    titleLabel.text = [NSString stringWithFormat:@"%@",minuteArray[row]];
                    break;
            }
        }
    }
    return titleLabel;
}


@end
