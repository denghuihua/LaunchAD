//
//  SHILaunchADBusiness.h
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/21.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LaunchADModel.h"
/*
 开屏广告控制器，业务层
 */
@interface SHILaunchADBusiness : NSObject

@property(nonatomic,strong)LaunchADModel *launchAdObj;

+ (instancetype)shareInstance;
- (BOOL)isShow;
- (void)loadNewData;
- (void)loadLaunchAdFromSever;
- (void)saveLaunchADData:(LaunchADModel *)adObj;
- (LaunchADModel *)loadLocalADData;
- (NSString *)filePathOfLaunchADImg;

@end
