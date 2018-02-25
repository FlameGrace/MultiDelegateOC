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
    
    UIButton *returnId = [[UIButton alloc]initWithFrame:CGRectMake(70, 200, 100, 44)];
    returnId.backgroundColor = [UIColor lightGrayColor];
    [returnId setTitle:@"Return id" forState:UIControlStateNormal];
    [returnId setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [returnId addTarget:self action:@selector(returnId:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnId];
    
    UIButton *returnInt = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 44)];
    returnInt.backgroundColor = [UIColor lightGrayColor];
    [returnInt setTitle:@"Return int" forState:UIControlStateNormal];
    [returnInt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [returnInt addTarget:self action:@selector(returnInt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnInt];
    
    UIButton *getNoReturn = [[UIButton alloc]initWithFrame:CGRectMake(70, 300, 100, 44)];
    getNoReturn.backgroundColor = [UIColor lightGrayColor];
    [getNoReturn setTitle:@"no return" forState:UIControlStateNormal];
    [getNoReturn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [getNoReturn addTarget:self action:@selector(getNoReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getNoReturn];
    
    self.source = [[DemoSource alloc]init];
    self.source.delegate = (id)self.source.multiDelegate;
    self.demo1 = [[Demo1 alloc]init];
    self.demo2 = [[Demo2 alloc]init];
    
    [self.source addMultiDelegate:self.demo1];
    [self.source addMultiDelegate:self.demo2];
}

- (void)returnId:(id)sender
{
    [self.source getId];
}

- (void)returnInt:(id)sender
{
    [self.source getInt];
}

- (void)getNoReturn:(id)sender
{
    [self.source getNoReturn];
}



@end
