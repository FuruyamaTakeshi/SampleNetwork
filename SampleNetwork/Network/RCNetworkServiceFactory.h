//
//  RCNetworkServiceFactory.h
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCNetworkService.h"
/**
 * @brief
 */
@interface RCNetworkServiceFactory : NSObject
+ (id)factoryWithName:(NSString*)name;
@end
