//
//  HLHJVoteNetWorkTool.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJVoteNetWorkTool.h"
#import "HLHJVoteToast.h"
#import "SVProgressHUD.h"
static AFHTTPSessionManager *_manager;

@implementation HLHJVoteNetWorkTool

+ (AFHTTPSessionManager *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
    });
    return _manager;
}
+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" , @"text/plain" ,@"text/html",@"application/xml",@"image/jpeg",nil];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 30.0f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //***************** HTTPS 设置 *****************************//
        // 设置非校验证书模式
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 客户端是否信任非法证书
        _manager.securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        _manager.securityPolicy.validatesDomainName = NO;
        
    });
    return _manager;
}

/**
 普通请求
 
 @param type 请求类型
 @param url 请求链接
 @param parameter 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithType:(requestType)type
                 requestUrl:(NSString *_Nonnull)url
                  parameter:(NSDictionary *_Nullable)parameter
            successComplete:(void(^_Nullable)(id _Nullable responseObject))success
            failureComplete:(void(^_Nonnull)(NSError * _Nonnull error))failure {
    
    
    url = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    
    _manager = [self sharedManager];
    
    if (type == 1) { // GET 请求
        [_manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            if ([responseObject[@"code"] integerValue] == 200) {
                !success ? : success(responseObject);
            }else if ([responseObject[@"code"] integerValue] == 500){
                [SVProgressHUD dismiss];
                [HLHJVoteToast hsShowBottomWithText:responseObject[@"message"]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            [SVProgressHUD dismiss];
            if (error.code == NSURLErrorCancelled)  return ;
            NSLog(@"%@",error);
            !failure ? : failure(error);
        }];
    }else if (type == 2){ // POST 请求
        

        
        [_manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            if ([responseObject[@"code"] integerValue] == 200) {
                !success ? : success(responseObject);
            }else if ([responseObject[@"code"] integerValue] == 500){
                [SVProgressHUD dismiss];
                [HLHJVoteToast hsShowBottomWithText:responseObject[@"message"]];

            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            [SVProgressHUD dismiss];
            if (error.code == NSURLErrorCancelled)  return ;
            NSLog(@"%@",error);
            !failure ? : failure(error);
        }];
    }else {
        NSLog(@"未选择请求类型");
        return;
    }
    
}


/**
 *  上传图片(多张)
 *
 *  @param path    路径
 *  @param photos  图片数组(data)
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)uploadImageWithPath:(NSString *_Nullable)path imageData:(NSData *)imageDate params:(NSDictionary *_Nullable)params  successComplete:(void(^_Nonnull)(id _Nonnull responseObject))success failureComplete:(void(^_Nonnull)(NSError * _Nonnull error))failure {
    
    path = [NSString stringWithFormat:@"%@%@",BASE_URL,path];
    
    [_manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        
        formatter.dateFormat=@"yyyyMMddHHmmss";
        
        NSString *str=[formatter stringFromDate:[NSDate date]];
        
        NSString *fileName=[NSString stringWithFormat:@"%@.jpeg",str];
        
        [formData appendPartWithFileData:imageDate name:@"avatar" fileName:fileName mimeType:@"file"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 200) {
            !success ? : success(responseObject);
        }else if ([responseObject[@"code"] integerValue] == 500){
            [SVProgressHUD dismiss];
            [HLHJVoteToast hsShowBottomWithText:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error.code == NSURLErrorCancelled)  return ;
        NSLog(@"%@",error);
        !failure ? : failure(error);
        
    }];
    
}


@end
