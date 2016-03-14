//
//  UIImage+UIImage_Filter.m
//  FotofanFramework
//
//  Created by Guillaume Derivery on 18/12/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "UIImage+UIImage_Filter.h"
#import "NSDictionary+NSDictionary_Tool.h"
#import "NSUsefulDefines.h"

@implementation UIImage (UIImage_Filter)

-(UIImage *)imageFilteredWithString:(NSString *)stringFilter andAttributes:(NSDictionary *)attributes
{
    if (!stringFilter || [stringFilter length] == 0)
    {
        DLog(@"Bad filter");
        return self;
    }
    
    CIImage *outputImage = nil;
    @autoreleasepool
    {
        CIImage *beginImage = [CIImage imageWithCGImage:[self CGImage]];
        NSMutableDictionary *attributesWithImage = [[NSMutableDictionary alloc] initWithDictionary:attributes];
        [attributesWithImage setObject:beginImage forKey:@"inputImage"];
        
        CIFilter *filter = [CIFilter filterWithName:stringFilter withInputParameters:attributesWithImage];
        
        for (id key in attributesWithImage) {
            NSLog(@"key: %@, value: %@ \n", key, [attributesWithImage objectForKey:key]);
        }
        
//        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" withInputParameters:@{
//                                                                                             @"inputImage": beginImage,
//                                                                                             @"inputRadius": @20
//                                                                                             }];
        
        outputImage = [filter outputImage];
    }
    
    CGImageRef cgimg = NULL;
    @autoreleasepool
    {
        if (outputImage)
        {
            CIContext *context = [CIContext contextWithOptions:nil];
            cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        }
    }
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return newImg;
}

@end
