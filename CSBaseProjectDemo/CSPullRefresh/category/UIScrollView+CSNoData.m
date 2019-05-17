//
//  UIScrollView+CSNoData.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UIScrollView+CSNoData.h"
#import <objc/runtime.h>
#import "CSPullRefresh.h"

static NSString *const kScrollViewNoMoreDataView = @"kScrollViewNoMoreDataView";
static float kScrollViewNoMoreDataViewHeight = 50;
static NSUInteger kNoMoreDataViewTag = 190511;

@implementation UIScrollView (CSNoData)

#pragma mark - set | get

- (void)setNoMoreDataView:(UIView *)noMoreDataView {
    objc_setAssociatedObject(self, &kScrollViewNoMoreDataView, noMoreDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 监听滑动
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (UIView *)noMoreDataView {
    UIView *noMoreDataView = objc_getAssociatedObject(self, &kScrollViewNoMoreDataView);
    
    if (noMoreDataView == nil) {
        noMoreDataView = [[UIView alloc] init];
        [self setNoMoreDataView:noMoreDataView];
    }
    
    return noMoreDataView;
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        NSValue *pointNewV = (NSValue *)change[NSKeyValueChangeNewKey];
        UIView *noMoreDataView = [self viewWithTag:kNoMoreDataViewTag];
        if (noMoreDataView) {
            noMoreDataView.frame = CGRectMake(0, pointNewV.CGSizeValue.height, kScreenWidth, kScrollViewNoMoreDataViewHeight);
        }
    }
}

#pragma mark - show | hide

/// 显示没有更多数据视图 - 文字默认为 no data
- (void)showNoMoreData {
    [self showNoMoreDataWithTitle:@"no more data"];
}

/// 显示没有更多数据视图
- (void)showNoMoreDataWithTitle:(NSString *)title {
    UIView *noMoreDataView = self.noMoreDataView;
    
    noMoreDataView.tag = kNoMoreDataViewTag;
    
    // 先移除所有子视图
    while (noMoreDataView.subviews.count) {
        [noMoreDataView.subviews.lastObject removeFromSuperview];
    }
    
    noMoreDataView.frame = CGRectMake(0, self.contentSize.height, kScreenWidth, kNoMoreDataViewTag);
    
    //view自定义
    UILabel *lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:14];
    lb.textColor = [UIColor blackColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 2;
    lb.text = title;
    [lb sizeToFit];
    lb.backgroundColor = [UIColor clearColor];
    if (lb.width > noMoreDataView.width * 0.7) {
        lb.width = noMoreDataView.width * 0.7;
    }
    lb.center = CGPointMake(noMoreDataView.width * 0.5, noMoreDataView.height * 0.5);
    [noMoreDataView addSubview:lb];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0.5)];
    line1.centerY = noMoreDataView.height * 0.5;
    line1.right = lb.x - 10;
    line1.backgroundColor = [UIColor blackColor];
    [noMoreDataView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(lb.right + 10, 0, 10, 0.5)];
    line2.centerY = noMoreDataView.height * 0.5;
    line2.backgroundColor = [UIColor blackColor];
    [noMoreDataView addSubview:line2];
    
    self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height + kNoMoreDataViewTag);
    
    [self addSubview:self.noMoreDataView];
}

/// 隐藏 no more data 视图
- (void)hideNoMoreData {
    UIView *noMoreDataView = [self viewWithTag:kNoMoreDataViewTag];
    if (noMoreDataView) {
        [noMoreDataView removeFromSuperview];
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height - kScrollViewNoMoreDataViewHeight);
    }
}

@end
