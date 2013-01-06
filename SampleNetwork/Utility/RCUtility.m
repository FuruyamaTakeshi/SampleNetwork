//
//  RCUtility.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCUtility.h"

@implementation RCUtility

+ (NSData*)createFormatData:(id)object
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    return data;
}

@end
