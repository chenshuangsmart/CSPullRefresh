//
//  CSRefreshAutoStateFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoStateFooter.h"

@interface CSRefreshAutoStateFooter()

/** 所有状态对应的文字 */
@property(nonatomic, strong)NSMutableDictionary *stateTitleJson;

@end

@implementation CSRefreshAutoStateFooter {
    __weak UILabel *_stateLbe;  /// 显示刷新状态的label
}

#pragma mark - 布局

- (void)prepare {
    [super prepare];
    
    // 初始化边距
    self.labelLeftDistance = kRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:@"点击或上拉加载更多" forState:CSRefreshStateNormal];
    [self setTitle:@"正在加载更多的数据..." forState:CSRefreshStateRefreshing];
    [self setTitle:@"已经全部加载完毕" forState:CSRefreshStateNoMoreData];
    
    // 监听 lbe 的点击事件
    self.stateLbe.userInteractionEnabled = YES;
    [self.stateLbe addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStateLbe)]];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLbe.constraints.count) {
        return;
    }
    
    // 状态标签
    self.stateLbe.frame = self.bounds;
}

#pragma mark - action

- (void)tapStateLbe {
    if (self.state == CSRefreshStateNormal) {
        [self beginRefreshing];
    }
}

#pragma mark - set

- (void)setTitle:(NSString *)title forState:(CSRefreshState)state {
    if (title == nil || title.length == 0) {
        return;
    }
    self.stateTitleJson[@(state)] = title;
    self.stateLbe.text = self.stateTitleJson[@(self.state)];
}

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    if (self.isRefreshingTitleHidden && state == CSRefreshStateRefreshing) {
        self.stateLbe.text = nil;
    } else {
        self.stateLbe.text = self.stateTitleJson[@(state)];
    }
}

#pragma mark - lazy

- (NSMutableDictionary *)stateTitleJson {
    if (_stateTitleJson == nil) {
        _stateTitleJson = [NSMutableDictionary dictionary];
    }
    return _stateTitleJson;
}

- (UILabel *)stateLbe {
    if (_stateLbe == nil) {
        [self addSubview:_stateLbe = [UILabel cs_createLbe]];
    }
    return _stateLbe;
}

@end
