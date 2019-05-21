//
//  CSRefreshNoMoreDataView.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/21.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshNoMoreDataView.h"

@interface CSRefreshNoMoreDataView() {
    __weak UILabel *_titleLbe;
}

@end

@implementation CSRefreshNoMoreDataView {
    NSString *_title;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        [self drawUI];
    }
    return self;
}

- (void)drawUI {
    self.titleLbe.text = _title;
    [self.titleLbe sizeToFit];
    self.titleLbe.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0.5)];
    line1.centerY = self.height * 0.5;
    line1.right = self.titleLbe.x - 10;
    line1.backgroundColor = CSRefreshColor(102, 102, 102);
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.titleLbe.right + 10, 0, 10, 0.5)];
    line2.centerY = self.height * 0.5;
    line2.backgroundColor = CSRefreshColor(102, 102, 102);
    [self addSubview:line2];
}

/** 当视图即将加入父视图时 / 当视图即将从父视图移除时调用 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是 UIScrollView,直接 pass
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    // 移除父控件旧的监听
    [self removeObservers];
    
    // 设置新的j父控件
    if (newSuperview) {
        self.cs_width = newSuperview.cs_width;  // 设置宽度
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 添加监听
        [self addObservers];
    }
}

#pragma mark - KVO 监听

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:kRefreshKeyPathContentSize options:options context:nil];
}

- (void)removeObservers {
    [self.scrollView removeObserver:self forKeyPath:kRefreshKeyPathContentSize];
}

/** 监听到 KVO 回调,通过代理方式告知子视图控件 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 如果不可以交互,直接返回
    if (!self.userInteractionEnabled) {
        return;
    }
    
    // 内容可滚动区域 - 就算不可见也需要处理
    if ([keyPath isEqualToString:kRefreshKeyPathContentSize]) {
        NSValue *pointNewV = (NSValue *)change[NSKeyValueChangeNewKey];
        self.y = pointNewV.CGSizeValue.height;
    }
}


#pragma mark - lazy

- (UILabel *)titleLbe {
    if (_titleLbe == nil) {
        UILabel *lbe = [[UILabel alloc] init];
        lbe.font = CSRefreshLabelFont;
        lbe.textColor = CSRefreshLabelTextColor;
        lbe.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        lbe.textAlignment = NSTextAlignmentCenter;
        lbe.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLbe = lbe];
    }
    return _titleLbe;
}

@end
