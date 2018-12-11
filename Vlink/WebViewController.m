//
//  WebViewController.m
//  Vlink
//
//  Created by Joy Lee on 2018/12/11.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layout];
    [self openWebView];
}

- (void)layout {
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissView)];
    self.navigationItem.title = self.navigationBarTitle;
    
    // webview
    self.formWKWebView = [[WKWebView alloc]init];
    self.formWKWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.formWKWebView];
    [self.formWKWebView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.formWKWebView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.formWKWebView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.formWKWebView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

- (void)openWebView {
    if(self.urlString){
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.formWKWebView loadRequest:request];
    }
    
}

- (void)dismissView {
    if(self.isDismissTwoVC){
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
