//
//  RCHttpOperation.h
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/01.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCRunloopOperation.h"
/**
 * @brief　HTTP通信Operationクラス NSOperationのサブクラス
 */
@interface RCHttpOperation : RCRunloopOperation <NSURLConnectionDataDelegate>
{
    NSURL* _url;
    NSURLConnection* _connection;

    NSMutableURLRequest* _request;
    NSHTTPURLResponse* _response;
    NSMutableData* _responseData;
    
    BOOL _isExecuting;
    BOOL _isFinished;
    
}
@property (nonatomic, retain) NSMutableURLRequest* request;
/**
 * @brief
 */
+ (id)requestWithURL:(NSURL*)targetUrl;
/**
 * @brief
 */
- (id)initWithURL:(NSURL *)targetUrl;
/**
 * @brief
 */
- (id)initWithRequest:(NSMutableURLRequest *)request;
@end
