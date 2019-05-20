//
//  UIScrollView+CSRefresh.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSRefreshNormalHeader.h"
#import "CSRefreshBackNormalFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CSRefresh)

/** 下拉刷新控件 */
@property (strong, nonatomic) CSRefreshNormalHeader *cs_header;

/** 上拉加载更多控件 */
@property (strong, nonatomic) CSRefreshBackNormalFooter *cd_footer;

#pragma mark - pull down | pull up

/**
 下拉刷新
 
 @param handler 执行代码块
 */
- (void)cs_addPullDownRefreshWithActionHandler:(void(^)(void))handler;

/**
 上拉加载更多
 
 @param handler 执行代码块
 */
- (void)cs_addPullUpRefreshWithActionHandler:(void(^)(void))handler;

/**
 停止下拉刷新动画
 */
- (void)stopPullDownAnimating;

/**
 停止下拉刷新动画
 */
- (void)stopHeaderRefreshAnimating;

/**
 停止上拉刷新动画
 */
- (void)stopPullUpAnimating;

/**
 停止上拉刷新动画
 */
- (void)stopFooterRefreshAnimating;

#pragma mark - no data view

/**
 显示没有更多数据视图 - 文字默认为 no data - 如果有 footer 视图,默认会隐藏
 */
- (void)showNoMoreData;

/**
 显示没有更多数据视图 - 如果有 footer 视图,默认会隐藏
 
 @param title 文案
 */
- (void)showNoMoreDataWithTitle:(NSString *)title;

/**
 隐藏 no more data 视图 - 如果有 footer 视图,默认会显示
 */
- (void)hideNoMoreData;

#pragma mark - data

/// 已经展示数据数量
- (NSInteger)cs_totalDataCount;

@end

NS_ASSUME_NONNULL_END
