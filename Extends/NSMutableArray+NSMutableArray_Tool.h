//
//  NSMutableArray+NSMutableArray_Tool.h
//  FoxSports
//
//  Created by Guillaume on 05/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSMutableArray_Tool)

-(void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex;

-(void)moveObject:(id)object toIndex:(NSUInteger)newIndex;

@end
