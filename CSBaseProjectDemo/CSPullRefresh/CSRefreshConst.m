//
//  CSRefreshConst.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshConst.h"

@implementation CSRefreshConst


#pragma mark - 常量

// 数值常量
const CGFloat kRefreshLabelLeftInset = 25;
const CGFloat kRefreshHeaderHeight = 54.0;
const CGFloat kRefreshFooterHeight = 44.0;
const CGFloat kRefreshFastAnimationDuration = 0.25;
const CGFloat kRefreshSlowAnimationDuration = 0.4;

// 字符串常量
NSString *const kRefreshHeaderLastUpdatedTimeKey = @"kRefreshHeaderLastUpdatedTimeKey";

NSString *const kRefreshHeaderIdleText = @"kRefreshHeaderIdleText";
NSString *const kRefreshHeaderPullingText = @"kRefreshHeaderPullingText";
NSString *const kRefreshHeaderRefreshingText = @"kRefreshHeaderRefreshingText";

#pragma mark - observer

NSString *const kRefreshKeyPathContentOffset = @"contentOffset";
NSString *const kRefreshKeyPathContentInset = @"contentInset";
NSString *const kRefreshKeyPathContentSize = @"contentSize";
NSString *const kRefreshKeyPathPanState = @"state";

@end
