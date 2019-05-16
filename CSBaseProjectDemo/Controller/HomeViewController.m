//
//  HomeViewController.m
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/14.
//  Copyright © 2019年 cs. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"

@interface HomeViewController ()
/** debug */
@property(nonatomic,assign)UILabel *debugLbe;
/** array*/
@property(nonatomic,assign)NSArray *array;  // 注意用assign修饰
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.debugLbe.text = @"齐天大圣";
}

- (void)drawUI {
    // 约束布局实现
    UILabel *normalLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    normalLbe.textColor = [UIColor blackColor];
    normalLbe.text = @"普通样式下拉上拉刷新";
    normalLbe.textAlignment = NSTextAlignmentCenter;
    normalLbe.backgroundColor = [UIColor orangeColor];
    [normalLbe onTap:self action:@selector(tapNormalLbe)];
    [self.view addSubview:normalLbe];
    
    [normalLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(normalLbe.size);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    // 按需加载
    UILabel *needLoadLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    needLoadLbe.textColor = [UIColor blackColor];
    needLoadLbe.text = @"按需加载";
    needLoadLbe.textAlignment = NSTextAlignmentCenter;
    needLoadLbe.backgroundColor = [UIColor orangeColor];
    [needLoadLbe onTap:self action:@selector(tapNeedLoad)];
    [self.view addSubview:needLoadLbe];
    
    [needLoadLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(needLoadLbe.size);
        make.top.equalTo(normalLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // 缓存 Cell 高度
    UILabel *calculCellHeightLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    calculCellHeightLbe.textColor = [UIColor blackColor];
    calculCellHeightLbe.text = @"缓存 Cell 高度";
    calculCellHeightLbe.textAlignment = NSTextAlignmentCenter;
    calculCellHeightLbe.backgroundColor = [UIColor orangeColor];
    [calculCellHeightLbe onTap:self action:@selector(tapCalculCellHeightLbe)];
    [self.view addSubview:calculCellHeightLbe];
    
    [calculCellHeightLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(calculCellHeightLbe.size);
        make.top.equalTo(needLoadLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // 异步绘制
    UILabel * asyncDrawLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    asyncDrawLbe.textColor = [UIColor blackColor];
    asyncDrawLbe.text = @"异步绘制";
    asyncDrawLbe.textAlignment = NSTextAlignmentCenter;
    asyncDrawLbe.backgroundColor = [UIColor orangeColor];
    [asyncDrawLbe onTap:self action:@selector(tapAsyncDrawLbe)];
    [self.view addSubview:asyncDrawLbe];
    
    [asyncDrawLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(asyncDrawLbe.size);
        make.top.equalTo( calculCellHeightLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    // 异步绘制
    UILabel * delayLoadImgLbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    delayLoadImgLbe.textColor = [UIColor blackColor];
    delayLoadImgLbe.text = @"延时加载图片";
    delayLoadImgLbe.textAlignment = NSTextAlignmentCenter;
    delayLoadImgLbe.backgroundColor = [UIColor orangeColor];
    [delayLoadImgLbe onTap:self action:@selector(tapDelayLoadImgLbe)];
    [self.view addSubview:delayLoadImgLbe];
    
    [delayLoadImgLbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(delayLoadImgLbe.size);
        make.top.equalTo( asyncDrawLbe.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - action

- (void)tapNormalLbe {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapNeedLoad {
    
}

- (void)tapCalculCellHeightLbe {
    
}

- (void)tapAsyncDrawLbe {
    
}

- (void)tapDelayLoadImgLbe {
    
}

#pragma mark - test

- (void)drawScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    
    [scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(scrollView.size);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    // 头像
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.imgtn.bdimg.com/it/u=1718891758,1099874998&fm=26&gp=0.jpg"]];
    iconImgView.layer.cornerRadius = 30;
    iconImgView.layer.masksToBounds = YES;
    [scrollView addSubview:iconImgView];
    
    [iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconImgView.size);
        make.centerY.equalTo(scrollView);
        make.leading.equalTo(scrollView).offset(20);
    }];
    
    UILabel *nameLbe = [[UILabel alloc] init];
    nameLbe.text = @"授权";
    nameLbe.textColor = [UIColor blackColor];
    [nameLbe sizeToFit];
    [scrollView addSubview:nameLbe];
    
    [nameLbe mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(nameLbe.size);
        make.centerY.equalTo(scrollView);
        make.trailing.equalTo(scrollView.mas_leading).offset(scrollView.width - 20);
    }];
}

@end
