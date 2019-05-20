//
//  CSRefreshAutoFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoFooter.h"

@interface CSRefreshAutoFooter()
/** 一个新的拖拽 */
@property(nonatomic, assign, getter=isOneNewPan)BOOL oneNewPan;
@end

@implementation CSRefreshAutoFooter

#pragma mark - 布局

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        if (!self.isHidden) {
            self.scrollView.cs_insetBottom += self.cs_height;
        }
        
        // 设置位置
        self.cs_y = self.scrollView.cs_contentHeight;
    } else {    // 被移除了
        if (!self.isHidden) {
            self.scrollView.cs_insetBottom -= self.cs_height;
        }
    }
}

- (void)prepare {
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticRefreshPercent = 1.0;
    // 设置为默认状态
    self.automaticRefresh = YES;
    // 默认是当offset达到条件就发送请求（可连续）
    self.onlyOnceRefreshPerDray = NO;
}

#pragma mark - set

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    if (state == CSRefreshStateRefreshing) {
        [self executeRefreshingCallback];   /** 通知外界开始要刷新数据啦 */
    } else if (state == CSRefreshStateNormal || state == CSRefreshStateNoMoreData) {
        // 之前是刷新状态 + 现在停止刷新 == 通知外界刷新完成
        if (self.endRefreshingCompletionBlock) {
            self.endRefreshingCompletionBlock();
        }
    }
}

- (void)setHidden:(BOOL)hidden {
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {    // 显示 -> 隐藏
        self.state = CSRefreshStateNormal;
        
        self.scrollView.cs_insetBottom -= self.cs_height;
    } else if (lastHidden && !hidden) { // 隐藏 -> 显示
        self.scrollView.cs_insetBottom += self.cs_height;
        
        // 设置位置
        self.cs_y = _scrollView.cs_contentHeight;
    }
}

#pragma mark - scrollView

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    
    /** 设置上拉加载更多控件的位置 */
    self.cs_y = self.scrollView.cs_contentHeight;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果不是处于正常状态 + 不需要自动刷新 == 直接返回
    if (self.state != CSRefreshStateNormal || !self.isAutomaticRefresh || self.cs_y == 0) {
        return;
    }
    
    /** 内容超过一个屏幕 */
    if (_scrollView.cs_insetTop + _scrollView.cs_contentHeight > _scrollView.cs_height) {
        /** 即将要刷新数据的临界点 - !这里的_scrollView.cs_contentHeight替换掉self.cs_y更为合理 */
        float happenOffsetY = _scrollView.cs_contentHeight - _scrollView.cs_height + self.cs_height * self.triggerAutomaticRefreshPercent + _scrollView.cs_insetBottom - self.cs_height;
        
        if (_scrollView.cs_offsetY >= happenOffsetY) {  // 偏移量大于临界点
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) {   // 回滚回去的话就直接 pass
                return;
            }
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != CSRefreshStateNormal) {
        return;
    }
    
    // 只有处于默认状态下才做事情
    UIGestureRecognizerState panState = _scrollView.panGestureRecognizer.state;
    
    if (panState == UIGestureRecognizerStateEnded) {    // 手松开
        if (_scrollView.cs_insetTop + _scrollView.cs_contentHeight <= _scrollView.cs_height) {  /** 不够一个屏幕 */
            if (_scrollView.cs_offsetY >= - _scrollView.cs_insetTop) {
                // 向上拽
                [self beginRefreshing];
            }
        } else {    /** 超出一个屏幕 */
            // 偏移量 >= 刷新控件即将显示所需的偏移量
            if (_scrollView.cs_offsetY >= _scrollView.cs_contentHeight + _scrollView.cs_insetBottom - _scrollView.cs_height) {
                [self beginRefreshing];
            }
        }
    } else if (panState == UIGestureRecognizerStateBegan) {
        self.oneNewPan = YES;
    }
}

#pragma mark - 开始刷新

- (void)beginRefreshing {
    if (!self.isOneNewPan && self.isOnlyOnceRefreshPerDray) {
        return;
    }
    
    self.oneNewPan = NO;
    [super beginRefreshing];
}

@end
