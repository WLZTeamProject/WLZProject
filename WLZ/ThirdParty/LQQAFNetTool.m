//
//  LQQAFNetTool.m
//  TellYou
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import "AFNetworking.h"
#import "LQQAFNetTool.h"

@implementation LQQAFNetTool
/**
 *  GET请求
 *
 *  @param url           请求网址
 *  @param body          请求体
 *  @param headFile      请求头
 *  @param responseStyle 返回数据类型
 *  @param success       成功
 *  @param failure       失败
 */
+ (void)getNetWithURL:(NSString*)url
                 body:(id)body
             headFile:(NSDictionary*)headFile
        responseStyle:(LQQResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask*, id))success
              failure:(void (^)(NSURLSessionDataTask*, NSError*))failure
{
    // 1. 创建网络管理者
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    // 2. 请求头
    if (headFile) {
        for (NSString* key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    // 3. 返回数据的类型
    switch (responseStyle) {
    case LQQJSON:
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        break;
    case LQQXML:
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        break;
    case LQQDATA:
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        break;
    default:
        break;
    }

    // 4. 响应返回数据类型
    [manager.responseSerializer
        setAcceptableContentTypes:[NSSet
                                      setWithObjects:@"application/json",
                                      @"text/json",
                                      @"text/javascript",
                                      @"text/html", @"text/css",
                                      @"text/plain",
                                      @"application/javascript",
                                      @"application/x-javascript",
                                      @"image/jpeg", nil]];
    // 5. 转码, iOS 9 转码方法
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:
                   [NSCharacterSet URLQueryAllowedCharacterSet]];
    // 6. 发送请求
    [manager GET:url
        parameters:body
        success:^(NSURLSessionDataTask* _Nonnull task,
            id _Nonnull responseObject) {
            
#pragma 缓存数据到本地
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            //不为空
            if (responseObject) {
                success(task, responseObject);
            }

        }
        failure:^(NSURLSessionDataTask* _Nonnull task, NSError* _Nonnull error) {


            // 缓存的文件夹
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 反归档
            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (result) {
                success(task, result);
                //            failure(task, error);
                //            NSLog(@"%@", error);
            } else {
                failure(task, error);
            }
            
            if (error) {
                failure(task, error);
                NSLog(@"%@", error);
            }

        }];
}

+ (void)postNetWithURL:(NSString*)url
                  body:(id)body
             bodyStyle:(LQQRequestStyle)requestStyle
              headFile:(NSDictionary*)headFile
         responseStyle:(LQQResponseStyle)responseStyle
               success:(void (^)(NSURLSessionDataTask*, id))success
               failure:(void (^)(NSURLSessionDataTask*, NSError*))failure
{

    // 1. 创建网络管理者
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    // 2. body的类型
    switch (requestStyle) {
    case LQQRequestJSON:
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        break;

    case LQQRequestNSString:

        [manager.requestSerializer
            setQueryStringSerializationWithBlock:^NSString* _Nonnull(
                NSURLRequest* _Nonnull request, id _Nonnull parameters,
                NSError* _Nullable* _Nullable error) {

                return parameters;
            }];
        break;
    default:
        break;
    }

    // 3. 请求头
    if (headFile) {
        for (NSString* key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }

    // 4. 返回数据的类型
    switch (responseStyle) {
    case LQQJSON:
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        break;
    case LQQXML:
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        break;
    case LQQDATA:
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        break;
    default:
        break;
    }

    // 5. 响应返回数据类型
    [manager.responseSerializer
        setAcceptableContentTypes:[NSSet
                                      setWithObjects:@"application/json",
                                      @"text/json",
                                      @"text/javascript",
                                      @"text/html", @"text/css",
                                      @"text/plain",
                                      @"application/javascript",
                                      @"application/x-javascript",
                                      @"image/jpeg", nil]];
    // 6. 转码, iOS 9 转码方法
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:
                   [NSCharacterSet URLQueryAllowedCharacterSet]];
    // 7. 发送请求
    [manager POST:url
        parameters:body
        success:^(NSURLSessionDataTask* _Nonnull task,
            id _Nonnull responseObject) {
            //不为空
            if (responseObject) {
                success(task, responseObject);
            }

        }
        failure:^(NSURLSessionDataTask* _Nonnull task, NSError* _Nonnull error) {

            if (error) {
                failure(task, error);
                NSLog(@"%@", error);
            }

        }];
}
@end
