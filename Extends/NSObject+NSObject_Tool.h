//
//  NSObject+NSObject_Tool.h
//  Extends
//
//  Created by bigmac on 28/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_Tool)

+(BOOL)isMainThread;
+(dispatch_queue_t)mainQueueBlock:(void (^)())block;
+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block;
+(dispatch_queue_t)backgroundDownloadQueueBlock:(void (^)())block;

-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block;
-(NSDictionary *)serializeToDictionary;

@end
