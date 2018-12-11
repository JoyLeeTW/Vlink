//
//  WebViewController.h
//  Vlink
//
//  Created by Joy Lee on 2018/12/11.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"

//NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController
@property (nonatomic, strong) WKWebView *formWKWebView;
@property (nonatomic) BOOL isDismissTwoVC;
@property (nonatomic, strong) NSString *navigationBarTitle;
@property (nonatomic, strong) NSString *urlString;

@end

//NS_ASSUME_NONNULL_END
