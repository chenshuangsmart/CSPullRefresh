//
//  CSRefreshBackFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshBackFooter.h"

@interface CSRefreshBackFooter()
/** 上一次刷新的数量 */
@property(nonatomic, assign)NSInteger lastRefreshCount;
/** 上一次底部 */
@property(nonatomic, assign)CGFloat lastBottomDelta;
@end

@implementation CSRefreshBackFooter

#pragma mark - 初始化 布局

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentSizeDidChange:@{}];
}

#pragma mark - scrollView delegate

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新,就直接返回
    if (self.state == CSRefreshStateRefreshing) {
        return;
    }
    
    // 记录原始 UIEdgeInsets
    _scrollViewOriginalInset = self.scrollView.cs_inset;
    
    // 当前的 contentOffset y
    CGFloat currentOffsetY = self.scrollView.cs_offsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self getHappenOffsetY];
    
    /** 如果是向下滚动到看不见尾部控件，直接返回 */
    if (currentOffsetY <= happenOffsetY) {
        return;
    }
    // 拖拽比例
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.cs_height;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == CSRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {   // 正在拖拽中
        self.pullingPercent = pullingPercent;
        
        // 普通状态 和 即将刷新状态 的临界点
        /** 即如果偏移量 (offsetY > 临界点,说明需要刷新) (反之,如果偏移量 offsetY <= 临界点,说明不需要刷新,回复正常状态) */
        CGFloat normalToPullingOffsetY = happenOffsetY + self.cs_height;
        
        if (self.state == CSRefreshStateNormal && currentOffsetY > normalToPullingOffsetY) {
            // 转为即将刷新状态
            self.state = CSRefreshStatePulling;
        } else if (self.state == CSRefreshStatePulling && currentOffsetY <= normalToPullingOffsetY) {
            // 转变为普通状态
            self.state = CSRefreshStateNormal;
        }
    } else if (self.state == CSRefreshStatePulling) {   // 松开 + 即将刷新
        // 开始刷新
        [self beginRefreshing]; /** 备注:不真正执行刷新回调,只是改变 state 和 更新 UI */
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度 - contentSize.height
    CGFloat contentHeight = self.scrollView.cs_contentHeight + self.ignoreScrollViewContentInsetBottom;
    // 视图的高度 - frame.size.height
    CGFloat scrollHeight = self.scrollView.cs_height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoreScrollViewContentInsetBottom;
    /** 动态设置上拉加载更多视图的位置 */
    self.cs_y = MAX(contentHeight, scrollHeight);
}

#pragma mark - set

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    // 根据状态来设置属性
    if (state == CSRefreshStateNoMoreData || state == CSRefreshStateNormal) {   // 无数据 + 默认状态
        /** 刷新完毕 - 改变 UI + 通知外界刷新完毕 */
        if (oldState == CSRefreshStateRefreshing) {
            [UIView animateWithDuration:kRefreshSlowAnimationDuration animations:^{
                self.scrollView.cs_insetBottom -= self.lastBottomDelta;
                
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) {
                    self.alpha = 0;
                }
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
    } else if (state == CSRefreshStateRefreshing) { // 正在刷新状态
        // 记录刷新前的数量
        self.lastRefreshCount = self.scrollView.cs_totalDataCount;
        
        /** 让视图停留在某一个特定的位置 - 改变偏移量即可 */
        [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.cs_height + self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self getHeightForContentBreakView];
            
            if (deltaH < 0) {   // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            
            self.lastBottomDelta = bottom - self.scrollView.cs_insetBottom;
            self.scrollView.cs_insetBottom = bottom;
            /// 如果刷新完毕不想让视图回到之前的位置,则不加上 self.cs_height 即可
            self.scrollView.cs_offsetY = [self getHappenOffsetY] + self.cs_height;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];   /** 告知外界这个时候可以刷新数据了 */
        }];
    }
}

#pragma mark - private

/// 获得scrollView的内容 超出 view 的高度
- (CGFloat)getHeightForContentBreakView {
    // 先把上下回弹区域扣除
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return  self.scrollView.contentSize.height - h;
}

/// 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)getHappenOffsetY {
    CGFloat deltaH = [self getHeightForContentBreakView];
    
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

@end
