//
//  CYYellowBagListModel.h
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYYellowBagListModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_date;
/** 发布的图片组，用;分割获取*/
@property (nonatomic, copy) NSString *imgurl;
/** 将后台的图片组，字符串转换为array*/
@property (nonatomic, copy) NSArray *imgUrlArr;
@property (nonatomic, copy) NSString *moment_id;
@property (nonatomic, copy) NSString *star_number;
/** 当前用户是否收藏*/
@property (nonatomic) BOOL isStarBySelf;
@property (nonatomic, copy) NSString *user_id;

@end

NS_ASSUME_NONNULL_END
