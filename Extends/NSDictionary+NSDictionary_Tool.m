//
//  NSDictionary+NSDictionary_Tool.m
//  FoxSports
//
//  Created by Guillaume on 09/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import "NSDictionary+NSDictionary_Tool.h"
#import "NSObject+NSObject_Xpath.h"

@implementation NSDictionary (NSDictionary_Tool)

+ (instancetype)dictionaryWithDictionaries:(NSDictionary *)dict, ...
{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
    
    va_list args;
    va_start(args, dict);
    
    id arg = nil;
    while ((arg = va_arg(args,id)))
    {
        if (arg && [arg isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *tempDictionary = (NSDictionary *)arg;
            [mutableDictionary addEntriesFromDictionary:tempDictionary];
        }
    }
    va_end(args);
    
    return [mutableDictionary ToUnMutable];
}

- (NSDictionary *)dictionaryByMergingDictionary:(NSDictionary*)dict
{
    NSMutableDictionary *mutDict = [self mutableCopy];
    [mutDict addEntriesFromDictionary:dict];
    return [mutDict ToUnMutable];
}

@end
