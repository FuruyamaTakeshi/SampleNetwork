//
//  RCRunloopOperation.m
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/02.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCRunloopOperation.h"

@interface RCRunloopOperation ()
@property (copy, readwrite) NSError* error;

@end
@implementation RCRunloopOperation

- (id)init
{
    LOG_METHOD;
    self = [super init];
    if (self) {
        if (self->_state == kRCRunloopOperationStateInited)
            NSLog(@"Inited");
    }
    return self;
}

- (void)dealloc
{
    [self->_runLoopModes release];
    [self->_runLoopThread release];
    [self->_error release];
    [super dealloc];
}

@synthesize runLoopThread = _runLoopThread;
@synthesize runLoopModes = _runLoopModes;

- (NSThread *)actualRunLoopThread
{
    NSThread* result;
    
    result = self.runLoopThread;
    if (result == nil) {
        result = [NSThread mainThread];
    }
    return result;
}

- (BOOL)isActualRunLoopThread
{
    return [[NSThread currentThread] isEqual:self.actualRunLoopThread];
}

- (NSSet *)actualRunLoopModes
{
    NSSet* result;
    
    result = self.actualRunLoopModes;
    if ((result == nil) || ([result count] == 0)) {
        result = [NSSet setWithObject:NSDefaultRunLoopMode];
    }
    return result;
}

@synthesize error = _error;

- (RCRunloopOperationState)state
{
    return self->_state;
}

- (void)setState:(RCRunloopOperationState)newState
{
    LOG_METHOD;
    @synchronized(self) {
        RCRunloopOperationState oldState;
        oldState = self->_state;
        if ( (newState == kRCRunloopOperetionStateExecuting) || (oldState == kRCRunloopOperetionStateExecuting)) {
            [self willChangeValueForKey:@"isExecuting"];
        }
        if (newState == kRCRunloopOperationStateFinished) {
            [self willChangeValueForKey:@"isFinished"];
        }
        self->_state = newState;
        if (newState == kRCRunloopOperationStateFinished) {
            [self didChangeValueForKey:@"isFinished"];
        }
        if (newState == kRCRunloopOperetionStateExecuting || oldState == kRCRunloopOperetionStateExecuting) {
            [self didChangeValueForKey:@"isExecuting"];
        }
    }
}
- (void)startOnRunLoopThread
{
    LOG_METHOD;
    if ([self isCancelled]) {
        [self finishWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
    } else {
        [self opereationDidStart];
    }
}

- (void)cancelOnRunLoopThread
{
    if (self.state == kRCRunloopOperetionStateExecuting) {
        [self finishWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
    }
}

- (void)finishWithError:(NSError *)error
{
    if (self.error == nil) {
        self.error = error;
    }
    [self opereationWillFinish];
    self.state = kRCRunloopOperationStateFinished;
}
#pragma mark * Subclass override points

- (void)opereationDidStart
{
    
}

- (void)opereationWillFinish
{
    
}

#pragma mark * Overrides

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.state == kRCRunloopOperetionStateExecuting;
}

- (BOOL)isFinished
{
    return self.state == kRCRunloopOperationStateFinished;
}

- (void)start
{
    LOG_METHOD;
    self.state = kRCRunloopOperetionStateExecuting;
    [self performSelector:@selector(startOnRunLoopThread) onThread:self.actualRunLoopThread withObject:nil waitUntilDone:NO modes:[self.actualRunLoopModes allObjects]];
}

- (void)cancel
{
    LOG_METHOD;
    BOOL runCancelOnRunLoopThread;
    BOOL oldVallue;
    
    @synchronized(self) {
        oldVallue = [self isCancelled];
        [super cancel];
        runCancelOnRunLoopThread = ! oldVallue && self.state == kRCRunloopOperetionStateExecuting;
    }
    if (runCancelOnRunLoopThread) {
        [self performSelector:@selector(cancelOnRunLoopThread) onThread:self.actualRunLoopThread withObject:nil waitUntilDone:YES modes:[self.actualRunLoopModes allObjects]];
    }
}
@end
