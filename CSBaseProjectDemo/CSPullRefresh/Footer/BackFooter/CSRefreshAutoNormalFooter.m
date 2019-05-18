//
//  CSRefreshAutoNormalFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoNormalFooter.h"

@interface CSRefreshAutoNormalFooter()
/** loading */
@property(nonatomic, weak)UIActivityIndicatorView *loadingView;
@end

@implementation CSRefreshAutoNormalFooter

#pragma mark - 布局方法

- (void)prepare {
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.loadingView.constraints.count) {
        return;
    }
    
    // 转圈圈
    CGFloat loadingCenterX = self.cs_width * 0.5;
    if (!self.isRefreshingTitleHidden) {
        loadingCenterX -= self.stateLbe.cs_width * 0.5 + self.labelLeftDistance;
    }
    self.loadingView.center = CGPointMake(loadingCenterX, self.cs_height * 0.5);
}

#pragma mark - set

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    // 根据状态做事情
    if (state == CSRefreshStateNoMoreData || state == CSRefreshStateNormal) {   // 默认状态 + 无数据视图
        [self.loadingView stopAnimating];
    } else if (state == CSRefreshStateRefreshing) { // 刷新状态
        [self.loadingView startAnimating];
    }
}

#pragma mark - lazy

- (UIActivityIndicatorView *)loadingView {
    if (_loadingView == nil) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

@end
