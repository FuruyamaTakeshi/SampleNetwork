//
//  RCNetworkManger.h
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCNetworkService.h"
/**
 * @brief ネットワーク管理クラス(Singlton)
 */
@interface RCNetworkManager : NSObject <RCNetworkServiceDelegate>
{
    NSThread*           _networkRunLoopThread;
    NSOperationQueue*   _queeForNetworkManagement;
    NSOperationQueue*   _queeForNetworkTransfer;
    
}
/**
 * @brief　クラスメソッド
 * @return id
 */
+ (id)sharedManager;
/**
 * @brief
 */
- (void)sendDataRequest:(NSData*)data withUrlString:(NSString*)urlString;
/**
 * @brief　データGETメソッド
 */
- (NSMutableURLRequest*)requestToGetWithURL:(NSURL*)url;
/**
 * @brief データPOSTメソッド
 */
- (NSMutableURLRequest *)requestToPost:(NSData*)data withURL:(NSURL*)url;
/**
 * @brief
 */
- (void)addNetworkOperation:(NSOperation *)operation finishedTarget:(id)target action:(SEL)action;
/**
 * @brief
 */
- (void)cancelOperation:(NSOperation *)operation;
/**
 * @brief
 */
- (void)hoge;
/**
 * @brief
 */
- (void)fugaWith:(NSData*)data;

@end
