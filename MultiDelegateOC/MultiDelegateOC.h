//
//  MultiDelegateOC.h
//  MultiDelegateOC
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.

#import <Foundation/Foundation.h>
//The mediation object holds the multi delegates array and forwards the delegate message
@interface MultiDelegateOC : NSObject

/**
 The array of registered delegates.
 */
@property (readonly, nonatomic) NSMutableArray* delegates;

/**
 Whether to throw an exception when the delegate method has no implementer. Default is NO;
 */
@property (nonatomic, assign) BOOL silentWhenEmpty;


- (void)addDelegate:(id)delegate;
- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate;

- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
