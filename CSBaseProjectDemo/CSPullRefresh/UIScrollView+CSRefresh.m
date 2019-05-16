//
//  UIScrollView+CSRefresh.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UIScrollView+CSRefresh.h"
#import <objc/runtime.h>

static const char CsRefreshHeaderKey = '\0';

@implementation UIScrollView (CSRefresh)

#pragma mark - header

- (void)setCs_header:(CSRefreshNormalHeader *)cs_header {
    if (cs_header != self.cs_header) {
        // 删除旧的,添加新的
        [self.cs_header removeFromSuperview];
        [self insertSubview:cs_header atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &CsRefreshHeaderKey, cs_header, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CSRefreshNormalHeader *)cs_header {
    return objc_getAssociatedObject(self, &CsRefreshHeaderKey);
}

#pragma mark - pull down | pull up

/**
 下拉刷新
 
 @param handler 执行代码块
 */
- (void)cs_addPullDownRefreshWithActionHandler:(void(^)(void))handler {
    self.cs_header = [CSRefreshNormalHeader headerWithRefreshingBlock:^{
        if (handler) {
            handler();
        }
    }];
}

/**
 上拉加载更多
 
 @param handler 执行代码块
 */
//- (void)cd_addPullUpRefreshWithActionHandler:(void(^)(void))handler {
//    self.cd_footer = [CDRefreshFooter footerWithRefreshingBlock:^{
//        if (handler) {
//            handler();
//        }
//    }];
//}

/**
 停止下拉刷新动画
 */
- (void)stopPullDownAnimating {
    if (self.cs_header) {
        [self.cs_header endRefreshing];
    }
}

/**
 停止下拉刷新动画
 */
- (void)stopHeaderRefreshAnimating {
    if (self.cs_header) {
        [self.cs_header endRefreshing];
    }
}

/**
 停止上拉刷新动画
 */
//- (void)stopPullUpAnimating {
//    if (self.cd_footer) {
//        [self.cd_footer endRefreshing];
//    }
//}

/**
 停止上拉刷新动画
 */
//- (void)stopFooterRefreshAnimating {
//    if (self.cd_footer) {
//        [self.cd_footer endRefreshing];
//    }
//}

@end
