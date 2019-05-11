//
//  UIScrollView+CSNoData.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 底部无数据视图
 */
@interface UIScrollView (CSNoData)

@property (nonatomic, strong) UIView *noMoreDataView;

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

@end

NS_ASSUME_NONNULL_END
