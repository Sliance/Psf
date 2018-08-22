//
//  ZSURLResponse.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSURLResponse.h"
#import "NSURLRequest+TYAFNetworking.h"
@interface ZSURLResponse ()

@property (nonatomic, assign, readwrite) ResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end
@implementation ZSURLResponse
#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(ResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        if (responseData != nil) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:NULL];
        }
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

#pragma mark - private methods
- (ResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        ResponseStatus result = ResponseStatusErrorFail;
        
        // 除了超时以外，所有错误都当成是请求失败
        if (error.code == NSURLErrorTimedOut) {
            result = ResponseStatusErrorFail;
        }
        return result;
    } else {
        return ResponseStatusSuccess;
    }
}

@end
