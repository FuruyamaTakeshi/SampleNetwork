//
//  RCAPIOperation.m
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/05.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCAPIOperation.h"

@implementation RCAPIOperation
@synthesize bodyData = _bodyData;
- (void)dealloc
{
    LOG_METHOD;
    [self.request release];
    [super dealloc];
}

+ (id)requestWithURL:(NSURL*)targetUrl withData:(NSData*)data
{
    LOG_METHOD;
    
    return [[[self alloc] initWithURL:targetUrl withData:data] autorelease];
}

- (id)initWithURL:(NSURL *)targetUrl withData:(NSData *)data
{
    LOG_METHOD;
    self = [super init];
    if (self) {
        _url = [targetUrl retain];
        _bodyData = [data retain];
    }
    _isExecuting = NO;
    _isFinished = NO;
    return self;
}

- (void)start
{
    LOG_METHOD;
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isExecuting"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:_url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Context-Type"];
    [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[_bodyData length] ] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:_bodyData];
    NSString* bodyStr = [[NSString alloc] initWithData:_bodyData encoding:NSUTF8StringEncoding];
    LOG(@"body:%@", bodyStr);
    LOG(@"~~~~~~ request~~~~~ %@",request);
    
    NSURLConnection* connection =  [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection != nil) {
        do
        {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }while (_isExecuting);
    }
}

@end
