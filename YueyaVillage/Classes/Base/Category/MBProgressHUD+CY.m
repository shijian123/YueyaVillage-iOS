//
//  MBProgressHUD+CY.m
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MBProgressHUD+CY.h"

@implementation MBProgressHUD (CY)

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:0.3];
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}

@end
