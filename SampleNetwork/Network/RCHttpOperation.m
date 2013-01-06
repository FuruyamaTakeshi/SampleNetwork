//
//  RCHttpOperation.m
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/01.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCHttpOperation.h"

@interface RCHttpOperation ()
@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, retain) NSURL* url;

@end
@implementation RCHttpOperation
@synthesize request = _request;
@synthesize connection = _connection;
@synthesize url = _url;

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([key isEqualToString:@"isExecuting"] || [key isEqualToString:@"isFinished"] ) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

+ (id)requestWithURL:(NSURL *)targetUrl
{
    LOG_METHOD;
    return [[[self alloc] initWithURL:targetUrl] autorelease];
}

- (id)initWithRequest:(NSMutableURLRequest *)request
{
    LOG_METHOD;
    self = [super init];
    if (self) {
        self->_request = [request copy];
    }
    return self;
}
- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return _isExecuting;
}

- (BOOL)isFinished
{
    return _isFinished;
}

- (id)initWithURL:(NSURL *)targetUrl
{
    LOG_METHOD;
    self = [super init];
    if (self) {
        _url = [targetUrl retain];
    }
    _isExecuting = NO;
    _isFinished = NO;
    return self;
}
- (void)start
{
    LOG_METHOD;
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isExecuting"];
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:_url];
    NSURLRequest* request = [NSURLRequest requestWithURL:_url];
    NSURLConnection* connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection != nil) {
        do
        {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }while (_isExecuting);
    }
}

- (void)opereationDidStart
{
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    for (NSString* mode in self.actualRunLoopModes) {
        [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:mode];
    }
    [self.connection start];
}

- (void)opereationWillFinish
{
    
}

#pragma mark - 
#pragma mark delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    LOG_METHOD;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    LOG(@"http ResponseCode:%d", [httpResponse statusCode]);
    if ([httpResponse statusCode] >= 400) {
        //Error
        LOG(@"error:%d", [httpResponse statusCode]);
    }
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    LOG_METHOD;
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    LOG_METHOD;
    LOG(@"connection error:%d ", [error code]);
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    LOG_METHOD;//
    NSString *a = [[NSString alloc] initWithBytes:[_responseData bytes] length:[_responseData length] encoding:NSASCIIStringEncoding];

    NSString* responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    LOG(@"responseString:%@", responseString);
    [_responseData release];
    [responseString release];
    [a release];
    
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
}
@end
