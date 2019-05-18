//
//  CSRefreshAutoStateFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoFooter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多 - 自动刷新 状态
 */
@interface CSRefreshAutoStateFooter : CSRefreshAutoFooter
/** 文字距离圈圈、箭头的距离 */
@property(nonatomic, assign) CGFloat labelLeftDistance;
/** 显示刷新状态的label */
@property(nonatomic, weak, readonly)UILabel *stateLbe;
/** 隐藏刷新状态的文字 */
@property(nonatomic, assign, getter=isRefreshingTitleHidden)BOOL refreshingTitleHidden;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(CSRefreshState)state;

@end

NS_ASSUME_NONNULL_END
