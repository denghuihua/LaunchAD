//
//  LaunchADModel.m
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/22.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "LaunchADModel.h"

@implementation LaunchADModel

- (id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.startTimeStamp = [[dic objectForKey:@"start_time"] doubleValue];
        self.endTimeStamp = [[dic objectForKey:@"end_time"] doubleValue];
        self.displayMillisecond = [[dic objectForKey:@"display_millisecond"] doubleValue];
        self.imgSeverUrl = [dic objectForKey:@"img_url"];
    }
    return self;
}

- (NSString *)description{
    NSDictionary *dic = @{@"startTime":@(self.startTimeStamp),@"endTime":@(self.endTimeStamp),@"displayMillisecond":@(self.displayMillisecond),@"imgSeverUrl":self.imgSeverUrl,@"imgLocalPath":self.imgLocalPath};
    return [NSString stringWithFormat:@"%@:%p,%@",[self class],self,dic];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:self.startTimeStamp forKey:@"startTime"];
    [aCoder encodeDouble:self.endTimeStamp forKey:@"endTime"];
    [aCoder encodeDouble:self.displayMillisecond forKey:@"displayMillisecond"];
    [aCoder encodeObject:self.imgLocalPath forKey:@"imgLocalPath"];
    [aCoder encodeObject:self.imgSeverUrl forKey:@"imgSeverUrl"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.startTimeStamp = [aDecoder decodeDoubleForKey:@"startTime"];
        self.endTimeStamp = [aDecoder decodeDoubleForKey:@"endTime"];
        self.displayMillisecond = [aDecoder decodeDoubleForKey:@"displayMillisecond"];
        self.imgLocalPath = [aDecoder decodeObjectForKey:@"imgLocalPath"];
        self.imgSeverUrl = [aDecoder decodeObjectForKey:@"imgSeverUrl"];
    }
    return self;   
}
@end
