//
//  CSRefreshComponent.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 刷新控件的状态
 */
typedef NS_ENUM(NSInteger, CSRefreshState) {
    /** 正常状态 */
    CSRefreshStateNormal = 0,
    /** 松开就可以进行刷新的状态 */
    CSRefreshStatePulling,
    /** 即将刷新的状态 */
    CSRefreshStateWillRefresh,
    /** 正在刷新中的状态 */
    CSRefreshStateRefreshing,
    /** 数据加载完毕,没有更多数据了 */
    CSRefreshStateNoMoreData
};

#pragma mark - 操作回调的 block

/** 进入刷新状态的回调 */
typedef void (^CSRefreshComponentRefreshingBlock)(void);
/** 开始刷新后的回调 */
typedef void (CSRefreshComponentBeginRefreshingBlock)(void);
/** 刷新结束后的回调 */
typedef void(CSRefreshComponentEndRefreshingBlock)(void);

/**
 刷新控件基类视图
 */
@interface CSRefreshComponent : UIView {
    UIEdgeInsets _scrollViewOriginalInset;  // scrollView刚开始的inset
    __weak UIScrollView *_scrollView;   // 父控件
}

#pragma mark - 刷新回调

/** 进入刷新状态的回调 */
@property(nonatomic, copy)CSRefreshComponentRefreshingBlock refreshingBlock;

#pragma mark - 刷新状态的控制

/** state */
@property(nonatomic, assign)CSRefreshState state;

#pragma mark - 布局 - 交由子类去实现

/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 布局子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;

#pragma mark - 对外暴露接口访问

/** 记录scrollView初始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
