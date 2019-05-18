//
//  CSRefreshAutoFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshFooter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多 - 自动刷新基础控件
 */
@interface CSRefreshAutoFooter : CSRefreshFooter

/** 是否自动刷新(默认为 YES) */
@property(nonatomic, assign, getter=isAutomaticRefresh) BOOL automaticRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新 */
@property(nonatomic, assign)CGFloat triggerAutomaticRefreshPercent;

/** 是否每一次拖拽只发一次请求 */
@property(nonatomic, assign, getter=isOnlyOnceRefreshPerDray)BOOL onlyOnceRefreshPerDray;

@end

NS_ASSUME_NONNULL_END
