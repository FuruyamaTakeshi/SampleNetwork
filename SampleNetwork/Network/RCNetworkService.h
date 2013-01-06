//
//  RCNetworkService.h
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief
 */
@protocol RCNetworkServiceDelegate <NSObject>
@optional
- (void)didFailWithError:(NSError *)error;
@end

@interface RCNetworkService : NSObject
@property (nonatomic, retain) id delegate;

- (void)sendAsynchronousRequest:(NSData*)data withStringUrl:(NSString*)url;
@end
