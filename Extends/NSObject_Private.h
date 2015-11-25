//
//  NSObject_Private.h
//  FoxSports
//
//  Created by Guillaume on 25/11/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#ifndef NSObject_Private_h
#define NSObject_Private_h

@interface NSObject ()
{
    void(^commonCompletionBLock)(NSUInteger numberOfChildBlock);

    NSUInteger numberBlockCallsBeforeCommonCompletionIsCalled;
    NSUInteger currentNumberOfBlockCalls;
}
@end

#endif /* NSObject_Private_h */
