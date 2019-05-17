//
//  CSRefreshStateHeader.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/14.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 下拉刷新状态视图
 */
@interface CSRefreshStateHeader : CSRefreshHeader

 #pragma mark - 时间相关

/** 利用这个block来决定显示的更新时间文字 */
@property(nonatomic, copy)NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
/** 显示上一次刷新时间的label */
@property(nonatomic, weak, readonly)UILabel *lastUpdatedTimeLbe;

#pragma mark - 状态相关

/** 文字距离圈圈、箭头的距离 */
@property(nonatomic, assign)CGFloat labelLeftDistance;
/** 显示刷新状态的label */
@property(nonatomic, weak, readonly)UILabel *stateLbe;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(CSRefreshState)state;

@end

NS_ASSUME_NONNULL_END
