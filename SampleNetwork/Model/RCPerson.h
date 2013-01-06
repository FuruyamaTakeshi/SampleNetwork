//
//  RCPerson.h
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/06.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief
 */
@interface RCPerson : NSObject
@property (retain, readwrite) NSString* name;
@property (retain, readwrite) NSNumber* age;
@property (retain, readwrite) NSString* livingarea;
@property (retain, readwrite) NSString* shokugyo;
/**
 * @brief
 * @return NSDictionary
 */
- (NSDictionary *)jsonToDictionary;
/**
 * @brief
 * @return NSData*
 */
- (NSData*)createJSONData;
@end
