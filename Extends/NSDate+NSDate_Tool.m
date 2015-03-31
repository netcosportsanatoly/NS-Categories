//
//  NSDate+NSDate_Tool.m
//  FoxSports
//
//  Created by Guillaume on 31/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import "NSDate+NSDate_Tool.h"

@implementation NSDate (NSDate_Tool)

+(NSDate *) dateWithISO8601String:(NSString *)dateTimeZFormat;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2013-11-18T23:00:00.324Z
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.locale = [NSLocale systemLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
    return [formatter dateFromString:dateTimeZFormat];
}

+(NSString *) stringWithISO8601Date:(NSDate *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2013-11-18T23:00:00.324Z
    formatter.locale = [NSLocale systemLocale];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
    return [formatter stringFromDate:dateTime];
}

@end
