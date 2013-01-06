//
//  RCNetworkServiceFactory.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCNetworkServiceFactory.h"

#import "RCNetworkServiceAsyncHTTP.h"

@implementation RCNetworkServiceFactory
+ (id)factoryWithName:(NSString*)name
{
    if ([name isEqualToString:@"AsyncHttp"]) {
        return [[[RCNetworkServiceAsyncHTTP alloc] init] autorelease];
    }
    else {
        return nil;
    }
}
@end
