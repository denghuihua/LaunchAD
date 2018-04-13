//
//  AppDelegate.m
//  AlertTest
//
//  Created by huihuadeng on 2018/4/13.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()
{
    UIWindow *window1;
    UIWindow * window2;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor yellowColor];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    window1.windowLevel = UIWindowLevelAlert;
    window1.backgroundColor = [UIColor redColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor  =[UIColor redColor];
    window1.rootViewController = vc2;
    [window1 makeKeyAndVisible];
    
    window2 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    window2.windowLevel = UIWindowLevelAlert;
    window2.backgroundColor = [UIColor blackColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor  =[UIColor blackColor];
    window2.rootViewController = vc3;
    [window2 makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
