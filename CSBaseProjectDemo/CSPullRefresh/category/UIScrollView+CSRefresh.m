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

#pragma mark - footer

static const char CDRefreshFooterKey = '\1';

- (void)setCd_footer:(CSRefreshBackNormalFooter *)cd_footer {
    if (cd_footer != self.cd_footer) {
        // 删除旧的，添加新的
        [self.cd_footer removeFromSuperview];
        [self insertSubview:cd_footer atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &CDRefreshFooterKey, cd_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CSRefreshBackNormalFooter *)cd_footer {
    return objc_getAssociatedObject(self, &CDRefreshFooterKey);
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
- (void)cs_addPullUpRefreshWithActionHandler:(void(^)(void))handler {
    self.cd_footer = [CSRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (handler) {
            handler();
        }
    }];
}

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
- (void)stopPullUpAnimating {
    if (self.cd_footer) {
        [self.cd_footer endRefreshing];
    }
}

/**
 停止上拉刷新动画
 */
- (void)stopFooterRefreshAnimating {
    if (self.cd_footer) {
        [self.cd_footer endRefreshing];
    }
}

/// 已经展示数据数量
- (NSInteger)cs_totalDataCount {
    NSInteger totalCount = 0;
    
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    
    return totalCount;
}

@end
