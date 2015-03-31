//
//  NSDate+NSDate_Tool.h
//  FoxSports
//
//  Created by Guillaume on 31/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_Tool)

/**
 *  Create a NSDate instance from an ISO 8601 string representation
 *
 *  @param `dateTime' ISO 8601 string representation
 *
 *  @return New NSDate instance
 */
+(NSDate *) dateWithISO8601String:(NSString *)dateTimeZFormat;

/**
 *  Transform a NSDate instance to an ISO 8601 string representation
 *
 *  @param `dateTime' ISO 8601 NSDate
 *
 *  @return New string representation
 */
+(NSString *) stringWithISO8601Date:(NSDate *)dateTime;

@end
