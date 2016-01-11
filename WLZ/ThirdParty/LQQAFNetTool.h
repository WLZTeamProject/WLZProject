//
//  LQQAFNetTool.h
//  TellYou
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  返回数据类型
 */
typedef NS_ENUM(NSUInteger, LQQResponseStyle) {
    /**
     *  JSON
     */
    LQQJSON,
    /**
     *  XML
     */
    LQQXML,
    /**
     *  DATA
     */
    LQQDATA,
};

typedef NS_ENUM(NSUInteger, LQQRequestStyle) {
    LQQRequestJSON,
    LQQRequestNSString,
};

@interface LQQAFNetTool : NSObject

/**
 *  get 请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param headFile      请求头
 *  @param responseStyle 返回数据类型
 *  @param success       请求成功
 *  @param failure       请求失败
 */
+ (void)getNetWithURL:(NSString *)url
                 body:(id)body
             headFile:(NSDictionary *)headFile
        responseStyle:(LQQResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
;

/**
 *  post 请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param requestStyle  请求数据类型
 *  @param headFile      请求头
 *  @param responseStyle 返回数据类型
 *  @param success       请求成功
 *  @param failure       请求失败
 */
+ (void)postNetWithURL:(NSString *)url
                  body:(id)body
             bodyStyle:(LQQRequestStyle)requestStyle
              headFile:(NSDictionary *)headFile
         responseStyle:(LQQResponseStyle)responseStyle
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
;


@end
