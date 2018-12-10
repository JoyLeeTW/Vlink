//
//  Opportunity.h
//  Vlink
//
//  Created by Joy Lee on 2018/11/28.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OPPORTUNITYTYPE) {
    OPPORTUNITYTYPE_OUT_COM = 0,    // 戶外陪伴類
    OPPORTUNITYTYPE_IN_COM,         // 室內陪伴類
    OPPORTUNITYTYPE_OUT_ALN,        // 戶外幫助類
    OPPORTUNITYTYPE_IN_ALN          // 室內幫助類
};

@interface Opportunity : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *organization;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *remaining;
@property (nonatomic) OPPORTUNITYTYPE type;
@property (nonatomic, strong) NSString *introduction;

+ (Opportunity *)setWithTitle:(NSString *)title organization:(NSString *)organization startTime:(NSString *)startTime endTime:(NSString *)endTime location:(NSString *)location amount:(NSString *)amount remaining:(NSString *)remaining type:(OPPORTUNITYTYPE)type introduction:(NSString *)introduction;
@end
