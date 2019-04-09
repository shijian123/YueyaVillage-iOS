//
//  CYYellowBagListMyCell.h
//  YueyaVillage
//
//  Created by zcy on 2019/4/9.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYYellowBagListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CYYellowBagListMyCell : UITableViewCell
@property (nonatomic, strong) CYYellowBagListModel *model;
/** 是否为我的发布CELL*/
@property (nonatomic) BOOL isMyRelease;

@end

NS_ASSUME_NONNULL_END


