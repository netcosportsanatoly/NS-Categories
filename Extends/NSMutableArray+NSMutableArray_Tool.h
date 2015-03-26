//
//  NSMutableArray+NSMutableArray_Tool.h
//  FoxSports
//
//  Created by Guillaume on 05/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSMutableArray_Tool)

/**
 *  Reverse the current array
 */
-(void)reverseMutableArray;

/**
 *  Remove the objects of the array whose predicate returns YES/true.
 *
 *  @param predicate Predicate block called for each objects in the array
 */
-(void)removeObjectsPassingTest:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))predicate;

/**
 *  Remove all string elements if isEqualToString: returns yes.
 *
 *  @param stringToRemove String to compare elemnts with
 */
-(void)removeStringIdenticalTo:(NSString *)stringToRemove;

/**
 *  Move object's position in the array
 *
 *  @param index    Current index of the object to move
 *  @param newIndex New index of the object once moved
 */
-(void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex;

/**
 *  Move objec's position in the array
 *
 *  @param object   Object to move
 *  @param newIndex New index of the object once moved
 */
-(void)moveObject:(id)object toIndex:(NSUInteger)newIndex;

@end
