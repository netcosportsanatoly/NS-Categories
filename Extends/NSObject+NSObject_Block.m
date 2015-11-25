//
//  NSObject+NSObject_Block.m
//  FoxSports
//
//  Created by Guillaume on 25/11/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import "NSObject+NSObject_Block.h"
#import "NSObject_Private.h"

#define D_MAX_BG_QUEUE 20

@implementation NSObject (NSObject_Block)

#pragma mark - Queue/Block management
+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block
{
    static dispatch_queue_t ar_queue[D_MAX_BG_QUEUE];
    static dispatch_once_t onceToken;
    
    srand((unsigned int)time(NULL));
    int i = rand() % D_MAX_BG_QUEUE;
    dispatch_queue_t queue = NULL;
    
    if ([NSObject isMainQueue] == NO)
    {
        if (block)
            block();
        queue = ar_queue[i];
    }
    else
    {
        dispatch_once(&onceToken, ^{
            for (int index = 0; index < D_MAX_BG_QUEUE; index++)
            {
                ar_queue[index] = dispatch_queue_create([[NSString stringWithFormat:@"NS-Queue%d",i] cStringUsingEncoding:(NSUTF8StringEncoding)], NULL);
            }
        });
        queue = ar_queue[i];
        dispatch_async(queue, ^{
            if (block)
                block();
        });
    }
    return queue;
}

+(dispatch_queue_t)mainQueueBlock:(void (^)())block
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    if ([NSObject isMainQueue])
    {
        if (block)
            block();
    }
    else
    {
        dispatch_sync(queue, ^{
            if (block)
                block();
        });
    }
    return queue;
}

+(BOOL)isMainQueue
{
    // Main queue is executed exclusively on the mainThread.
    if ([NSThread isMainThread])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - Block with delay
-(void)NSObject_Tool:(void(^)())block
{
    block();
}

-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block
{
    [self performSelector:@selector(NSObject_Tool:) withObject:[block copy] afterDelay:time];
}

#pragma mark - Multiple block management
-(void)performCommonCompletionBlock:(void(^)(NSUInteger numberOfChildBlock))completionBlock afterNumberOfBlockCalls:(NSUInteger)numberOfCalls
{
    commonCompletionBLock = [completionBlock copy];
    numberBlockCallsBeforeCommonCompletionIsCalled = numberOfCalls;
    currentNumberOfBlockCalls = 0;
}

-(void)updateNumberOfBlockCalls
{
    currentNumberOfBlockCalls += 1;
    if (currentNumberOfBlockCalls == numberBlockCallsBeforeCommonCompletionIsCalled && commonCompletionBLock)
    {
        commonCompletionBLock(numberBlockCallsBeforeCommonCompletionIsCalled);
        [self clearCommonCompletionBlock];
    }
}

-(void)clearCommonCompletionBlock
{
    commonCompletionBLock = nil;
    currentNumberOfBlockCalls = 0;
    numberBlockCallsBeforeCommonCompletionIsCalled = 0;
}

@end
