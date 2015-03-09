//
//  UIViewController+Tool.m
//  FoxSports
//
//  Created by Guillaume on 04/03/15.
//  Copyright (c) 2015 Netco Sports. All rights reserved.
//

#import "UIViewController+UIViewController_Tool.h"

@implementation UIViewController (UIViewController_Tool)

-(void)removeChildViewControllers
{
    [[self childViewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        if (obj && [obj isKindOfClass:[UIViewController class]])
        {
            [obj removeFromParentViewController];
        }
    }];
}

@end
