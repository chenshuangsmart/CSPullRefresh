//
//  CSRefreshBackStateFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshBackFooter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多 - 停止拖拽返回后刷新
 */
@interface CSRefreshBackStateFooter : CSRefreshBackFooter
/** 文字距离圈圈、箭头的距离 */
@property(nonatomic, assign) CGFloat labelLeftDistance;
/** 显示刷新状态的label */
@property(nonatomic, weak, readonly)UILabel *stateLbe;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(CSRefreshState)state;

/** 获取state状态下的title */
- (NSString *)titleForState:(CSRefreshState)state;

@end

NS_ASSUME_NONNULL_END
