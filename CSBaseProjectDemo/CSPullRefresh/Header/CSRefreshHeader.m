//
//  CSRefreshHeader.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/13.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshHeader.h"

@interface CSRefreshHeader()

/** insert delta */
@property(nonatomic, assign)CGFloat insetTDelta;

@end

@implementation CSRefreshHeader

#pragma mark - 初始化构造方法

+ (instancetype)headerWithRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock {
    CSRefreshHeader *header = [[self alloc] initWithhRefreshingBlock:refreshingBlock];
    return header;
}

+ (instancetype)headerWithRefreshingTarget:(id)target action:(SEL)action {
    CSRefreshHeader *header = [[self alloc] initWithTarget:target action:action];
    return header;
}

#pragma mark - 重写父类的方法

- (void)prepare {
    [super prepare];
    
    // 设置上一次更新的 key
    self.lastUpdatedTimeKey = kRefreshHeaderLastUpdatedTimeKey;
    
    // 设置视图高度
    self.cs_height = kRefreshFooterHeight;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 设置 Y 值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.cs_y = - self.cs_height - self.ignoredScrollViewContentInsetTopDistance;
}

/// 当视图即将加入父视图时 / 当视图即将从父视图移除时调用
- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (!newWindow && self.isRefreshing) {
        [self endRefreshing];
    }
}

#pragma mark - 滚动偏移量

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的 refreshing 状态 - 暂时保留
    if (self.state == CSRefreshStateRefreshing) {
        if (self.window == nil) {
            return;
        }
        
        // sectionheader停留解决
        CGFloat insetTop = - self.scrollView.cs_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.cs_offsetY : _scrollViewOriginalInset.top;
        insetTop = insetTop > self.cs_height + _scrollViewOriginalInset.top ? self.cs_height + _scrollViewOriginalInset.top : insetTop;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetTop;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.cs_inset;
    
    // 当前的contentOffsetY
    CGFloat offsetY = self.scrollView.cs_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY > happenOffsetY) {
        return;
    }
    
    // 普通 和 即将刷新 的临界点
    CGFloat normalToPullingOffsetY = happenOffsetY - self.cs_height;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.cs_height;
    
    if (self.scrollView.isDragging) {   // 正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == CSRefreshStateNormal && offsetY < normalToPullingOffsetY) {
            // 转为即将刷新状态
            self.state = CSRefreshStatePulling;
        } else if (self.state == CSRefreshStatePulling && offsetY >= normalToPullingOffsetY) {
            // 转为普通状态
            self.state = CSRefreshStateNormal;
        }
    } else if (self.state == CSRefreshStatePulling) {   // 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

#pragma mark - 刷新状态

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck
    
    // 根据状态做事情
    if (state == CSRefreshStateNormal) {    // 恢复正常状态
        if (oldState != CSRefreshStateRefreshing) {
            return;
        }
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复 inset 和 offset
        [UIView animateWithDuration:kRefreshSlowAnimationDuration animations:^{
            self.scrollView.cs_insetTop += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) {
                self.alpha = 0.8;
            }
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    } else if (state == CSRefreshStateRefreshing) { // 处于刷新状态
        CSRefreshDispatchAsyncOnMainQueue(
            [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
                if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateCancelled) {
                    CGFloat top = self.scrollViewOriginalInset.top + self.cs_height;
                    // 增加滚动区域 top
                    self.scrollView.cs_insetTop = top;
                    // 设置滚动位置
                    CGPoint offset = self.scrollView.contentOffset;
                    offset.y = -top;
                    [self.scrollView setContentOffset:offset animated:NO];  // 顶部停留一片刷新区域
                }
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        )
    }
}

#pragma mark - 公共方法

- (NSDate *)lastUpdatedTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

- (void)setIgnoredScrollViewContentInsetTopDistance:(CGFloat)ignoredScrollViewContentInsetTopDistance {
    _ignoredScrollViewContentInsetTopDistance = ignoredScrollViewContentInsetTopDistance;
    
    self.cs_y = - self.cs_height - _ignoredScrollViewContentInsetTopDistance;
}

@end
