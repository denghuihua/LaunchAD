//
//  LaunchAdViewController.m
//  DHHLauchADExample
//
//  Created by huihuadeng on 2018/3/21.
//  Copyright © 2018年 huihuadeng. All rights reserved.
//

#import "LaunchAdViewController.h"
#import <YYImage/YYImage.h>
#import "Masonry.h"

@interface LaunchAdViewController ()
@property(nonatomic,strong)YYAnimatedImageView *launchADImgView;

@end

@implementation LaunchAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
   
    [self.view addSubview:self.launchADImgView];
    [self.launchADImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadImageOrGifWithPath:(NSString *)imgPath{
    
    self.launchADImgView.image = [YYImage imageWithContentsOfFile:imgPath];
}

-(YYAnimatedImageView *)launchADImgView
{
    if (!_launchADImgView) {
        _launchADImgView = [[YYAnimatedImageView alloc] init];
    }
    return _launchADImgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
