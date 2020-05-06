//
//  ViewController.m
//  FlutterHybirdiOS
//
//  Created by tianyang on 2020/5/6.
//  Copyright © 2020 tianyang. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame  = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)handleButtonAction {
    FlutterViewController *flutterViewController = [FlutterViewController new];
    [flutterViewController setInitialRoute:@"{name:'devio', dataList:['aa','bb','cc']}"];
    [self presentViewController: flutterViewController animated:true completion:nil];
}



@end
