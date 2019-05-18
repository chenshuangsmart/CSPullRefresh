//
//  CSRefreshFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/17.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多基础控件
 */
@interface CSRefreshFooter : CSRefreshComponent

/** 创建下拉刷新header */
+ (instancetype)footerWithRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建下拉刷新header */
+ (instancetype)footerWithRefreshingTarget:(id)target action:(SEL)action;

/** 停止刷新并且提示没有更多的数据 */
- (void)endRefreshingAndShowNoMoreData;

/** 重置没有更多的数据（消除没有更多数据的状态) */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property(nonatomic, assign)CGFloat ignoreScrollViewContentInsetBottom;

@end

NS_ASSUME_NONNULL_END
