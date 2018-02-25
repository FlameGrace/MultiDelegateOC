//
//  NSObject+MultiDelegateOC.m
//  MultiDelegateOC
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NSObject+MultiDelegateOC.h"
#import <objc/runtime.h>


@implementation NSObject (MultiDelegate)

//使用动态运行时添加数组对象multiDelegates，保存代理
- (void)setMultiDelegate:(MultiDelegateOC *)multiDelegate
{
    objc_setAssociatedObject(self, @selector(multiDelegate), multiDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (MultiDelegateOC *)multiDelegate
{
    MultiDelegateOC *multiDelegate = objc_getAssociatedObject(self,@selector(multiDelegate));
    if(multiDelegate == nil)
    {
        multiDelegate = [[MultiDelegateOC alloc]init];
        objc_setAssociatedObject(self, @selector(multiDelegate), multiDelegate, OBJC_ASSOCIATION_RETAIN);
    }
    return multiDelegate;
}

- (void)addMultiDelegate:(id)delegate
{
    [self.multiDelegate addDelegate:delegate];
}

- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate
{
    [self.multiDelegate addDelegate:self beforeDelegate:otherDelegate];
}
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate
{
    [self.multiDelegate addDelegate:self afterDelegate:otherDelegate];
}


- (void)removeMultiDelegate:(id)delegate
{
    [self.multiDelegate removeDelegate:self];
}

- (void)removeAllDelegates
{
    [self.multiDelegate removeAllDelegates];
}

@end
