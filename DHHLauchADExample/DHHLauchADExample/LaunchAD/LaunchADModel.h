//
//  LaunchADModel.h
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/22.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchADModel : NSObject

@property(nonatomic,assign)NSTimeInterval startTimeStamp; //开屏图 启用时间
@property(nonatomic,assign)NSTimeInterval endTimeStamp;//开屏图 弃用时间 （对应节假日活动开屏图业务）
@property(nonatomic,assign)NSTimeInterval displayMillisecond; //开屏图 展现时间 毫秒为单位
@property(nonatomic,copy)NSString *imgSeverUrl;//图片地址 约束png/gif  （Native可以判断此URL来区分用缓存还是拉新图）
//相对App沙盒 地址 eg.Documents/dir/pic.png
@property(nonatomic,copy)NSString *imgLocalPath;//图片地址 约束png/gif  （Native可以判断此URL来区分用缓存还是拉新图）

@end
