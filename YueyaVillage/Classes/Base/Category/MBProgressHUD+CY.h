//
//  MBProgressHUD+CY.h
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (CY)
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
