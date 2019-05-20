//
//  CSRefreshGifHeader.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/17.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshGifHeader.h"

@interface CSRefreshGifHeader() {
    __weak UIImageView *_gifImgView;    // gif img view
}
/** 所有状态对应的动画图片 */
@property(nonatomic, strong)NSMutableDictionary *stateImgsJson;
/** 所有状态对应的动画时间 */
@property(nonatomic, strong)NSMutableDictionary *stateDurationJson;

@end

@implementation CSRefreshGifHeader

#pragma mark - 视图布局

- (void)prepare {
    [super prepare];
    
    // 初始化间距
    self.labelLeftDistance = 20;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 外界已经添加约束布局了
    if (self.gifImgView.constraints.count) {
        return;
    }
    
    self.gifImgView.frame = self.bounds;
    
    if (self.stateLbe.isHidden && self.lastUpdatedTimeLbe.isHidden) {
        self.gifImgView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifImgView.contentMode = UIViewContentModeRight;
        
        CGFloat stateWidth = self.stateLbe.cs_textWidth;
        CGFloat timeWidth = 0;
        if (!self.lastUpdatedTimeLbe.isHidden) {
            timeWidth = self.lastUpdatedTimeLbe.cs_textWidth;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        self.gifImgView.cs_width = self.cs_width * 0.5 - textWidth * 0.5 - self.labelLeftDistance;
    }
}

#pragma mark - set

- (void)setImages:(NSArray<UIImage *> *)images forState:(CSRefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

- (void)setImages:(NSArray<UIImage *> *)images duration:(NSTimeInterval)duration forState:(CSRefreshState)state {
    if (images == nil || images.count == 0) {
        return;
    }
    
    self.stateImgsJson[@(state)] = images;
    self.stateDurationJson[@(state)] = @(duration);
    
    // 根据图片设置控件的高度
    UIImage *img = images.firstObject;
    if (img.size.height > self.cs_height) {
        self.cs_height = img.size.height;
    }
}

/// 更新 UI 视图操作
- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    // 根据状态做一些事情
    if (state == CSRefreshStatePulling || state == CSRefreshStateRefreshing) {  // 正在拖拽|刷新中
        NSArray *imgs = self.stateImgsJson[@(state)];
        if (imgs.count == 0) {
            return;
        }
        
        [self.gifImgView stopAnimating];
        
        if (imgs.count == 1) {  // 单张图片
            self.gifImgView.image = [imgs lastObject];
        } else {    // 多张图片
            self.gifImgView.animationImages = imgs;
            self.gifImgView.animationDuration = [self.stateDurationJson[@(state)] doubleValue];
            [self.gifImgView startAnimating];
        }
    } else if (state == CSRefreshStateNormal) { // 默认状态下-停止动画
        [self.gifImgView stopAnimating];
    }
}

/// 设置拖拽比例
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSArray *imgs = self.stateImgsJson[@(CSRefreshStateNormal)];
    if (self.state != CSRefreshStateNormal || imgs.count == 0) {
        return;
    }
    
    // 停止动画
    [self.gifImgView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index = imgs.count * pullingPercent;
    if (index >= imgs.count) {
        index = imgs.count - 1; // 默认设置最后一张
    }
    self.gifImgView.image = imgs[index];
}

#pragma mark - lazy

- (UIImageView *)gifImgView {
    if (_gifImgView == nil) {
        UIImageView *gifImgView = [[UIImageView alloc] init];
        [self addSubview:_gifImgView = gifImgView];
    }
    return _gifImgView;
}

- (NSMutableDictionary *)stateImgsJson {
    if (_stateImgsJson == nil) {
        _stateImgsJson = [NSMutableDictionary dictionary];
    }
    return _stateImgsJson;
}

- (NSMutableDictionary *)stateDurationJson {
    if (_stateDurationJson == nil) {
        _stateDurationJson = [NSMutableDictionary dictionary];
    }
    return _stateDurationJson;
}

@end
