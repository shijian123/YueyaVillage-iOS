//
//  CYYellowBagListCell.h
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYYellowBagListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CYYellowBagListCell : UITableViewCell
@property (nonatomic, strong) CYYellowBagListModel *model;
@property (nonatomic) void (^reloadTableViewBlock)(void);

@end

NS_ASSUME_NONNULL_END
