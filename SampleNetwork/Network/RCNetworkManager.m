//
//  RCNetworkManger.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCNetworkManager.h"
#import "RCNetworkServiceFactory.h"
#import "RCNetworkServiceAsyncHTTP.h"
#import "RCHttpOperation.h"
#import "RCAPIOperation.h"

@interface RCNetworkManager ()
@property (nonatomic, retain, readonly) NSThread* networkRunLoopThread;

@property (nonatomic, retain, readonly) NSOperationQueue* networkQueue;
@end
@implementation RCNetworkManager
static id _manager = nil;

+ (id)sharedManager
{
    @synchronized(self)
    {
        if (!_manager) {
            _manager = [[self alloc] init];
        }
    }
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        self->_networkQueue = [[NSOperationQueue alloc] init];
        self->_networkRunLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRunLoopThreadEntry) object:nil];
        
        [self->_networkRunLoopThread setName:@"networkRunLoopThread"];
    }
    if ([self->_networkRunLoopThread respondsToSelector:@selector(setThreadPriority)]) {
        [self->_networkRunLoopThread setThreadPriority:0.3];
    }
    [self->_networkRunLoopThread start];
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark * Operation dispatch

@synthesize networkRunLoopThread = _networkRunLoopThread;
@synthesize networkQueue = _networkQueue;

- (void)networkRunLoopThreadEntry
{
    while (YES) {
        NSAutoreleasePool *pool;
        pool = [[NSAutoreleasePool alloc] init];
        [[NSRunLoop currentRunLoop] run];
        [pool drain];
    }
}
- (void)sendDataRequest:(NSData*)data withUrlString:(NSString*)urlString
{
    RCNetworkService *service = [RCNetworkServiceFactory factoryWithName:@"AsyncHttp"];
    service.delegate = self;
    [service sendAsynchronousRequest:data withStringUrl:urlString];
}

- (void)requestPost:(NSData*)data withURL:(NSURL*)url
{
    LOG_METHOD;
    RCHttpOperation* op = [[RCHttpOperation requestWithURL:url] retain];
    [self->_networkQueue addOperation:op];
    [op release];
}


- (void)addNetworkOperation:(NSOperation *)operation finishedTarget:(id)target action:(SEL)action
{
    if ([operation respondsToSelector:@selector(setRunloopThread:)]) {
        if ([(id)operation runLoopThread] == nil) {
            [(id)operation setRunLoopThread:self.networkRunLoopThread];
        }
    }
}

- (void)cancelOperation:(NSOperation *)operation
{
    
}


#pragma mark -
#pragma mark delegate

- (void)didFailWithError:(NSError *)error
{
    LOG_METHOD;
    LOG(@"did Faile with Error : NSErrorCode %d", [error code]);
}


#pragma mark -
- (void)hoge
{
    LOG_METHOD;
    RCHttpOperation* ope1 = [[RCHttpOperation requestWithURL:[NSURL URLWithString:@"http://192.168.11.7"]] retain];
    [ope1 addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [self->_networkQueue addOperation:ope1];
    [ope1 release];
    
//    RCHttpOperation* ope2 = [[RCHttpOperation requestWithURL:[NSURL URLWithString:@"http://www.google.com"]] retain];
//    [ope2 addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
//    [self->_networkQueue addOperation:ope2];
//    [ope2 release];
    
}

- (void)fugaWith:(NSData*)data
{
    RCAPIOperation* ope = [[RCAPIOperation requestWithURL:[NSURL URLWithString:@"http://192.168.1.11/personInfoUp.php"] withData:data] retain];
    [ope addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [self->_networkQueue addOperation:ope];
    [ope release];
}
#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    LOG_METHOD;
    LOG(@"%@", @"Operation end");
    if ([keyPath isEqualToString:@"isFinished"]) {
        NSLog(@"isFinished");
    }
    [object removeObserver:self forKeyPath:keyPath];
}
@end
