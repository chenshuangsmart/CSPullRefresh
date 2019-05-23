//
//  UIScrollView+CSRefresh.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UIScrollView+CSRefresh.h"
#import <objc/runtime.h>
#import "CSRefreshNormalHeader.h"
#import "CSRefreshBackNormalFooter.h"
#import "CSRefreshNoMoreDataView.h"

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

static const char CSRefreshFooterKey = '\1';

- (void)setCs_footer:(CSRefreshBackNormalFooter *)cs_footer {
    if (cs_footer != self.cs_footer) {
        // 删除旧的，添加新的
        [self.cs_footer removeFromSuperview];
        [self insertSubview:cs_footer atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &CSRefreshFooterKey, cs_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CSRefreshBackNormalFooter *)cs_footer {
    return objc_getAssociatedObject(self, &CSRefreshFooterKey);
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
    self.cs_footer = [CSRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    if (self.cs_footer) {
        [self.cs_footer endRefreshing];
    }
}

/**
 停止上拉刷新动画
 */
- (void)stopFooterRefreshAnimating {
    if (self.cs_footer) {
        [self.cs_footer endRefreshing];
    }
}

#pragma mark - no more data

static const char CSRefreshNoMoreDataK = '\2';

- (void)setCs_noMordDataView:(CSRefreshNoMoreDataView *)cs_noMordDataView {
    if (cs_noMordDataView != self.cs_noMordDataView) {
        // 移除旧的,添加新的
        [self.cs_noMordDataView removeFromSuperview];
        [self insertSubview:cs_noMordDataView atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &CSRefreshNoMoreDataK, cs_noMordDataView, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CSRefreshNoMoreDataView *)cs_noMordDataView {
    return objc_getAssociatedObject(self, &CSRefreshNoMoreDataK);
}

/**
 显示没有更多数据视图 - 文字默认为 no data - 如果有 footer 视图,默认会隐藏
 */
- (void)showNoMoreData {
    [self showNoMoreDataWithTitle:@"no more"];
}

/**
 显示没有更多数据视图 - 如果有 footer 视图,默认会隐藏
 
 @param title 文案
 */
- (void)showNoMoreDataWithTitle:(NSString *)title {
    if (self.cs_footer) {
        self.cs_footer.hidden = YES;
        self.cs_footer.state = CSRefreshStateNoMoreData;
    }
    if (self.cs_noMordDataView == nil) {
        self.cs_noMordDataView = [[CSRefreshNoMoreDataView alloc] initWithTitle:@"no more"];
    }
}

/**
 隐藏 no more data 视图 - 如果有 footer 视图,默认会显示
 */
- (void)hideNoMoreData {
    if (self.cs_footer) {
        self.cs_footer.hidden = NO;
        self.cs_footer.state = CSRefreshStateNormal;
    }
    if (self.cs_noMordDataView) {
        [self.cs_noMordDataView removeFromSuperview];
        objc_setAssociatedObject(self, &CSRefreshNoMoreDataK, nil, OBJC_ASSOCIATION_RETAIN);
    }
}

#pragma mark - data

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
