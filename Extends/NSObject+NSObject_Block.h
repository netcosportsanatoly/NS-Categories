//
//  NSObject+NSObject_Block.h
//  FoxSports
//
//  Created by Guillaume on 25/11/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_Block)

+(BOOL)isMainQueue;
+(dispatch_queue_t)mainQueueBlock:(void (^)())block;
+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block;

@end
