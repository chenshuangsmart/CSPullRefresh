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
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:kRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:kRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:kRefreshKeyPathPanState options:options context:nil];
}

- (void)removeObservers {
    [self.scrollView removeObserver:self forKeyPath:kRefreshKeyPathContentOffset];
    [self.scrollView removeObserver:self forKeyPath:kRefreshKeyPathContentSize];
    [self.pan removeObserver:self forKeyPath:kRefreshKeyPathPanState];
    self.pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 如果不可以交互,直接返回
    if (!self.userInteractionEnabled) {
        return;
    }
    
    // 内容可滚动区域 - 就算不可见也需要处理
    if ([keyPath isEqualToString:kRefreshKeyPathContentSize]) {
        [ self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.isHidden) {
        return;
    }
    
    // 偏移量
    if ([keyPath isEqualToString:kRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:kRefreshKeyPathPanState]) {  // 拖拽手势
        [self scrollViewPanStateDidChange:change];
    }
}

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    // 子类去实现
}
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    // 子类去实现
}
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    // 子类去实现
}

#pragma mark - 公共方法

- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

- (void)setState:(CSRefreshState)state {
    _state = state;
    
    // 加入主队列的目的是等setState:方法调用完毕、再去布局子控件
    CSRefreshDispatchAsyncOnMainQueue([self setNeedsLayout];)
}

#pragma mark - 进入刷新状态

- (void)beginRefreshing {
    [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    
    self.pullingPercent = 1.0;
    
    // 只要正在刷新,就完全显示
    if (self.window) {
        self.state = CSRefreshStateRefreshing;
    } else {
        // 预防正在刷新中时，调用本方法使得header inset回置失败
        if (self.state != CSRefreshStateRefreshing) {
            self.state = CSRefreshStateWillRefresh;
            
            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
        }
    }
}

- (void)beginRefreshingWithCompletionBlock:(void (^)(void))completionBlock {
    self.beginRefreshingCompletionBlock = completionBlock;
    
    [self beginRefreshing];
}

#pragma mark - 结束刷新状态

- (void)endRefreshing {
    CSRefreshDispatchAsyncOnMainQueue(self.state = CSRefreshStateNormal;);
}

- (void)endRefreshingWithCompletionBlock:(void (^)(void))completionBlock {
    self.endRefreshingCompletionBlock = completionBlock;
    
    [self endRefreshing];
}

#pragma mark - 刷新状态

- (BOOL)isRefreshing {
    return self.state == CSRefreshStateRefreshing || self.state == CSRefreshStateWillRefresh;
}

#pragma mark - 透明度

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha {
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if (self.isRefreshing) {
        return;
    }
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    } else {
        self.alpha = 1.0;
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) {
        return;
    }
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

#pragma mark - 内部实现方法

- (void)executeRefreshingCallback {
    CSRefreshDispatchAsyncOnMainQueue({
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            CSRefreshMsgSend(CSRefreshMsgTarget(self.refreshingTarget),self.refreshingAction,self);
        }
        if (self.beginRefreshingCompletionBlock) {
            self.beginRefreshingCompletionBlock();
        }
    })
}

@end
