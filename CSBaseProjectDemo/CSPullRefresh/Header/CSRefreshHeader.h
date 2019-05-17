//
//  CSRefreshHeader.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/13.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

/**
 下拉刷新基础控件
 */
@interface CSRefreshHeader : CSRefreshComponent

/** 创建下拉刷新header */
+ (instancetype)headerWithRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建下拉刷新header */
+ (instancetype)headerWithRefreshingTarget:(id)target action:(SEL)action;

/** 存储上一次下拉刷新成功的时间 */
@property(nonatomic, copy)NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property(nonatomic, strong, readonly)NSDate *lastUpdatedTime;
/** 忽略多少scrollView的contentInset的top  */
@property(nonatomic, assign)CGFloat ignoredScrollViewContentInsetTopDistance;

@end

NS_ASSUME_NONNULL_END
