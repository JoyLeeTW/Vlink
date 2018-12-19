//
//  Opportunity.m
//  Vlink
//
//  Created by Joy Lee on 2018/11/28.
//  Copyright © 2018年 Joy Lee. All rights reserved.
//

#import "Opportunity.h"

@implementation Opportunity

+ (Opportunity *)setWithTitle:(NSString *)title organization:(NSString *)organization startTime:(NSString *)startTime endTime:(NSString *)endTime location:(NSString *)location amount:(NSString *)amount remaining:(NSString *)remaining type:(OPPORTUNITYTYPE)type introduction:(NSString *)introduction oppo_id:(NSString *)oppo_id{
    Opportunity *opportunity = [[Opportunity alloc] init];
    opportunity.title = title;
    opportunity.organization = organization;
    opportunity.startTime = startTime;
    opportunity.endTime = endTime;
    opportunity.location = location;
    opportunity.amount = amount;
    opportunity.remaining = remaining;
    opportunity.type = type;
    opportunity.introduction = introduction;
    opportunity.oppo_id = oppo_id;
    return opportunity;
}

@end
