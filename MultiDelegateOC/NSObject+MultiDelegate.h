//
//  NSObject+MultiDelegate.h
//  MultiDelegate
//
//  Created by Flame Grace on 16/11/17.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取单个代理对象对其进行操作
typedef void(^MultiDelegateOperateBlack)(id delegate);


/*
 此类扩展能实现多代理
 需要委托代理执行方法时，调用operateDelegates:方法可在相应block块中获取到单个代理，对其进行操作
*/
@interface NSObject (MultiDelegate)

//添加一个代理
- (void)addMultiDelegate:(id)delegate;
//移除一个代理
- (void)removeMultiDelegate:(id)delegate;
//操作代理
- (void)operateMultiDelegates:(MultiDelegateOperateBlack)operate;

@end
