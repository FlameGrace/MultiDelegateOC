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


- (void)getId
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getId)])
    {
        NSNumber *d = [self.delegate getId];
        NSLog(@"Real number is %@",d);
    }
}

- (void)getInt
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getInt)])
    {
        int d = [self.delegate getInt];
        NSLog(@"Real number is %d",d);
    }
}
- (void)getNoReturn
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getNoReturn)])
    {
        [self.delegate getNoReturn];
    }
}

@end
