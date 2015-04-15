//
//  NSObject+NSObject_Tool.m
//  Extends
//
//  Created by bigmac on 28/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import "NSObject+NSObject_Tool.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

#define D_MAX_BG_QUEUE 20

@implementation NSObject (NSObject_Tool)

#pragma mark - QUEUES MANAGEMENT
+(dispatch_queue_t)backgroundDownloadQueueBlock:(void (^)())block
{
	if (![NSThread isMainThread])
    {
		block();
		return 0;
	}
	
	static dispatch_queue_t ar_queue2[D_MAX_BG_QUEUE];
	static dispatch_once_t onceToken2;
	srand((unsigned int)time(NULL));
	dispatch_once(&onceToken2, ^{
		for (int i = 0; i < D_MAX_BG_QUEUE; i++)
        {
			ar_queue2[i] = dispatch_queue_create([[NSString stringWithFormat:@"MyQueue%d",i] cStringUsingEncoding:(NSUTF8StringEncoding)],NULL);
		}
	});
	int i = rand() % D_MAX_BG_QUEUE;
	dispatch_queue_t queue = ar_queue2[i];
	dispatch_async(queue, ^{
		block();
	});
    return queue;
}

+(dispatch_queue_t)backgroundQueueBlock:(void (^)())block
{
	if (![NSThread isMainThread])
    {
		block();
        return 0;
	}
	static dispatch_queue_t ar_queue[D_MAX_BG_QUEUE];
	static dispatch_once_t onceToken;
	srand((unsigned int)time(NULL));
	dispatch_once(&onceToken, ^{
		for (int i = 0; i < D_MAX_BG_QUEUE; i++)
        {
			ar_queue[i] = dispatch_queue_create([[NSString stringWithFormat:@"MyQueue%d",i] cStringUsingEncoding:(NSUTF8StringEncoding)],NULL);
		}
	});
	int i = rand() % D_MAX_BG_QUEUE;
	dispatch_queue_t queue = ar_queue[i];
	dispatch_async(queue, ^{
		block();
	});
    return queue;
}

+(dispatch_queue_t)mainQueueBlock:(void (^)())block
{
    dispatch_queue_t queue = dispatch_get_main_queue();

    if ([NSThread isMainThread])
    {
        block();
	}
    else
    {
        dispatch_sync(queue, ^{
            block();
        });
    }
    return queue;
}

+(BOOL)isMainThread
{
    if ([NSThread isMainThread])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)NSObject_Tool:(void(^)())block
{
	block();
}

-(void)performWithDelay:(NSTimeInterval)time block:(void(^)())block
{
	[self performSelector:@selector(NSObject_Tool:) withObject:[block copy] afterDelay:time];
}

-(NSDictionary *)serializeToDictionary
{
    Class clazz = [self class];
    u_int count;
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableDictionary* propertyDic = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char  *methodName = property_getName(properties[i]);
        NSString *method_name = [NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding];
        @try {
            id val = [self valueForKey:method_name];
            [propertyDic setObject:val forKey:method_name];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
        }
    }
    free(properties);
    return  propertyDic;
}
@end
