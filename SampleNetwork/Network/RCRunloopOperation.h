//
//  RCRunloopOperation.h
//  SampleNetwork
//
//  Created by 古山 健司 on 13/01/02.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
enum RCRunloopOperationState {
    kRCRunloopOperationStateInited,
    kRCRunloopOperetionStateExecuting,
    kRCRunloopOperationStateFinished
};
typedef enum RCRunloopOperationState RCRunloopOperationState;
/**
 * @brief
 */
@interface RCRunloopOperation : NSOperation
{
    RCRunloopOperationState _state;
    NSThread*               _runLoopThread;
    NSSet*                  _runLoopModes;
    NSError*                _error;
}
@property (retain, readwrite) NSThread* runLoopThread;
@property (copy, readwrite) NSSet* runLoopModes;

@property (copy, readonly) NSError* error;

@property (assign, readonly) RCRunloopOperationState state;
@property (retain, readonly) NSThread* actualRunLoopThread;
@property (assign, readonly) BOOL isActualRunLoopThread;
@property (copy, readonly) NSSet* actualRunLoopModes;

@end
/**
 * @brief
 */
@interface RCRunloopOperation (SubClassSupport)
/**
 * @brief
 */
- (void)opereationDidStart;
/**
 * @brief
 */
- (void)opereationWillFinish;
/**
 * @brief
 */
- (void)finishWithError:(NSError*)error;

@end