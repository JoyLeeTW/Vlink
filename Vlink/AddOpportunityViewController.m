//
//  AddOpportunityViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/9/24.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "AddOpportunityViewController.h"
#import "UIColor+PXExtentions.h"

@interface AddOpportunityViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *organizationTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *starHTextField;
@property (weak, nonatomic) IBOutlet UITextField *starMTextField;
@property (weak, nonatomic) IBOutlet UITextField *endHTextField;
@property (weak, nonatomic) IBOutlet UITextField *endMTextField;

@property (weak, nonatomic) IBOutlet UITextView *detailContentTextView;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) NSArray *categoryPickerArray;
@end

@implementation AddOpportunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryPickerArray = @[@"戶外陪伴類",@"室內陪伴類",@"戶外幫助類",@"室內幫助類"];
    
    self.categoryPickerView.delegate = self;
    self.categoryPickerView.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Vlink";
    
    [self setTextField:self.titleTextField];
    [self setTextField:self.organizationTextField];
    [self setTextField:self.locationTextField];
    [self setTextField:self.amountTextField];
    [self setTextField:self.yearTextField];
    [self setTextField:self.monthTextField];
    [self setTextField:self.dateTextField];
    [self setTextField:self.starHTextField];
    [self setTextField:self.starMTextField];
    [self setTextField:self.endHTextField];
    [self setTextField:self.endMTextField];
    
    self.addButton.layer.cornerRadius = 10.0f;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.backgroundColor = [UIColor colorFromHexString:@"#ffdc35"];
    self.addButton.titleLabel.textColor = [UIColor blackColor];
//    self.addButton.layer.borderWidth = 1;
//    self.addButton.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.detailContentTextView.layer.cornerRadius = 10.0f;
    self.detailContentTextView.layer.masksToBounds = YES;
    self.detailContentTextView.backgroundColor = [UIColor colorFromHexString:@"#fff4c2"];
    

}

- (void) setTextField:(UITextField *)textField{
    textField.layer.cornerRadius = 10.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[UIColor colorFromHexString:@"#ffdc35"] CGColor];
    textField.layer.borderWidth = 1.0f;
}

#pragma marks - pickerView



- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.categoryPickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.categoryPickerArray[row];
}
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
/*
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
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

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}
*/
@end
