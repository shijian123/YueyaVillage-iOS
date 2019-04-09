//
//  CYYellowBagHomeNavView.h
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYYellowBagHomeNavView : UIView

@property (nonatomic) void(^switchTitleBtnBlock)(UIButton *sender);

- (void)adjustNavViewWithScrollOffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
