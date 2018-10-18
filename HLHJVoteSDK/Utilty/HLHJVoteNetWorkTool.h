//
//  HLHJVoteNetWorkTool.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
typedef NS_ENUM(NSInteger, requestType) {
    GET = 1,
    POST = 2,
};
@interface HLHJVoteNetWorkTool : NSObject

+ (AFHTTPSessionManager *_Nonnull)shareInstance;

+ (void)requestWithType:(requestType )type
                 requestUrl:(NSString *_Nonnull)url
                  parameter:(NSDictionary *_Nullable)parameter
            successComplete:(void(^_Nullable)(id _Nullable responseObject))success
            failureComplete:(void(^_Nonnull)(NSError * _Nonnull error))failure;


/**
 *  上传图片(多张)
 *
 *  @param path    路径
 *  @param photos  图片数组(data)
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)uploadImageWithPath:(NSString *_Nullable)path imageData:(NSData *)imageDate params:(NSDictionary *_Nullable)params  successComplete:(void(^_Nonnull)(id _Nonnull responseObject))success failureComplete:(void(^_Nonnull)(NSError * _Nonnull error))failure;


@end
