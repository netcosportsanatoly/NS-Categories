//
//  NSObject+NSObject_Block.h
//  FoxSports
//
//  Created by Guillaume on 25/11/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_Block)

#pragma mark - Queue/Block management
+(BOOL)isMainQueue;
+(dispatch_queue_t)mainQueueBlock:(void (^)())block;
+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block;

#pragma mark - Block with delay
-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block;

#pragma mark - Multiple block management
-(void)performCommonCompletionBlock:(void(^)(NSUInteger numberOfChildBlocksCalled))completionBlock afterNumberOfBlockCalls:(NSUInteger)numberOfCalls;
-(void)updateNumberOfBlockCalls;
-(void)clearCommonCompletionBlock;

@end
