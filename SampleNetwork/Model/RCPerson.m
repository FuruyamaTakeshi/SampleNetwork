//
//  RCPerson.m
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/06.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCPerson.h"
#import "RCUtility.h"
@implementation RCPerson
@synthesize name = _name;
@synthesize age = _age;
@synthesize livingarea = _livingarea;
@synthesize shokugyo = _shokugyo;
static const NSString* kAKey = @"age";
- (void)dealloc
{
    LOG_METHOD;
    self.name = nil;
    self.age = nil;
    self.livingarea = nil;
    self.shokugyo = nil;
    [super dealloc];
}

- (NSDictionary *)jsonToDictionary
{
    LOG_METHOD;
    return [NSDictionary dictionaryWithObjectsAndKeys:self.name, @"name", self.age, @"age", self.livingarea, @"livingarea", self.shokugyo, @"shokugyo", nil];
}
- (NSData*)createJSONData
{
    LOG_METHOD;
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:[self jsonToDictionary] options:0 error:&error];
}
@end
