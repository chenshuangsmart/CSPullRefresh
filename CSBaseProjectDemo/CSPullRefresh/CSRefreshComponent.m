//
//  CSRefreshComponent.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshComponent.h"

@interface CSRefreshComponent()
@property (strong, nonatomic) UIPanGestureRecognizer *pan;  // 滑动手势
@end

@implementation CSRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化
        [self prepare];
        
        // 默认是普通状态
        self.state = CSRefreshStateNormal;
    }
    return self;
}

#pragma mark - 布局实现

- (void)layoutSubviews {
    [super layoutSubviews];
    [self placeSubviews];
}

/** 准备工作 */
- (void)prepare {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

/** 重新布局子控件 */
- (void)placeSubviews {}

/** 当视图即将加入父视图时 / 当视图即将从父视图移除时调用 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是 UIScrollView,直接 pass
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    // 移除父控件旧的监听
    [self removeObservers];
    
    // 设置新的j父控件
    if (newSuperview) {
        self.cs_width = newSuperview.cs_width;  // 设置宽度
        self.cs_x = -_scrollView.cs_insetLeft;
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.cs_inset;
        
        // 添加监听
        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.state == CSRefreshStateWillRefresh) {
        // 预防view还没显示出来就调用了beginRefreshing
        self.state = CSRefreshStateRefreshing;
    }
}

#pragma mark - KVO 监听

- (void)addObservers {
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    self.scrollView addObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>
    
}

- (void)removeObservers {
    
}

@end
