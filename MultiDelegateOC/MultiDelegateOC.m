//
//  MultiDelegateOC.m
//  MultiDelegateOC
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.

#import "MultiDelegateOC.h"

@interface FGPrivate_WeakDelegateObject : NSObject

@property (weak, nonatomic) id delegate;

@end

@implementation FGPrivate_WeakDelegateObject

- (NSString *)description{
    return [NSString stringWithFormat:@"%@",self.delegate];
}

@end


@interface MultiDelegateOC()

@property (readwrite,strong,nonatomic) NSMutableArray* delegates;

@end



@implementation MultiDelegateOC

- (instancetype)init
{
    if(self = [super init])
    {
        self.silentWhenEmpty = YES;
    }
    return self;
}

- (FGPrivate_WeakDelegateObject *)findDelegateObjectByDelegate:(id)delegate{
    if(!delegate){
        return nil;
    }
    NSArray *delegates = [NSArray arrayWithArray:self.delegates];
    for (FGPrivate_WeakDelegateObject *delegateObject in delegates) {
        if(delegateObject.delegate && [delegateObject.delegate isEqual:delegate]){
            return delegateObject;
        }
    }
    return nil;
}

- (void)addDelegate:(id)delegate
{
    [self addDelegate:delegate before:NO otherDelegate:nil];
}

- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate{
    [self addDelegate:delegate before:YES otherDelegate:otherDelegate];
}

- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate{
    [self addDelegate:delegate before:NO otherDelegate:otherDelegate];
}

- (void)addDelegate:(id)delegate before:(BOOL)before otherDelegate:(id)otherDelegate{
    @synchronized (self) {
        if(!delegate){
            return;
        }
        FGPrivate_WeakDelegateObject *otherDelegateObject = [self findDelegateObjectByDelegate:otherDelegate];
        FGPrivate_WeakDelegateObject *delegateObject = [self findDelegateObjectByDelegate:delegate];
        if(!delegateObject){
            delegateObject = [[FGPrivate_WeakDelegateObject alloc]init];
            delegateObject.delegate = delegate;
            if(!otherDelegateObject){
                [self.delegates addObject:delegateObject];
                return;
            }
        }else{
            if(!otherDelegateObject){
                return;
            }
            [self.delegates removeObject:delegateObject];
        }
        NSInteger index = [self.delegates indexOfObject:otherDelegateObject];
        if(!before){
            index = [self.delegates indexOfObject:otherDelegateObject]+1;
            if(index > self.delegates.count){
                index = self.delegates.count;
            }
        }
        [self.delegates insertObject:delegateObject atIndex:index];
    }
}

- (void)fg_private_compact{
    @synchronized (self) {
        NSArray *delegates = [NSArray arrayWithArray:self.delegates];
        for (FGPrivate_WeakDelegateObject *delegateObject in delegates) {
            if(!delegateObject.delegate){
                [self.delegates removeObject:delegateObject];
            }
        }
    }
}

- (void)removeDelegate:(id)delegate{
    @synchronized (self) {
        FGPrivate_WeakDelegateObject *exist = [self findDelegateObjectByDelegate:delegate];
        if(exist){
            [self.delegates removeObject:exist];
        }
    }
}

- (void)removeAllDelegates
{
    @synchronized (self) {
        [self.delegates removeAllObjects];
    }
}

- (BOOL)respondsToSelector:(SEL)selector
{
    if ([super respondsToSelector:selector]){
        return YES;
    }
    [self fg_private_compact];
    NSArray *delegates = [NSArray arrayWithArray:self.delegates];
    for (FGPrivate_WeakDelegateObject *delegateObject in delegates){
        if (delegateObject.delegate && [delegateObject.delegate respondsToSelector:selector]){
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (signature){
        return signature;
    }
    NSArray *delegates = [NSArray arrayWithArray:self.delegates];
    for (FGPrivate_WeakDelegateObject *delegateObject in delegates){
        if (!delegateObject.delegate){
            continue;
        }
        signature = [delegateObject.delegate methodSignatureForSelector:selector];
        if (signature){
             break;
        }
    }
    if(!signature && self.silentWhenEmpty){
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL selector = [invocation selector];
    BOOL responded = NO;
    void *returnValue = NULL;
    NSArray *delegates = [NSArray arrayWithArray:self.delegates];
    for (FGPrivate_WeakDelegateObject *delegateObject in delegates){
        if (delegateObject.delegate && [delegateObject.delegate respondsToSelector:selector]){
            [invocation invokeWithTarget:delegateObject.delegate];
            if(invocation.methodSignature.methodReturnLength != 0){
                void *value = nil;
                [invocation getReturnValue:&value];
                if(value){
                    returnValue = value;
                }
            }
            responded = YES;
        }
    }
    if(returnValue){
        [invocation setReturnValue:&returnValue];
    }
    if (!responded && !self.silentWhenEmpty){
        [self doesNotRecognizeSelector:selector];
    }
}

- (NSMutableArray *)delegates{
    if(!_delegates){
        _delegates = [[NSMutableArray alloc]init];
    }
    return _delegates;
}

@end

