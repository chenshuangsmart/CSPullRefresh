//
//  CSRefreshBackStateFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshBackStateFooter.h"

@interface CSRefreshBackStateFooter()

/** 所有状态对应的文字 */
@property(nonatomic, strong)NSMutableDictionary *stateTitleJson;

@end

@implementation CSRefreshBackStateFooter {
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
    [self setTitle:@"松开立即加载更多" forState:CSRefreshStatePulling];
    [self setTitle:@"已经全部加载完毕" forState:CSRefreshStateNoMoreData];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLbe.constraints.count) {
        return;
    }
    
    // 状态标签
    self.stateLbe.frame = self.bounds;
}

#pragma mark - set | get

- (void)setTitle:(NSString *)title forState:(CSRefreshState)state {
    if (title == nil || title.length == 0) {
        return;
    }
    self.stateTitleJson[@(state)] = title;
    self.stateLbe.text = self.stateTitleJson[@(self.state)];
}

- (NSString *)titleForState:(CSRefreshState)state {
    return self.stateTitleJson[@(state)];
}

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    // 设置状态文字
    self.stateLbe.text = self.stateTitleJson[@(state)];
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
