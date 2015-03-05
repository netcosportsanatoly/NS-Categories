//
//  NSMutableArray+NSMutableArray_Tool.m
//  FoxSports
//
//  Created by Guillaume on 05/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import "NSMutableArray+NSMutableArray_Tool.h"

@implementation NSMutableArray (NSMutableArray_Tool)

-(void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex
{
    id object = [self objectAtIndex:index];
    [self removeObjectAtIndex:index];
    [self insertObject:object atIndex:newIndex];
}

-(void)moveObject:(id)object toIndex:(NSUInteger)newIndex
{
    [self moveObjectAtIndex:[self indexOfObject:object] toIndex:newIndex];
}

@end
