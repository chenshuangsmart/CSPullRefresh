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
typedef void (^CSRefreshComponentBeginRefreshingBlock)(void);
/** 刷新结束后的回调 */
typedef void(^CSRefreshComponentEndRefreshingBlock)(void);

/**
 刷新控件基类视图
 */
@interface CSRefreshComponent : UIView {
    UIEdgeInsets _scrollViewOriginalInset;  // scrollView刚开始的inset
    __weak UIScrollView *_scrollView;   // 父控件
}

#pragma mark - 初始化方法

/** 通过 block 初始化 */
- (instancetype)initWithhRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock;

/** 通过 target action 初始化*/
- (instancetype)initWithRefreshingTarget:(id)target action:(SEL)action;

#pragma mark - 刷新回调

/** 进入刷新状态的回调 */
@property(nonatomic, copy)CSRefreshComponentRefreshingBlock refreshingBlock;
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 回调对象 */
@property(nonatomic, weak)id refreshingTarget;
/** 回调方法 */
@property(nonatomic, assign)SEL refreshingAction;
/** 触发回调(交由子类去实现) */
- (void)executeRefreshingCallback;

#pragma mark - 刷新状态的控制

/** 开始刷新 */
- (void)beginRefreshing;
/** 开始刷新后完成回调 */
- (void)beginRefreshingWithCompletionBlock:(void(^)(void))completionBlock;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 结束刷新回调 */
- (void)endRefreshingWithCompletionBlock:(void(^)(void))completionBlock;
/** 开始刷新后的回调 */
@property(nonatomic, copy)CSRefreshComponentBeginRefreshingBlock beginRefreshingCompletionBlock;
/** 结束刷新的回调 */
@property(nonatomic, copy)CSRefreshComponentEndRefreshingBlock endRefreshingCompletionBlock;
/** 是否正在刷新 */
@property(nonatomic, assign, readonly, getter=isRefreshing)BOOL refreshing;
/** 刷新状态 一般交给子类内部实现 */
@property(nonatomic, assign)CSRefreshState state;

#pragma mark - 布局 - 交由子类去实现

/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 布局子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

#pragma mark - 对外暴露接口访问

/** 记录scrollView初始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

#pragma mark - 其他一些参数变量

/** 拉拽的百分比(交给子类重写) */
@property(nonatomic, assign)CGFloat pullingPercent;
/** 根据拖拽比例自动切换透明度 */
@property(nonatomic, assign, getter=isAutomaticallyChangeAlpha)BOOL automaticallyChangeAlpha;

@end

#pragma mark - UILabel(CSRefresh)

@interface UILabel(CSRefresh)

/** 快速创建一个 Lbe */
+ (instancetype)cs_createLbe;

/// 求 UILabel 控件文字长度
- (CGFloat)cs_textWidth;

@end

NS_ASSUME_NONNULL_END
