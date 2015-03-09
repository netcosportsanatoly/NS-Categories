//
//  NSObject+NSObject_File.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_File)

#pragma mark - Folder paths access
+(NSString *)getApplicationDocumentPath;
+(NSString *)getApplicationCachePath;
+(NSString *)getApplicationTempPath;

#pragma mark - File paths access
+(NSString *)getApplicationDocumentPathForFile:(NSString *)fileName;
+(NSString *)getApplicationCachePathForFile:(NSString *)fileName;
+(NSString *)getApplicationTempPathForFile:(NSString *)fileName;
+(BOOL)isFileExisting;

#pragma mark - Get objects from files
+(id)getObjectFromDocumentFile:(NSString *)fileName withTTL:(NSUInteger)ttl;
+(id)getObjectFromCacheFile:(NSString *)fileName withTTL:(NSUInteger)ttl;
+(id)getObjectFromTempFile:(NSString *)fileName withTTL:(NSUInteger)ttl;

#pragma mark - Save objects in files
-(void)saveObjectInDocumentFile:(NSString *)fileName;
-(void)saveObjectInCacheFile:(NSString*)fileName;
-(void)saveObjectInTempFile:(NSString*)fileName;

#pragma mark - File cleaning
+(void)emptyContentOfDocumentFile:(NSString *)fileName;
+(void)emptyContentOfCacheFile:(NSString *)fileName;
+(void)emptyContentOfTempFile:(NSString *)fileName;

#pragma mark - File removing
+(void)removeDocumentFile:(NSString *)fileName;
+(void)removeCacheFile:(NSString *)fileName;
+(void)removeCacheFiles;
+(void)removeTempFile:(NSString *)fileName;

#pragma mark - TTL Checking
+(NSInteger)dateModifiedSort:(NSString *)fileName withTTL:(NSUInteger)ttl;

@end
