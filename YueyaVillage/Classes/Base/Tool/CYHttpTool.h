//
//  CYHttpTool.h
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYHttpTool : NSObject

/**
 *  get请求
 *
 *  @param url     请求的url地址
 *  @param params  传入的参数
 *  @param success 成功返回值
 *  @param failure 失败返回值
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params
    success:(void (^) (id json))success
    failure:(void (^) (NSError * error))failure;

/**
 *  post请求
 *
 *  @param url     请求的url地址
 *  @param params  传入的参数
 *  @param success 成功返回值
 *  @param failure 失败返回值
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params
     success:(void (^) (id json))success
     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param url     请求地址
 *  @param params  传入参数
 *  @param image   传入图片
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(void(^)(id))success failure:(void (^)(NSError *))failure;

/**
 上传多张图片
 
 @param url 请求地址
 @param params 传入参数
 @param imageArr 多张图片的数组
 @param nameArr 多张图片对应的命名
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params imageList:(NSArray *)imageArr imageNameList:(NSArray *)nameArr success:(void(^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  检查网络的变化
 */
+ (void)checkNetWorkStatusChange;

@end

NS_ASSUME_NONNULL_END
