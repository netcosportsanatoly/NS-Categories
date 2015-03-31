//
//  NSObject+NSObject_Xpath.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_Xpath)

-(id)getXpath:(NSString*)xpath type:(Class)type def:(id)def;
-(id)getXpathNil:(NSString*)xpath type:(Class)type;

-(NSString *)getXpathEmptyString:(NSString*)xpath;
-(NSString *)getXpathNilString:(NSString*)xpath;

-(NSString *)getXpathIntegerToString:(NSString*)xpath;
-(NSInteger)getXpathInteger:(NSString*)xpath;
-(NSUInteger)getXpathUInteger:(NSString*)xpath;
-(long)getXpathLong:(NSString*)xpath;
-(BOOL)getXpathBool:(NSString*)xpath defaultValue:(BOOL)defaultValue;

-(NSDictionary *)getXpathNilDictionary:(NSString*)xpath;

-(NSArray*)getXpathNilArray:(NSString*)xpath;
-(NSArray*)getXpathEmptyArray:(NSString*)xpath;

-(id)ToMutable;
-(id)ToUnMutable;

@end
