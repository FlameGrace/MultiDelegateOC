//
//  DemoSource.h
//  Demo
//
//  Created by Flame Grace on 2017/11/13.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MultiDelegateOC.h"

@protocol DemoSourceDelegate <NSObject>

- (void)changeDemoSource;

@end


@interface DemoSource : NSObject

@property (weak, nonatomic) id <DemoSourceDelegate> delegate;

- (void)change;

@end
