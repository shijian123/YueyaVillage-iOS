//
//  CYHttpTool.m
//  YueyaVillage
//
//  Created by zcy on 2019/4/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYHttpTool.h"
#import "AFNetworking.h"

@implementation CYHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self checkNetWorkStatusChange];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    NSString *userCookie = [CYUserDefaults objectForKey:@"CYUserCookieKey"];
    userCookie = @"userid=1013";
    [manager.requestSerializer setValue:userCookie forHTTPHeaderField:@"Cookie"];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //加载中
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task.response.URL : ## %@ ",task.response.URL);
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"task.response.URL : ## %@, ERROR ## : %@",task.response.URL,error);
            failure(error);
        }
    }];
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    //415错误
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//申明请求类型
    NSString *userCookie = [CYUserDefaults objectForKey:@"CYUserCookieKey"];
    userCookie = @"userid=1013";
    [manager.requestSerializer setValue:userCookie forHTTPHeaderField:@"Cookie"];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //加载中
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task.response.URL : ## %@ ",task.response.URL);
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"task.response.URL : ## %@, ERROR ## : %@",task.response.URL,error);
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(void(^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
//        [formData appendPartWithFileData:imgData name:@"files" fileName:@"iosImage.png" mimeType:@"image/png"];
        [formData appendPartWithHeaders:@{
            @"Content-Disposition":@"form-data;name=\"file\";filename=\"img.png\"",
            @"Content-Type":@"image/png",
            } body:imgData];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //加载中
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task.response.URL : ## %@ ",task.response.URL);
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"task.response.URL : ## %@, ERROR ## : %@",task.response.URL,error);
            failure(error);
        }
    }];
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params imageList:(NSArray *)imageArr imageNameList:(NSArray *)nameArr success:(void(^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int count = 0; count < imageArr.count; count ++) {
            UIImage *image = imageArr[count];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            NSLog(@"imgData : %zd",[imgData length]);
            NSString *fileName = nameArr[count];
            [formData appendPartWithFileData:imgData name:@"files" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //加载中
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task.response.URL : ## %@ ",task.response.URL);
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"task.response.URL : ## %@, ERROR ## : %@",task.response.URL,error);
            failure(error);
        }
    }];
    
}

+ (void)checkNetWorkStatusChange{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络状态未知");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI状态");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前网络不可用");
                break;
            default:
                break;
        }
    }];
    //开启监控
    [mgr startMonitoring];
}

/**
 *  字典或者数组转json语句
 *
 *  @param objectData 需要转换的数据
 *
 *  @return 转换之后的json语句
 */
+ (NSString *)jsonStringWithObject:(NSDictionary *)objectData{
    NSData *queryData = [NSJSONSerialization dataWithJSONObject:objectData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *queryJson = [[NSString alloc] initWithData:queryData encoding:NSUTF8StringEncoding];
    return queryJson;
}

@end
