//
//  NSString+CY.m
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSString+CY.h"

@implementation NSString (CY)

- (NSString *)dateWithLongLongStringWithYMD{
    return [self dateWithLongLongStringWithFormatter:@"yyyy-MM-dd"];
}

- (NSString *)dateWithLongLongStringWithFormatter:(NSString *)formatStr{
    NSDate* confromTimesp = [self timeDateWithLongLongString];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:formatStr];
    //    DKDLog(@"time : ## %@",[formatter stringFromDate:confromTimesp]);
    return [formatter stringFromDate:confromTimesp];
}

- (NSString *)timeIntervalFromNow{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval ) [self longLongValue]/1000];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval interval = [nowDate timeIntervalSinceDate:oldDate];
    NSInteger timeInterval = [NSNumber numberWithDouble:interval].integerValue;
    NSString *timeStr = @"";
    if (timeInterval < 60) {
        timeStr = [NSString stringWithFormat:@"%zd秒前",timeInterval];
    }
    if (timeInterval >= 60 && timeInterval < 60 *60) {
        timeStr = [NSString stringWithFormat:@"%zd分钟前",timeInterval/60];
    }
    if (timeInterval >= 60 *60 && timeInterval < 24 *60 *60) {
        timeStr = [NSString stringWithFormat:@"%zd小时前",timeInterval/(60 *60)];
    }
    if (timeInterval >= 24 *60 *60 && timeInterval < 24 *60 *60 * 3) {
        timeStr = [NSString stringWithFormat:@"%zd天前",timeInterval/(24 *60 *60)];
    }
    if (timeInterval >= 24 *60 *60 * 3) {
        timeStr = [self dateWithLongLongStringWithYMD];
    }
    return timeStr;
}

- (NSDate *)timeDateWithLongLongString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[self longLongValue]/1000];
    return confromTimesp;
}

/**
 *  判断是否为纯数字
 */
- (BOOL)isCheckPureNumAndCharacters{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0){
        return NO;
    }
    return YES;
}

/**
 *  判断昵称是否为中文、字母、数字、“-、_”
 */
- (BOOL)isCheckNickName{
    NSString *regex = @"[0-9a-zA-Z\u4e00-\u9fa5]+";
    return [self checkIsLegalByRegex:regex];
}

/**
 通过校验正则表达式来判断是否条件是否符合
 
 @param regex 正则表达式
 @return 是否合法
 */
- (BOOL)checkIsLegalByRegex:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

@end
