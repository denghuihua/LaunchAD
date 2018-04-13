//
//  ViewController.m
//  AlertTest
//
//  Created by huihuadeng on 2018/4/13.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIWindow *window1;
    UIWindow *window2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
//    window1.windowLevel = UIWindowLevelNormal + 1;
//    window1.backgroundColor = [UIColor redColor];
//    [window1 makeKeyAndVisible];
//    
//    window2 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
//    window2.windowLevel = UIWindowLevelNormal + 1;
//    window2.backgroundColor = [UIColor blackColor];
//    [window2 makeKeyAndVisible];
}

- (void)btnAction:(UIButton *)button{
    NSLog(@"before alert_keyWindow:%@", [[UIApplication sharedApplication]keyWindow]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
    NSLog(@"after alert_keyWindow:%@", [[UIApplication sharedApplication]keyWindow]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
