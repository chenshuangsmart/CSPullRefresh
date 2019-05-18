//
//  CSRefreshFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/17.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshFooter.h"

@implementation CSRefreshFooter

#pragma mark - 构造方法

/** 创建下拉刷新header */
+ (instancetype)footerWithRefreshingBlock:(CSRefreshComponentRefreshingBlock)refreshingBlock {
    return [[self alloc] initWithhRefreshingBlock:refreshingBlock];
}

/** 创建下拉刷新header */
+ (instancetype)footerWithRefreshingTarget:(id)target action:(SEL)action {
    return [[self alloc] initWithRefreshingTarget:target action:action];
}

#pragma mark - 布局方法 - 重写父类的方法

- (void)prepare {
    [super prepare];
    
    // 设置自己的高度
    self.cs_height = kRefreshFooterHeight;
}

#pragma mark - 公共方法

- (void)endRefreshingAndShowNoMoreData {
    CSRefreshDispatchAsyncOnMainQueue(self.state = CSRefreshStateNoMoreData;);
}

- (void)resetNoMoreData {
    CSRefreshDispatchAsyncOnMainQueue(self.state = CSRefreshStateNormal;);
}

@end
