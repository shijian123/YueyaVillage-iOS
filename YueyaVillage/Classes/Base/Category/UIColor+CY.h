//
//  UIColor+CY.h
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CY)

/**
 * 通过十六进制数字进行创建color
 */
+ (UIColor*)colorWithHex:(long)hexColor;

@end

NS_ASSUME_NONNULL_END
