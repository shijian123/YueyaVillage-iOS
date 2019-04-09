//
//  CYHelperTool.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYHelperTool.h"

@implementation CYHelperTool

+ (NSString *)currentdateInterval{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
    
}

@end
