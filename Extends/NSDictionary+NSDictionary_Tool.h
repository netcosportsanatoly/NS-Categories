//
//  NSDictionary+NSDictionary_Tool.h
//  FoxSports
//
//  Created by Guillaume on 09/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_Tool)

#pragma mark - Class method

/**
 *  It creates an instance of NSDictionary filled with the entries of all dictionaries passed in the variable arguments list.
 *
 *  @param dict VA_LIST of dictionaries
 *
 *  @return NSDictionary instance created with the entries from the dictioary list.
 */
+ (instancetype)dictionaryWithDictionaries:(NSDictionary *)dict, ...;


#pragma mark - Instance Method

/**
 *  Merging `self' dictionary with dict.
 *
 *  @param dict Dictionary to merge with self
 *
 *  @return A new instance of NSDictionary containing entries from self & dict.
 */
- (NSDictionary *)dictionaryByMergingDictionary:(NSDictionary*)dict;

@end
