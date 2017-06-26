//
//  NSObject+MultiDelegate.m
//  MultiDelegate
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NSObject+MultiDelegate.h"
#import "MDWeakObject.h"
#import <objc/runtime.h>


@implementation NSObject (MultiDelegate)

//使用动态运行时添加数组对象multiDelegates，保存代理
- (void)setMultiDelegates:(NSMutableArray<MDWeakObject *> *)multiDelegates
{
    objc_setAssociatedObject(self, @selector(multiDelegates), multiDelegates, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<MDWeakObject *> *)multiDelegates
{
    NSMutableArray *multiDelegates = objc_getAssociatedObject(self,@selector(multiDelegates));
    if(multiDelegates == nil)
    {
        multiDelegates = [[NSMutableArray alloc]init];
        objc_setAssociatedObject(self, @selector(multiDelegates), multiDelegates, OBJC_ASSOCIATION_RETAIN);
    }
    return multiDelegates;
}

- (void)addMultiDelegate:(id)delegate
{
    if(delegate == nil)return;
    
    __block BOOL exist = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [self.multiDelegates enumerateObjectsUsingBlock:^(MDWeakObject * _Nonnull delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if(delegate.object)
        {
            if([delegate.object isEqual:delegate])
            {
                exist = YES;
            }
        }
        else
        {
            [weakSelf.multiDelegates removeObject:delegate];
        }
    }];
    
    if(!exist)
    {
        MDWeakObject *newDelegate = [[MDWeakObject alloc]init];
        newDelegate.object =delegate;
        [self.multiDelegates addObject:newDelegate];
    }
    
}

- (void)removeMultiDelegate:(id)delegate
{
    if(delegate == nil)return;
    
    __weak typeof(self) weakSelf = self;
    
    [self.multiDelegates enumerateObjectsUsingBlock:^(MDWeakObject * _Nonnull delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if([delegate.object isEqual:delegate])
        {
            [weakSelf.multiDelegates removeObject:delegate];
        }
    }];
    
}

- (void)operateMultiDelegates:(MultiDelegateOperateBlack)operate
{
     [self.multiDelegates enumerateObjectsUsingBlock:^(MDWeakObject * _Nonnull delegate, NSUInteger idx, BOOL * _Nonnull stop) {
         operate(delegate.object);
     }];
}



@end
