//
//  SHILaunchADBusiness.m
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/21.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//
#define imageURL @"http://yun.it7090.com/image/XHLaunchAd/pic01.jpg"

#import "SHILaunchADBusiness.h"
#import <AFNetworking/AFNetworking.h>


static NSString *const LaunchADDataModelPlist  = @"launchADDataModel.plist";
static NSString *const LaunchAdDir  = @"LaunchAd";
static NSString *const LaunchADFetchDataSuccessTime = @"LaunchADFetchDataSuccessTime";

@interface SHILaunchADBusiness()
@property(nonatomic,assign)NSTimeInterval fetchDataSuccessTime;
@end

@implementation SHILaunchADBusiness

+ (instancetype)shareInstance{
    static SHILaunchADBusiness *launchObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchObj = [[SHILaunchADBusiness alloc] init];
    });
    return launchObj;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.launchAdObj = [self loadLocalADData];
        self.fetchDataSuccessTime = 0;
    }
    return self;
}

- (BOOL)isShow
{
    BOOL isShow = NO;
    NSTimeInterval currentTimeStamp = [self currentTimeStamp];
    if (currentTimeStamp < self.launchAdObj.endTimeStamp && currentTimeStamp > self.launchAdObj.startTimeStamp) {
        //to do 检查文件是否存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.launchAdObj.imgLocalPath]) {
            isShow = YES;
        }else
        {
            isShow = YES;   
        }
    }else
    {
        isShow = NO;
    }
    return isShow;
}

//程序启动
//|
//本次开屏启动页展示时间尚是否过期———
//|是（不展示广告页）                             |否
//|                                                              |
//|                                    本次数据抓取 同 上次数据抓取 时间间隔大于等于 24时
//|  ————————————————  |
//|
//抓取数据(抓取数据，抓取图片)
//|
//|
//数据同上次一致 丢弃 ，不一致 替换
- (void)loadNewData
{
    NSTimeInterval currentTimeStamp = [self currentTimeStamp];
    if (currentTimeStamp > self.launchAdObj.endTimeStamp) {
        [self loadLaunchAdDataFromSever];
    }else
    {
        double timeStampFromLastFetchData = fabs(self.fetchDataSuccessTime - currentTimeStamp);
        if (timeStampFromLastFetchData > 24*60*60) {
        // test 
//        if (timeStampFromLastFetchData > 2) {
            [self loadLaunchAdDataFromSever];
        }
    }
}

 
- (void)loadLaunchAdDataFromSever{
    /*
     1、load sever data
     2、load imageData  图片没有抓取成功，数据丢弃
     3、替换保存本地数据
     */  
    LaunchADModel *model = [[LaunchADModel alloc] init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *DEVICE_SCREEN_SIZE = [NSString stringWithFormat:@"%.f*%.f",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:DEVICE_SCREEN_SIZE forHTTPHeaderField:@"SIZE"];
    [requestSerializer setValue:@"iOS" forHTTPHeaderField:@"PLATFORM"];
    NSString *URLstr = @"http://ink-dev.sce.sohuno.com/inkguide/v1/launch_image/";
    NSURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:URLstr parameters:nil error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            if (dataDic) {
                model.startTimeStamp = [[dataDic objectForKey:@"start_time"] doubleValue];
                model.displayMillisecond = [[dataDic objectForKey:@"display_millisecond"] doubleValue];
                model.endTimeStamp = [[dataDic objectForKey:@"end_time"] doubleValue];
                model.imgSeverUrl = [dataDic objectForKey:@"img_url"]; 
                
                //saveImgData
                NSString *imageName = [[model.imgSeverUrl componentsSeparatedByString:@"/"] lastObject];
                NSString *imgLocalPath = [NSString stringWithFormat:@"%@/%@",[SHILaunchADBusiness dirPathOfLaunchADimg],imageName];
                model.imgLocalPath = [NSString stringWithFormat:@"Documents/%@/%@",LaunchAdDir,imageName];
                NSError *error = NULL;
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgSeverUrl] options:NSDataReadingUncached error:&error];
                if ([imgData writeToFile:imgLocalPath atomically:YES]) {
                    [self saveLaunchADData:model];
                    [self trackFetchDataSuccessTime];
                }
            }
        }
    }];
    [dataTask resume];
}

- (void)saveLaunchADData:(LaunchADModel *)adObj{

    NSString *launchAdFilePath = [SHILaunchADBusiness filePathOfLaunchADData];
    BOOL success = [NSKeyedArchiver archiveRootObject:adObj toFile:launchAdFilePath];
    NSLog(@"%d",success);
}

- (LaunchADModel *)loadLocalADData{
    NSString *launchAdFilePath = [SHILaunchADBusiness filePathOfLaunchADData];
     LaunchADModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:launchAdFilePath];
    return model;
}

+ (NSString *)filePathOfLaunchADData{
    NSString *dirPath = [self dirPathOfLaunchADimg];
    NSString *launchAdFilePath = [NSString stringWithFormat:@"%@/%@",dirPath,LaunchADDataModelPlist];
    if (![[NSFileManager defaultManager] fileExistsAtPath:launchAdFilePath]) {
        [[NSFileManager defaultManager]createFileAtPath:launchAdFilePath contents:nil attributes:nil];
    }
    NSLog(@"filePathOfLaunchADData:%@",launchAdFilePath);
    return launchAdFilePath;
}

- (NSString *)filePathOfLaunchADImg{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),self.launchAdObj.imgLocalPath];
    return filePath;
}

+ (NSString *)dirPathOfLaunchADimg{
    NSString *dirPath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",LaunchAdDir];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:nil]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:dirPath withIntermediateDirectories:YES  attributes:nil error:nil];
    }
    return dirPath;
}

#pragma mark - time

- (NSTimeInterval)fetchDataSuccessTime{
    if (_fetchDataSuccessTime == 0) {
        NSTimeInterval lastTime = [[NSUserDefaults standardUserDefaults] doubleForKey:LaunchADFetchDataSuccessTime];
        _fetchDataSuccessTime = lastTime;
    }
    return _fetchDataSuccessTime;
}

- (NSTimeInterval)currentTimeStamp{
    NSDate *date = [NSDate date];
    NSTimeInterval currentTimeStamp = [date timeIntervalSince1970];
    return currentTimeStamp;
}

- (void)trackFetchDataSuccessTime
{
    NSTimeInterval launchTimeStamp = [self currentTimeStamp];
    [[NSUserDefaults standardUserDefaults] setDouble:launchTimeStamp forKey:LaunchADFetchDataSuccessTime];
    [[NSUserDefaults standardUserDefaults] synchronize]; 
}

@end
