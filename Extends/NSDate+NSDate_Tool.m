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
// 2013-11-18T23:00:00.324Z
// [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.locale = [NSLocale systemLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    NSDate *date = [formatter dateFromString:dateTimeZFormat];
    return date;
}

+(NSString *) stringWithISO8601Date:(NSDate *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    NSString *stringFromDate = [formatter stringFromDate:dateTime];
    return stringFromDate;
}

@end
