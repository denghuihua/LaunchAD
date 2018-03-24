//
//  LaunchADController.m
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/21.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "LaunchADController.h"
#import <UIKit/UIKit.h>
#import "LaunchAdViewController.h"
#import "SHILaunchADBusiness.h"
#import "AppDelegate.h"
static NSString *LaunchADVC;

@interface LaunchADController(){
    SHILaunchADBusiness *_launchAdBusiness;
}
@property(nonatomic,strong)UIWindow *launchADWindow;
@end

@implementation LaunchADController

+ (void)load{
    [self shareInstance];
}

+ (LaunchADController *)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LaunchADController alloc] init];
    });
    return instance;
}

-(id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
        _launchAdBusiness = [SHILaunchADBusiness shareInstance];
    }
    return self;
}

- (void)applicationDidFinishLaunching{
    //视图展示
    if ([_launchAdBusiness isShow]) {
        [self showLaunchAdView];
    }
    //广告抓取
    [_launchAdBusiness loadNewData];
}

#pragma mark - loadViews

//to do . replace filePath
- (void)showLaunchAdView{
    [self showLauchADWindow];
    NSString *filePath = [_launchAdBusiness filePathOfLaunchADImg];
     [(LaunchAdViewController *)self.launchADWindow.rootViewController loadImageOrGifWithPath:filePath];
    [NSTimer scheduledTimerWithTimeInterval:_launchAdBusiness.launchAdObj.displayMillisecond/1000 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self dismissLaunchWindow];
    }];
}

- (void)dismissLaunchWindow{
    __weak  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [UIView animateWithDuration:0.3 animations:^{
        self.launchADWindow.alpha = 0.3;
    } completion:^(BOOL finished) {
        [appDelegate.window makeKeyAndVisible];
        
        [self.launchADWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview]; 
        }];
        self.launchADWindow = nil;
        
        _launchAdBusiness = nil;
    }];
}

- (void)showLauchADWindow
{
    [self.launchADWindow makeKeyAndVisible];
    _launchADWindow.alpha = 0;
    _launchADWindow.rootViewController.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _launchADWindow.alpha = 1;
        _launchADWindow.rootViewController.view.alpha = 1;
    }];
}

- (UIWindow *)launchADWindow
{
    if (!_launchADWindow) {
        _launchADWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _launchADWindow.windowLevel = UIWindowLevelAlert + 1;
        _launchADWindow.backgroundColor = [UIColor blueColor];
        
        LaunchAdViewController *rootVC = [[LaunchAdViewController alloc] init];
        _launchADWindow.rootViewController = rootVC;
    }                                                       
    return _launchADWindow;
}

@end
