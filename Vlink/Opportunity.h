//
//  Opportunity.h
//  Vlink
//
//  Created by Joy Lee on 2018/11/28.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OPPORTUNITYTYPE) {
    OPPORTUNITYTYPE_OUT_COM = 0,    // 戶外活動類
    OPPORTUNITYTYPE_IN_COM,         // 關懷陪伴類
    OPPORTUNITYTYPE_OUT_ALN,        // 行政/藝術類
    OPPORTUNITYTYPE_IN_ALN          // 綠色環保類 
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
@property (nonatomic, strong) NSString *oppo_id;

+ (Opportunity *)setWithTitle:(NSString *)title organization:(NSString *)organization startTime:(NSString *)startTime endTime:(NSString *)endTime location:(NSString *)location amount:(NSString *)amount remaining:(NSString *)remaining type:(OPPORTUNITYTYPE)type introduction:(NSString *)introduction oppo_id:(NSString *)oppo_id;
@end
