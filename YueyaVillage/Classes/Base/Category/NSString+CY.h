//
//  NSString+CY.h
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CY)

/**
 将毫秒转换成正常的时间显示(yyyy-MM-dd)
 */
- (NSString *)dateWithLongLongStringWithYMD;

/**
 将毫秒转换成正常的时间显示(自定义)

 @param formatStr format 的显示类型
 */
- (NSString *)dateWithLongLongStringWithFormatter:(NSString *)formatStr;

/**
 距离现在的时间
 */
- (NSString *)timeIntervalFromNow;

/**
 *  判断昵称是否为中文、字母、数字、“-、_”
 */
- (BOOL)isCheckNickName;

/**
 *  判断是否为纯数字
 */
- (BOOL)isCheckPureNumAndCharacters;

@end

NS_ASSUME_NONNULL_END
