//
//  MultiDelegateOC.h
//  MultiDelegateOC
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.

#import <Foundation/Foundation.h>

@interface MultiDelegateOC : NSObject

/**
 The array of registered delegates.
 */
@property (readonly, nonatomic) NSPointerArray* delegates;

/**
 Set whether to throw unrecognized selector exceptions when calling delegate methods on an empty AIMultiDelegate.
 
 When `slientWhenEmpty` is NO, the default, if a delegate selector is called and there are no registered delegates an
 unregonized selector execption will be thrown. Which, unless you have a try/catch block, will crash the app. Setting
 `silentWhenEmpt` to YES will silence the execptions by ignoring selector invocations when there are no registered
 delegates.
 */
@property (nonatomic, assign) BOOL silentWhenEmpty;


- (void)addDelegate:(id)delegate;
- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate;

- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
