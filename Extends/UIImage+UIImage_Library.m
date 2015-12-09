//
//  UIImage+UIImage_Library.m
//  Extends
//
//  Created by Guillaume Derivery on 09/12/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <Photos/Photos.h>
#import "UIImage+UIImage_Library.h"
#import "NSUsefulDefines.h"

@implementation UIImage (UIImage_Library)

#pragma mark Class methods
+(NSArray *) getImagesFromLibraryAfter:(NSDate *)date
{
    __block NSMutableArray *images = [NSMutableArray new];
    PHFetchResult *fetchResult = [UIImage getImagesFromPhotoLibraryOrderedByCreationDate];
    
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (EXISTS(asset, [PHAsset class]) && [asset.creationDate compare:date] == NSOrderedAscending) // asset.creationDate is earlier than date
         {
             [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info)
              {
                  if (result)
                      [images addObject:result];
              }];
         }
     }];
    return images;
}

+(UIImage *) getLastImageFromLibrary
{
    __block UIImage *lastImage = nil;
    PHFetchResult *fetchResult = [UIImage getImagesFromPhotoLibraryOrderedByCreationDate];
    
    if ([fetchResult count] > 0)
    {
        PHAsset *asset = [fetchResult lastObject];
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info)
         {
             lastImage = result;
         }];
    }
    return lastImage;
}

+(PHFetchResult *)getImagesFromPhotoLibraryOrderedByCreationDate
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    return [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
}

#pragma mark Instance methods
-(void) saveToLibraryInAlbum:(NSString *)album withCompletionBlock:(void(^)(BOOL success, NSError *error))completion
{
    __block PHFetchResult *photosAsset;
    __block PHAssetCollection *collection;
    __block PHObjectPlaceholder *placeholder;
    
    // Find the album
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", album];
    collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:fetchOptions].firstObject;
    
    // Create the album
    if (!collection)
    {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^(void)
         {
             PHAssetCollectionChangeRequest *createAlbum = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album];
             placeholder = [createAlbum placeholderForCreatedAssetCollection];
             
         } completionHandler:^(BOOL success, NSError *error)
         {
             if (success)
             {
                 PHFetchResult *collectionFetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[placeholder.localIdentifier] options:nil];
                 collection = collectionFetchResult.firstObject;
             }
         }];
    }
    
    // Save to the album
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^(void)
     {
         PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self];
         placeholder = [assetRequest placeholderForCreatedAsset];
         photosAsset = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
         PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection assets:photosAsset];
         [albumChangeRequest addAssets:@[placeholder]];
         
     } completionHandler:completion];
}

@end
