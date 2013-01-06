//
//  RCAPIOperation.h
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/05.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCHttpOperation.h"
/**
 * @brief　HTTP通信POST Operationクラス NSOperationのサブクラス
 */
@interface RCAPIOperation : RCHttpOperation <NSURLConnectionDataDelegate>
+ (id)requestWithURL:(NSURL*)targetUrl withData:(NSData*)data;

@property (retain, readwrite) NSData* bodyData;
/**
 * @brief コンストラクタ
 * @param [in] url
 * @param [in] data
 * @return (id) object
 */
- (id)initWithURL:(NSURL *)targetUrl withData:(NSData*)data;
@end
