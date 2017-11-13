//
//  DemoSource.m
//  Demo
//
//  Created by Flame Grace on 2017/11/13.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "DemoSource.h"


@interface DemoSource ()

@end


@implementation DemoSource


- (void)change
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(changeDemoSource)])
    {
        [self.delegate changeDemoSource];
    }
}

@end
