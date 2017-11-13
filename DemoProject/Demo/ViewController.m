//
//  ViewController.m
//  Demo
//
//  Created by Flame Grace on 2017/11/8.
//  Copyright © 2017年 com.flamegrace. All rights reserved.
//

#import "ViewController.h"
#import "DemoSource.h"
#import "Demo1.h"
#import "Demo2.h"

@interface ViewController ()

@property (strong, nonatomic) DemoSource *source;
@property (strong, nonatomic) Demo1 *demo1;
@property (strong, nonatomic) Demo2 *demo2;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *click = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 44)];
    click.backgroundColor = [UIColor lightGrayColor];
    [click setTitle:@"click" forState:UIControlStateNormal];
    [click setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [click addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
    
    self.source = [[DemoSource alloc]init];
    self.source.delegate = (id)self.source.multiDelegate;
    self.demo1 = [[Demo1 alloc]init];
    self.demo2 = [[Demo2 alloc]init];
    
    [self.source addMultiDelegate:self.demo1];
    [self.source addMultiDelegate:self.demo2];
}

- (void)click:(id)sender
{
    [self.source change];
}


@end
