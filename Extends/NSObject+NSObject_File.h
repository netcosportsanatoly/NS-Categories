//
//  NSObject+NSObject_File.h
//  Extends
//
//  Created by bigmac on 25/09/12.
//  Copyright (c) 2012 Jean Alexandre Iragne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObject_File)

/**
 *  Retrieve application useful folders (Document, Document/tmp, Cache)
 *
 *  @return Path for the current application
 */
#pragma mark - Folder paths access
+(NSString *)getApplicationDocumentPath;
+(NSString *)getApplicationCachePath;
+(NSString *)getApplicationTempPath;

/**
 *  Retrieve application useful folders associated with a file name.
 *
 *  @return Entire path of the given fileName.
 */
#pragma mark - File paths access
+(NSString *)getApplicationDocumentPathForFile:(NSString *)fileName;
+(NSString *)getApplicationCachePathForFile:(NSString *)fileName;
+(NSString *)getApplicationTempPathForFile:(NSString *)fileName;

/**
 *  Check if a file exists
 *
 *  @param filePath Full path of the file
 *
 *  @return YES if the NSFileManager found it, Not if not.
 */
+(BOOL)isFileExistingAtPath:(NSString *)filePath;

/**
 *  Create an object from the given file name using the given TTL.
 *  If file is older than the ttl, the object created will be empty.
 *
 *  @return Created object
 */
#pragma mark - Get objects from files
+(id)getObjectFromDocumentFile:(NSString *)fileName withTTL:(NSUInteger)ttl;
+(id)getObjectFromCacheFile:(NSString *)fileName withTTL:(NSUInteger)ttl;
+(id)getObjectFromTempFile:(NSString *)fileName withTTL:(NSUInteger)ttl;

/**
 *  Save an object into a file given with fileName
 *
 *  @return (/)
 */
#pragma mark - Save objects in files
-(void)saveObjectInDocumentFile:(NSString *)fileName;
-(void)saveObjectInCacheFile:(NSString*)fileName;
-(void)saveObjectInTempFile:(NSString*)fileName;

/**
 *  Remove the content of a file given with fileName
 *
 *  @return (/)
 */
#pragma mark - File cleaning
+(void)emptyContentOfDocumentFile:(NSString *)fileName;
+(void)emptyContentOfCacheFile:(NSString *)fileName;
+(void)emptyContentOfTempFile:(NSString *)fileName;

/**
 *  Remove file given with fileName
 *
 *  @return (/)
 */
#pragma mark - File removing
+(void)removeDocumentFile:(NSString *)fileName;
+(void)removeCacheFile:(NSString *)fileName;
+(void)removeCacheFiles;
+(void)removeTempFile:(NSString *)fileName;

/**
 *  Check if the file is older than the TTL.
 *  If it is older than the TTL, it removes it.
 *
 *  @param NSInteger TTL to comapre with.
 *
 *  @return 1 if the file has been removed, 0 if not.
 */
#pragma mark - TTL Checking
+(NSInteger)dateModifiedSortFile:(NSString *)filePath withTTL:(NSUInteger)ttl andRemove:(BOOL)shouldRemove;

+(BOOL)file:(NSString *)filePath hasBeenModifiedBeforeNowMinusTTL:(NSUInteger)ttl;

@end
