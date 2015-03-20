//
//  NSArray+NSArray_Tool.m
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSArray+NSArray_Tool.h"
#import "NSObject+NSObject_File.h"
#import "NSObject+NSObject_Xpath.h"

#pragma mark - NSArray
@implementation NSArray (NSArray_Tool)

#pragma mark Class method
+ (instancetype)arrayWithArrays:(NSArray *)array, ...
{
    NSMutableArray *mutableArrayOfArrays = [NSMutableArray new];
    
    va_list args;
    va_start(args, array);
    
    id arg = nil;
    while ((arg = va_arg(args,id)))
    {
        if (arg && [arg isKindOfClass:[NSArray class]])
        {
            NSArray *tempArray = (NSArray *)arg;
            [mutableArrayOfArrays addObjectsFromArray:tempArray];
        }
    }
    va_end(args);
    
    return [mutableArrayOfArrays ToUnMutable];
}

#pragma mark Instance method
-(BOOL)diffForNewArrayElement:(NSArray *)newArray comp:(NSCategoryDiffComp(^)(id itemOld, id itemNew))comp complete:(void(^)(BOOL changed, NSArray *remove, NSArray *insert, NSArray *update))completed{
    __block BOOL hasChange = NO;
    NSMutableArray  *remove = [NSMutableArray new];
    NSMutableArray  *update = [NSMutableArray new];
    NSMutableArray  *insert = [NSMutableArray new];
    
    [newArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
    {
        __block BOOL hasStopped = NO;
        [self enumerateObjectsUsingBlock:^(id obj2, NSUInteger index2, BOOL *stop)
        {
            NSCategoryDiffComp res = comp(self[index2], newArray[index]);
            if (res == NSCategoryDiffCompUpdate)
            {
                [update addObject:obj];
                hasStopped = YES;
                *stop = YES;
                return;
            }
            if (res == NSCategoryDiffCompEqual)
            {
                hasStopped = YES;
                *stop = YES;
                return;
            }
            hasStopped = NO;
            *stop = NO;
            return;
        }];
        if (!hasStopped)
            [insert addObject:obj];
    }];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
     {
         __block BOOL hasStopped = NO;
         [newArray enumerateObjectsUsingBlock:^(id obj2, NSUInteger index2, BOOL *stop)
         {
             NSCategoryDiffComp res = comp(self[index], newArray[index2]);
             if (res == NSCategoryDiffCompEqual || res == NSCategoryDiffCompUpdate)
             {
                 hasStopped = YES;
                 *stop = YES;
                 return;
             }
             hasStopped = NO;
             *stop = NO;
             return;
         }];
         if (!hasStopped)
             [remove addObject:obj];
     }];

    hasChange = [remove count] > 0 || [insert count] > 0 || [remove count] > 0;
    completed(hasChange, remove, insert, update);
    return hasChange;
}


-(BOOL)diffForNewArrayItem:(NSArray *)newArray section:(NSInteger)section comp:(NSCategoryDiffComp(^)(id itemOld, id itemNew))comp complete:(void(^)(BOOL changed, NSArray *remove, NSArray *insert, NSArray *update))completed{
    __block BOOL hasChange = NO;
    NSMutableArray  *remove = [NSMutableArray new];
    NSMutableArray  *update = [NSMutableArray new];
    NSMutableArray  *insert = [NSMutableArray new];
    
    [newArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
     {
         __block BOOL hasStopped = NO;
         [self enumerateObjectsUsingBlock:^(id obj2, NSUInteger index2, BOOL *stop)
          {
              NSCategoryDiffComp res = comp(self[index2], newArray[index]);
              if (res == NSCategoryDiffCompUpdate)
              {
                  [update addObject:[NSIndexPath indexPathForItem:index inSection:section]];
                  hasStopped = YES;
                  *stop = YES;
                  return;
              }
              if (res == NSCategoryDiffCompEqual)
              {
                  hasStopped = YES;
                  *stop = YES;
                  return;
              }
              hasStopped = NO;
              *stop = NO;
              return;
          }];
         if (!hasStopped)
             [insert addObject:[NSIndexPath indexPathForItem:index inSection:section]];
     }];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
     {
         __block BOOL hasStopped = NO;
         [newArray enumerateObjectsUsingBlock:^(id obj2, NSUInteger index2, BOOL *stop)
          {
              NSCategoryDiffComp res = comp(self[index], newArray[index2]);
              if (res == NSCategoryDiffCompEqual || res == NSCategoryDiffCompUpdate)
              {
                  hasStopped = YES;
                  *stop = YES;
                  return;
              }
              hasStopped = NO;
              *stop = NO;
              return;
          }];
         if(!hasStopped)
             [remove addObject:[NSIndexPath indexPathForItem:index inSection:section]];
     }];
    hasChange = [remove count] > 0 || [insert count] > 0 || [remove count] > 0;
    completed(hasChange, remove, insert, update);
    return hasChange;
}

-(NSArray *) sortAlphabeticallyArrayOfObjectUsing:(NSString *)keys isAsc:(BOOL)asc
{
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:keys ascending:asc];
    return [self sortedArrayUsingDescriptors:@[brandDescriptor]];
}

-(BOOL)containsString:(NSString *)stringToCompareWith
{
    __block BOOL returnedValue = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
       if (obj && [obj isKindOfClass:[NSString class]] && [obj isEqualToString:stringToCompareWith])
       {
           returnedValue = YES;
           *stop = YES;
       }
    }];
    return returnedValue;
}

- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator)
    {
        [array addObject:element];
    }
    return [array ToUnMutable];
}

- (NSString *)implode:(NSString *)separator
{
    return [self componentsJoinedByString:separator];
}

@end
